-- Dado el nombre del cliente, conocer las órdenes que ha realizado durante el último año, 
-- especificando para cada orden, si ha solicitado factura o no

-- Luis López Martínez


SELECT F.ID_FACTURA, COUNT(O.NUM_ORDEN) AS COMPRAS, SUM(O.CANTIDAD_COMPRADA * O.PRECIO_ACTUAL) AS TOTAL, F.SOLICITA_FACTURA
FROM ORDEN O
JOIN FACTURA F ON O.ID_FACTURA = F.ID_FACTURA
WHERE F.ID_CLIENTE = (
        SELECT ID_CLIENTE FROM CLIENTE
        WHERE NOMBRES_CLIENTE = 'Juan' AND
              APELLIDO_P_CLIENTE = 'González' AND
              APELLIDO_M_CLIENTE = 'Rodríguez'
) 
AND
(
    EXTRACT(YEAR FROM F.FECHA_FAC) >= EXTRACT(YEAR FROM CURRENT_DATE) - 1
    AND EXTRACT(YEAR FROM F.FECHA_FAC) <= EXTRACT(YEAR FROM CURRENT_DATE)
) 
GROUP BY F.ID_FACTURA, F.SOLICITA_FACTURA;
    



-- Consulta 2
/*
Dado el número de un producto, conocer el número de facturas que se han solicitado del mismo por parte de los
clientes.

Solución: 
*/

-- PRO06d59484c08f8264f14d5eea1f70d7c6
-- PRO82c8c6b872f69f5734118bc6426aec6f

SELECT COUNT(*) AS "# facturas del producto PRO06d59484c08f8264f14d5eea1f70d7c6"
FROM FACTURA
WHERE SOLICITA_FACTURA = TRUE AND ID_FACTURA IN (
	SELECT ORDEN.ID_FACTURA
	FROM ORDEN
	WHERE ORDEN.ID_PRODUCTO = 'PRO06d59484c08f8264f14d5eea1f70d7c6'
);


-- Consulta 3
/*
Dado un tipo de pago, conocer el nombre de los clientes que lo usan.
*/

SELECT NOMBRES_CLIENTE as "Nombres de clientes que usan EFECTIVO para pagar"
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
					WHERE NOMB_TIPO = 'CHEQUE'
				)
		)
);


-- Consulta 4
/*
Dado un número de cuenta, conocer los métodos de pago que usa el dueño de la misma
*/
-- Número de cuenta usado: 34567890123456789012
SELECT NOMB_TIPO FROM TIPO_PAGO
	WHERE ID_TIPO_P IN (
		SELECT ID_TIPO_P FROM METODO_PAGO
			WHERE ID_METODO IN (
				SELECT ID_METODO FROM FACTURA
					WHERE ID_CLIENTE IN (
						SELECT ID_CLIENTE FROM FACTURA
							WHERE ID_METODO = (
								SELECT ID_METODO
								FROM METODO_PAGO
								WHERE NUM_CUENTA = '13345678901234567890'
							)
				)
			)
);





-- Consulta 5

SELECT C.NOMBRES_CLIENTE , F.ID_FACTURA , SUM(O.CANTIDAD_COMPRADA * O.PRECIO_ACTUAL)
FROM CLIENTE C
INNER JOIN FACTURA F ON F.ID_CLIENTE = C.ID_CLIENTE
INNER JOIN ORDEN O  ON O.ID_FACTURA = F.ID_FACTURA
WHERE EXTRACT(YEAR FROM F.FECHA_FAC) = 2023
GROUP BY C.NOMBRES_CLIENTE,F.ID_FACTURA;