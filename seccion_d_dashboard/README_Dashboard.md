# Dashboard Power BI - Atlas

## Instrucciones para crear el dashboard

### 1. Conectar Power BI a MySQL
- Abrir Power BI Desktop
- Ir a "Obtener datos" > "Base de datos" > "Base de datos MySQL"
- Configurar conexión:
  - Servidor: localhost
  - Base de datos: atlas_prueba

### 2. Importar datos usando las consultas SQL
Usar las consultas del archivo `consultas_powerbi.sql` para crear las siguientes tablas:
- **VentasPorCategoria**: Para el gráfico de ventas por categoría
- **VentasPorCategoriaYMes**: Para el gráfico de categorías por mes
- **ClientesMayoresCompras**: Para identificar el cliente que más compra

### 3. Crear visualizaciones

#### Gráfico de Ventas por Categoría
- Tipo: Gráfico de barras o circular
- Eje X: categoria
- Eje Y: total_ventas

#### Gráfico de Categorías por Mes
- Tipo: Gráfico de líneas o barras apiladas
- Eje X: nombre_mes
- Eje Y: ventas_mes
- Leyenda: categoria

#### Cliente que Más Compra
- Tipo: Tarjeta o tabla
- Mostrar: cliente, total_compras, numero_compras

### 4. Configurar filtros y segmentadores
- Agregar segmentador por año
- Agregar segmentador por ciudad
- Configurar interacciones entre visualizaciones