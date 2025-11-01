-- CREATE DATABASE IF NOT EXISTS techstore_sales;
-- USE techstore_sales;

-- primero se crea la tabla clientes
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    email VARCHAR(255),
    ciudad VARCHAR(100)
);

-- despues se crea la tabla sucursales
CREATE TABLE IF NOT EXISTS sucursales (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sucursal VARCHAR(200) NOT NULL,
    ciudad VARCHAR(100)
);

-- seguidamente se crea la tabla ventas ya que depende de clientes y sucursales
CREATE TABLE IF NOT EXISTS ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INTEGER,
    id_sucursal INTEGER,
    fecha_venta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE SET NULL,
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal) ON DELETE SET NULL
) ENGINE=InnoDB;

-- finalmente se crea la tabla detalle_ventas que depende de ventas
CREATE TABLE IF NOT EXISTS detalle_ventas (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INTEGER NOT NULL,
    sku_producto VARCHAR(100) NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_venta_momento DECIMAL(12,2) NOT NULL CHECK (precio_venta_momento >= 0),
    
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta) ON DELETE CASCADE
) ENGINE=InnoDB;

-- se crean los índices para optimizar consultas
CREATE INDEX idx_detalle_sku ON detalle_ventas(sku_producto);

-- se crea un índice en la tabla ventas para consultas por fecha
CREATE INDEX idx_ventas_fecha ON ventas(fecha_venta);