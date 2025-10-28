# Instrucciones de Ejecución - Prueba Técnica Atlas

## Requisitos Previos
- MySQL Server instalado y ejecutándose
- Python 3.8+
- Power BI Desktop

## Sección A: Base de Datos

### 1. Crear la base de datos
```bash
mysql -u root -p < seccion_a_bd/crear_bd.sql
```

### 2. Ejecutar consultas
```bash
mysql -u root -p atlas_prueba < seccion_a_bd/consultas.sql
```

## Sección B: ETL

### 1. Instalar dependencias
```bash
cd seccion_b_etl
pip install -r requirements.txt
```

### 2. Configurar conexiones
Editar `config.json` con las credenciales correctas de MySQL

### 3. Ejecutar ETL
```bash
python etl.py
```

## Sección C: API

### 1. Instalar dependencias
```bash
cd seccion_c_api
pip install -r requirements.txt
```

### 2. Ejecutar API
```bash
python app.py
```

### 3. Probar endpoints
- Health check: `GET http://localhost:5000/health`
- Ventas por categoría: `GET http://localhost:5000/ventas-por-categoria`

## Sección D: Dashboard

1. Seguir las instrucciones en `seccion_d_dashboard/README_Dashboard.md`
2. Usar las consultas de `seccion_d_dashboard/consultas_powerbi.sql`

## Estructura del Proyecto
```
PruebaTecnicaAtlas/
├── seccion_a_bd/
│   ├── crear_bd.sql
│   └── consultas.sql
├── seccion_b_etl/
│   ├── config.json
│   ├── etl.py
│   └── requirements.txt
├── seccion_c_api/
│   ├── app.py
│   └── requirements.txt
├── seccion_d_dashboard/
│   ├── consultas_powerbi.sql
│   └── README_Dashboard.md
└── INSTRUCCIONES.md
```