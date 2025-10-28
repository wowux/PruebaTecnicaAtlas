import mysql.connector
import json
import pandas as pd
from datetime import datetime

class ETL:
    def __init__(self, config_file):
        with open(config_file, 'r') as f:
            self.config = json.load(f)
        
    def extract(self):
        """Extrae datos de la BD origen"""
        conn = mysql.connector.connect(**self.config['source_db'])
        
        # Extraer clientes
        clientes = pd.read_sql("SELECT * FROM clientes", conn)
        
        # Extraer productos
        productos = pd.read_sql("SELECT * FROM productos", conn)
        
        # Extraer ventas con joins
        ventas = pd.read_sql("""
            SELECT v.*, c.nombre as cliente_nombre, p.categoria, p.precio
            FROM ventas v
            JOIN clientes c ON v.cliente_id = c.id
            JOIN productos p ON v.producto_id = p.id
        """, conn)
        
        conn.close()
        return clientes, productos, ventas
    
    def transform(self, clientes, productos, ventas):
        """Transforma los datos"""
        # Agregar columna de valor total en ventas
        ventas['valor_total'] = ventas['cantidad'] * ventas['precio']
        
        # Agregar timestamp de procesamiento
        timestamp = datetime.now()
        clientes['fecha_procesamiento'] = timestamp
        productos['fecha_procesamiento'] = timestamp
        ventas['fecha_procesamiento'] = timestamp
        
        return clientes, productos, ventas
    
    def load(self, clientes, productos, ventas):
        """Carga datos en BD destino"""
        # Crear BD destino
        conn = mysql.connector.connect(
            host=self.config['target_db']['host'],
            user=self.config['target_db']['user'],
            password=self.config['target_db']['password'],
            port=self.config['target_db']['port']
        )
        cursor = conn.cursor()
        cursor.execute("CREATE DATABASE IF NOT EXISTS atlas_etl")
        conn.close()
        
        # Conectar a BD destino
        conn = mysql.connector.connect(**self.config['target_db'])
        
        # Crear tablas
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS clientes_etl (
                id INT PRIMARY KEY,
                nombre VARCHAR(100),
                ciudad VARCHAR(50),
                fecha_registro DATE,
                fecha_procesamiento DATETIME
            )
        """)
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS productos_etl (
                id INT PRIMARY KEY,
                categoria VARCHAR(50),
                precio DECIMAL(10,2),
                fecha_procesamiento DATETIME
            )
        """)
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS ventas_etl (
                id INT PRIMARY KEY,
                cliente_id INT,
                producto_id INT,
                fecha_venta DATE,
                cantidad INT,
                cliente_nombre VARCHAR(100),
                categoria VARCHAR(50),
                precio DECIMAL(10,2),
                valor_total DECIMAL(10,2),
                fecha_procesamiento DATETIME
            )
        """)
        
        # Cargar datos
        clientes.to_sql('clientes_etl', conn, if_exists='replace', index=False)
        productos.to_sql('productos_etl', conn, if_exists='replace', index=False)
        ventas.to_sql('ventas_etl', conn, if_exists='replace', index=False)
        
        conn.close()
    
    def run(self):
        """Ejecuta el proceso ETL completo"""
        print("Iniciando ETL...")
        
        # Extract
        print("Extrayendo datos...")
        clientes, productos, ventas = self.extract()
        
        # Transform
        print("Transformando datos...")
        clientes, productos, ventas = self.transform(clientes, productos, ventas)
        
        # Load
        print("Cargando datos...")
        self.load(clientes, productos, ventas)
        
        print("ETL completado exitosamente!")

if __name__ == "__main__":
    etl = ETL('config.json')
    etl.run()