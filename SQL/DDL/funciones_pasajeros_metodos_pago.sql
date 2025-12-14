-- =====================================================
-- FUNCIONES PARA GESTIÓN DE PASAJEROS Y MÉTODOS DE PAGO
-- Fecha: Diciembre 2024
-- =====================================================

-- =====================================================
-- 1. FUNCIÓN PARA REGISTRAR PASAJEROS
-- =====================================================

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

-- =====================================================
-- 2. FUNCIÓN PARA REGISTRAR MÉTODO DE PAGO (UNIVERSAL)
-- =====================================================

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
        -- TARJETAS (Crédito y Débito)
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

        -- CHEQUE
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

        -- EFECTIVO
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

        -- MILLAS
        WHEN 'Milla_MP' THEN
            INSERT INTO Metodo_de_Pago (
                Tipo
            )
            VALUES (p_tipo)
            RETURNING MP_COD INTO nuevo_mp_id;

        -- CRIPTOMONEDAS
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

        -- BILLETERA DIGITAL (PayPal, Zinli, etc.)
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

        -- PAGO MÓVIL
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

        -- TRANSFERENCIA y ZELLE
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

-- =====================================================
-- 3. FUNCIÓN PARA OBTENER PASAJEROS DE UNA RESERVA
-- =====================================================

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

    -- Obtener todos los pasajeros de la reserva
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

-- =====================================================
-- COMENTARIOS Y EJEMPLOS DE USO
-- =====================================================

-- EJEMPLO 1: Registrar múltiples pasajeros
/*
SELECT registrar_pasajeros(
    51,  -- cliente_id
    1,   -- reserva_id
    '[
        {
            "primerNombre": "Juan",
            "segundoNombre": "Carlos",
            "primerApellido": "Pérez",
            "segundoApellido": "González",
            "fechaNacimiento": "1990-05-15",
            "estadoCivil": "Casado"
        },
        {
            "primerNombre": "María",
            "segundoNombre": null,
            "primerApellido": "López",
            "segundoApellido": "Martínez",
            "fechaNacimiento": "1992-08-20",
            "estadoCivil": "Casado"
        }
    ]'::jsonb
);
*/

-- EJEMPLO 2: Registrar Tarjeta de Crédito
/*
SELECT registrar_metodo_pago(
    'Tarjeta_Credito',
    51,  -- cliente_id
    '{
        "numTarjeta": "4111111111111111",
        "codSeguridad": "123",
        "emisor": "Banco XYZ",
        "marca": "Visa",
        "fechaVencimiento": "2026-12-31",
        "nombreTitular": "JUAN PEREZ"
    }'::jsonb
);
*/

-- EJEMPLO 3: Registrar Pago Móvil
/*
SELECT registrar_metodo_pago(
    'Pago_Movil',
    51,
    '{
        "numReferencia": "123456789012345",
        "banco": "Banco Provincial",
        "fecha": "2024-12-14"
    }'::jsonb
);
*/

-- EJEMPLO 4: Registrar Zelle
/*
SELECT registrar_metodo_pago(
    'Zelle',
    51,
    '{
        "numCuentaDestino": "1234567890",
        "banco": "Bank of America",
        "fecha": "2024-12-14",
        "numReferencia": "987654321"
    }'::jsonb
);
*/

-- EJEMPLO 5: Obtener pasajeros de una reserva
/*
SELECT obtener_pasajeros_reserva(1);
*/

