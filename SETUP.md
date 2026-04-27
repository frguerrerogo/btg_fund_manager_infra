# Setup - Desarrollo Local

Guía completa para levantar el ambiente de desarrollo local.

## 1. Requisitos

- Docker & Docker Compose
- AWS CLI
- Git

## 2. Levantar LocalStack

LocalStack emula AWS servicios localmente.

```bash
docker-compose up -d
```

Verifica que esté corriendo:

```bash
docker ps
```

Debería mostrar container `localstack_main` corriendo.

## 3. Deploy Infraestructura

```bash
cd terraform
terraform init
terraform apply -var="env=dev"
```

Verifica que las tablas se crearon:

```bash
aws dynamodb list-tables --endpoint-url http://localhost:4566 --region us-east-1
```

Debería listar: `dev-funds`, `dev-transactions`, `dev-users`

## 4. Seedear Datos

```bash
cd scripts
.\seed.bat
```

Verifica:

```bash
aws dynamodb scan --table-name dev-funds --endpoint-url http://localhost:4566 --region us-east-1 --select COUNT
```

Debería mostrar `"Count": 5`

## 5. Ver Datos (DynamoDB Admin)

UI visual para navegar los datos:

```bash
docker run -p 8001:8001 -e DYNAMO_ENDPOINT=http://localhost:4566 aaronshaf/dynamodb-admin
```

Abre en navegador: http://localhost:8001

## 6. Agregar Nuevas Tablas

1. Crea módulo en `terraform/modules/tu-modulo/`
2. Agrega a `terraform/main.tf`
3. Ejecuta `terraform apply`
4. Crea datos en `scripts/tu-modulo/*.json`
5. Ejecuta `seed.bat`

---

## Troubleshooting

| Problema          | Solución                                                    |
| ----------------- | ----------------------------------------------------------- |
| Port 4566 en uso  | `docker stop localstack_main && docker rm localstack_main`  |
| Tablas no existen | `terraform apply`                                           |
| 0 items en tabla  | `cd scripts && .\seed.bat`                                  |
| AWS CLI error     | `aws configure` (credenciales dummy: key=test, secret=test) |
