-- Crear base de datos
CREATE DATABASE atlas_prueba;
USE atlas_prueba;

-- Tabla Clientes
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    fecha_registro DATE NOT NULL
);

-- Tabla Productos
CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

-- Tabla Ventas
CREATE TABLE ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    producto_id INT,
    fecha_venta DATE NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Insertar datos en Clientes
INSERT INTO clientes (nombre, ciudad, fecha_registro) VALUES
('Juan Pérez', 'Bogotá', '2023-01-15'),
('María López', 'Medellín', '2023-02-20'),
('Carlos Gómez', 'Cali', '2023-03-05'),
('Ana Torres', 'Bogotá', '2023-03-25'),
('Luis Ramírez', 'Barranquilla', '2023-04-10');

-- Insertar datos en Productos
INSERT INTO productos (categoria, precio) VALUES
('Electrónica', 500.00),
('Electrónica', 1500.00),
('Hogar', 200.00),
('Hogar', 750.00),
('Ropa', 100.00);

-- Insertar datos en Ventas
INSERT INTO ventas (cliente_id, producto_id, fecha_venta, cantidad) VALUES
(1, 1, '2023-05-01', 2),  -- Juan Pérez - Electrónica 500
(1, 3, '2023-05-15', 1),  -- Juan Pérez - Hogar 200
(2, 2, '2023-06-05', 1),  -- María López - Electrónica 1500
(3, 4, '2023-06-20', 3),  -- Carlos Gómez - Hogar 750
(3, 1, '2023-06-25', 1),  -- Carlos Gómez - Electrónica 500
(4, 5, '2023-07-10', 4),  -- Ana Torres - Ropa 100
(5, 1, '2023-07-15', 2),  -- Luis Ramírez - Electrónica 500
(5, 2, '2023-07-20', 1);  -- Luis Ramírez - Electrónica 1500