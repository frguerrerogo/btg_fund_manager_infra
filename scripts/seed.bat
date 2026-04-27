@echo off
REM Seed DynamoDB with funds

setlocal enabledelayedexpansion

set TABLE=dev-funds
set ENDPOINT=http://localhost:4566
set REGION=us-east-1

echo [*] Seeding %TABLE%...

REM Fondo 1
aws dynamodb put-item --table-name %TABLE% --endpoint-url %ENDPOINT% --region %REGION% --item file://funds/1.json
echo   [+] FPV_BTG_PACTUAL_RECAUDADORA

REM Fondo 2
aws dynamodb put-item --table-name %TABLE% --endpoint-url %ENDPOINT% --region %REGION% --item file://funds/2.json
echo   [+] FPV_BTG_PACTUAL_ECOPETROL

REM Fondo 3
aws dynamodb put-item --table-name %TABLE% --endpoint-url %ENDPOINT% --region %REGION% --item file://funds/3.json
echo   [+] DEUDAPRIVADA

REM Fondo 4
aws dynamodb put-item --table-name %TABLE% --endpoint-url %ENDPOINT% --region %REGION% --item file://funds/4.json
echo   [+] FDO-ACCIONES

REM Fondo 5
aws dynamodb put-item --table-name %TABLE% --endpoint-url %ENDPOINT% --region %REGION% --item file://funds/5.json
echo   [+] FPV_BTG_PACTUAL_DINAMICA

echo.
echo [OK] Done!
