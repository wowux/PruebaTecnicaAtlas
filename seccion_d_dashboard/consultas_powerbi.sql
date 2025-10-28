-- Consultas para Power BI Dashboard

-- 1. Ventas por categoría
SELECT 
    p.categoria,
    SUM(v.cantidad * p.precio) as total_ventas,
    SUM(v.cantidad) as total_unidades
FROM ventas v
JOIN productos p ON v.producto_id = p.id
GROUP BY p.categoria;

-- 2. Ventas por categoría y mes
SELECT 
    p.categoria,
    YEAR(v.fecha_venta) as año,
    MONTH(v.fecha_venta) as mes,
    MONTHNAME(v.fecha_venta) as nombre_mes,
    SUM(v.cantidad * p.precio) as ventas_mes
FROM ventas v
JOIN productos p ON v.producto_id = p.id
GROUP BY p.categoria, YEAR(v.fecha_venta), MONTH(v.fecha_venta)
ORDER BY año, mes;

-- 3. Cliente que más compra
SELECT 
    c.nombre as cliente,
    c.ciudad,
    SUM(v.cantidad * p.precio) as total_compras,
    COUNT(v.id) as numero_compras,
    AVG(v.cantidad * p.precio) as promedio_compra
FROM clientes c
JOIN ventas v ON c.id = v.cliente_id
JOIN productos p ON v.producto_id = p.id
GROUP BY c.id, c.nombre, c.ciudad
ORDER BY total_compras DESC;