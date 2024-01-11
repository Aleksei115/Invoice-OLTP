CREATE OR REPLACE FUNCTION generar_clave_primaria(nombre_tabla_param CHAR(50)) RETURNS CHAR(256) AS $$
DECLARE
    prefix CHAR(3);
    full_key CHAR(256);
BEGIN
    -- Tomar las primeras 3 letras del nombre de la tabla
    prefix := LEFT(nombre_tabla_param, 3);

    -- Combinar el prefijo y los caracteres aleatorios para la clave primaria
    full_key := prefix || MD5(random()::VARCHAR(253));

    RETURN full_key;
END;$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION verificar_tipo_pago_efectivo()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.CANTIDAD_PAGO IS NOT NULL THEN
        IF (SELECT NOMB_TIPO FROM TIPO_PAGO WHERE ID_TIPO_P = NEW.ID_TIPO_P) <> 'EFECTIVO' AND (SELECT NOMB_TIPO FROM TIPO_PAGO WHERE ID_TIPO_P = NEW.ID_TIPO_P) <> 'CHEQUE' THEN
            RAISE EXCEPTION 'El tipo de pago debe ser ''EFECTIVO'' o ''CHEQUE'' si CANTIDAD_PAGO es proporcionada.';
        END IF;
    END IF;

    IF NEW.CANTIDAD_PAGO IS NULL THEN
        IF (SELECT NOMB_TIPO FROM TIPO_PAGO WHERE ID_TIPO_P = NEW.ID_TIPO_P) = 'EFECTIVO' OR (SELECT NOMB_TIPO FROM TIPO_PAGO WHERE ID_TIPO_P = NEW.ID_TIPO_P) = 'CHEQUE' THEN
            RAISE EXCEPTION 'El tipo de pago debe ser NO PUEDE SER ''EFECTIVO'' o ''CHEQUE'' si NUM_CUENTA es proporcionada.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_verificar_tipo_pago_efectivo
BEFORE INSERT OR UPDATE ON METODO_PAGO
FOR EACH ROW
EXECUTE PROCEDURE verificar_tipo_pago_efectivo();




-- Agregar categorias

CREATE OR REPLACE FUNCTION sp_inserta(nomb_cat_param CHAR(40)) RETURNS VOID AS $$
DECLARE
    id_generado VARCHAR(256);
BEGIN
    SELECT generar_clave_primaria('CATEGORIA') INTO id_generado;

    -- Verificar si la categoría ya existe
    IF EXISTS (SELECT 1 FROM CATEGORIA WHERE NOMB_CAT = nomb_cat_param) THEN
        -- La categoría ya existe, realizar un ROLLBACK
        RAISE EXCEPTION 'La categoría ya existe, se realiza un ROLLBACK.';
    ELSE
        -- La categoría no existe, realizar la inserción
        INSERT INTO CATEGORIA (ID_CAT, NOMB_CAT) VALUES (id_generado, nomb_cat_param);
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Agregar productos


CREATE OR REPLACE FUNCTION insertar_producto(nomb_cat_param CHAR(40), desc_producto_param CHAR(500), nomb_producto_param CHAR(30), precio_regular_param NUMERIC(10,2), stock_param DECIMAL(8)) RETURNS VOID AS $$
DECLARE
    id_cat_param CHAR(256);
BEGIN
    -- Buscar el ID de la categoría por su nombre
    SELECT ID_CAT INTO id_cat_param FROM CATEGORIA WHERE NOMB_CAT = nomb_cat_param;

    -- Verificar si el producto ya existe por su nombre
    IF EXISTS (SELECT 1 FROM PRODUCTO WHERE NOMB_PRODUCTO = nomb_producto_param) THEN
        -- El producto ya existe, realizar un ROLLBACK
        RAISE EXCEPTION 'El producto ya existe, se realiza un ROLLBACK.';
    ELSE
        -- El producto no existe, realizar la inserción
        INSERT INTO PRODUCTO (ID_PRODUCTO, ID_CAT, DESC_PRODUCTO, NOMB_PRODUCTO, PRECIO_REGULAR, STOCK)
        VALUES (generar_clave_primaria('PRODUCTO'), id_cat_param, desc_producto_param, nomb_producto_param, precio_regular_param, stock_param);
    END IF;
END;
$$ LANGUAGE plpgsql;


-- AGREGAR TIPO_PAGO 

