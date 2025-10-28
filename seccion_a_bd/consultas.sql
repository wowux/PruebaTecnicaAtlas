-- 1. Ventas totales por mes y categoría de producto
SELECT 
    YEAR(v.fecha_venta) as año,
    MONTH(v.fecha_venta) as mes,
    p.categoria,
    SUM(v.cantidad * p.precio) as ventas_totales
FROM ventas v
JOIN productos p ON v.producto_id = p.id
GROUP BY YEAR(v.fecha_venta), MONTH(v.fecha_venta), p.categoria
ORDER BY año, mes, p.categoria;

-- 2. TOP 5 clientes con mayores compras en el último año
SELECT 
    c.nombre,
    c.ciudad,
    SUM(v.cantidad * p.precio) as total_compras
FROM clientes c
JOIN ventas v ON c.id = v.cliente_id
JOIN productos p ON v.producto_id = p.id
WHERE v.fecha_venta >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY c.id, c.nombre, c.ciudad
ORDER BY total_compras DESC
LIMIT 5;

-- 3. Vista: cliente, ciudad, total de compras, última fecha de compra
CREATE VIEW vista_resumen_clientes AS
SELECT 
    c.nombre as cliente,
    c.ciudad,
    SUM(v.cantidad * p.precio) as total_compras,
    MAX(v.fecha_venta) as ultima_fecha_compra
FROM clientes c
JOIN ventas v ON c.id = v.cliente_id
JOIN productos p ON v.producto_id = p.id
GROUP BY c.id, c.nombre, c.ciudad;