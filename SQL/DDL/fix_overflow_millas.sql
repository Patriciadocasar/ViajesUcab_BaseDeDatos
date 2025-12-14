-- ===================================================================
-- FIX: Desbordamiento de campo numeric en Res_Milla_Obtenida
-- ===================================================================
-- Problema: Si el total de la reserva es muy alto (>$9,990), 
--           las millas obtenidas (10%) exceden 999 (límite de NUMERIC(3))
-- Solución: Limitar las millas obtenidas a máximo 999
-- ===================================================================

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
    -- ✅ FIX: Usamos v_millas_totales (suma de millas de cada servicio) y limitamos a 999
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

    -- Crear los itinerarios para cada servicio
    -- Paquetes Turísticos
    IF p_paquete_turistico_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_paquete_turistico_ids, 1) LOOP
            INSERT INTO Itinerario (
                Paquete_Turistico_PT_COD,
                Iti_Costo_Total,
                Iti_Fecha_Inicio,
                Iti_Fecha_Fin,
                Iti_Cant_Milla_Total,
                Reserva_Res_COD
            )
            SELECT 
                p_paquete_turistico_ids[i],
                PT_Costo,
                COALESCE(p_fechas_inicio[i], CURRENT_DATE),
                COALESCE(p_fechas_fin[i], CURRENT_DATE + INTERVAL '1 day'),
                PT_Cant_Milla,
                v_nueva_reserva_id
            FROM Paquete_Turistico
            WHERE PT_COD = p_paquete_turistico_ids[i];
        END LOOP;
    END IF;

    -- Hospedajes
    IF p_hospedaje_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_hospedaje_ids, 1) LOOP
            INSERT INTO Itinerario (
                Hospedaje_Hos_COD,
                Iti_Costo_Total,
                Iti_Fecha_Inicio,
                Iti_Fecha_Fin,
                Iti_Cant_Milla_Total,
                Reserva_Res_COD
            )
            SELECT 
                p_hospedaje_ids[i],
                Hos_Costo,
                COALESCE(p_fechas_inicio[i], CURRENT_DATE),
                COALESCE(p_fechas_fin[i], CURRENT_DATE + INTERVAL '1 day'),
                Hot_Cant_Milla,
                v_nueva_reserva_id
            FROM Hospedaje
            WHERE Hos_COD = p_hospedaje_ids[i];
        END LOOP;
    END IF;

    -- Vuelos
    IF p_vuelo_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_vuelo_ids, 1) LOOP
            INSERT INTO Itinerario (
                Vuelo_Vue_COD,
                Iti_Costo_Total,
                Iti_Fecha_Inicio,
                Iti_Fecha_Fin,
                Iti_Cant_Milla_Total,
                Reserva_Res_COD
            )
            SELECT 
                p_vuelo_ids[i],
                Vue_Costo,
                COALESCE(p_fechas_inicio[i], CURRENT_DATE),
                COALESCE(p_fechas_fin[i], CURRENT_DATE + INTERVAL '1 day'),
                Vue_Cant_Millas,
                v_nueva_reserva_id
            FROM Vuelo
            WHERE Vue_COD = p_vuelo_ids[i];
        END LOOP;
    END IF;

    -- Cruceros
    IF p_crucero_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_crucero_ids, 1) LOOP
            INSERT INTO Itinerario (
                Crucero_Cru_COD,
                Iti_Costo_Total,
                Iti_Fecha_Inicio,
                Iti_Fecha_Fin,
                Iti_Cant_Milla_Total,
                Reserva_Res_COD
            )
            SELECT 
                p_crucero_ids[i],
                Cru_Costo,
                COALESCE(p_fechas_inicio[i], CURRENT_DATE),
                COALESCE(p_fechas_fin[i], CURRENT_DATE + INTERVAL '1 day'),
                Cru_Cant_Millas,
                v_nueva_reserva_id
            FROM Crucero
            WHERE Cru_COD = p_crucero_ids[i];
        END LOOP;
    END IF;

    -- Transporte Terrestre
    IF p_transporte_terrestre_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_transporte_terrestre_ids, 1) LOOP
            INSERT INTO Itinerario (
                Transporte_Terrestre_TT_COD,
                Iti_Costo_Total,
                Iti_Fecha_Inicio,
                Iti_Fecha_Fin,
                Iti_Cant_Milla_Total,
                Reserva_Res_COD
            )
            SELECT 
                p_transporte_terrestre_ids[i],
                TT_Costo,
                COALESCE(p_fechas_inicio[i], CURRENT_DATE),
                COALESCE(p_fechas_fin[i], CURRENT_DATE + INTERVAL '1 day'),
                TT_Cant_Millas,
                v_nueva_reserva_id
            FROM Transporte_Terrestre
            WHERE TT_COD = p_transporte_terrestre_ids[i];
        END LOOP;
    END IF;

    -- Servicios Adicionales
    IF p_servicio_adicional_ids IS NOT NULL THEN
        FOR i IN 1..array_length(p_servicio_adicional_ids, 1) LOOP
            INSERT INTO Itinerario (
                Servicio_Adicional_SA_COD,
                Iti_Costo_Total,
                Iti_Fecha_Inicio,
                Iti_Fecha_Fin,
                Iti_Cant_Milla_Total,
                Reserva_Res_COD
            )
            SELECT 
                p_servicio_adicional_ids[i],
                SA_Costo,
                COALESCE(p_fechas_inicio[i], CURRENT_DATE),
                COALESCE(p_fechas_fin[i], CURRENT_DATE + INTERVAL '1 day'),
                SA_Cant_Milla,
                v_nueva_reserva_id
            FROM Servicio_Adicional
            WHERE SA_COD = p_servicio_adicional_ids[i];
        END LOOP;
    END IF;

    -- Retornar resultado exitoso
    RETURN json_build_object(
        'status', 'success',
        'message', 'Reserva e itinerarios creados exitosamente',
        'data', json_build_object(
            'reserva_id', v_nueva_reserva_id,
            'numero_reserva', v_numero_reserva,
            'subtotal', v_subtotal,
            'total', v_total,
            'millas_obtenidas', v_millas_obtenidas,
            'millas_totales_servicios', v_millas_totales
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al crear la reserva: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

-- ===================================================================
-- Verificación
-- ===================================================================
-- Ahora la función limitará las millas obtenidas a máximo 999
-- Ejemplo: Si v_total = $15,000, millas = min(1500, 999) = 999
-- ===================================================================

