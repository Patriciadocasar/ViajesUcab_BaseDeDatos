--Registrar Usuario
CREATE OR REPLACE FUNCTION registrar_usuario(
    U_Correo VARCHAR,
    U_Contrasena VARCHAR,
    U_Primer_Nombre VARCHAR,
    U_Primer_Apellido VARCHAR,
    U_Rol_ID INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado JSON;
    validar_existe VARCHAR(100);
    nuevo_usuario_id INTEGER;
BEGIN
    -- Verificar si el correo ya existe
    SELECT Usu_Correo INTO validar_existe
    FROM Usuario
    WHERE Usu_Correo = U_Correo;

    IF validar_existe IS NOT NULL THEN
        resultado := json_build_object(
            'status', 'error',
            'message', format('El correo %s ya está registrado', U_Correo)
        );
        RETURN resultado;
    END IF;

    -- Insertar nuevo usuario
    INSERT INTO Usuario (
        Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Primer_Apellido, Rol_Rol_COD
    )
    VALUES (
        U_Correo, U_Contrasena, U_Primer_Nombre, U_Primer_Apellido, U_Rol_ID
    )
    RETURNING Usu_COD INTO nuevo_usuario_id;

    -- Si todo sale bien
    resultado := json_build_object(
        'status', 'success',
        'message', 'Usuario registrado correctamente',
        'usuario_ID', nuevo_usuario_id
    );
    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        resultado := json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
        RETURN resultado;
END;
$$ LANGUAGE plpgsql;

-- Iniciar Sesion
CREATE OR REPLACE FUNCTION inicio_sesion(
    correo VARCHAR,
    contrasena VARCHAR
) 
RETURNS JSON AS $$
DECLARE
    resultado JSON;
    v_usuario_id INTEGER;
    v_rol_id INTEGER;
    v_contrasena VARCHAR;
    v_primer_nombre VARCHAR;
    v_primer_apellido VARCHAR;
    v_correo VARCHAR;
BEGIN
    -- Primero verificamos si el correo existe
    SELECT Usu_COD, Rol_Rol_COD, Usu_Contrasena, Usu_Primer_Nombre, Usu_Primer_Apellido, Usu_Correo
    INTO v_usuario_id, v_rol_id, v_contrasena, v_primer_nombre, v_primer_apellido, v_correo
    FROM Usuario
    WHERE Usu_Correo = correo;

    IF NOT FOUND THEN
        -- No existe el correo
        resultado := json_build_object(
            'status', 'error',
            'message', 'Usuario no existe'
        );
    ELSE
        -- Existe el correo, verificamos contraseña
        IF v_contrasena = contrasena THEN
            resultado := json_build_object(
                'status', 'success',
                'message', 'Inicio de sesión correcto',
                'usuario_ID', v_usuario_id,
                'rol_ID', v_rol_id,
                'primerNombre', v_primer_nombre,
                'primerApellido', v_primer_apellido,
                'email', v_correo
            );
        ELSE
            resultado := json_build_object(
                'status', 'error',
                'message', 'Usuario o contraseña no coinciden'
            );
        END IF;
    END IF;

    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        resultado := json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
        RETURN resultado;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertar_aerolinea(
    Aer_Nombre VARCHAR,
    Aer_Direccion TEXT,
    Aer_Telefono NUMERIC,
    Aer_Correo VARCHAR,
    Aer_Fecha_Fundacion DATE,
    Lugar_ID INTEGER
)
RETURNS JSON AS $$
BEGIN
    INSERT INTO Aerolinea(
        Pro_Nombre,
        Pro_Direccion,
        Pro_Telefono,
        Pro_Correo,
        A_Fecha_Fundacion,
        Lugar_Lug_COD
    )
    VALUES (
        Aer_Nombre,
        Aer_Direccion,
        Aer_Telefono,
        Aer_Correo,
        Aer_Fecha_Fundacion,
        Lugar_ID
    );

    RETURN json_build_object(
        'status', 'success',
        'message', 'Aerolinea insertada correctamente'
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION consultar_aerolinea(
    Aer_ID INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado RECORD;
BEGIN
    SELECT *
    INTO resultado
    FROM Aerolinea
    WHERE Pro_COD = Aer_ID;

    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Aerolínea no encontrada'
        );
    END IF;

    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'Pro_COD', resultado.Pro_COD,
            'Pro_Nombre', resultado.Pro_Nombre,
            'Pro_Direccion', resultado.Pro_Direccion,
            'Pro_Telefono', resultado.Pro_Telefono,
            'Pro_Correo', resultado.Pro_Correo,
            'A_Fecha_Fundacion', resultado.A_Fecha_Fundacion,
            'Lugar_Lug_COD', resultado.Lugar_Lug_COD
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_aerolinea(
    Aer_ID INTEGER,
    Aer_Nombre VARCHAR,
    Aer_Direccion TEXT,
    Aer_Telefono NUMERIC,
    Aer_Correo VARCHAR,
    Aer_Fecha_Fundacion DATE,
    Lugar_ID INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado JSON;
BEGIN
    UPDATE Aerolinea
    SET 
        Pro_Nombre = Aer_Nombre,
        Pro_Direccion = Aer_Direccion,
        Pro_Telefono = Aer_Telefono,
        Pro_Correo = Aer_Correo,
        A_Fecha_Fundacion = Aer_Fecha_Fundacion,
        Lugar_Lug_COD = Lugar_ID
    WHERE Pro_COD = Aer_ID;

    IF NOT FOUND THEN
        resultado := json_build_object(
            'status', 'error',
            'message', 'No se encontró la aerolínea con el ID proporcionado'
        );
    ELSE
        resultado := json_build_object(
            'status', 'success',
            'message', 'Aerolínea actualizada correctamente',
            'Pro_COD', Aer_ID
        );
    END IF;

    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION eliminar_aerolinea(
    Aer_ID INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado JSON;
BEGIN
    DELETE FROM Aerolinea
    WHERE Pro_COD = Aer_ID;

    IF NOT FOUND THEN
        resultado := json_build_object(
            'status', 'error',
            'message', 'No se encontró la aerolínea con el ID proporcionado'
        );
    ELSE
        resultado := json_build_object(
            'status', 'success',
            'message', 'Aerolínea eliminada correctamente',
            'Pro_COD', Aer_ID
        );
    END IF;

    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION crear_rol(
    p_tipo VARCHAR
)
RETURNS JSON AS $$
DECLARE
    resultado JSON;
    nuevo_id INTEGER;
BEGIN
    INSERT INTO Rol (Rol_tipo)
    VALUES (p_tipo)
    RETURNING Rol_COD INTO nuevo_id;

    resultado := json_build_object(
        'status', 'success',
        'message', 'Rol creado correctamente',
        'Rol_COD', nuevo_id
    );

    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status','error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION consultar_roles()
RETURNS JSON AS $$
DECLARE
    resultado JSON;
BEGIN
    SELECT json_agg(row_to_json(r))
    INTO resultado
    FROM Rol r;

    IF resultado IS NULL THEN
        resultado := json_build_object(
            'status','success',
            'message','No hay roles registrados',
            'data', '[]'
        );
    ELSE
        resultado := json_build_object(
            'status','success',
            'message','Listado de roles',
            'data', resultado
        );
    END IF;

    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status','error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_rol(
    p_cod INTEGER,
    p_tipo VARCHAR
)
RETURNS JSON AS $$
DECLARE
    resultado JSON;
BEGIN
    UPDATE Rol
    SET Rol_tipo = p_tipo
    WHERE Rol_COD = p_cod;

    IF NOT FOUND THEN
        resultado := json_build_object(
            'status','error',
            'message','No se encontró el rol con el ID proporcionado'
        );
    ELSE
        resultado := json_build_object(
            'status','success',
            'message','Rol actualizado correctamente',
            'Rol_COD', p_cod
        );
    END IF;

    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status','error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_rol(
    p_cod INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado JSON;
BEGIN
    DELETE FROM Rol WHERE Rol_COD = p_cod;

    IF NOT FOUND THEN
        resultado := json_build_object(
            'status','error',
            'message','No se encontró el rol con el ID proporcionado'
        );
    ELSE
        resultado := json_build_object(
            'status','success',
            'message','Rol eliminado correctamente',
            'Rol_COD', p_cod
        );
    END IF;

    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status','error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

-- Obtener todas las tasas de cambio
CREATE OR REPLACE FUNCTION obtener_tasas_cambio()
RETURNS JSON AS $$
DECLARE
    resultado JSON;
BEGIN
    SELECT json_agg(row_to_json(t))
    INTO resultado
    FROM (
        SELECT * FROM Tasa_de_Cambio
    ) t;

    IF resultado IS NULL THEN
        resultado := json_build_object(
            'status','success',
            'message','No hay tasas registradas',
            'data', '[]'
        );
    ELSE
        resultado := json_build_object(
            'status','success',
            'message','Listado de tasas de cambio',
            'data', resultado
        );
    END IF;

    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        resultado := json_build_object('status','error','message',SQLERRM);
        RETURN resultado;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION registrar_promocion(
    P_Tipo VARCHAR,
    P_Fecha_Inicio DATE,
    P_Fecha_Fin DATE,
    P_Porcentaje NUMERIC
)
RETURNS JSON AS $$
DECLARE
    nuevo_id INTEGER;
BEGIN
    INSERT INTO Promocion (Prom_Tipo, Prom_Fecha_Inicio, Prom_Fecha_Fin, Prom_Porcentaje)
    VALUES (P_Tipo, P_Fecha_Inicio, P_Fecha_Fin, P_Porcentaje)
    RETURNING Prom_COD INTO nuevo_id;

    RETURN json_build_object(
        'status', 'success',
        'message', 'Promoción registrada correctamente',
        'Prom_COD', nuevo_id
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION consultar_promocion(
    ID INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado RECORD;
BEGIN
    SELECT *
    INTO resultado
    FROM Promocion
    WHERE Prom_COD = ID;

    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Promoción no encontrada'
        );
    END IF;

    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'Prom_COD', resultado.Prom_COD,
            'Prom_Tipo', resultado.Prom_Tipo,
            'Prom_Fecha_Inicio', resultado.Prom_Fecha_Inicio,
            'Prom_Fecha_Fin', resultado.Prom_Fecha_Fin,
            'Prom_Porcentaje', resultado.Prom_Porcentaje
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION consultar_compania_crucero(
    ID INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado RECORD;
BEGIN
    SELECT *
    INTO resultado
    FROM Compania_Crucero
    WHERE Pro_COD = ID;

    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Compañía de crucero no encontrada'
        );
    END IF;

    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'Pro_COD', resultado.Pro_COD,
            'Pro_Nombre', resultado.Pro_Nombre,
            'Pro_Direccion', resultado.Pro_Direccion,
            'Pro_Telefono', resultado.Pro_Telefono,
            'Pro_Correo', resultado.Pro_Correo,
            'CC_Fecha_Fundacion', resultado.CC_Fecha_Fundacion
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION consultar_transporte_terrestre(
    ID INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado RECORD;
BEGIN
    SELECT *
    INTO resultado
    FROM Compania_Transporte_Terrestre
    WHERE Pro_COD = ID;

    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Compañía de transporte terrestre no encontrada'
        );
    END IF;

    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'Pro_COD', resultado.Pro_COD,
            'Pro_Nombre', resultado.Pro_Nombre,
            'Pro_Direccion', resultado.Pro_Direccion,
            'Pro_Telefono', resultado.Pro_Telefono,
            'Pro_Correo', resultado.Pro_Correo
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION consultar_reclamos(
    ID INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado RECORD;
BEGIN
    SELECT *
    INTO resultado
    FROM Reclamo
    WHERE Rec_COD = ID;

    -- Si no existe
    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Reclamo no encontrado'
        );
    END IF;

    -- Si existe
    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'Rec_COD', resultado.Rec_COD,
            'Rec_Descripcion', resultado.Rec_Descripcion
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION mostrar_vuelo_json(
    id INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado RECORD;
BEGIN
    -- Obtener los datos del vuelo
    SELECT 
        V.vue_cod,
        V.avion_avi_cod,
        V.vue_huella_carbono,
        V.vue_fecha_hora_salida,
        V.vue_fecha_hora_llegada,
        V.vue_cant_millas,
        V.vue_costo,

        -- ORIGEN
        (
            SELECT L.lug_nombre
            FROM Ruta R, Terminal T, Lugar L
            WHERE R.vuelo_vue_cod = id
            AND T.ter_cod = R.terminal_ter_cod
            AND L.lug_cod = T.lugar_lug_cod
        ) AS origen,

        -- DESTINO
        (
            SELECT L.lug_nombre
            FROM Ruta R, Terminal T, Lugar L
            WHERE R.vuelo_vue_cod = id
            AND T.ter_cod = R.terminal_ter_cod
            AND L.lug_cod = T.lugar_lug_cod2
        ) AS destino,

        -- NOMBRE DEL VUELO
        (
            'Vuelo ' ||
            (SELECT L.lug_nombre
             FROM Ruta R, Terminal T, Lugar L
             WHERE R.vuelo_vue_cod = id
             AND T.ter_cod = R.terminal_ter_cod
             AND L.lug_cod = T.lugar_lug_cod
            )
            || '-' ||
            (SELECT L.lug_nombre
             FROM Ruta R, Terminal T, Lugar L
             WHERE R.vuelo_vue_cod = id
             AND T.ter_cod = R.terminal_ter_cod
             AND L.lug_cod = T.lugar_lug_cod2
            )
        ) AS nombre_vuelo
    INTO resultado
    FROM Vuelo V
    WHERE V.vue_cod = id;

    -- Si no existe
    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Vuelo no encontrado'
        );
    END IF;

    -- Si existe, devolver JSON
    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'Vue_COD', resultado.vue_cod,
            'Avion_Avi_COD', resultado.avion_avi_cod,
            'Vue_Huella_Carbono', resultado.vue_huella_carbono,
            'Vue_Fecha_Hora_Salida', resultado.vue_fecha_hora_salida,
            'Vue_Fecha_Hora_Llegada', resultado.vue_fecha_hora_llegada,
            'Vue_Cant_Millas', resultado.vue_cant_millas,
            'Vue_Costo', resultado.vue_costo,
            'Origen', resultado.origen,
            'Destino', resultado.destino,
            'Nombre_Vuelo', resultado.nombre_vuelo
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


select mostrar_vuelo_json(1);

CREATE OR REPLACE FUNCTION mostrar_crucero_json(
    id INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado RECORD;
BEGIN
    -- Obtener los datos del crucero
    SELECT 
        C.cru_cod,
        C.cru_nombre,
        C.barco_bar_cod,
        C.cru_huella_carbono,
        C.cru_fecha_hora_salida,
        C.cru_fecha_hora_lllegada,
        C.cru_cant_millas,
        C.cru_costo,

        -- ORIGEN
        (
            SELECT L.lug_nombre
            FROM Ruta R, Terminal T, Lugar L
            WHERE R.crucero_cru_cod = id
            AND T.ter_cod = R.terminal_ter_cod
            AND L.lug_cod = T.lugar_lug_cod
        ) AS origen,

        -- DESTINO
        (
            SELECT L.lug_nombre
            FROM Ruta R, Terminal T, Lugar L
            WHERE R.crucero_cru_cod = id
            AND T.ter_cod = R.terminal_ter_cod
            AND L.lug_cod = T.lugar_lug_cod2
        ) AS destino,

        -- NOMBRE DEL VIAJE
        (
            'Crucero ' ||
            (SELECT L.lug_nombre
             FROM Ruta R, Terminal T, Lugar L
             WHERE R.crucero_cru_cod = id
             AND T.ter_cod = R.terminal_ter_cod
             AND L.lug_cod = T.lugar_lug_cod
            )
            || '-' ||
            (SELECT L.lug_nombre
             FROM Ruta R, Terminal T, Lugar L
             WHERE R.crucero_cru_cod = id
             AND T.ter_cod = R.terminal_ter_cod
             AND L.lug_cod = T.lugar_lug_cod2
            )
        ) AS nombre_viaje_crucero
    INTO resultado
    FROM Crucero C
    WHERE C.cru_cod = id;

    -- Si no existe
    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Crucero no encontrado'
        );
    END IF;

    -- Si existe, devolver JSON
    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'Cru_COD', resultado.cru_cod,
            'Cru_Nombre', resultado.cru_nombre,
            'Barco_Bar_COD', resultado.barco_bar_cod,
            'Cru_Huella_Carbono', resultado.cru_huella_carbono,
            'Cru_Fecha_Hora_Salida', resultado.cru_fecha_hora_salida,
            'Cru_Fecha_Hora_Llegada', resultado.cru_fecha_hora_lllegada,
            'Cru_Cant_Millas', resultado.cru_cant_millas,
            'Cru_Costo', resultado.cru_costo,
            'Origen', resultado.origen,
            'Destino', resultado.destino,
            'Nombre_Viaje_Crucero', resultado.nombre_viaje_crucero
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION mostrar_transporte_json(
    id INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado RECORD;
BEGIN
    -- Obtener los datos del transporte
    SELECT 
        T.tra_cod,
        T.vehiculo_veh_cod,
        T.tra_huella_carbono,
        T.tra_fecha_hora_salida,
        T.tra_fecha_hora_llegada,
        T.tra_costo,

        -- ORIGEN
        (
            SELECT L.lug_nombre
            FROM Ruta R, Terminal Te, Lugar L
            WHERE R.transporte_tra_cod = id
            AND Te.ter_cod = R.terminal_ter_cod
            AND L.lug_cod = Te.lugar_lug_cod
        ) AS origen,

        -- DESTINO
        (
            SELECT L.lug_nombre
            FROM Ruta R, Terminal Te, Lugar L
            WHERE R.transporte_tra_cod = id
            AND Te.ter_cod = R.terminal_ter_cod
            AND L.lug_cod = Te.lugar_lug_cod2
        ) AS destino,

        -- NOMBRE DEL TRANSPORTE
        (
            'Transporte ' ||
            (SELECT L.lug_nombre
             FROM Ruta R, Terminal Te, Lugar L
             WHERE R.transporte_tra_cod = id
             AND Te.ter_cod = R.terminal_ter_cod
             AND L.lug_cod = Te.lugar_lug_cod
            )
            || '-' ||
            (SELECT L.lug_nombre
             FROM Ruta R, Terminal Te, Lugar L
             WHERE R.transporte_tra_cod = id
             AND Te.ter_cod = R.terminal_ter_cod
             AND L.lug_cod = Te.lugar_lug_cod2
            )
        ) AS nombre_transporte
    INTO resultado
    FROM Transporte T
    WHERE T.tra_cod = id;

    -- Si no existe
    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Transporte no encontrado'
        );
    END IF;

    -- Si existe, devolver JSON
    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'Tra_COD', resultado.tra_cod,
            'Vehiculo_Veh_COD', resultado.vehiculo_veh_cod,
            'Tra_Huella_Carbono', resultado.tra_huella_carbono,
            'Tra_Fecha_Hora_Salida', resultado.tra_fecha_hora_salida,
            'Tra_Fecha_Hora_Llegada', resultado.tra_fecha_hora_llegada,
            'Tra_Costo', resultado.tra_costo,
            'Origen', resultado.origen,
            'Destino', resultado.destino,
            'Nombre_Transporte', resultado.nombre_transporte
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION filtrar_pais_json()
RETURNS JSON AS $$
BEGIN
    RETURN (
        SELECT json_build_object(
            'status', 'success',
            'paises',
            json_agg(
                json_build_object(
                    'direccion', L.lug_nombre,
                    'lug_cod', L.lug_cod
                )
                ORDER BY L.lug_nombre
            )
        )
        FROM Lugar L
        WHERE L.lug_tipo = 'Pais'
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_direcciones_filtro()
RETURNS JSON
LANGUAGE plpgsql AS
$$
BEGIN
    RETURN (
        SELECT json_build_object(
            'direcciones',
            json_agg(
                json_build_object(
                    'lug_cod', Lug_COD,
                    'direccion', direccion
                )
                ORDER BY direccion
            )
        )
        FROM (
            -- Países
            SELECT p.Lug_COD,
                   p.Lug_Nombre AS direccion
            FROM Lugar p
            WHERE p.Lug_Tipo = 'Pais'

            UNION ALL

            -- Regiones con su país
            SELECT r.Lug_COD,
                   r.Lug_Nombre || ', ' || p.Lug_Nombre AS direccion
            FROM Lugar r
            JOIN Lugar p ON r.Lugar_Lug_COD = p.Lug_COD
            WHERE p.Lug_Tipo = 'Pais'
              AND r.Lug_Tipo = 'Region'
        ) sub
    );
END;
$$;

--Registrar Usuario
CREATE OR REPLACE FUNCTION registrar_usuario_cliente(
    U_Correo VARCHAR,
    U_Contrasena VARCHAR,
    U_Primer_Nombre VARCHAR,
    U_Primer_Apellido VARCHAR,
    U_Rol_ID INTEGER,
    C_Primer_Nombre VARCHAR,
    C_Segundo_Nombre VARCHAR,
    C_Apellido VARCHAR,
    C_Segundo_Apellido VARCHAR,
    C_Fecha_Nacimiento DATE,
    C_Estado_Civil VARCHAR,
    C_Lugar_ID INTEGER
) RETURNS JSON AS $$
DECLARE
    resultado JSON;
    validar_existe VARCHAR(100);
    nuevo_usuario_id INTEGER;
    nuevo_cliente_id INTEGER;
BEGIN
    -- Verificar si el correo ya existe
    SELECT Usu_Correo INTO validar_existe
    FROM Usuario
    WHERE Usu_Correo = U_Correo;

    IF validar_existe IS NOT NULL THEN
        resultado := json_build_object(
            'status', 'error',
            'message', format('El correo %s ya está registrado', U_Correo)
        );
        RETURN resultado;
    END IF;

    -- Insertar nuevo cliente primero
    INSERT INTO Cliente (
        Cli_Primer_Nombre, Cli_Segundo_Nombre, Cli_Apellido, Cli_Segundo_Apellido,
        Cli_Fecha_Nacimiento, Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD
    )
    VALUES (
        C_Primer_Nombre, C_Segundo_Nombre, C_Apellido, C_Segundo_Apellido,
        C_Fecha_Nacimiento, C_Estado_Civil, 0, C_Lugar_ID
    )
    RETURNING Cli_COD INTO nuevo_cliente_id;

    -- Insertar usuario con referencia al cliente
    INSERT INTO Usuario (
        Usu_Correo, Usu_Contrasena, Usu_Primer_Nombre, Usu_Primer_Apellido, Rol_Rol_COD, Cliente_Cli_COD
    )
    VALUES (
        U_Correo, U_Contrasena, U_Primer_Nombre, U_Primer_Apellido, U_Rol_ID, nuevo_cliente_id
    )
    RETURNING Usu_COD INTO nuevo_usuario_id;

    -- Resultado final
    resultado := json_build_object(
        'status', 'success',
        'message', 'Usuario y cliente registrados correctamente',
        'usuario_ID', nuevo_usuario_id,
        'cliente_ID', nuevo_cliente_id
    );
    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        resultado := json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
        RETURN resultado;
END;
$$ LANGUAGE plpgsql;

--Iniciar Sesion
-- Iniciar Sesion
CREATE OR REPLACE FUNCTION inicio_sesion(
    correo VARCHAR,
    contrasena VARCHAR
) 
RETURNS JSON AS $$
DECLARE
    resultado JSON;
    v_usuario_id INTEGER;
    v_rol_id INTEGER;
    v_contrasena VARCHAR;
    v_primer_nombre VARCHAR;
    v_primer_apellido VARCHAR;
    v_correo VARCHAR;
BEGIN
    -- Primero verificamos si el correo existe
    SELECT Usu_COD, Rol_Rol_COD, Usu_Contrasena, Usu_Primer_Nombre, Usu_Primer_Apellido, Usu_Correo
    INTO v_usuario_id, v_rol_id, v_contrasena, v_primer_nombre, v_primer_apellido, v_correo
    FROM Usuario
    WHERE Usu_Correo = correo;

    IF NOT FOUND THEN
        -- No existe el correo
        resultado := json_build_object(
            'status', 'error',
            'message', 'Usuario no existe'
        );
    ELSE
        -- Existe el correo, verificamos contraseña
        IF v_contrasena = contrasena THEN
            resultado := json_build_object(
                'status', 'success',
                'message', 'Inicio de sesión correcto',
                'usuario_ID', v_usuario_id,
                'rol_ID', v_rol_id,
                'primerNombre', v_primer_nombre,
                'primerApellido', v_primer_apellido,
                'email', v_correo
            );
        ELSE
            resultado := json_build_object(
                'status', 'error',
                'message', 'Usuario o contraseña no coinciden'
            );
        END IF;
    END IF;

    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        resultado := json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
        RETURN resultado;
END;
$$ LANGUAGE plpgsql;


--PARA TRANSPORTE TERRESTRE
CREATE OR REPLACE FUNCTION mostrar_transporte(
    id INTEGER
)
RETURNS TABLE(
    Tra_COD INTEGER,
    Vehiculo_Veh_COD INTEGER,
    Tra_Huella_Carbono NUMERIC,
    Tra_Fecha_Hora_Salida TIMESTAMP,
    Tra_Fecha_Hora_Llegada TIMESTAMP,
    Tra_Costo NUMERIC,
    Origen VARCHAR,
    Destino VARCHAR,
    Nombre_Transporte TEXT
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        T.TT_COD,
        T.Vehiculo_Veh_COD,
        T.TT_Huella_Carbono,
        T.TT_Fecha_Hora_Salida,
        T.TT_Fecha_Hora_Llegada,
        T.TT_Costo,

        -- ORIGEN
        (
            SELECT L.Lug_Nombre
            FROM Ruta R
            JOIN Terminal Te ON Te.Ter_COD = R.Terminal_Ter_COD
            JOIN Lugar L ON L.Lug_COD = Te.Lugar_Lug_COD
            WHERE R.Transporte_Terrestre_TT_COD = id
            ORDER BY R.Rut_Fecha_Hora_Salida
            LIMIT 1
        ) AS Origen,

        -- DESTINO
        (
            SELECT L.Lug_Nombre
            FROM Ruta R
            JOIN Terminal Te ON Te.Ter_COD = R.Terminal_Ter_COD
            JOIN Lugar L ON L.Lug_COD = Te.Lugar_Lug_COD2
            WHERE R.Transporte_Terrestre_TT_COD = id
            ORDER BY R.Rut_Fecha_Hora_Llegada DESC
            LIMIT 1
        ) AS Destino,

        -- NOMBRE DEL TRANSPORTE
        (
            'Transporte ' ||
            (
                SELECT L.Lug_Nombre
                FROM Ruta R
                JOIN Terminal Te ON Te.Ter_COD = R.Terminal_Ter_COD
                JOIN Lugar L ON L.Lug_COD = Te.Lugar_Lug_COD
                WHERE R.Transporte_Terrestre_TT_COD = id
                ORDER BY R.Rut_Fecha_Hora_Salida
                LIMIT 1
            )
            || ' - ' ||
            (
                SELECT L.Lug_Nombre
                FROM Ruta R
                JOIN Terminal Te ON Te.Ter_COD = R.Terminal_Ter_COD
                JOIN Lugar L ON L.Lug_COD = Te.Lugar_Lug_COD2
                WHERE R.Transporte_Terrestre_TT_COD = id
                ORDER BY R.Rut_Fecha_Hora_Llegada DESC
                LIMIT 1
            )
        ) AS Nombre_Transporte

    FROM Transporte_Terrestre T
    WHERE T.TT_COD = id;
END;
$$ LANGUAGE plpgsql;

--PARA MOSTRAR LOS HOSPEDAJES Y SU HOTEL
CREATE OR REPLACE FUNCTION mostrar_hospedaje(
    id INTEGER
)
RETURNS TABLE(
    Hos_COD INTEGER,
    Hotel_Hot_COD INTEGER,
    Hos_Fecha_Hora_Inicio TIMESTAMP,
    Hos_Fecha_Hora_Fin TIMESTAMP,
    Hot_Cant_Millas NUMERIC,
    Hos_Costo NUMERIC,
    Ubicacion VARCHAR,
    Nombre_Hotel VARCHAR,
    Nombre_Hospedaje TEXT
)
AS $$
BEGIN
RETURN QUERY
    SELECT 
        Ho.hos_cod,
        Ho.hotel_pro_cod,
        Ho.hos_fecha_hora_inicio,
        Ho.hos_fecha_hora_fin,
        Ho.hot_cant_millas,
        Ho.hos_costo,

        -- UBICACIÓN
        (
            SELECT 
                L.lug_nombre || ', ' || H.pro_direccion
            FROM Hotel H, Lugar L
            WHERE H.pro_cod = Ho.hotel_pro_cod
            AND L.lug_cod = H.lugar_lug_cod
        ) AS ubicacion,

        -- NOMBRE DEL HOTEL
        (
            SELECT 
                H.pro_nombre
            FROM Hotel H
            WHERE H.pro_cod = Ho.hotel_pro_cod
        ) AS nombre_hotel,

        -- NOMBRE DEL HOSPEDAJE
        (
            'Hospedaje en ' ||
            (
                SELECT 
                    H.pro_nombre
                FROM Hotel H
                WHERE H.pro_cod = Ho.hotel_pro_cod
            )
        ) AS nombre_hospedaje

    FROM Hospedaje Ho
    WHERE Ho.hos_cod = id;
END;
$$ LANGUAGE plpgsql;


--PARA MOSTRAR RESTAURANTE 
CREATE OR REPLACE FUNCTION mostrar_restaurante(
    id INTEGER
)
RETURNS JSON
AS $$
DECLARE
    resultado JSON;
BEGIN
    SELECT row_to_json(t)
    INTO resultado
    FROM (
        SELECT 
            R.rest_cod,
            R.rest_nombre,
            R.rest_direccion,
            R.rest_clasificacion,
            R.lugar_lug_cod,
            R.rest_tipo_comida,
            R.rest_ambiente,

            -- UBICACIÓN COMPLETA
            (
                SELECT 
                    L.lug_nombre || ', ' || R.rest_direccion
                FROM Lugar L
                WHERE L.lug_cod = R.lugar_lug_cod
            ) AS ubicado_en

        FROM Restaurante R
        WHERE R.rest_cod = id
    ) t;

    RETURN resultado;
END;
$$ LANGUAGE plpgsql;

--PARA MOSTRAR SERVICIO ADICIONAL
CREATE OR REPLACE FUNCTION mostrar_servicio_adicional(
    id INTEGER
)
RETURNS JSON
AS $$
DECLARE
    resultado JSON;
BEGIN
    SELECT row_to_json(t)
    INTO resultado
    FROM (
        SELECT 
            S.SA_COD,
            S.SA_Tipo,
            S.SA_Nombre,
            S.Operador_Turistico_Pro_COD,
            S.SA_Descripcion,
            S.SA_Costo,
            S.SA_Cant_Milla,
            S.SA_Fecha_Hora_Inicio,
            S.SA_Fecha_Hora_Fin,

            -- UBICACIÓN DEL OPERADOR
            (
                SELECT 
                    L.lug_nombre || ', ' || O.pro_direccion
                FROM Operador_Turistico O, Lugar L
                WHERE O.pro_cod = S.Operador_Turistico_Pro_COD
                AND L.lug_cod = O.lugar_lug_cod
            ) AS ubicacion

        FROM Servicio_Adicional S
        WHERE S.SA_cod = id
    ) t;

    RETURN resultado;
END;
$$ LANGUAGE plpgsql;


--PARA MOSTRAR OPERADOR TURISTICO
CREATE OR REPLACE FUNCTION consultar_operador_turistico(
    ID INTEGER
)
RETURNS JSON
AS $$
DECLARE
    resultado RECORD;
BEGIN
    -- Buscar el operador turístico
    SELECT *
    INTO resultado
    FROM Operador_Turistico
    WHERE Pro_COD = ID;

    -- Si no existe
    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Operador turístico no encontrado'
        );
    END IF;

    -- Si existe, devolver JSON
    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'Pro_COD', resultado.Pro_COD,
            'Pro_Nombre', resultado.Pro_Nombre,
            'Pro_Direccion', resultado.Pro_Direccion,
            'Pro_Telefono', resultado.Pro_Telefono,
            'Pro_Correo', resultado.Pro_Correo,
            'Lugar_Lug_COD', resultado.Lugar_Lug_COD
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


--PARA MOSTRAR USUARIOS 
CREATE OR REPLACE FUNCTION mostrar_usuario(
    id INTEGER
)
RETURNS JSON
AS $$
DECLARE
    resultado RECORD;
BEGIN
    -- Buscar el usuario
    SELECT *
    INTO resultado
    FROM Usuario
    WHERE Usu_COD = id;

    -- Si no existe
    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Usuario no encontrado'
        );
    END IF;

    -- Si existe, devolver JSON
    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'Usu_COD', resultado.Usu_COD,
            'Usu_Primer_Nombre', resultado.Usu_Primer_Nombre,
            'Usu_Primer_Apellido', resultado.Usu_Primer_Apellido,
            'Usu_Segundo_Nombre', resultado.Usu_Segundo_Nombre,
            'Usu_Segundo_Apellido', resultado.Usu_Segundo_Apellido,
            'Usu_Correo', resultado.Usu_Correo,
            'Usu_Contrasena', resultado.Usu_Contrasena,
            'Cliente_Cli_COD', resultado.Cliente_Cli_COD,
            'Compania_Crucero', resultado.Compania_Crucero,
            'Operador_Turistico', resultado.Operador_Turistico,
            'Aerolinea', resultado.Aerolinea,
            'Transporte_Terrestre', resultado.Transporte_Terrestre,
            'Hotel', resultado.Hotel,
            'Empleado_Emp_COD', resultado.Empleado_Emp_COD,
            'Rol_Rol_COD', resultado.Rol_Rol_COD
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


--Obtener pasajeros 
CREATE OR REPLACE FUNCTION insertar_pasajero(
    p_Primer_Nombre VARCHAR,
    p_Primer_Apellido VARCHAR,
    p_Fecha_Nacimiento DATE,
    p_Estado_Civil VARCHAR,
    p_Segundo_Nombre VARCHAR DEFAULT NULL,
    p_Segundo_Apellido VARCHAR DEFAULT NULL
)
RETURNS VOID
AS $$
BEGIN
    INSERT INTO Pasajero (Pas_Primer_Nombre, Pas_Segundo_Nombre, Pas_Primer_Apellido, Pas_Segundo_Apellido, Pas_Fecha_Nacimiento, Pas_Estado_Civil)
    VALUES (p_Primer_Nombre, p_Segundo_Nombre, p_Primer_Apellido, p_Segundo_Apellido, p_Fecha_Nacimiento, p_Estado_Civil);
END;
$$ LANGUAGE plpgsql;


--Obtener documentos
CREATE OR REPLACE FUNCTION obtener_documento(
    d_Nombre VARCHAR,
    d_Numero_Identificacion VARCHAR,
    d_Fecha_Emision DATE,
    d_Fecha_Vencimiento DATE
)
RETURNS VOID 
AS $$
BEGIN
INSERT INTO Documento (Doc_Nombre, Doc_Numero_Identificacion, Doc_Fecha_Emision, Doc_Fecha_Vencimiento)
VALUES (d_Nombre, d_Numero_Identificacion, d_Fecha_Emision, d_Fecha_Vencimiento);
END;
$$ LANGUAGE plpgsql;


--Obtener metodo de pago
CREATE OR REPLACE FUNCTION obtener_metodo_pago(
    p_id INTEGER
)
RETURNS TABLE (
    MP_COD INTEGER,
    Tipo VARCHAR,
    Fecha_Registro TIMESTAMP,

    Num_Tarjeta NUMERIC,
    Cod_Seguridad NUMERIC,
    Emisor VARCHAR,
    Marca VARCHAR,
    Fecha_Vencimiento DATE,
    Nombre_Titular VARCHAR,

    Id_Transaccion VARCHAR,
    Fecha_Hora TIMESTAMP,
    Monto NUMERIC,

    Cod_Cuenta_Cliente NUMERIC,
    Num_Cheque NUMERIC,
    Banco_Emisor VARCHAR,
    Fecha_Emision DATE,

    Tipo_Moneda VARCHAR,

    Num_Cuenta_Destino NUMERIC,
    Banco VARCHAR,
    Fecha DATE,
    Num_Referencia NUMERIC,

    Num_Confirmacion NUMERIC,
    Monto_Billetera NUMERIC
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        mp.MP_COD,
        mp.Tipo,
        mp.Fecha_Registro,

        mp.Num_Tarjeta,
        mp.Cod_Seguridad,
        mp.Emisor,
        mp.Marca,
        mp.Fecha_Vencimiento,
        mp.Nombre_Titular,

        mp.Id_Transaccion,
        mp.Fecha_Hora,
        mp.Monto,

        mp.Cod_Cuenta_Cliente,
        mp.Num_Cheque,
        mp.Banco_Emisor,
        mp.Fecha_Emision,

        mp.Tipo_Moneda,

        mp.Num_Cuenta_Destino,
        mp.Banco,
        mp.Fecha,
        mp.Num_Referencia,

        mp.Num_Confirmacion,
        mp.Monto_Billetera
    FROM Metodo_de_Pago mp
    WHERE mp.MP_COD = p_id;
END;
$$ LANGUAGE plpgsql;

--PARA PAQUETE 
-- =====================================================================
-- Función: insertar_paquete_turistico
-- Descripción: Inserta un nuevo paquete turístico en la base de datos.
--              Si el paquete es de tipo "Especial", se debe especificar
--              el tipo de restricción (Edad o Estado Civil) que se 
--              guardará automáticamente en la tabla Restriccion_Paquete.
-- 
-- Parámetros:
--   - PaqTur_Restriccion_Tipo: 'Edad' o 'Estado Civil' (OBLIGATORIO si tipo = 'Especial')
--   - PaqTur_Restriccion_Descripcion: Descripción de la restricción (OPCIONAL)
--
-- Ejemplo de uso para paquete especial:
--   SELECT insertar_paquete_turistico(
--       'Paquete Luna de Miel',
--       'Viaje romántico todo incluido',
--       5000.00,
--       2500.00,
--       400,
--       'Especial',
--       'Estado Civil',
--       'Exclusivo para parejas casadas'
--   );
-- =====================================================================
CREATE OR REPLACE FUNCTION insertar_paquete_turistico(
    PaqTur_Nombre VARCHAR,
    PaqTur_Descripcion TEXT,
    PaqTur_Costo NUMERIC,
    PaqTur_Costo_Millas NUMERIC,
    PaqTur_Cant_Milla NUMERIC,
    PaqTur_Tipo VARCHAR,
    PaqTur_Restriccion_Tipo VARCHAR DEFAULT NULL,
    PaqTur_Restriccion_Descripcion TEXT DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
    nuevo_id INTEGER;
    restriccion_id INTEGER;
BEGIN
    -- Validar que si es especial, debe tener tipo de restricción
    IF LOWER(PaqTur_Tipo) = 'especial' AND PaqTur_Restriccion_Tipo IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Los paquetes especiales requieren especificar el tipo de restricción (Edad o Estado Civil)'
        );
    END IF;

    -- Validar que el tipo de restricción sea válido
    IF PaqTur_Restriccion_Tipo IS NOT NULL AND 
       LOWER(PaqTur_Restriccion_Tipo) NOT IN ('edad', 'estado civil') THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El tipo de restricción debe ser "Edad" o "Estado Civil"'
        );
    END IF;

    -- Insertar el paquete turístico
    INSERT INTO Paquete_Turistico(
        PT_Nombre,
        PT_Descripcion,
        PT_Costo,
        PT_Costo_Millas,
        PT_Cant_Milla,
        PT_Tipo
    )
    VALUES (
        PaqTur_Nombre,
        PaqTur_Descripcion,
        PaqTur_Costo,
        PaqTur_Costo_Millas,
        PaqTur_Cant_Milla,
        PaqTur_Tipo
    )
    RETURNING PT_COD INTO nuevo_id;

    -- Si es un paquete especial, insertar la restricción
    IF LOWER(PaqTur_Tipo) = 'especial' AND PaqTur_Restriccion_Tipo IS NOT NULL THEN
        INSERT INTO Restriccion_Paquete(
            RP_Tipo,
            RP_Descripción,
            Paquete_Turistico_PT_COD
        )
        VALUES (
            PaqTur_Restriccion_Tipo,
            COALESCE(PaqTur_Restriccion_Descripcion, 'Restricción de ' || PaqTur_Restriccion_Tipo),
            nuevo_id
        )
        RETURNING RP_COD INTO restriccion_id;

        RETURN json_build_object(
            'status', 'success',
            'message', 'Paquete turístico especial insertado correctamente con restricción',
            'id', nuevo_id,
            'restriccion_id', restriccion_id,
            'tipo_restriccion', PaqTur_Restriccion_Tipo
        );
    END IF;

    RETURN json_build_object(
        'status', 'success',
        'message', 'Paquete turístico insertado correctamente',
        'id', nuevo_id
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION consultar_paquete_turistico(
    PaqTur_ID INTEGER
)
RETURNS JSON
AS $$
DECLARE
    resultado RECORD;
BEGIN
    -- Buscar el paquete turístico
    SELECT 
        PT_COD,
        PT_Nombre,
        PT_Descripcion,
        PT_Costo,
        PT_Costo_Millas,
        PT_Cant_Milla,
        PT_Tipo
    INTO resultado
    FROM Paquete_Turistico
    WHERE PT_COD = PaqTur_ID;

    -- Si no existe
    IF resultado IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Paquete turístico no encontrado'
        );
    END IF;

    -- Si existe, devolver JSON
    RETURN json_build_object(
        'status', 'success',
        'data', json_build_object(
            'PT_COD', resultado.PT_COD,
            'PT_Nombre', resultado.PT_Nombre,
            'PT_Descripcion', resultado.PT_Descripcion,
            'PT_Costo', resultado.PT_Costo,
            'PT_Costo_Millas', resultado.PT_Costo_Millas,
            'PT_Cant_Milla', resultado.PT_Cant_Milla,
            'PT_Tipo', resultado.PT_Tipo
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


-- =====================================================================
-- Función: actualizar_paquete_turistico
-- Descripción: Actualiza un paquete turístico existente.
--              Si el paquete cambia a tipo "Especial", se debe especificar
--              el tipo de restricción que se guardará en Restriccion_Paquete.
--              Si cambia de "Especial" a "Regular", las restricciones se eliminan.
-- 
-- Parámetros:
--   - PaqTur_Restriccion_Tipo: 'Edad' o 'Estado Civil' (OBLIGATORIO si tipo = 'Especial')
--   - PaqTur_Restriccion_Descripcion: Descripción de la restricción (OPCIONAL)
--
-- Ejemplo de uso:
--   SELECT actualizar_paquete_turistico(
--       1,
--       'Paquete Quinceañera',
--       'Viaje especial para celebrar los 15 años',
--       3000.00,
--       1500.00,
--       250,
--       'Especial',
--       'Edad',
--       'Exclusivo para personas de 15 años'
--   );
-- =====================================================================
CREATE OR REPLACE FUNCTION actualizar_paquete_turistico(
    PaqTur_ID INTEGER,
    PaqTur_Nombre VARCHAR,
    PaqTur_Descripcion TEXT,
    PaqTur_Costo NUMERIC,
    PaqTur_Costo_Millas NUMERIC,
    PaqTur_Cant_Milla NUMERIC,
    PaqTur_Tipo VARCHAR,
    PaqTur_Restriccion_Tipo VARCHAR DEFAULT NULL,
    PaqTur_Restriccion_Descripcion TEXT DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
    filas_actualizadas INTEGER;
    restriccion_existente INTEGER;
    restriccion_id INTEGER;
BEGIN
    -- Validar que el paquete existe
    IF NOT EXISTS (SELECT 1 FROM Paquete_Turistico WHERE PT_COD = PaqTur_ID) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Paquete turístico no encontrado'
        );
    END IF;

    -- Validar que si es especial, debe tener tipo de restricción
    IF LOWER(PaqTur_Tipo) = 'especial' AND PaqTur_Restriccion_Tipo IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Los paquetes especiales requieren especificar el tipo de restricción (Edad o Estado Civil)'
        );
    END IF;

    -- Validar que el tipo de restricción sea válido
    IF PaqTur_Restriccion_Tipo IS NOT NULL AND 
       LOWER(PaqTur_Restriccion_Tipo) NOT IN ('edad', 'estado civil') THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El tipo de restricción debe ser "Edad" o "Estado Civil"'
        );
    END IF;

    -- Actualizar el paquete turístico
    UPDATE Paquete_Turistico
    SET
        PT_Nombre = PaqTur_Nombre,
        PT_Descripcion = PaqTur_Descripcion,
        PT_Costo = PaqTur_Costo,
        PT_Costo_Millas = PaqTur_Costo_Millas,
        PT_Cant_Milla = PaqTur_Cant_Milla,
        PT_Tipo = PaqTur_Tipo
    WHERE PT_COD = PaqTur_ID;

    -- Verificar si ya existe una restricción para este paquete
    SELECT RP_COD INTO restriccion_existente
    FROM Restriccion_Paquete
    WHERE Paquete_Turistico_PT_COD = PaqTur_ID
    LIMIT 1;

    -- Si el paquete es especial, crear o actualizar la restricción
    IF LOWER(PaqTur_Tipo) = 'especial' AND PaqTur_Restriccion_Tipo IS NOT NULL THEN
        IF restriccion_existente IS NOT NULL THEN
            -- Actualizar restricción existente
            UPDATE Restriccion_Paquete
            SET
                RP_Tipo = PaqTur_Restriccion_Tipo,
                RP_Descripción = COALESCE(PaqTur_Restriccion_Descripcion, 'Restricción de ' || PaqTur_Restriccion_Tipo)
            WHERE RP_COD = restriccion_existente;
        ELSE
            -- Crear nueva restricción
            INSERT INTO Restriccion_Paquete(
                RP_Tipo,
                RP_Descripción,
                Paquete_Turistico_PT_COD
            )
            VALUES (
                PaqTur_Restriccion_Tipo,
                COALESCE(PaqTur_Restriccion_Descripcion, 'Restricción de ' || PaqTur_Restriccion_Tipo),
                PaqTur_ID
            );
        END IF;
    ELSE
        -- Si cambió a regular, eliminar las restricciones
        IF restriccion_existente IS NOT NULL THEN
            DELETE FROM Restriccion_Paquete
            WHERE Paquete_Turistico_PT_COD = PaqTur_ID;
        END IF;
    END IF;

    RETURN json_build_object(
        'status', 'success',
        'message', 'Paquete turístico actualizado correctamente',
        'id', PaqTur_ID,
        'tipo_restriccion', PaqTur_Restriccion_Tipo
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION eliminar_paquete_turistico(
    PaqTur_ID INTEGER
)
RETURNS JSON AS $$
DECLARE
    filas_eliminadas INTEGER;
BEGIN
    DELETE FROM Paquete_Turistico
    WHERE PT_COD = PaqTur_ID
    RETURNING 1 INTO filas_eliminadas;

    -- Si no se eliminó nada
    IF filas_eliminadas IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Paquete turístico no encontrado'
        );
    END IF;

    -- Eliminación exitosa
    RETURN json_build_object(
        'status', 'success',
        'message', 'Paquete turístico eliminado correctamente',
        'id', PaqTur_ID
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;




--Crear una reserva y uno o varios itinerarios asociados

CREATE OR REPLACE FUNCTION crear_itinerario_con_reserva(
    p_cliente_id INTEGER,
    
    -- Datos de la Reserva
    p_res_camarote VARCHAR DEFAULT NULL,
    
    -- Datos del Itinerario (pueden ser arrays por si hay varios itinerarios)
    p_paquete_turistico_ids INTEGER[] DEFAULT NULL,
    p_hospedaje_ids INTEGER[] DEFAULT NULL,
    p_restaurante_ids INTEGER[] DEFAULT NULL,
    p_vuelo_ids INTEGER[] DEFAULT NULL,
    p_crucero_ids INTEGER[] DEFAULT NULL,
    p_transporte_terrestre_ids INTEGER[] DEFAULT NULL,
    p_servicio_adicional_ids INTEGER[] DEFAULT NULL,
    p_fechas_inicio DATE[] DEFAULT NULL,
    p_fechas_fin DATE[] DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
    v_resultado JSON;
    v_nueva_reserva_id INTEGER;
    v_numero_reserva INTEGER;
    v_subtotal NUMERIC(8,2) := 0;
    v_total NUMERIC(8,2) := 0;
    v_millas_obtenidas NUMERIC(3) := 0;
    v_millas_totales NUMERIC(4) := 0;
    v_nuevo_itinerario_id INTEGER;
    v_costo_itinerario NUMERIC(8,2);
    v_millas_itinerario NUMERIC(4);
    i INTEGER;
    v_count INTEGER;
BEGIN
    -- Validar que el cliente existe
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cli_COD = p_cliente_id) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El cliente especificado no existe'
        );
    END IF;

    -- Validar que hay al menos un servicio
    v_count := COALESCE(array_length(p_paquete_turistico_ids, 1), 0) +
               COALESCE(array_length(p_hospedaje_ids, 1), 0) +
               COALESCE(array_length(p_restaurante_ids, 1), 0) +
               COALESCE(array_length(p_vuelo_ids, 1), 0) +
               COALESCE(array_length(p_crucero_ids, 1), 0) +
               COALESCE(array_length(p_transporte_terrestre_ids, 1), 0) +
               COALESCE(array_length(p_servicio_adicional_ids, 1), 0);

    IF v_count = 0 THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Debe incluir al menos un servicio en el itinerario'
        );
    END IF;

    -- Generar número de reserva único (últimos 4 dígitos del timestamp) es como un randomizer
    v_numero_reserva := (EXTRACT(EPOCH FROM NOW())::BIGINT % 10000)::INTEGER;

    
--Calculo de los precios de cada servicio
    IF p_paquete_turistico_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_paquete_turistico_ids, 1) LOOP
            SELECT COALESCE(PT_Costo, 0), COALESCE(PT_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Paquete_Turistico
            WHERE PT_COD = p_paquete_turistico_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    IF p_hospedaje_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_hospedaje_ids, 1) LOOP
            SELECT COALESCE(Hos_Costo, 0), COALESCE(Hot_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Hospedaje
            WHERE Hos_COD = p_hospedaje_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    IF p_vuelo_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_vuelo_ids, 1) LOOP
            SELECT COALESCE(Vue_Costo, 0), COALESCE(Vue_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Vuelo
            WHERE Vue_COD = p_vuelo_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;


    IF p_crucero_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_crucero_ids, 1) LOOP
            SELECT COALESCE(Cru_Costo, 0), COALESCE(Cru_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Crucero
            WHERE Cru_COD = p_crucero_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    IF p_transporte_terrestre_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_transporte_terrestre_ids, 1) LOOP
            SELECT COALESCE(TT_Costo, 0), COALESCE(TT_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Transporte_Terrestre
            WHERE TT_COD = p_transporte_terrestre_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    IF p_servicio_adicional_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_servicio_adicional_ids, 1) LOOP
            SELECT COALESCE(SA_Costo, 0), COALESCE(SA_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Servicio_Adicional
            WHERE SA_COD = p_servicio_adicional_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    -- Calcular total 
    v_total := v_subtotal;
    
    -- Calcular millas obtenidas, se hizo esto porque el total de millas es muy grande y no tiene sentido que ganes 14000 millas, ya que la gente pagaria siempre con eso 
    v_millas_obtenidas := FLOOR(v_total * 0.10);

    -- Crear la reserva
    INSERT INTO Reserva (
        Res_Numero_Reserva,
        Res_Milla_Obtenida,
        Res_Fecha_Hora,
        Res_Camarote,
        Cliente_Cli_COD,
        Res_Subtotal,
        Res_Total
    )
    VALUES (
        v_numero_reserva,
        v_millas_obtenidas,
        NOW(),
        p_res_camarote,
        p_cliente_id,
        v_subtotal,
        v_total
    )
    RETURNING Res_COD INTO v_nueva_reserva_id;

    -- Crear los itinerarios
    v_count := GREATEST(
        COALESCE(array_length(p_paquete_turistico_ids, 1), 1),
        COALESCE(array_length(p_hospedaje_ids, 1), 1),
        COALESCE(array_length(p_restaurante_ids, 1), 1),
        COALESCE(array_length(p_vuelo_ids, 1), 1),
        COALESCE(array_length(p_crucero_ids, 1), 1),
        COALESCE(array_length(p_transporte_terrestre_ids, 1), 1),
        COALESCE(array_length(p_servicio_adicional_ids, 1), 1)
    );

    FOR i IN 1..v_count LOOP
        -- Calcular costo del itinerario individual
        v_costo_itinerario := 0;
        v_millas_itinerario := 0;

        -- Suma del costo de cada servicio 
        IF p_paquete_turistico_ids IS NOT NULL AND i <= array_length(p_paquete_turistico_ids, 1) THEN
            SELECT COALESCE(PT_Costo, 0), COALESCE(PT_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Paquete_Turistico WHERE PT_COD = p_paquete_turistico_ids[i];
        END IF;

        IF p_hospedaje_ids IS NOT NULL AND i <= array_length(p_hospedaje_ids, 1) THEN
            SELECT v_costo_itinerario + COALESCE(Hos_Costo, 0), 
                   v_millas_itinerario + COALESCE(Hot_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Hospedaje WHERE Hos_COD = p_hospedaje_ids[i];
        END IF;

        IF p_vuelo_ids IS NOT NULL AND i <= array_length(p_vuelo_ids, 1) THEN
            SELECT v_costo_itinerario + COALESCE(Vue_Costo, 0),
                   v_millas_itinerario + COALESCE(Vue_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Vuelo WHERE Vue_COD = p_vuelo_ids[i];
        END IF;

        IF p_crucero_ids IS NOT NULL AND i <= array_length(p_crucero_ids, 1) THEN
            SELECT v_costo_itinerario + COALESCE(Cru_Costo, 0),
                   v_millas_itinerario + COALESCE(Cru_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Crucero WHERE Cru_COD = p_crucero_ids[i];
        END IF;

        IF p_transporte_terrestre_ids IS NOT NULL AND i <= array_length(p_transporte_terrestre_ids, 1) THEN
            SELECT v_costo_itinerario + COALESCE(TT_Costo, 0),
                   v_millas_itinerario + COALESCE(TT_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Transporte_Terrestre WHERE TT_COD = p_transporte_terrestre_ids[i];
        END IF;

        IF p_servicio_adicional_ids IS NOT NULL AND i <= array_length(p_servicio_adicional_ids, 1) THEN
            SELECT v_costo_itinerario + COALESCE(SA_Costo, 0),
                   v_millas_itinerario + COALESCE(SA_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Servicio_Adicional WHERE SA_COD = p_servicio_adicional_ids[i];
        END IF;

        -- Insertar el itinerario
        INSERT INTO Itinerario (
            Paquete_Turistico_PT_COD,
            Iti_Costo_Total,
            Hospedaje_Hos_COD,
            Restaurante_Rest_COD,
            Vuelo_Vue_COD,
            Crucero_Cru_COD,
            Transporte_Terrestre_TT_COD,
            Iti_Fecha_Inicio,
            Iti_Fecha_Fin,
            Servicio_Adicional_SA_COD,
            Iti_Cant_Milla_Total,
            Reserva_Res_COD
        )
        VALUES (
            CASE WHEN p_paquete_turistico_ids IS NOT NULL AND i <= array_length(p_paquete_turistico_ids, 1) 
                 THEN p_paquete_turistico_ids[i] ELSE NULL END,
            v_costo_itinerario,
            CASE WHEN p_hospedaje_ids IS NOT NULL AND i <= array_length(p_hospedaje_ids, 1) 
                 THEN p_hospedaje_ids[i] ELSE NULL END,
            CASE WHEN p_restaurante_ids IS NOT NULL AND i <= array_length(p_restaurante_ids, 1) 
                 THEN p_restaurante_ids[i] ELSE NULL END,
            CASE WHEN p_vuelo_ids IS NOT NULL AND i <= array_length(p_vuelo_ids, 1) 
                 THEN p_vuelo_ids[i] ELSE NULL END,
            CASE WHEN p_crucero_ids IS NOT NULL AND i <= array_length(p_crucero_ids, 1) 
                 THEN p_crucero_ids[i] ELSE NULL END,
            CASE WHEN p_transporte_terrestre_ids IS NOT NULL AND i <= array_length(p_transporte_terrestre_ids, 1) 
                 THEN p_transporte_terrestre_ids[i] ELSE NULL END,
            CASE WHEN p_fechas_inicio IS NOT NULL AND i <= array_length(p_fechas_inicio, 1) 
                 THEN p_fechas_inicio[i] ELSE CURRENT_DATE END,
            CASE WHEN p_fechas_fin IS NOT NULL AND i <= array_length(p_fechas_fin, 1) 
                 THEN p_fechas_fin[i] ELSE CURRENT_DATE + INTERVAL '7 days' END,
            CASE WHEN p_servicio_adicional_ids IS NOT NULL AND i <= array_length(p_servicio_adicional_ids, 1) 
                 THEN p_servicio_adicional_ids[i] ELSE NULL END,
            v_millas_itinerario,
            v_nueva_reserva_id
        )
        RETURNING Iti_COD INTO v_nuevo_itinerario_id;
    END LOOP;

    -- Retornar resultado exitoso
    v_resultado := json_build_object(
        'status', 'success',
        'message', 'Reserva e itinerario(s) creados correctamente',
        'data', json_build_object(
            'reserva_id', v_nueva_reserva_id,
            'numero_reserva', v_numero_reserva,
            'subtotal', v_subtotal,
            'total', v_total,
            'millas_obtenidas', v_millas_obtenidas,
            'millas_totales_servicios', v_millas_totales,
            'itinerarios_creados', v_count
        )
    );

    RETURN v_resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al crear la reserva: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


-- procesar el pago de una reserva
CREATE OR REPLACE FUNCTION procesar_pago_reserva(
    -- Datos de la Reserva
    p_reserva_id INTEGER,
    
    -- Datos del Cliente y Método de Pago
    p_cliente_id INTEGER,
    p_metodo_pago_id INTEGER,
    
    -- Datos del Pago
    p_monto_pago NUMERIC(10,2),
    p_pago_con_millas BOOLEAN DEFAULT FALSE,
    p_cantidad_millas INTEGER DEFAULT 0,
    
    -- Tasa de Cambio 
    p_tasa_cambio_id INTEGER DEFAULT NULL,
    
    -- Financiamiento (opcional)
    p_usar_financiamiento BOOLEAN DEFAULT FALSE,
    p_numero_cuotas INTEGER DEFAULT NULL,
    p_monto_financiado NUMERIC(8,2) DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
    v_resultado JSON;
    v_nuevo_pago_id INTEGER;
    v_nuevo_financiamiento_id INTEGER;
    v_total_reserva NUMERIC(10,2);
    v_millas_obtenidas NUMERIC(3);
    v_millas_actuales_cliente NUMERIC(6);
    v_cli_mp_existe BOOLEAN;
BEGIN
    -- Validar que la reserva existe
    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE Res_COD = p_reserva_id) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'La reserva especificada no existe'
        );
    END IF;

    -- Validar que el cliente existe y pertenece a la reserva
    SELECT Res_Total, Res_Milla_Obtenida
    INTO v_total_reserva, v_millas_obtenidas
    FROM Reserva
    WHERE Res_COD = p_reserva_id AND Cliente_Cli_COD = p_cliente_id;

    IF NOT FOUND THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El cliente no corresponde a esta reserva'
        );
    END IF;

    -- Obtener millas actuales del cliente
    SELECT Cli_Millas_Acum INTO v_millas_actuales_cliente
    FROM Cliente
    WHERE Cli_COD = p_cliente_id;

    -- Validar si se usa pago con millas
    IF p_pago_con_millas THEN
        IF v_millas_actuales_cliente < p_cantidad_millas THEN
            RETURN json_build_object(
                'status', 'error',
                'message', 'El cliente no tiene suficientes millas acumuladas'
            );
        END IF;
    END IF;

    -- Validar que existe la relación Cli_MP
    SELECT EXISTS (
        SELECT 1 FROM Cli_MP 
        WHERE Cliente_Cli_COD = p_cliente_id 
        AND Metodo_de_Pago_MP_COD = p_metodo_pago_id
    ) INTO v_cli_mp_existe;

    IF NOT v_cli_mp_existe THEN
        -- Crear la relación si no existe
        INSERT INTO Cli_MP (Cliente_Cli_COD, Metodo_de_Pago_MP_COD)
        VALUES (p_cliente_id, p_metodo_pago_id);
    END IF;

    -- Si se usa financiamiento, crear el registro de financiamiento
    IF p_usar_financiamiento AND p_numero_cuotas > 0 THEN
        INSERT INTO Financiamiento (
            Fin_Numero_Cuotas,
            Reserva_Res_COD,
            Fin_Monto_Financiado,
            Fin_Fecha
        )
        VALUES (
            p_numero_cuotas,
            p_reserva_id,
            COALESCE(p_monto_financiado, v_total_reserva),
            CURRENT_DATE
        )
        RETURNING Fin_COD INTO v_nuevo_financiamiento_id;

        -- Crear las cuotas
        FOR i IN 1..p_numero_cuotas LOOP
            INSERT INTO Cuota (
                Cuo_Monto,
                Cuo_Fecha_Vencimiento,
                Financiamiento_Fin_COD,
                Cuo_Fecha_Pago
            )
            VALUES (
                (COALESCE(p_monto_financiado, v_total_reserva) / p_numero_cuotas),
                CURRENT_DATE + (i * INTERVAL '1 month'),
                v_nuevo_financiamiento_id,
                CURRENT_DATE + (i * INTERVAL '1 month')
            );
        END LOOP;
    END IF;

    -- Registrar el pago
    INSERT INTO Pago (
        PAG_Fecha_Hora,
        PAG_Total,
        Tasa_de_Cambio_TC_COD,
        Cli_MP_MP_COD,
        Cli_MP_Cli_COD,
        Pag_Total_Milla,
        Reserva_Res_COD
    )
    VALUES (
        NOW(),
        p_monto_pago,
        p_tasa_cambio_id,
        p_metodo_pago_id,
        p_cliente_id,
        CASE WHEN p_pago_con_millas THEN p_cantidad_millas ELSE NULL END,
        p_reserva_id
    )
    RETURNING PAG_COD INTO v_nuevo_pago_id;

    -- Actualizar las millas del cliente
    IF p_pago_con_millas THEN
        -- Restar las millas usadas
        UPDATE Cliente
        SET Cli_Millas_Acum = Cli_Millas_Acum - p_cantidad_millas
        WHERE Cli_COD = p_cliente_id;
    END IF;

    -- Agregar las millas obtenidas por la compra
    UPDATE Cliente
    SET Cli_Millas_Acum = Cli_Millas_Acum + v_millas_obtenidas
    WHERE Cli_COD = p_cliente_id;

    -- Obtener las millas actualizadas
    SELECT Cli_Millas_Acum INTO v_millas_actuales_cliente
    FROM Cliente
    WHERE Cli_COD = p_cliente_id;

    -- Retornar resultado exitoso
    v_resultado := json_build_object(
        'status', 'success',
        'message', 'Pago procesado correctamente',
        'data', json_build_object(
            'pago_id', v_nuevo_pago_id,
            'reserva_id', p_reserva_id,
            'monto_pagado', p_monto_pago,
            'millas_usadas', CASE WHEN p_pago_con_millas THEN p_cantidad_millas ELSE 0 END,
            'millas_obtenidas', v_millas_obtenidas,
            'millas_actuales_cliente', v_millas_actuales_cliente,
            'financiamiento_id', v_nuevo_financiamiento_id,
            'cuotas_creadas', CASE WHEN p_usar_financiamiento THEN p_numero_cuotas ELSE 0 END
        )
    );

    RETURN v_resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al procesar el pago: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;



-- Descripción: Registra un nuevo método de pago de tipo tarjeta
CREATE OR REPLACE FUNCTION registrar_metodo_pago_tarjeta(
    p_tipo VARCHAR, -- 'Tarjeta_Credito' o 'Tarjeta_Debito'
    p_num_tarjeta NUMERIC(16),
    p_cod_seguridad NUMERIC(3),
    p_emisor VARCHAR(60),
    p_marca VARCHAR(60),
    p_fecha_vencimiento DATE,
    p_nombre_titular VARCHAR(60)
)
RETURNS JSON AS $$
DECLARE
    v_nuevo_id INTEGER;
BEGIN
    -- Validar que el tipo sea correcto
    IF p_tipo NOT IN ('Tarjeta_Credito', 'Tarjeta_Debito') THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El tipo debe ser Tarjeta_Credito o Tarjeta_Debito'
        );
    END IF;

    -- Insertar el método de pago
    INSERT INTO Metodo_de_Pago (
        Tipo,
        Num_Tarjeta,
        Cod_Seguridad,
        Emisor,
        Marca,
        Fecha_Vencimiento,
        Nombre_Titular
    )
    VALUES (
        p_tipo,
        p_num_tarjeta,
        p_cod_seguridad,
        p_emisor,
        p_marca,
        p_fecha_vencimiento,
        p_nombre_titular
    )
    RETURNING MP_COD INTO v_nuevo_id;

    RETURN json_build_object(
        'status', 'success',
        'message', 'Método de pago registrado correctamente',
        'data', json_build_object(
            'metodo_pago_id', v_nuevo_id
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al registrar método de pago: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- 4. FUNCIÓN: obtener_detalle_reserva
-- Descripción: Obtiene el detalle completo de una reserva con sus itinerarios
-- =====================================================
CREATE OR REPLACE FUNCTION obtener_detalle_reserva(
    p_reserva_id INTEGER
)
RETURNS JSON AS $$
DECLARE
    v_resultado JSON;
    v_reserva RECORD;
    v_itinerarios JSON;
BEGIN
    -- Obtener datos de la reserva
    SELECT 
        R.Res_COD,
        R.Res_Numero_Reserva,
        R.Res_Milla_Obtenida,
        R.Res_Fecha_Hora,
        R.Res_Camarote,
        R.Res_Subtotal,
        R.Res_Total,
        C.Cli_Primer_Nombre,
        C.Cli_Apellido,
        C.Cli_COD
    INTO v_reserva
    FROM Reserva R
    JOIN Cliente C ON R.Cliente_Cli_COD = C.Cli_COD
    WHERE R.Res_COD = p_reserva_id;

    IF NOT FOUND THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Reserva no encontrada'
        );
    END IF;

    -- Obtener los itinerarios de la reserva
    SELECT json_agg(
        json_build_object(
            'itinerario_id', I.Iti_COD,
            'costo_total', I.Iti_Costo_Total,
            'fecha_inicio', I.Iti_Fecha_Inicio,
            'fecha_fin', I.Iti_Fecha_Fin,
            'millas_totales', I.Iti_Cant_Milla_Total,
            'paquete_turistico_id', I.Paquete_Turistico_PT_COD,
            'hospedaje_id', I.Hospedaje_Hos_COD,
            'restaurante_id', I.Restaurante_Rest_COD,
            'vuelo_id', I.Vuelo_Vue_COD,
            'crucero_id', I.Crucero_Cru_COD,
            'transporte_terrestre_id', I.Transporte_Terrestre_TT_COD,
            'servicio_adicional_id', I.Servicio_Adicional_SA_COD
        )
    )
    INTO v_itinerarios
    FROM Itinerario I
    WHERE I.Reserva_Res_COD = p_reserva_id;

    -- Construir el resultado
    v_resultado := json_build_object(
        'status', 'success',
        'data', json_build_object(
            'reserva', json_build_object(
                'reserva_id', v_reserva.Res_COD,
                'numero_reserva', v_reserva.Res_Numero_Reserva,
                'fecha_hora', v_reserva.Res_Fecha_Hora,
                'subtotal', v_reserva.Res_Subtotal,
                'total', v_reserva.Res_Total,
                'millas_obtenidas', v_reserva.Res_Milla_Obtenida,
                'camarote', v_reserva.Res_Camarote,
                'cliente', json_build_object(
                    'cliente_id', v_reserva.Cli_COD,
                    'nombre', v_reserva.Cli_Primer_Nombre || ' ' || v_reserva.Cli_Apellido
                )
            ),
            'itinerarios', COALESCE(v_itinerarios, '[]'::json)
        )
    );

    RETURN v_resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al obtener detalle de reserva: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- 5. FUNCIÓN: cancelar_reserva_con_reembolso
-- Descripción: Cancela una reserva y genera un reembolso
-- =====================================================
CREATE OR REPLACE FUNCTION cancelar_reserva_con_reembolso(
    p_reserva_id INTEGER,
    p_porcentaje_retencion NUMERIC(4,2),
    p_metodo_pago_reembolso_id INTEGER,
    p_tasa_cambio_id INTEGER
)
RETURNS JSON AS $$
DECLARE
    v_resultado JSON;
    v_total_reserva NUMERIC(8,2);
    v_monto_retenido NUMERIC(8,2);
    v_monto_devuelto NUMERIC(8,2);
    v_nuevo_reembolso_id INTEGER;
    v_tasa_aplicada NUMERIC(8,2) := 1.00;
    v_divisa VARCHAR(60) := 'USD';
BEGIN
    -- Obtener el total de la reserva
    SELECT Res_Total INTO v_total_reserva
    FROM Reserva
    WHERE Res_COD = p_reserva_id;

    IF NOT FOUND THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Reserva no encontrada'
        );
    END IF;

    -- Calcular montos
    v_monto_retenido := v_total_reserva * (p_porcentaje_retencion / 100);
    v_monto_devuelto := v_total_reserva - v_monto_retenido;

    -- Obtener tasa de cambio si se proporciona
    IF p_tasa_cambio_id IS NOT NULL THEN
        SELECT TC_Valor, TC_Tipo_Moneda
        INTO v_tasa_aplicada, v_divisa
        FROM Tasa_de_Cambio
        WHERE TC_COD = p_tasa_cambio_id;
    END IF;

    -- Crear el reembolso
    INSERT INTO Reembolso (
        Rem_Monto_Devuelto,
        Rem_Monto_Retenido,
        Reserva_Res_COD
    )
    VALUES (
        v_monto_devuelto,
        v_monto_retenido,
        p_reserva_id
    )
    RETURNING Rem_COD INTO v_nuevo_reembolso_id;

    -- Registrar el pago reembolsado
    INSERT INTO Pago_Reembolsado (
        Reembolso_Rem_COD,
        Metodo_de_Pago_MP_COD,
        Fecha_Hora_Reembolso,
        Monto_Reembolso,
        Divisa_Utilizada,
        Tasa_Aplicada,
        Tasa_de_Cambio_TC_COD
    )
    VALUES (
        v_nuevo_reembolso_id,
        p_metodo_pago_reembolso_id,
        NOW(),
        v_monto_devuelto,
        v_divisa,
        v_tasa_aplicada,
        p_tasa_cambio_id
    );

    -- Retornar resultado
    RETURN json_build_object(
        'status', 'success',
        'message', 'Reserva cancelada y reembolso procesado',
        'data', json_build_object(
            'reembolso_id', v_nuevo_reembolso_id,
            'monto_total', v_total_reserva,
            'monto_retenido', v_monto_retenido,
            'monto_devuelto', v_monto_devuelto,
            'porcentaje_retencion', p_porcentaje_retencion
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al procesar cancelación: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


-- Iniciar Sesion
CREATE OR REPLACE FUNCTION inicio_sesion(
    correo VARCHAR,
    contrasena VARCHAR
) 
RETURNS JSON AS $$
DECLARE
    resultado JSON;
    v_usuario_id INTEGER;
    v_cliente_id INTEGER;
    v_rol_id INTEGER;
    v_contrasena VARCHAR;
    v_primer_nombre VARCHAR;
    v_primer_apellido VARCHAR;
    v_correo VARCHAR;
BEGIN
    -- Primero verificamos si el correo existe
    SELECT Usu_COD, Cliente_Cli_COD, Rol_Rol_COD, Usu_Contrasena, Usu_Primer_Nombre, Usu_Primer_Apellido, Usu_Correo
    INTO v_usuario_id, v_cliente_id, v_rol_id, v_contrasena, v_primer_nombre, v_primer_apellido, v_correo
    FROM Usuario
    WHERE Usu_Correo = correo;

    IF NOT FOUND THEN
        -- No existe el correo
        resultado := json_build_object(
            'status', 'error',
            'message', 'Usuario no existe'
        );
    ELSE
        -- Existe el correo, verificamos contraseña
        IF v_contrasena = contrasena THEN
            resultado := json_build_object(
                'status', 'success',
                'message', 'Inicio de sesión correcto',
                'usuario_ID', v_usuario_id,
                'cliente_ID', v_cliente_id,
                'rol_ID', v_rol_id,
                'primerNombre', v_primer_nombre,
                'primerApellido', v_primer_apellido,
                'email', v_correo
            );
        ELSE
            resultado := json_build_object(
                'status', 'error',
                'message', 'Usuario o contraseña no coinciden'
            );
        END IF;
    END IF;

    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        resultado := json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
        RETURN resultado;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION registrar_pasajeros(
    p_cliente_id INTEGER,
    p_reserva_id INTEGER,
    p_pasajeros JSONB  -- Array de objetos con datos de pasajeros
)
RETURNS JSON AS $$
DECLARE
    resultado JSON;
    pasajero JSONB;
    nuevo_pasajero_id INTEGER;
    pasajeros_ids INTEGER[] := '{}';
BEGIN
    -- Validar que exista el cliente
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cli_COD = p_cliente_id) THEN
        resultado := json_build_object(
            'status', 'error',
            'message', 'El cliente no existe'
        );
        RETURN resultado;
    END IF;

    -- Validar que exista la reserva
    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE Res_COD = p_reserva_id) THEN
        resultado := json_build_object(
            'status', 'error',
            'message', 'La reserva no existe'
        );
        RETURN resultado;
    END IF;

    -- Recorrer el array de pasajeros y registrar cada uno
    FOR pasajero IN SELECT * FROM jsonb_array_elements(p_pasajeros)
    LOOP
        INSERT INTO Pasajero (
            Pas_Primer_Nombre,
            Pas_Segundo_Nombre,
            Pas_Primer_Apellido,
            Pas_Segundo_Apellido,
            Pas_Fecha_Nacimiento,
            Pas_Estado_Civil,
            Cliente_Cli_COD,
            Reserva_Res_COD
        )
        VALUES (
            pasajero->>'primerNombre',
            pasajero->>'segundoNombre',
            pasajero->>'primerApellido',
            pasajero->>'segundoApellido',
            (pasajero->>'fechaNacimiento')::DATE,
            pasajero->>'estadoCivil',
            p_cliente_id,
            p_reserva_id
        )
        RETURNING Pas_COD INTO nuevo_pasajero_id;

        -- Agregar al array de IDs
        pasajeros_ids := array_append(pasajeros_ids, nuevo_pasajero_id);
    END LOOP;

    resultado := json_build_object(
        'status', 'success',
        'message', format('Se registraron %s pasajeros correctamente', array_length(pasajeros_ids, 1)),
        'data', json_build_object(
            'pasajeros_ids', pasajeros_ids,
            'cantidad', array_length(pasajeros_ids, 1)
        )
    );
    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        resultado := json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
        RETURN resultado;
END;
$$ LANGUAGE plpgsql;



--PARA REGISTRAR MÉTODO DE PAGO
CREATE OR REPLACE FUNCTION registrar_metodo_pago(
    p_tipo VARCHAR,
    p_cliente_id INTEGER,
    p_datos JSONB  -- Datos específicos según el tipo
)
RETURNS JSON AS $$
DECLARE
    resultado JSON;
    nuevo_mp_id INTEGER;
BEGIN
    -- Validar que el tipo sea válido
    IF p_tipo NOT IN (
        'Tarjeta_Credito','Tarjeta_Debito','Cheque',
        'Efectivo','Milla_MP','Criptomonedas','Billetera_Digital',
        'Zelle','PayPal','Zinli','Pago_Movil','Transferencia'
    ) THEN
        resultado := json_build_object(
            'status', 'error',
            'message', 'Tipo de método de pago no válido'
        );
        RETURN resultado;
    END IF;

    -- Insertar método de pago según el tipo
    CASE p_tipo
        WHEN 'Tarjeta_Credito', 'Tarjeta_Debito' THEN
            INSERT INTO Metodo_de_Pago (
                Tipo,
                Num_Tarjeta,
                Cod_Seguridad,
                Emisor,
                Marca,
                Fecha_Vencimiento,
                Nombre_Titular
            )
            VALUES (
                p_tipo,
                (p_datos->>'numTarjeta')::NUMERIC(16),
                (p_datos->>'codSeguridad')::NUMERIC(3),
                p_datos->>'emisor',
                p_datos->>'marca',
                (p_datos->>'fechaVencimiento')::DATE,
                p_datos->>'nombreTitular'
            )
            RETURNING MP_COD INTO nuevo_mp_id;
        WHEN 'Cheque' THEN
            INSERT INTO Metodo_de_Pago (
                Tipo,
                Cod_Cuenta_Cliente,
                Num_Cheque,
                Banco_Emisor,
                Fecha_Emision
            )
            VALUES (
                p_tipo,
                (p_datos->>'codCuentaCliente')::NUMERIC(7),
                (p_datos->>'numCheque')::NUMERIC(8),
                p_datos->>'bancoEmisor',
                (p_datos->>'fechaEmision')::DATE
            )
            RETURNING MP_COD INTO nuevo_mp_id;
        WHEN 'Efectivo' THEN
            INSERT INTO Metodo_de_Pago (
                Tipo,
                Tipo_Moneda
            )
            VALUES (
                p_tipo,
                COALESCE(p_datos->>'tipoMoneda', 'USD')
            )
            RETURNING MP_COD INTO nuevo_mp_id;
        WHEN 'Milla_MP' THEN
            INSERT INTO Metodo_de_Pago (
                Tipo
            )
            VALUES (p_tipo)
            RETURNING MP_COD INTO nuevo_mp_id;
        WHEN 'Criptomonedas' THEN
            INSERT INTO Metodo_de_Pago (
                Tipo,
                Id_Transaccion,
                Fecha_Hora,
                Monto,
                Tipo_Moneda
            )
            VALUES (
                p_tipo,
                p_datos->>'idTransaccion',
                COALESCE((p_datos->>'fechaHora')::TIMESTAMP, NOW()),
                (p_datos->>'monto')::NUMERIC(10,2),
                p_datos->>'tipoMoneda'
            )
            RETURNING MP_COD INTO nuevo_mp_id;
        WHEN 'Billetera_Digital', 'PayPal', 'Zinli' THEN
            INSERT INTO Metodo_de_Pago (
                Tipo,
                Num_Confirmacion,
                Monto_Billetera
            )
            VALUES (
                p_tipo,
                (p_datos->>'numConfirmacion')::NUMERIC(20),
                (p_datos->>'montoBilletera')::NUMERIC(10,2)
            )
            RETURNING MP_COD INTO nuevo_mp_id;
        WHEN 'Pago_Movil' THEN
            INSERT INTO Metodo_de_Pago (
                Tipo,
                Num_Referencia,
                Banco,
                Fecha
            )
            VALUES (
                p_tipo,
                (p_datos->>'numReferencia')::NUMERIC(30),
                p_datos->>'banco',
                COALESCE((p_datos->>'fecha')::DATE, CURRENT_DATE)
            )
            RETURNING MP_COD INTO nuevo_mp_id;
        WHEN 'Transferencia', 'Zelle' THEN
            INSERT INTO Metodo_de_Pago (
                Tipo,
                Num_Cuenta_Destino,
                Banco,
                Fecha,
                Num_Referencia
            )
            VALUES (
                p_tipo,
                (p_datos->>'numCuentaDestino')::NUMERIC(30),
                p_datos->>'banco',
                COALESCE((p_datos->>'fecha')::DATE, CURRENT_DATE),
                (p_datos->>'numReferencia')::NUMERIC(30)
            )
            RETURNING MP_COD INTO nuevo_mp_id;

    END CASE;

    -- Asociar método de pago con el cliente en Cli_MP
    IF p_cliente_id IS NOT NULL THEN
        INSERT INTO Cli_MP (Metodo_de_Pago_MP_COD, Cliente_Cli_COD)
        VALUES (nuevo_mp_id, p_cliente_id);
    END IF;

    resultado := json_build_object(
        'status', 'success',
        'message', format('Método de pago %s registrado correctamente', p_tipo),
        'data', json_build_object(
            'metodo_pago_id', nuevo_mp_id
        )
    );
    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        resultado := json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
        RETURN resultado;
END;
$$ LANGUAGE plpgsql;



--PARA OBTENER PASAJEROS DE UNA RESERVA
CREATE OR REPLACE FUNCTION obtener_pasajeros_reserva(
    p_reserva_id INTEGER
)
RETURNS JSON AS $$
DECLARE
    resultado JSON;
    pasajeros_json JSON;
BEGIN
    -- Verificar que existe la reserva
    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE Res_COD = p_reserva_id) THEN
        resultado := json_build_object(
            'status', 'error',
            'message', 'La reserva no existe'
        );
        RETURN resultado;
    END IF;

    -- Obtener los pasajeros de la reserva
    SELECT json_agg(
        json_build_object(
            'pas_cod', p.Pas_COD,
            'primerNombre', p.Pas_Primer_Nombre,
            'segundoNombre', p.Pas_Segundo_Nombre,
            'primerApellido', p.Pas_Primer_Apellido,
            'segundoApellido', p.Pas_Segundo_Apellido,
            'fechaNacimiento', p.Pas_Fecha_Nacimiento,
            'estadoCivil', p.Pas_Estado_Civil,
            'clienteId', p.Cliente_Cli_COD
        )
    )
    INTO pasajeros_json
    FROM Pasajero p
    WHERE p.Reserva_Res_COD = p_reserva_id;

    resultado := json_build_object(
        'status', 'success',
        'data', json_build_object(
            'reserva_id', p_reserva_id,
            'pasajeros', COALESCE(pasajeros_json, '[]'::json)
        )
    );
    RETURN resultado;

EXCEPTION
    WHEN OTHERS THEN
        resultado := json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
        RETURN resultado;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION crear_itinerario_con_reserva(
    -- Datos del Cliente
    p_cliente_id INTEGER,
    
    -- Datos de la Reserva
    p_res_camarote VARCHAR DEFAULT NULL,
    
    -- Datos del Itinerario 
    p_paquete_turistico_ids INTEGER[] DEFAULT NULL,
    p_hospedaje_ids INTEGER[] DEFAULT NULL,
    p_restaurante_ids INTEGER[] DEFAULT NULL,
    p_vuelo_ids INTEGER[] DEFAULT NULL,
    p_crucero_ids INTEGER[] DEFAULT NULL,
    p_transporte_terrestre_ids INTEGER[] DEFAULT NULL,
    p_servicio_adicional_ids INTEGER[] DEFAULT NULL,
    p_fechas_inicio DATE[] DEFAULT NULL,
    p_fechas_fin DATE[] DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
    v_resultado JSON;
    v_nueva_reserva_id INTEGER;
    v_numero_reserva INTEGER;
    v_subtotal NUMERIC(8,2) := 0;
    v_total NUMERIC(8,2) := 0;
    v_millas_obtenidas NUMERIC(3) := 0;
    v_millas_totales NUMERIC(4) := 0;
    v_nuevo_itinerario_id INTEGER;
    v_costo_itinerario NUMERIC(8,2);
    v_millas_itinerario NUMERIC(4);
    i INTEGER;
    v_count INTEGER;
BEGIN
    -- Validar que el cliente existe
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cli_COD = p_cliente_id) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El cliente especificado no existe'
        );
    END IF;

    -- Validar que hay al menos un servicio
    v_count := COALESCE(array_length(p_paquete_turistico_ids, 1), 0) +
               COALESCE(array_length(p_hospedaje_ids, 1), 0) +
               COALESCE(array_length(p_restaurante_ids, 1), 0) +
               COALESCE(array_length(p_vuelo_ids, 1), 0) +
               COALESCE(array_length(p_crucero_ids, 1), 0) +
               COALESCE(array_length(p_transporte_terrestre_ids, 1), 0) +
               COALESCE(array_length(p_servicio_adicional_ids, 1), 0);

    IF v_count = 0 THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Debe incluir al menos un servicio en el itinerario'
        );
    END IF;

    -- Generar número de reserva único (últimos 4 dígitos del timestamp), es como un radomizer
    v_numero_reserva := (EXTRACT(EPOCH FROM NOW())::BIGINT % 10000)::INTEGER;
    
    -- Paquetes Turísticos
    IF p_paquete_turistico_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_paquete_turistico_ids, 1) LOOP
            SELECT COALESCE(PT_Costo, 0), COALESCE(PT_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Paquete_Turistico
            WHERE PT_COD = p_paquete_turistico_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    -- Hospedajes
    IF p_hospedaje_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_hospedaje_ids, 1) LOOP
            SELECT COALESCE(Hos_Costo, 0), COALESCE(Hot_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Hospedaje
            WHERE Hos_COD = p_hospedaje_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    -- Vuelos
    IF p_vuelo_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_vuelo_ids, 1) LOOP
            SELECT COALESCE(Vue_Costo, 0), COALESCE(Vue_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Vuelo
            WHERE Vue_COD = p_vuelo_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    -- Cruceros
    IF p_crucero_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_crucero_ids, 1) LOOP
            SELECT COALESCE(Cru_Costo, 0), COALESCE(Cru_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Crucero
            WHERE Cru_COD = p_crucero_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    -- Transporte Terrestre
    IF p_transporte_terrestre_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_transporte_terrestre_ids, 1) LOOP
            SELECT COALESCE(TT_Costo, 0), COALESCE(TT_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Transporte_Terrestre
            WHERE TT_COD = p_transporte_terrestre_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    -- Servicios Adicionales
    IF p_servicio_adicional_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_servicio_adicional_ids, 1) LOOP
            SELECT COALESCE(SA_Costo, 0), COALESCE(SA_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Servicio_Adicional
            WHERE SA_COD = p_servicio_adicional_ids[i];
            
            v_subtotal := v_subtotal + v_costo_itinerario;
            v_millas_totales := v_millas_totales + v_millas_itinerario;
        END LOOP;
    END IF;

    v_total := v_subtotal;
    
    -- Calcular millas obtenidas (suma de las millas de todos los servicios, máximo 999)
    v_millas_obtenidas := LEAST(v_millas_totales, 999);

    -- Crear la reserva
    INSERT INTO Reserva (
        Res_Numero_Reserva,
        Res_Milla_Obtenida,
        Res_Fecha_Hora,
        Res_Camarote,
        Cliente_Cli_COD,
        Res_Subtotal,
        Res_Total
    )
    VALUES (
        v_numero_reserva,
        v_millas_obtenidas,
        NOW(),
        p_res_camarote,
        p_cliente_id,
        v_subtotal,
        v_total
    )
    RETURNING Res_COD INTO v_nueva_reserva_id;

    -- Crear los itinerarios
    -- Determinar cuántos itinerarios crear 
    v_count := GREATEST(
        COALESCE(array_length(p_paquete_turistico_ids, 1), 1),
        COALESCE(array_length(p_hospedaje_ids, 1), 1),
        COALESCE(array_length(p_restaurante_ids, 1), 1),
        COALESCE(array_length(p_vuelo_ids, 1), 1),
        COALESCE(array_length(p_crucero_ids, 1), 1),
        COALESCE(array_length(p_transporte_terrestre_ids, 1), 1),
        COALESCE(array_length(p_servicio_adicional_ids, 1), 1)
    );

    -- Crear itinerarios
    FOR i IN 1..v_count LOOP
        -- Calcular costo del itinerario individual
        v_costo_itinerario := 0;
        v_millas_itinerario := 0;

        -- Sumar costo de cada servicio si existe en este índice
        IF p_paquete_turistico_ids IS NOT NULL AND i <= array_length(p_paquete_turistico_ids, 1) THEN
            SELECT COALESCE(PT_Costo, 0), COALESCE(PT_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Paquete_Turistico WHERE PT_COD = p_paquete_turistico_ids[i];
        END IF;

        IF p_hospedaje_ids IS NOT NULL AND i <= array_length(p_hospedaje_ids, 1) THEN
            SELECT v_costo_itinerario + COALESCE(Hos_Costo, 0), 
                   v_millas_itinerario + COALESCE(Hot_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Hospedaje WHERE Hos_COD = p_hospedaje_ids[i];
        END IF;

        IF p_vuelo_ids IS NOT NULL AND i <= array_length(p_vuelo_ids, 1) THEN
            SELECT v_costo_itinerario + COALESCE(Vue_Costo, 0),
                   v_millas_itinerario + COALESCE(Vue_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Vuelo WHERE Vue_COD = p_vuelo_ids[i];
        END IF;

        IF p_crucero_ids IS NOT NULL AND i <= array_length(p_crucero_ids, 1) THEN
            SELECT v_costo_itinerario + COALESCE(Cru_Costo, 0),
                   v_millas_itinerario + COALESCE(Cru_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Crucero WHERE Cru_COD = p_crucero_ids[i];
        END IF;

        IF p_transporte_terrestre_ids IS NOT NULL AND i <= array_length(p_transporte_terrestre_ids, 1) THEN
            SELECT v_costo_itinerario + COALESCE(TT_Costo, 0),
                   v_millas_itinerario + COALESCE(TT_Cant_Millas, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Transporte_Terrestre WHERE TT_COD = p_transporte_terrestre_ids[i];
        END IF;

        IF p_servicio_adicional_ids IS NOT NULL AND i <= array_length(p_servicio_adicional_ids, 1) THEN
            SELECT v_costo_itinerario + COALESCE(SA_Costo, 0),
                   v_millas_itinerario + COALESCE(SA_Cant_Milla, 0)
            INTO v_costo_itinerario, v_millas_itinerario
            FROM Servicio_Adicional WHERE SA_COD = p_servicio_adicional_ids[i];
        END IF;

        -- Insertar el itinerario
        INSERT INTO Itinerario (
            Paquete_Turistico_PT_COD,
            Iti_Costo_Total,
            Hospedaje_Hos_COD,
            Restaurante_Rest_COD,
            Vuelo_Vue_COD,
            Crucero_Cru_COD,
            Transporte_Terrestre_TT_COD,
            Iti_Fecha_Inicio,
            Iti_Fecha_Fin,
            Servicio_Adicional_SA_COD,
            Iti_Cant_Milla_Total,
            Reserva_Res_COD
        )
        VALUES (
            CASE WHEN p_paquete_turistico_ids IS NOT NULL AND i <= array_length(p_paquete_turistico_ids, 1) 
                 THEN p_paquete_turistico_ids[i] ELSE NULL END,
            v_costo_itinerario,
            CASE WHEN p_hospedaje_ids IS NOT NULL AND i <= array_length(p_hospedaje_ids, 1) 
                 THEN p_hospedaje_ids[i] ELSE NULL END,
            CASE WHEN p_restaurante_ids IS NOT NULL AND i <= array_length(p_restaurante_ids, 1) 
                 THEN p_restaurante_ids[i] ELSE NULL END,
            CASE WHEN p_vuelo_ids IS NOT NULL AND i <= array_length(p_vuelo_ids, 1) 
                 THEN p_vuelo_ids[i] ELSE NULL END,
            CASE WHEN p_crucero_ids IS NOT NULL AND i <= array_length(p_crucero_ids, 1) 
                 THEN p_crucero_ids[i] ELSE NULL END,
            CASE WHEN p_transporte_terrestre_ids IS NOT NULL AND i <= array_length(p_transporte_terrestre_ids, 1) 
                 THEN p_transporte_terrestre_ids[i] ELSE NULL END,
            CASE WHEN p_fechas_inicio IS NOT NULL AND i <= array_length(p_fechas_inicio, 1) 
                 THEN p_fechas_inicio[i] ELSE CURRENT_DATE END,
            CASE WHEN p_fechas_fin IS NOT NULL AND i <= array_length(p_fechas_fin, 1) 
                 THEN p_fechas_fin[i] ELSE CURRENT_DATE + INTERVAL '7 days' END,
            CASE WHEN p_servicio_adicional_ids IS NOT NULL AND i <= array_length(p_servicio_adicional_ids, 1) 
                 THEN p_servicio_adicional_ids[i] ELSE NULL END,
            v_millas_itinerario,
            v_nueva_reserva_id
        )
        RETURNING Iti_COD INTO v_nuevo_itinerario_id;
    END LOOP;

    -- Retornar resultado exitoso
    v_resultado := json_build_object(
        'status', 'success',
        'message', 'Reserva e itinerario(s) creados correctamente',
        'data', json_build_object(
            'reserva_id', v_nueva_reserva_id,
            'numero_reserva', v_numero_reserva,
            'subtotal', v_subtotal,
            'total', v_total,
            'millas_obtenidas', v_millas_obtenidas,
            'millas_totales_servicios', v_millas_totales,
            'itinerarios_creados', v_count
        )
    );

    RETURN v_resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al crear la reserva: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;
