DO $$
DECLARE
    factura_ids VARCHAR(256)[] := ARRAY[
        'FAC5888093b745a09590e759f406d6cc992',
        'FAC54659e5913928c2b8b721405ecca0545',
        'FAC07fad912707526b6a48ff403eb5813e9',
        'FACd43e1b8238e2c2b1926b5d6e9771ead1',
        'FACbc7f18639d92d61d11e57063316f8634',
        'FACeabd3c03028ce3d88ff198d4433f7bc1',
        'FACba2005dc6febb630d3eecd7a51bd4e8d',
        'FACb48889b551c9e2ac2448431597ef2761',
        'FACce8f4e08e7ebb92351a7256f4731a678',
        'FAC79ba10e674843d9fb78ea3025a96701f',
        'FAC717eb818eb7a345547f305876ff36f86',
        'FAC86d034efd2729fb85fd844b62f35082d',
        'FAC6ccffc03f75ce5a8fc1dc4abdedeb839',
        'FACa21fba7964a4f9683127ecec763d8efc',
        'FAC66a2a452274590c153bbf54f2daaf90f',
        'FACb3fff3c27c629360c79aa3cd2c7e8954',
        'FACc8d4a5ee637016d89ec61b1e905d6d0f',
        'FAC1b660c5762a505228f72c94621e115f2',
        'FAC867b6a4dd456cf54313cc687bad809d0',
        'FACb79eecc35b250f6b6bb2bbb9032a0379',
        'FAC1de1b22df40b83c3994755acade4d659',
        'FACcf5022d6942864d64c6faf15f540d524',
        'FAC5278ddf0284da59228a04046741f2c25',
        'FAC849ce4c6a6df1a1de60fbd62705f1c30',
        'FAC8c05d9008ef6868983d9f10374d2e0e3',
        'FAC188d79a2df4595f88b82225b6daeb490',
        'FACbb5304ad1b3783728362db861ebf1d8a',
        'FACcaa7e0c13083a4356c117978b0b914d8',
        'FACa2102dc86bdb245333f2869d7910210d',
        'FAC3df65257d4b74b29e72dcad09c6f659a'
    ];

    producto_ids VARCHAR(256)[] := ARRAY[
        'PRO27e440be2281274c980409899bfa6438',
        'PRO20c42ac42119d75daaaeb4bd851ee8db',
        'PRO84d16cb856504d336972b88f780e101d',
        'PRO6c52ccc69eab226d46984b88460e9784',
        'PRO3ded070aa568a54d07814f3030e9eb7a',
        'PRO20a68915fca8497b7ba567a6c672071f',
        'PRO82c8c6b872f69f5734118bc6426aec6f',
        'PRO22627a0fd711d27b338948b450923f40',
        'PRO06d59484c08f8264f14d5eea1f70d7c6',
        'PRO17f6d64b23346fc2308cba3355a62187',
        'PRO6240406232952a1d28c9169bc8f2bf54',
        'PRO47f74f6471362ef93aaaebeb8cc744fa',
        'PRO408108989c607f615bd4edef8e93a712',
        'PROde1065cdaacd8377c0dc8bb0f001993e',
        'PRO9160c2834592ed5d21901c10bd957cbe',
        'PRO6b0bf0672f634b6cddca58c2d79db903',
        'PROda12f7d3f45b3dac443d67c9849a339c',
        'PRO25e5ded89f232be4ad55601dfbe3b99d'
    ];

	producto_id VARCHAR(256);
	factura_id VARCHAR(256);
BEGIN
    FOREACH factura_id IN ARRAY factura_ids
    LOOP
        FOR i IN 1..3
        LOOP
            
            producto_id := producto_ids[1 + (i - 1) * 6 + floor(random() * 6)::int];
            PERFORM insertar_orden(factura_id, producto_id, (floor(random() * 10) + 1)::NUMERIC(8), 5::NUMERIC(10,2));
        END LOOP;
    END LOOP;
END;
$$;