CREATE OR REPLACE FUNCTION insertar_tipo_pago(nomb_tipo_param CHAR(40)) RETURNS VOID AS $$
BEGIN
    -- Verificar si el tipo de pago ya existe por su nombre
    IF EXISTS (SELECT 1 FROM TIPO_PAGO WHERE NOMB_TIPO = UPPER(nomb_tipo_param)) THEN
        -- El tipo de pago ya existe, realizar un ROLLBACK
        RAISE EXCEPTION 'El tipo de pago ya existe, se realiza un ROLLBACK.';
    ELSE
        -- El tipo de pago no existe, realizar la inserción
        INSERT INTO TIPO_PAGO (ID_TIPO_P, NOMB_TIPO) VALUES (generar_clave_primaria('TIPO_PAGO'), UPPER(nomb_tipo_param));
    END IF;
END;
$$ LANGUAGE plpgsql;



-- AGREGAR CLIENTE 

CREATE OR REPLACE FUNCTION insertar_cliente(nombres_cliente_param CHAR(50), apellido_p_cliente_param CHAR(30), apellido_m_cliente_param CHAR(30), calle_param CHAR(30), no_ext_param DECIMAL(5), colonia_param CHAR(30), cp_param CHAR(6), correo_e_param CHAR(50), num_telefono_param CHAR(12), rfc_param CHAR(13)) 
RETURNS VOID AS $$
BEGIN
    -- Verificar si el cliente ya existe por su RFC
    IF EXISTS (SELECT 1 FROM CLIENTE WHERE RFC = rfc_param) THEN
        -- El cliente ya existe, realizar un ROLLBACK
        RAISE EXCEPTION 'El cliente ya existe, se realiza un ROLLBACK.';
    ELSE
        -- El cliente no existe, realizar la inserción
        INSERT INTO CLIENTE (ID_CLIENTE, NOMBRES_CLIENTE, APELLIDO_P_CLIENTE, APELLIDO_M_CLIENTE, CALLE, NO_EXT, COLONIA, CP, CORREO_E, NUM_TELEFONO, RFC)
        VALUES (generar_clave_primaria('CLIENTE'), nombres_cliente_param, apellido_p_cliente_param, apellido_m_cliente_param, calle_param, no_ext_param, colonia_param, cp_param, correo_e_param, num_telefono_param, rfc_param);
    END IF;
END;
$$ LANGUAGE plpgsql;



-- CREAR METODO DE PAGO

CREATE OR REPLACE FUNCTION insertar_metodo_pago(tipo_pago_param char(40),num_cuenta_param CHAR(60), cantidad_pago_param DECIMAL(6))
RETURNS VOID AS $$
DECLARE
    id_tpo_var CHAR(256);
BEGIN
	SELECT ID_TIPO_P INTO id_tpo_var FROM TIPO_PAGO WHERE NOMB_TIPO = UPPER(tipo_pago_param);

    -- Verificar que se proporcione al menos uno de los campos (NUM_CUENTA o CANTIDAD_PAGO)
    IF (num_cuenta_param IS NULL AND cantidad_pago_param IS NULL) THEN
        RAISE EXCEPTION 'Se debe proporcionar al menos NUM_CUENTA o CANTIDAD_PAGO. ROLLBACK';
    END IF;


	-- Insertar el nuevo método de pago
	INSERT INTO METODO_PAGO (ID_METODO, ID_TIPO_P, NUM_CUENTA, CANTIDAD_PAGO)
	VALUES (generar_clave_primaria('METODO_PAGO'), id_tpo_var, num_cuenta_param, cantidad_pago_param);

END;
$$ LANGUAGE plpgsql;


-- CREAR FACTURA



CREATE OR REPLACE FUNCTION insertar_factura(id_cliente_param CHAR(256), id_metodo_param CHAR(256), solicita_factura_param BOOL)
RETURNS VOID AS $$
BEGIN
    -- Verificar si el cliente existe
    IF NOT EXISTS (SELECT 1 FROM CLIENTE WHERE ID_CLIENTE = id_cliente_param) THEN
        -- El cliente no existe, realizar un ROLLBACK
        RAISE EXCEPTION 'El cliente especificado no existe, se realiza un ROLLBACK.';
    ELSE
        -- Verificar si el método de pago existe
        IF NOT EXISTS (SELECT 1 FROM METODO_PAGO WHERE ID_METODO = id_metodo_param) THEN
            -- El método de pago no existe, realizar un ROLLBACK
            RAISE EXCEPTION 'El método de pago especificado no existe, se realiza un ROLLBACK.';
        ELSE
            -- El cliente y el método de pago existen, realizar la inserción en la tabla FACTURA
            INSERT INTO FACTURA (ID_FACTURA, ID_CLIENTE, ID_METODO, SOLICITA_FACTURA)
            VALUES (generar_clave_primaria('FACTURA'), id_cliente_param, id_metodo_param, solicita_factura_param);
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;




