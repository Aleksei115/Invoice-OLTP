
SELECT sp_inserta('ELECTRONICA');
SELECT sp_inserta('ROPA');
SELECT sp_inserta('HOGAR');
SELECT sp_inserta('DEPORTES');
SELECT sp_inserta('LIBROS');
SELECT sp_inserta('ELECTRODOMESTICOS');
SELECT sp_inserta('CALZADO');
SELECT sp_inserta('JOYERIA');
SELECT sp_inserta('JUGUETES');
SELECT sp_inserta('MUEBLES');
SELECT sp_inserta('ROPA DEPORTIVA');



SELECT insertar_producto('ELECTRONICA', 'Laptop de última generación', 'Laptop', 800, 10);
SELECT insertar_producto('ELECTRONICA', 'Smartphone de alta calidad', 'Smartphone', 400, 20);
SELECT insertar_producto('ROPA', 'Camiseta de algodón', 'Camiseta', 20, 50);
SELECT insertar_producto('ROPA', 'Jeans modernos', 'Jeans', 50, 30);
SELECT insertar_producto('HOGAR', 'Sofá cómodo para la sala', 'Sofa', 600, 5);
SELECT insertar_producto('HOGAR', 'Mesa de comedor', 'Mesa', 300, 8);
SELECT insertar_producto('DEPORTES', 'Balón de fútbol', 'Balon', 30, 20);
SELECT insertar_producto('DEPORTES', 'Raqueta de tenis', 'Raqueta', 80, 12);
SELECT insertar_producto('LIBROS', 'Novela de misterio', 'Novela', 10, 100);
SELECT insertar_producto('LIBROS', 'Libro de cocina', 'Libro de Cocina', 15, 70);
SELECT insertar_producto('ELECTRODOMESTICOS', 'Licuadora de alta potencia', 'Licuadora', 120, 15);
SELECT insertar_producto('CALZADO', 'Zapatos deportivos', 'Zapatos Deportivos', 80, 30);
SELECT insertar_producto('JOYERIA', 'Anillo de diamante', 'Anillo', 1000, 5);
SELECT insertar_producto('ELECTRONICA', 'Tablet con pantalla HD', 'Tablet', 250, 10);
SELECT insertar_producto('HOGAR', 'Silla de oficina ergonómica', 'Silla Ergonómica', 200, 20);
SELECT insertar_producto('JUGUETES', 'Muñeca de colección', 'Muñeca', 30, 50);
SELECT insertar_producto('MUEBLES', 'Sofá de cuero', 'Sofá de Cuero', 700, 10);
SELECT insertar_producto('ROPA DEPORTIVA', 'Shorts deportivos', 'Shorts Deportivos', 25, 40);
SELECT insertar_producto('JOYERIA', 'Collar de perlas', 'Collar de Perlas', 300, 15);




SELECT insertar_tipo_pago('Tarjeta Debito');
SELECT insertar_tipo_pago('Tarjeta de Credito');
SELECT insertar_tipo_pago('PayPal');
SELECT insertar_tipo_pago('TRANSFERENCIA');
SELECT insertar_tipo_pago('CHEQUE');
SELECT insertar_tipo_pago('TARJETA REGALO');
SELECT insertar_tipo_pago('PAGO APLAZADO');
SELECT insertar_tipo_pago('VISA');
SELECT insertar_tipo_pago('MASTERCARD');
SELECT insertar_tipo_pago('AMERICAN EXPRESS');
SELECT insertar_tipo_pago('EFECTIVO');



