from flask import Flask, jsonify
import mysql.connector
import json

app = Flask(__name__)

# Configuración de BD
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "password",
    "database": "atlas_prueba",
    "port": 3306
}

@app.route('/ventas-por-categoria', methods=['GET'])
def ventas_por_categoria():
    """Endpoint que devuelve ventas totales por categoría"""
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor(dictionary=True)
        
        query = """
            SELECT 
                p.categoria,
                SUM(v.cantidad * p.precio) as total_ventas
            FROM ventas v
            JOIN productos p ON v.producto_id = p.id
            GROUP BY p.categoria
            ORDER BY total_ventas DESC
        """
        
        cursor.execute(query)
        resultados = cursor.fetchall()
        
        conn.close()
        
        return jsonify({
            "status": "success",
            "data": resultados
        })
        
    except Exception as e:
        return jsonify({
            "status": "error",
            "message": str(e)
        }), 500

@app.route('/health', methods=['GET'])
def health():
    """Endpoint de salud"""
    return jsonify({"status": "API funcionando correctamente"})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)