-- CREAR ORDEN 


CREATE OR REPLACE FUNCTION insertar_orden(id_factura_param CHAR(256), id_producto_param CHAR(256), cantidad_comprada_param NUMERIC(8), precio_actual_param NUMERIC(10,2) DEFAULT NULL) 
RETURNS VOID AS $$
DECLARE
    sig_num_orden_var NUMERIC(8);
BEGIN
    -- Verificar el último NUM_ORDEN de la FACTURA ASOCIADA y sumar uno para insertar el nuevo registro
    SELECT COUNT(NUM_ORDEN) + 1 INTO sig_num_orden_var FROM ORDEN WHERE ID_FACTURA = id_factura_param;

    -- Verificar si la FACTURA EXISTE
    IF NOT EXISTS (SELECT 1 FROM FACTURA WHERE ID_FACTURA = id_factura_param) THEN
        RAISE EXCEPTION 'La factura especificada no existe, se realiza un ROLLBACK.';
    ELSE
        -- Verificar si el PRODUCTO ASOCIADO EXISTE
        IF NOT EXISTS (SELECT 1 FROM PRODUCTO WHERE ID_PRODUCTO = id_producto_param) THEN
            RAISE EXCEPTION 'El producto especificado no existe, se realiza un ROLLBACK.';
        ELSE
   
            -- Si el precio_actual_param no se proporciona (es NULL), utilizar el precio del producto
            IF precio_actual_param IS NULL THEN
                SELECT PRECIO_REGULAR INTO precio_actual_param FROM PRODUCTO WHERE ID_PRODUCTO = id_producto_param;
            END IF;

            -- Realizar la inserción en la tabla ORDEN
            INSERT INTO ORDEN (ID_FACTURA, NUM_ORDEN, ID_PRODUCTO, CANTIDAD_COMPRADA, PRECIO_ACTUAL)
            VALUES (id_factura_param, sig_num_orden_var, id_producto_param, cantidad_comprada_param, precio_actual_param);
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;




/*
Descripcion de la funcion:
Dado el nombre de una categoria eliminarla, para esto se hara la busqueda de su ID dentro del procedimiento y despues se realiza su eliminacion
*/

-- Declaración de la función

CREATE OR REPLACE FUNCTION sp_borra(NOMB_CAT_PARAM CHAR(40))
RETURNS VOID AS $$
DECLARE 
    ID_CAT_VAR CHAR(256);
BEGIN

    -- Obtener el ID de la categoría
    SELECT ID_CAT INTO ID_CAT_VAR FROM CATEGORIA WHERE NOMB_CAT = NOMB_CAT_PARAM;

    -- Verificar si se encontró un ID
    IF FOUND THEN
        -- Eliminar la categoría usando el ID
        DELETE FROM CATEGORIA WHERE ID_CAT = ID_CAT_VAR;
    END IF;
END; $$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION sp_consulta(
    NOMBRES_CLIENTE_PARAM CHAR(50),
    APELLIDO_P_CLIENTE_PARAM CHAR(30),
    APELLIDO_M_CLIENTE_PARAM CHAR(30),
    ID_PRODUCTO_PARAM CHAR(256),
    NOMB_TIPO CHAR(40),
    NUM_CUENTA CHAR(60),
	FECHA_FAC_PARAM DATE) 
RETURNS VOID AS $$
DECLARE
    primera_consulta TEXT;
    segunda_consulta TEXT;
    tercera_consulta TEXT;
    cuarta_consulta TEXT;
    quinta_consulta TEXT;
