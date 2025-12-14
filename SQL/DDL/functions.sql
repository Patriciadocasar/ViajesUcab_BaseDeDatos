-- =====================================================
-- FUNCIONES PARA GESTIÓN DE ITINERARIOS Y PAGOS
-- =====================================================

-- =====================================================
-- 1. FUNCIÓN: crear_itinerario_con_reserva
-- Descripción: Crea una reserva y uno o varios itinerarios asociados
-- =====================================================
CREATE OR REPLACE FUNCTION crear_itinerario_con_reserva(
    -- Datos del Cliente
    p_cliente_id INTEGER,
    
    -- Datos de la Reserva
    p_res_camarote VARCHAR DEFAULT NULL,
    
    -- Datos del Itinerario (pueden ser arrays para múltiples itinerarios)
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

    -- Generar número de reserva único (últimos 4 dígitos del timestamp)
    v_numero_reserva := (EXTRACT(EPOCH FROM NOW())::BIGINT % 10000)::INTEGER;

    -- Calcular subtotal y millas antes de crear la reserva
    -- Procesar cada tipo de servicio
    
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

    -- Calcular total (podría incluir impuestos aquí si es necesario)
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
    -- Determinar cuántos itinerarios crear (el máximo de los arrays)
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

-- =====================================================
-- 2. FUNCIÓN: procesar_pago_reserva
-- Descripción: Procesa el pago de una reserva completa
-- =====================================================
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
    
    -- Tasa de Cambio (opcional)
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

-- =====================================================
-- 3. FUNCIÓN: registrar_metodo_pago_tarjeta
-- Descripción: Registra un nuevo método de pago de tipo tarjeta
-- =====================================================
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
    p_porcentaje_retencion NUMERIC(4,2) DEFAULT 10.00,
    p_metodo_pago_reembolso_id INTEGER,
    p_tasa_cambio_id INTEGER DEFAULT NULL
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

