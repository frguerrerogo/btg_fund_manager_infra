# Seed DynamoDB

Rellena la tabla de fondos con datos iniciales.

## Requisitos

- AWS CLI

## Uso

```powershell
.\seed.bat
```

## Cambiar fondos

Edita los archivos en carpeta `funds/`:

```
funds/
├── 1.json
├── 2.json
├── 3.json
├── 4.json
└── 5.json
```

Ejemplo `funds/1.json`:

```json
{
  "id": { "S": "1" },
  "name": { "S": "Tu Fondo" },
  "minimum_amount": { "N": "75000" },
  "category": { "S": "FPV" }
}
```

Luego ejecuta `seed.bat` de nuevo.

## Verificar datos

```bash
aws dynamodb scan --table-name dev-funds --region us-east-1 --endpoint-url http://localhost:4566 --select COUNT
```

Debería mostrar `"Count": 5` ✅