-- Llamar al procedimiento para insertar cada método de pago
SELECT insertar_metodo_pago('Tarjeta Debito', '13345678901234567890', NULL);
SELECT insertar_metodo_pago('Tarjeta de Credito', '13345678901234567810', NULL);
SELECT insertar_metodo_pago('Tarjeta Debito', '34567890123456789012', NULL);
SELECT insertar_metodo_pago('PayPal', '56789012345678901234', NULL);
SELECT insertar_metodo_pago('Tarjeta Debito', '90123456789012345678', NULL);
SELECT insertar_metodo_pago('Otro', NULL, 1500);
SELECT insertar_metodo_pago('Transferencia', '12345678901234567890', NULL);
SELECT insertar_metodo_pago('Transferencia', '23456789012345678901', NULL);
SELECT insertar_metodo_pago('Transferencia', '45678901234567890123', NULL);
SELECT insertar_metodo_pago('Visa', '12345678901234567892', NULL);


-- NO FUNCIONAN

SELECT insertar_metodo_pago('Transferencia', NULL, 8000);
SELECT insertar_metodo_pago('Cheque', '89012345678901234567', NULL);
SELECT insertar_metodo_pago('Efectivo', NULL, NULL);
SELECT insertar_metodo_pago('Tarjeta Regalo', '34567890123456789012', NULL);




SELECT insertar_cliente('Juan', 'González', 'Rodríguez', 'Avenida de los Pájaros', 123, 'Colonia Primavera', '12345', 'juan.gonzalez@gmail.com', '55-1234-5678', 'GORJ920519ABC');
SELECT insertar_cliente('María', 'Pérez', 'Hernández', 'Calle del Sol', 456, 'Colonia Los Pinos', '54321', 'maria.perez@hotmail.com', '55-2345-6719', 'PEHM890720DEF');
SELECT insertar_cliente('Luis', 'López', 'Martínez', 'Callejón de las Flores', 789, 'Colonia San Antonio', '67890', 'luis.lopez@yahoo.com', '55-3456-7891', 'LOML821013GHI');
SELECT insertar_cliente('Ana', 'García', 'Rodríguez', 'Avenida de las Rosas', 101, 'Colonia del Bosque', '10101', 'ana.garcia@comunidad.unam.mx', '55-4567-8901', 'GARA900515JKL');
SELECT insertar_cliente('Jorge', 'Rodríguez', 'Pérez', 'Paseo de la Luna', 202, 'Colonia de la Montaña', '20202', 'jorge.rodriguez@gmail.com', '55-5678-9012', 'ROJP830527MNO');
SELECT insertar_cliente('María', 'López', 'González', 'Calle 123', 123, 'Colonia A', '12345', 'maria@yahoo.com', '55-5678-9112', 'LOGM880719PQR');
SELECT insertar_cliente('Pedro', 'Martínez', 'Sánchez', 'Calle 456', 456, 'Colonia B', '23456', 'pedro@yahoo.com', '55-6789-0123', 'MASP700305STU');
SELECT insertar_cliente('Laura', 'García', 'Fernández', 'Calle 789', 789, 'Colonia C', '34567', 'laura@gmail.com', '55-7890-1234', 'GAFR740210VWX');
SELECT insertar_cliente('Javier', 'Torres', 'Rodríguez', 'Calle 101', 101, 'Colonia D', '45678', 'javier@gmail.com', '55-8901-2345', 'TORJ850607YZA');
SELECT insertar_cliente('Sofía', 'Hernández', 'López', 'Calle 112', 112, 'Colonia E', '56789', 'sofia@gmail.com', '55-9012-3456', 'HELS911213BCD');
SELECT insertar_cliente('Carlos', 'Díaz', 'Pérez', 'Calle 131', 131, 'Colonia F', '67890', 'carlos@gmail.com', '55-0123-4567', 'DIAP880724EFG');
SELECT insertar_cliente('Ana', 'Ramírez', 'Soto', 'Calle 145', 145, 'Colonia G', '78901', 'ana@gmail.com', '55-1234-5378', 'RASA890523HIJ');
SELECT insertar_cliente('Luis', 'Gómez', 'Castro', 'Calle 161', 161, 'Colonia H', '89012', 'luisGo@gmail.com', '55-2345-6781', 'GOCL810724KLM');
SELECT insertar_cliente('Laura', 'Ramírez', 'Gómez', 'Calle de la Luna', 303, 'Colonia Primavera', '54321', 'lauraRan@gmail.com', '55-2345-6789', 'RAGO840506NOP');
SELECT insertar_cliente('José', 'Martínez', 'Hernández', 'Avenida del Sol', 505, 'Colonia Los Robles', '10101', 'jose@hotmail.com', '55-3456-7893', 'MAHJ890708QRS');
SELECT insertar_cliente('Rosa', 'Díaz', 'García', 'Calle 25 de Mayo', 101, 'Colonia Flores', '67890', 'rosa@gmail.com', '55-2345-5671', 'DIGR810216TUV');
SELECT insertar_cliente('Pedro', 'Ramírez', 'Martínez', 'Avenida de las Estrellas', 303, 'Colonia Los Pinos', '54321', 'pedro_124@hotmail.com', '55-3456-6781', 'RAMG891124WXY');