BEGIN

    primera_consulta := 'SELECT TRIM(F.ID_FACTURA) AS FACTURA, COUNT(O.NUM_ORDEN) AS COMPRAS, SUM(O.CANTIDAD_COMPRADA * O.PRECIO_ACTUAL) AS TOTAL, F.SOLICITA_FACTURA
                            FROM ORDEN O
                            JOIN FACTURA F ON O.ID_FACTURA = F.ID_FACTURA
                            WHERE F.ID_CLIENTE = (
                                    SELECT ID_CLIENTE FROM CLIENTE
                                    WHERE NOMBRES_CLIENTE =' ||  quote_literal(NOMBRES_CLIENTE_PARAM)  || ' AND ' ||
                                    'APELLIDO_P_CLIENTE =' ||  quote_literal(APELLIDO_P_CLIENTE_PARAM) ||  ' AND ' ||
                                    'APELLIDO_M_CLIENTE =' ||  quote_literal(APELLIDO_M_CLIENTE_PARAM) || ' 
                            ) 
                            AND
                            (
                                EXTRACT(YEAR FROM F.FECHA_FAC) >= EXTRACT(YEAR FROM CURRENT_DATE) - 1
                                AND EXTRACT(YEAR FROM F.FECHA_FAC) <= EXTRACT(YEAR FROM CURRENT_DATE)
                            ) 
                            GROUP BY F.ID_FACTURA, F.SOLICITA_FACTURA';


    segunda_consulta := 'SELECT COUNT(*) AS "Número de facturas del producto PROD92QIW"
                            FROM FACTURA
                            WHERE SOLICITA_FACTURA = TRUE AND ID_FACTURA IN (
                                SELECT ORDEN.ID_FACTURA
                                FROM ORDEN
                                WHERE ORDEN.ID_PRODUCTO = ' || quote_literal(ID_PRODUCTO_PARAM)  || '
                            )';

    
    tercera_consulta := 'SELECT NOMBRES_CLIENTE as "Nombres de clientes que usan efectivo para pagar"
                            FROM CLIENTE
                            WHERE ID_CLIENTE IN(
                                SELECT ID_CLIENTE
                                FROM FACTURA
                                WHERE ID_METODO IN (
                                        SELECT ID_METODO
                                        FROM METODO_PAGO
                                        WHERE ID_TIPO_P IN(
                                                SELECT ID_TIPO_P
                                                FROM TIPO_PAGO
                                                WHERE NOMB_TIPO = ' || quote_literal(NOMB_TIPO) || '
                                            )
                                    )
                            )';


    cuarta_consulta := 'SELECT NOMB_TIPO
                        FROM TIPO_PAGO
                        WHERE ID_TIPO_P IN (
                            SELECT ID_TIPO_P
                            FROM METODO_PAGO
                            WHERE NUM_CUENTA = ' || quote_literal(NUM_CUENTA) ||'
                        )';

    

    quinta_consulta := 'SELECT C.NOMBRES_CLIENTE , F.ID_FACTURA , SUM(O.CANTIDAD_COMPRADA * O.PRECIO_ACTUAL)
                        FROM CLIENTE C
                        INNER JOIN FACTURA F ON F.ID_CLIENTE = C.ID_CLIENTE
                        INNER JOIN ORDEN O  ON O.ID_FACTURA = F.ID_FACTURA
                        WHERE EXTRACT(YEAR FROM F.FECHA_FAC) =' ||  quote_literal(FECHA_FAC_PARAM) || '
                        GROUP BY C.NOMBRES_CLIENTE,F.ID_FACTURA';


    EXECUTE 'COPY ('||  primera_consulta || ') TO ''C:\resultados\ordenes_ultimo_anio.csv''WITH CSV HEADER DELIMITER '',''';
    EXECUTE 'COPY ('||  segunda_consulta || ') TO ''C:\resultados\numero_facturas_solicitadas.csv''WITH CSV HEADER DELIMITER '',''';
    EXECUTE 'COPY ('||  tercera_consulta || ') TO ''C:\resultados\clientes_por_metodo_pago.csv''WITH CSV HEADER DELIMITER '',''';
    EXECUTE 'COPY ('||  cuarta_consulta  || ') TO ''C:\resultados\metodos_pago_deuno_cuenta.csv''WITH CSV HEADER DELIMITER '',''';
    EXECUTE 'COPY ('||  quinta_consulta  || ') TO ''C:\resultados\facturas_clientes_2023.csv''WITH CSV HEADER DELIMITER '',''';
END;
$$ LANGUAGE plpgsql;