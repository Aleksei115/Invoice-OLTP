DO $$
DECLARE
    id_clientes VARCHAR(256)[] := ARRAY[
        'CLI6dec498ddf7d1f56976965944c45bec8',
        'CLI09f873dd8bc7496aff73b368fd0f3ac1',
        'CLI21656be91b1bbccaf90191f47499f993',
        'CLI2fbb60debffbfd540522ebb8ef4da111',
        'CLI16455905363878c5ff85df83b127a6f4',
        'CLI5180d566b9cae4f5f99f714d936996e0',
        'CLI9b7882a5d923cc3aa1c063368f0f9f07',
        'CLI4f609b558b5d471aaa81490f716f6418',
        'CLI462001213ec6212e54603b8c5ebbb92f',
        'CLIa067f1f6f3408d4bbf1938b4885b564d',
        'CLIae06e47ae2dce4150e754f7fda179aa5',
        'CLId71eef12a5878727e33eb14adf0eca34',
        'CLIdc2e48c42cdf66df3ed19e586803907d',
        'CLI2ff035d302f2cf828a72154acf5cbe31',
        'CLIab407e852d1f16c2fcd8643152b9a6cc',
        'CLId8a304482b30b8932db2c8a43880f47c',
        'CLI62c1a7cd45e380ef3a0a80b298e14a12'
    ];


    id_metodos VARCHAR(256)[] := ARRAY[
        'METd82347f3e8d5c7bf625b1dd3188c5be6',
        'MET0620f64ef9a5f1237c335fdd3b74d674',
        'MET8225326b9c98863071dc8a68eb5568f6',
        'MET97c71b5e84439a55760b6fc57327ed6b',
        'METf4636c40f0f29facaa46d93d4cb9cd45',
        'MET4a0bd49313569a5991f4e73eea1bb7b8',
        'METc5efdd4edcd169ce35c9524ef18a3d1e',
        'MET3938ac004330d0afcaa618fc6c77b5f4',
        'MET60862a2ba6858bdbd7463ecd71ecc6b1',
        'MET1972df956e56cdfa181d7ef652027b8f'
    ];


	cliente_id VARCHAR(256);
	id_metodo VARCHAR(256);
BEGIN
    FOREACH id_metodo IN ARRAY id_metodos
    LOOP
        FOR i IN 1..3
        LOOP
            cliente_id := id_clientes[1 + (i - 1) * 6 + floor(random() * 6)::int];
            PERFORM insertar_factura(cliente_id, id_metodo, random() > 0.5);
        END LOOP;
    END LOOP;
END;
$$;