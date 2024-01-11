
-- Cuando se hagan consultas de precio de productos
create index PRODUCTO_PRECIO on PRODUCTO (PRECIO_REGULAR);

-- Para cuando se hagan consultas por nombre de cliente
create index CLIENTE_NOMB_APP on CLIENTE (NOMBRES_CLIENTE,APELLIDO_P_CLIENTE);

-- Cuantas facturas se hacen por una fecha
create index FACTURA_FECHA on FACTURA (FECHA_FAC);

-- SI se hacen consultas por numero de orden
create index ORDEN_NUM on ORDEN (NUM_ORDEN);