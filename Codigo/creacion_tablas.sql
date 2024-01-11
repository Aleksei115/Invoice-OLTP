create table CATEGORIA (
    ID_CAT               CHAR(256)            ,
    NOMB_CAT             CHAR(40)             not null UNIQUE,
    CONSTRAINT PK_CATEGORIA PRIMARY KEY (ID_CAT),
    CONSTRAINT CHK_NOMB_CAT_UPPER CHECK (NOMB_CAT = UPPER(NOMB_CAT))  -- Nos aseguramos que sean mayusculas
);

create table PRODUCTO (
    ID_PRODUCTO          CHAR(256)            ,
    ID_CAT               CHAR(256)            ,
    DESC_PRODUCTO        CHAR(500)            not null,
    NOMB_PRODUCTO        CHAR(30)             not null UNIQUE,
    PRECIO_REGULAR       NUMERIC(10, 2)       not null,
    STOCK                DECIMAL(8)           not null,
    CONSTRAINT PK_PRODUCTO PRIMARY KEY (ID_PRODUCTO),
    CONSTRAINT FK_PRODUCTO_ETIQUETA_CATEGORI FOREIGN KEY (ID_CAT)
        REFERENCES CATEGORIA (ID_CAT)
        ON DELETE SET NULL ON UPDATE restrict,
    CONSTRAINT CK_PRECIO_REGULAR CHECK (PRECIO_REGULAR >= 0) -- Evitar tener precios negativos
);

create table TIPO_PAGO (
    ID_TIPO_P            CHAR(256)            ,
    NOMB_TIPO             CHAR(40)             not null UNIQUE,
    CONSTRAINT PK_TIPO_PAGO PRIMARY KEY (ID_TIPO_P),
    CONSTRAINT CHK_NOMB_TIPO_UPPER CHECK (NOMB_TIPO = UPPER(NOMB_TIPO))
);


create table CLIENTE (
    ID_CLIENTE           CHAR(256)            ,
    NOMBRES_CLIENTE      CHAR(50)             not null,
    APELLIDO_P_CLIENTE   CHAR(30)             not null,
    APELLIDO_M_CLIENTE   CHAR(30)             null,
    CALLE                CHAR(30)             not null,
    NO_EXT               NUMERIC(5)           not null,
    COLONIA              CHAR(30)             not null,
    CP                   CHAR(6)              not null,
    CORREO_E             CHAR(50)             not null UNIQUE,
    NUM_TELEFONO         CHAR(12)             not null UNIQUE,
    RFC                  CHAR(13)             NOT NULL UNIQUE, 
    CONSTRAINT CHK_RFC_LENGTH CHECK (LENGTH(RFC) BETWEEN 12 AND 13),
    CONSTRAINT PK_CLIENTE primary key (ID_CLIENTE)
);



create table METODO_PAGO (
    ID_METODO            CHAR(256)            ,
    ID_TIPO_P            CHAR(256)            ,
    NUM_CUENTA           CHAR(60)             null UNIQUE,
    CANTIDAD_PAGO        DECIMAL(6)           null,
    CONSTRAINT PK_METODO_PAGO PRIMARY KEY (ID_METODO),
    CONSTRAINT FK_METODO_P_POSEE_TIPO_PAG FOREIGN KEY (ID_TIPO_P)
      REFERENCES TIPO_PAGO (ID_TIPO_P)
      ON DELETE SET NULL ON UPDATE restrict,
    --   O da la cantidad de pago o da el numero de cuenta, 
    -- Pero siempre debe haber uno de los dos
    CONSTRAINT CK_PAGO_FACTURA CHECK (
            (NUM_CUENTA IS NOT NULL AND CANTIDAD_PAGO IS NULL)
            OR ( NUM_CUENTA IS NULL AND CANTIDAD_PAGO IS NOT NULL)),
    CONSTRAINT CK_NUM_CUENTA_LENGTH CHECK (
        (NUM_CUENTA IS NULL) OR (LENGTH(NUM_CUENTA) = 20)),
    CONSTRAINT CK_CANTIDAD_PAGAR CHECK (CANTIDAD_PAGO >= 0) -- Evitar tener monto negativo
);




create table FACTURA (
    ID_FACTURA           CHAR(256)            ,
    ID_CLIENTE           CHAR(256)            not null,
    ID_METODO            CHAR(256)            not null,
    FECHA_FAC            DATE                 DEFAULT CURRENT_DATE not null,
    SOLICITA_FACTURA     BOOL                 not null,
    CONSTRAINT PK_FACTURA PRIMARY KEY (ID_FACTURA),
	CONSTRAINT FK_FACTURA_PAGA_METODO_P FOREIGN KEY  (ID_METODO)
		REFERENCES METODO_PAGO (ID_METODO)
		ON DELETE restrict ON UPDATE restrict,
	CONSTRAINT FK_FACTURA_HACE_CLIENTE FOREIGN KEY (ID_CLIENTE)
	  REFERENCES CLIENTE (ID_CLIENTE)
      ON DELETE restrict ON UPDATE restrict,
    CONSTRAINT CK_FECHA CHECK (FECHA_FAC <= CURRENT_DATE)
);


create table ORDEN (
    ID_FACTURA           CHAR(256)            ,
    NUM_ORDEN            NUMERIC(8)           ,
    ID_PRODUCTO          CHAR(256)            not null,
    CANTIDAD_COMPRADA    NUMERIC(8)           not null,
    PRECIO_ACTUAL        NUMERIC(10, 2)                not null,
    CONSTRAINT PK_ORDEN PRIMARY KEY (ID_FACTURA, NUM_ORDEN),
    CONSTRAINT FK_ORDEN_CONTIENE_FACTURA FOREIGN KEY (ID_FACTURA)
      REFERENCES FACTURA (ID_FACTURA)
      ON DELETE restrict ON UPDATE restrict,
    CONSTRAINT FK_ORDEN_ADQUIERE_PRODUCTO FOREIGN KEY (ID_PRODUCTO)
      REFERENCES PRODUCTO (ID_PRODUCTO)
      ON DELETE SET NULL ON UPDATE restrict,
    CONSTRAINT CK_PRECIO_ACTUAL CHECK (PRECIO_ACTUAL >= 0)
);