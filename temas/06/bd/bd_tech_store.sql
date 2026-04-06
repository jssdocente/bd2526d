    DROP DATABASE IF EXISTS techstore;
    CREATE DATABASE techstore;
    USE techstore;

    CREATE TABLE proveedores (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        ciudad VARCHAR(50),
        activo BOOLEAN DEFAULT TRUE
    );

    CREATE TABLE clientes (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        saldo DECIMAL(10,2) DEFAULT 0.00
    );

    CREATE TABLE productos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        precio DECIMAL(10,2) NOT NULL,
        stock INT DEFAULT 0,
        proveedor_id INT,
        activo BOOLEAN DEFAULT TRUE,
        FOREIGN KEY (proveedor_id) REFERENCES proveedores(id) ON DELETE SET NULL
    );

    CREATE TABLE pedidos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
        cliente_id INT,
        total DECIMAL(10,2) DEFAULT 0.00,
        estado VARCHAR(20) DEFAULT 'PENDIENTE',
        FOREIGN KEY (cliente_id) REFERENCES clientes(id)
    );

    CREATE TABLE detalle_pedido (
        pedido_id INT,
        producto_id INT,
        cantidad INT NOT NULL,
        precio_unitario DECIMAL(10,2) NOT NULL,
        PRIMARY KEY (pedido_id, producto_id),
        FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
        FOREIGN KEY (producto_id) REFERENCES productos(id)
    );