-- SELECT insertar_factura('CLI660059744b5cab81d1837c31dfdaf39c', 'METbca486ea25fda0960ceadbde086bbfa8', TRUE);
-- SELECT insertar_factura('CLI0a5543d6b427691371144d0486280a32', 'METd85d222c9d221ef1e2faa703a15274fe', FALSE);
-- SELECT insertar_factura('CLI650bd9b3c8dee32cd6e49d63b41c19bb', 'METd55516674efe6e0c493cf9b9a7b06e02', TRUE);
-- SELECT insertar_factura('CLI0146371f3a7a4d934b8837bc096b789a', 'MET91f6b343a3317da7e310e219525f170f', FALSE);
-- SELECT insertar_factura('CLI4996cf14eaac57d0e3c879880312a6c2', 'METa278a7974d50726b610cf48295b5ec0c', TRUE);
-- SELECT insertar_factura('CLI72e8de6c864c4a08a1ac040ae0970745', 'MET3d6f1330af656b9a677d6947bbf26281', FALSE);


-- INSERT INTO ORDEN (ID_FACTURA, NUM_ORDEN, ID_PRODUCTO, CANTIDAD_COMPRADA, PRECIO_ACTUAL)
-- VALUES
--     ('FAC03HQX', 1, 'PROD24MFK', 1, 800),
--     ('FAC75ZJX', 2, 'PROD54KLP', 5, 20),
--     ('FAC08TAE', 1, 'PROD92QIW', 10, 400),
--     ('FAC08TAE', 2, 'PROD11AOB', 4, 50),
--     ('FAC43KQR', 1, 'PROD78XZY', 1, 600),
--     ('FAC43KQR', 2, 'PROD63RPT', 5, 300),
--     ('FAC48WWN', 1, 'PROD45HJN', 3, 30),
--     ('FAC08DXO', 1, 'PROD76FVG', 2, 80),
--     ('FAC03HQX', 2, 'PROD32DVE', 5, 10),
--     ('FAC54VLE', 1, 'PROD09LMA', 2, 15),
--     ('FAC54VLE', 2, 'PROD92QIW', 2, 450),
--     ('FAC54VLE', 3, 'PROD45HJN', 2, 15),
--     ('FAC54VLE', 4, 'PROD24MFK', 2, 750),
--     ('FAC70DTT', 1, 'PROD22XZN', 1, 120),
--     ('FAC70DTT', 2, 'PROD50PQR', 1, 1000),
--     ('FAC15RDD', 1, 'PROD16WXC', 2, 80),
--     ('FAC15RDD', 2, 'PROD45BRT', 3, 200),
--     ('FAC47JVH', 1, 'PROD92QPO', 2, 60),
--     ('FAC47JVH', 2, 'PROD34NML', 1, 700),
--     ('FAC42KUI', 1, 'PROD67BDC', 3, 75),
--     ('FAC42KUI', 2, 'PROD55XZX', 2, 600),
--     ('FAC42KUI', 3, 'PROD89SDF', 1, 600);