CREATE OR REPLACE FUNCTION obtener_itinerarios_cliente(
    p_cliente_id INTEGER
)
RETURNS JSON AS $$
DECLARE
    v_resultado JSON;
    v_reservas JSON;
BEGIN
    -- Validar que el cliente existe
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cli_COD = p_cliente_id) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El cliente especificado no existe'
        );
    END IF;

    -- Obtener todas las reservas del cliente con sus itinerarios
    SELECT json_agg(
        json_build_object(
            'reserva_id', R.Res_COD,
            'numero_reserva', R.Res_Numero_Reserva,
            'fecha_reserva', R.Res_Fecha_Hora,
            'subtotal', R.Res_Subtotal,
            'total', R.Res_Total,
            'millas_obtenidas', R.Res_Milla_Obtenida,
            'camarote', R.Res_Camarote,
            'itinerarios', (
                SELECT json_agg(
                    json_build_object(
                        'itinerario_id', I.Iti_COD,
                        'costo_total', I.Iti_Costo_Total,
                        'fecha_inicio', I.Iti_Fecha_Inicio,
                        'fecha_fin', I.Iti_Fecha_Fin,
                        'millas_totales', I.Iti_Cant_Milla_Total,
                        'paquete_turistico', CASE 
                            WHEN I.Paquete_Turistico_PT_COD IS NOT NULL THEN
                                (SELECT json_build_object(
                                    'id', PT.PT_COD,
                                    'nombre', PT.PT_Nombre,
                                    'descripcion', PT.PT_Descripcion,
                                    'costo', PT.PT_Costo,
                                    'tipo', PT.PT_Tipo
                                ) FROM Paquete_Turistico PT WHERE PT.PT_COD = I.Paquete_Turistico_PT_COD)
                            ELSE NULL
                        END,
                        'hospedaje', CASE 
                            WHEN I.Hospedaje_Hos_COD IS NOT NULL THEN
                                (SELECT json_build_object(
                                    'id', H.Hos_COD,
                                    'hotel_nombre', (SELECT Pro_Nombre FROM Hotel WHERE Pro_COD = H.Hotel_Pro_COD),
                                    'costo', H.Hos_Costo,
                                    'fecha_inicio', H.Hos_Fecha_Hora_Inicio,
                                    'fecha_fin', H.Hos_Fecha_Hora_Fin,
                                    'millas', H.Hot_Cant_Milla
                                ) FROM Hospedaje H WHERE H.Hos_COD = I.Hospedaje_Hos_COD)
                            ELSE NULL
                        END,
                        'restaurante', CASE 
                            WHEN I.Restaurante_Rest_COD IS NOT NULL THEN
                                (SELECT json_build_object(
                                    'id', REST.Rest_COD,
                                    'nombre', REST.Rest_Nombre,
                                    'tipo_comida', REST.Rest_Tipo_Comida,
                                    'clasificacion', REST.Rest_Clasificacion
                                ) FROM Restaurante REST WHERE REST.Rest_COD = I.Restaurante_Rest_COD)
                            ELSE NULL
                        END,
                        'vuelo', CASE 
                            WHEN I.Vuelo_Vue_COD IS NOT NULL THEN
                                (SELECT json_build_object(
                                    'id', V.Vue_COD,
                                    'costo', V.Vue_Costo,
                                    'fecha_salida', V.Vue_Fecha_Hora_Salida,
                                    'fecha_llegada', V.Vue_Fecha_Hora_Llegada,
                                    'millas', V.Vue_Cant_Millas,
                                    'huella_carbono', V.Vue_Huella_Carbono
                                ) FROM Vuelo V WHERE V.Vue_COD = I.Vuelo_Vue_COD)
                            ELSE NULL
                        END,
                        'crucero', CASE 
                            WHEN I.Crucero_Cru_COD IS NOT NULL THEN
                                (SELECT json_build_object(
                                    'id', CR.Cru_COD,
                                    'nombre', CR.Cru_Nombre,
                                    'costo', CR.Cru_Costo,
                                    'fecha_salida', CR.Cru_Fecha_Hora_Salida,
                                    'fecha_llegada', CR.Cru_Fecha_Hora_Lllegada,
                                    'millas', CR.Cru_Cant_Millas,
                                    'huella_carbono', CR.Cru_Huella_Carbono
                                ) FROM Crucero CR WHERE CR.Cru_COD = I.Crucero_Cru_COD)
                            ELSE NULL
                        END,
                        'transporte_terrestre', CASE 
                            WHEN I.Transporte_Terrestre_TT_COD IS NOT NULL THEN
                                (SELECT json_build_object(
                                    'id', TT.TT_COD,
                                    'costo', TT.TT_Costo,
                                    'fecha_salida', TT.TT_Fecha_Hora_Salida,
                                    'fecha_llegada', TT.TT_Fecha_Hora_Llegada,
                                    'millas', TT.TT_Cant_Millas,
                                    'huella_carbono', TT.TT_Huella_Carbono
                                ) FROM Transporte_Terrestre TT WHERE TT.TT_COD = I.Transporte_Terrestre_TT_COD)
                            ELSE NULL
                        END,
                        'servicio_adicional', CASE 
                            WHEN I.Servicio_Adicional_SA_COD IS NOT NULL THEN
                                (SELECT json_build_object(
                                    'id', SA.SA_COD,
                                    'nombre', SA.SA_Nombre,
                                    'descripcion', SA.SA_Descripcion,
                                    'costo', SA.SA_Costo,
                                    'tipo', SA.SA_Tipo,
                                    'millas', SA.SA_Cant_Milla,
                                    'fecha_inicio', SA.SA_Fecha_Hora_Inicio,
                                    'fecha_fin', SA.SA_Fecha_Hora_Fin
                                ) FROM Servicio_Adicional SA WHERE SA.SA_COD = I.Servicio_Adicional_SA_COD)
                            ELSE NULL
                        END
                    )
                )
                FROM Itinerario I
                WHERE I.Reserva_Res_COD = R.Res_COD
            )
        )
        ORDER BY R.Res_Fecha_Hora DESC
    )
    INTO v_reservas
    FROM Reserva R
    WHERE R.Cliente_Cli_COD = p_cliente_id;

    -- Construir el resultado
    v_resultado := json_build_object(
        'status', 'success',
        'data', json_build_object(
            'cliente_id', p_cliente_id,
            'total_reservas', (SELECT COUNT(*) FROM Reserva WHERE Cliente_Cli_COD = p_cliente_id),
            'reservas', COALESCE(v_reservas, '[]'::json)
        )
    );

    RETURN v_resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al obtener itinerarios del cliente: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sp_agregar_wishlist_json(
    p_cli_cod INTEGER,
    p_iti_cod INTEGER,
    p_wis_descripcion TEXT
)
RETURNS JSON AS $$
DECLARE
    v_nueva_wishlist_id INTEGER;
BEGIN
    -- Validar que el cliente existe
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cli_COD = p_cli_cod) THEN
        RETURN json_build_object('status','error','message','Cliente no encontrado');
    END IF;

    -- Validar que el itinerario existe
    IF NOT EXISTS (SELECT 1 FROM Itinerario WHERE Iti_COD = p_iti_cod) THEN
        RETURN json_build_object('status','error','message','Itinerario no encontrado');
    END IF;

    -- Insertar en la wishlist
    INSERT INTO Wishlist (Wis_Descripcion, Cliente_Cli_COD, Itinerario_Iti_COD)
    VALUES (p_wis_descripcion, p_cli_cod, p_iti_cod)
    RETURNING Wis_COD INTO v_nueva_wishlist_id;

    -- Retornar resultado exitoso
    RETURN json_build_object(
        'status','success',
        'message','Itinerario agregado a la lista de deseos',
        'data', json_build_object(
            'wishlist_id', v_nueva_wishlist_id,
            'cliente_id', p_cli_cod,
            'itinerario_id', p_iti_cod,
            'descripcion', p_wis_descripcion,
            'fecha_agregado', CURRENT_DATE
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object('status','error','message','Error al agregar a wishlist: '||SQLERRM);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sp_obtener_wishlist_cliente(
    p_cli_cod INTEGER
)
RETURNS JSON AS $$
DECLARE
    v_resultado JSON;
    v_wishlist_items JSON;
BEGIN
    -- Validar que el cliente existe
    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cli_COD = p_cli_cod) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Cliente no encontrado'
        );
    END IF;

    -- Obtener los servicios
    SELECT json_agg(
        json_build_object(
            'wishlist_id', W.Wis_COD,
            'descripcion', W.Wis_Descripcion,
            'fecha_agregado', W.Wis_Fecha,
            'itinerario_id', I.Iti_COD,
            'costo_total', I.Iti_Costo_Total,
            'fecha_inicio', I.Iti_Fecha_Inicio,
            'fecha_fin', I.Iti_Fecha_Fin,
            'millas_totales', I.Iti_Cant_Milla_Total,
            'paquete_turistico', CASE
                WHEN I.Paquete_Turistico_PT_COD IS NOT NULL THEN
                    (SELECT json_build_object(
                        'id', PT.PT_COD,
                        'nombre', PT.PT_Nombre,
                        'descripcion', PT.PT_Descripcion,
                        'costo', PT.PT_Costo
                    ) FROM Paquete_Turistico PT WHERE PT.PT_COD = I.Paquete_Turistico_PT_COD)
                ELSE NULL
            END,
            'hospedaje', CASE
                WHEN I.Hospedaje_Hos_COD IS NOT NULL THEN
                    (SELECT json_build_object(
                        'id', H.Hos_COD,
                        'hotel_nombre', (SELECT Pro_Nombre FROM Hotel WHERE Pro_COD = H.Hotel_Pro_COD),
                        'costo', H.Hos_Costo
                    ) FROM Hospedaje H WHERE H.Hos_COD = I.Hospedaje_Hos_COD)
                ELSE NULL
            END,
            'vuelo', CASE
                WHEN I.Vuelo_Vue_COD IS NOT NULL THEN
                    (SELECT json_build_object(
                        'id', V.Vue_COD,
                        'costo', V.Vue_Costo,
                        'fecha_salida', V.Vue_Fecha_Hora_Salida,
                        'fecha_llegada', V.Vue_Fecha_Hora_Llegada
                    ) FROM Vuelo V WHERE V.Vue_COD = I.Vuelo_Vue_COD)
                ELSE NULL
            END,
            'crucero', CASE
                WHEN I.Crucero_Cru_COD IS NOT NULL THEN
                    (SELECT json_build_object(
                        'id', CR.Cru_COD,
                        'nombre', CR.Cru_Nombre,
                        'costo', CR.Cru_Costo
                    ) FROM Crucero CR WHERE CR.Cru_COD = I.Crucero_Cru_COD)
                ELSE NULL
            END
        )
        ORDER BY W.Wis_Fecha DESC
    )
    INTO v_wishlist_items
    FROM Wishlist W
    JOIN Itinerario I ON W.Itinerario_Iti_COD = I.Iti_COD
    WHERE W.Cliente_Cli_COD = p_cli_cod;


    v_resultado := json_build_object(
        'status', 'success',
        'data', json_build_object(
            'cliente_id', p_cli_cod,
            'total_items', (SELECT COUNT(*) FROM Wishlist WHERE Cliente_Cli_COD = p_cli_cod),
            'wishlist', COALESCE(v_wishlist_items, '[]'::json)
        )
    );

    RETURN v_resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al obtener wishlist: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sp_registrar_resena_json(
    p_iti_cod INTEGER,
    p_rese_descripcion TEXT
)
RETURNS JSON AS $$
DECLARE
    v_rese_cod INTEGER;
    v_desc TEXT := NULLIF(TRIM(p_rese_descripcion), '');
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Itinerario WHERE Iti_COD = p_iti_cod) THEN
        RETURN json_build_object('status','error','message','Itinerario no encontrado');
    END IF;
    IF v_desc IS NULL THEN
        RETURN json_build_object('status','error','message','La descripción de la reseña no puede estar vacía');
    END IF;
    INSERT INTO Resenas (Itinerario_Iti_COD, Rese_Descripcion)
    VALUES (p_iti_cod, v_desc)
    RETURNING Rese_COD INTO v_rese_cod;
    RETURN json_build_object(
        'status','success',
        'message','Reseña registrada correctamente',
        'data', json_build_object(
            'resena_id', v_rese_cod,
            'itinerario_id', p_iti_cod,
            'descripcion', v_desc,
            'fecha', CURRENT_DATE
        )
    );
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object('status','error','message','Error al registrar reseña: '||SQLERRM);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sp_registrar_reclamo_json(
    p_iti_cod INTEGER,
    p_rec_descripcion TEXT
)
RETURNS JSON AS $$
DECLARE
    v_rec_cod INTEGER;
    v_reg_cod INTEGER;
    v_estatus_pendiente INTEGER;
    v_desc TEXT := NULLIF(TRIM(p_rec_descripcion), '');
BEGIN
    -- Validar existencia de itinerario
    IF NOT EXISTS (SELECT 1 FROM Itinerario WHERE Iti_COD = p_iti_cod) THEN
        RETURN json_build_object('status','error','message','Itinerario no encontrado');
    END IF;
    -- Validar que la descripción no esté vacía
    IF v_desc IS NULL THEN
        RETURN json_build_object('status','error','message','La descripción del reclamo no puede estar vacía');
    END IF;
    -- Obtener el código del estatus "Pendiente"
    SELECT Est_COD INTO v_estatus_pendiente
    FROM Estatus
    WHERE Est_Descripcion = 'Pendiente'
    LIMIT 1;
    IF v_estatus_pendiente IS NULL THEN
        RETURN json_build_object('status','error','message','No existe estatus Pendiente en la tabla Estatus');
    END IF;
    -- Insertar en Reclamo
    INSERT INTO Reclamo (Rec_Descripcion, Itinerario_Iti_COD)
    VALUES (v_desc, p_iti_cod)
    RETURNING Rec_COD INTO v_rec_cod;
    -- Insertar en Registro_Reclamos con estado Pendiente
    INSERT INTO Registro_Reclamos (Fecha_Inicio, Fecha_Fin, Estatus_Est_COD, Reclamo_Rec_COD)
    VALUES (CURRENT_DATE, NULL, v_estatus_pendiente, v_rec_cod)
    RETURNING COD INTO v_reg_cod;
    RETURN json_build_object(
        'status','success',
        'message','Reclamo registrado correctamente con estado Pendiente',
        'data', json_build_object(
            'reclamo_id', v_rec_cod,
            'registro_id', v_reg_cod,
            'itinerario_id', p_iti_cod,
            'descripcion', v_desc,
            'estatus_id', v_estatus_pendiente,
            'fecha_inicio', CURRENT_DATE,
            'fecha_fin', NULL
        )
    );
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object('status','error','message','Error al registrar reclamo: '||SQLERRM);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_mostrar_reclamos_admin()
RETURNS JSON AS $$
DECLARE
    v_reclamos JSON;
BEGIN
    -- Versión simplificada: solo obtiene datos básicos de Reclamo
    -- Sin joins complejos para evitar errores si las tablas no existen
    SELECT json_agg(
        json_build_object(
            'reclamo_id', R.Rec_COD,
            'descripcion', R.Rec_Descripcion,
            'itinerario_id', COALESCE(R.Itinerario_Iti_COD, 0)
        )
        ORDER BY R.Rec_COD DESC
    )
    INTO v_reclamos
    FROM Reclamo R;

    RETURN json_build_object(
        'status', 'success',
        'message', 'Reclamos obtenidos correctamente',
        'data', COALESCE(v_reclamos, '[]'::json)
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object('status','error','message','Error al listar reclamos: '||SQLERRM);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sp_registrar_reembolso_json(
    p_res_cod INTEGER,
    p_divisa TEXT,
    p_tasa_aplicada NUMERIC(12,2),
    p_mp_cod INTEGER,
    p_tc_cod INTEGER DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
    v_total_reserva NUMERIC(12,2);
    v_monto_devuelto NUMERIC(12,2);
    v_monto_retenido NUMERIC(12,2);
    v_rem_cod INTEGER;
    v_tasa_final NUMERIC(12,2) := p_tasa_aplicada;
    v_divisa_final VARCHAR(60) := p_divisa;
    v_valor_dolar NUMERIC(12,2);
    v_monto_equivalente_usd NUMERIC(12,2);
BEGIN
    SELECT Res_Total INTO v_total_reserva
    FROM Reserva
    WHERE Res_COD = p_res_cod;

    IF NOT FOUND THEN
        RETURN json_build_object('status','error','message','Reserva no encontrada');
    END IF;

    v_monto_retenido := v_total_reserva * 0.10;
    v_monto_devuelto := v_total_reserva * 0.90;

    --tasa de cambio
    IF p_tc_cod IS NOT NULL THEN
        SELECT TC_Valor, TC_Tipo_Moneda, TC_Valor_Dolar
        INTO v_tasa_final, v_divisa_final, v_valor_dolar
        FROM Tasa_de_Cambio
        WHERE TC_COD = p_tc_cod;

        v_monto_equivalente_usd := v_monto_devuelto * v_valor_dolar;
    END IF;


    INSERT INTO Reembolso (Reserva_Res_COD, Rem_Monto_Devuelto, Rem_Monto_Retenido)
    VALUES (p_res_cod, v_monto_devuelto, v_monto_retenido)
    RETURNING Rem_COD INTO v_rem_cod;


    INSERT INTO Pago_Reembolsado (
        Reembolso_Rem_COD, Metodo_de_Pago_MP_COD, Fecha_Hora_Reembolso,
        Monto_Reembolso, Divisa_Utilizada, Tasa_Aplicada, Tasa_de_Cambio_TC_COD
    )
    VALUES (
        v_rem_cod, p_mp_cod, CURRENT_TIMESTAMP,
        v_monto_devuelto, v_divisa_final, v_tasa_final, p_tc_cod
    );

    RETURN json_build_object(
        'status','success',
        'message','Reembolso procesado correctamente',
        'data', json_build_object(
            'reserva_id', p_res_cod,
            'reembolso_id', v_rem_cod,
            'monto_total', v_total_reserva,
            'monto_retenido', v_monto_retenido,
            'monto_devuelto', v_monto_devuelto,
            'divisa', v_divisa_final,
            'tasa_aplicada', v_tasa_final,
            'metodo_pago_id', p_mp_cod,
            'tasa_cambio_id', p_tc_cod,
            'monto_equivalente_usd', v_monto_equivalente_usd,
            'fecha_reembolso', CURRENT_TIMESTAMP
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object('status','error','message','Error al procesar reembolso: '||SQLERRM);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_registrar_financiamiento_json(
    p_reserva_id INTEGER,
    p_numero_cuotas INTEGER
)
RETURNS JSON AS $$
DECLARE
    v_financiamiento_id INTEGER;
    v_total_reserva NUMERIC(12,2);
    v_monto_cuota NUMERIC(12,2);
    v_cliente_id INTEGER;
    i INTEGER;
BEGIN

    SELECT Res_Total, Cliente_Cli_COD 
    INTO v_total_reserva, v_cliente_id
    FROM Reserva
    WHERE Res_COD = p_reserva_id;
    
    IF v_total_reserva IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'No encontré esa reserva'
        );
    END IF;
    
    v_monto_cuota := v_total_reserva / p_numero_cuotas;
    
    INSERT INTO Financiamiento (
        Fin_Numero_Cuotas,
        Reserva_Res_COD,
        Fin_Monto_Financiado,
        Fin_Fecha
    )
    VALUES (
        p_numero_cuotas,
        p_reserva_id,
        v_total_reserva,
        CURRENT_DATE
    )
    RETURNING Fin_COD INTO v_financiamiento_id;
    
    FOR i IN 1..p_numero_cuotas LOOP
        INSERT INTO Cuota (
            Cuo_Monto,
            Cuo_Fecha_Vencimiento,
            Financiamiento_Fin_COD,
            Cuo_Fecha_Pago
        )
        VALUES (
            v_monto_cuota,
            CURRENT_DATE + (i * INTERVAL '1 month'),
            v_financiamiento_id,
            CURRENT_DATE + (i * INTERVAL '1 month') + INTERVAL '1 day'
        );
    END LOOP;
    
    RETURN json_build_object(
        'status', 'success',
        'message', 'Financiamiento creado',
        'data', json_build_object(
            'financiamiento_id', v_financiamiento_id,
            'reserva_id', p_reserva_id,
            'cliente_id', v_cliente_id,
            'total', v_total_reserva,
            'cuotas', p_numero_cuotas,
            'monto_mensual', v_monto_cuota
        )
    );
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Hubo un error: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION listar_paquetes_turisticos()
RETURNS JSON AS $$
BEGIN
    RETURN (
        SELECT json_build_object(
            'status', 'success',
            'data', COALESCE(json_agg(
                json_build_object(
                    'id', PT_COD,
                    'nombre', PT_Nombre,
                    'descripcion', PT_Descripcion,
                    'costo', PT_Costo,
                    'costoMillas', PT_Costo_Millas,
                    'cantidadMillas', PT_Cant_Milla,
                    'tipo', PT_Tipo
                )
                ORDER BY PT_COD
            ), '[]'::json)
        )
        FROM Paquete_Turistico
    );
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al listar paquetes: ' 
        );
END;
$$ LANGUAGE plpgsql;


-- Insertar restricción de paquete
CREATE OR REPLACE FUNCTION insertar_restriccion_paquete(
    p_tipo VARCHAR,
    p_descripcion TEXT,
    p_paquete_id INTEGER
)
RETURNS JSON AS $$
DECLARE
    v_restriccion_id INTEGER;
BEGIN

    IF NOT EXISTS (SELECT 1 FROM Paquete_Turistico WHERE PT_COD = p_paquete_id) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El paquete turístico no existe'
        );
    END IF;

    INSERT INTO Restriccion_Paquete (
        RP_Tipo,
        RP_Descripción,
        Paquete_Turistico_PT_COD
    )
    VALUES (
        p_tipo,
        p_descripcion,
        p_paquete_id
    )
    RETURNING RP_COD INTO v_restriccion_id;

    RETURN json_build_object(
        'status', 'success',
        'message', 'Restricción agregada correctamente',
        'data', json_build_object(
            'restriccion_id', v_restriccion_id,
            'paquete_id', p_paquete_id,
            'tipo', p_tipo,
            'descripcion', p_descripcion
        )
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al insertar restricción: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION consultar_restricciones_paquete(
    p_paquete_id INTEGER
)
RETURNS JSON AS $$
BEGIN
    RETURN (
        SELECT json_build_object(
            'status', 'success',
            'data', COALESCE(json_agg(
                json_build_object(
                    'id', RP_COD,
                    'tipo', RP_Tipo,
                    'descripcion', RP_Descripción,
                    'paqueteId', Paquete_Turistico_PT_COD
                )
                ORDER BY RP_COD
            ), '[]'::json)
        )
        FROM Restriccion_Paquete
        WHERE Paquete_Turistico_PT_COD = p_paquete_id
    );
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al consultar restricciones: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;


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

    IF LOWER(PaqTur_Tipo) = 'especial' AND PaqTur_Restriccion_Tipo IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Los paquetes especiales requieren especificar el tipo de restricción (Edad o Estado Civil)'
        );
    END IF;

    IF PaqTur_Restriccion_Tipo IS NOT NULL AND 
       LOWER(PaqTur_Restriccion_Tipo) NOT IN ('edad', 'estado civil') THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El tipo de restricción debe ser "Edad" o "Estado Civil"'
        );
    END IF;

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


-- =====================================================================
-- FUNCIÓN PARA VALIDAR RESTRICCIONES DE PAQUETES AL COMPRAR
-- =====================================================================
-- Esta función verifica si los pasajeros de una reserva cumplen con
-- las restricciones del paquete turístico que están comprando.
-- 
-- Tipos de restricción:
-- 1. EDAD: Al menos un pasajero debe tener la edad exacta especificada
-- 2. ESTADO CIVIL: 
--    - Si menciona "casado/matrimonio/luna de miel": Todos deben estar casados
--    - Si menciona "divorciado/divorcio": Al menos uno debe estar divorciado
-- =====================================================================

CREATE OR REPLACE FUNCTION validar_restricciones_paquete(
    p_paquete_id INTEGER,
    p_reserva_id INTEGER
)
RETURNS JSON AS $$
DECLARE
    v_restriccion RECORD;
    v_pasajeros_count INTEGER;
    v_pasajeros_cumplen INTEGER;
    v_edad_requerida INTEGER;
    v_descripcion_lower TEXT;
BEGIN
    -- Paso 1: Verificar si el paquete existe
    IF NOT EXISTS (SELECT 1 FROM Paquete_Turistico WHERE PT_COD = p_paquete_id) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El paquete turístico no existe'
        );
    END IF;

    -- Paso 2: Verificar si la reserva existe
    IF NOT EXISTS (SELECT 1 FROM Reserva WHERE Res_COD = p_reserva_id) THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'La reserva no existe'
        );
    END IF;

    -- Paso 3: Verificar cuántos pasajeros tiene la reserva
    SELECT COUNT(*) INTO v_pasajeros_count
    FROM Pasajero
    WHERE Reserva_Res_COD = p_reserva_id;

    IF v_pasajeros_count = 0 THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'La reserva no tiene pasajeros asociados'
        );
    END IF;

    -- Paso 4: Buscar si el paquete tiene restricciones
    SELECT RP_Tipo, RP_Descripción 
    INTO v_restriccion
    FROM Restriccion_Paquete
    WHERE Paquete_Turistico_PT_COD = p_paquete_id
    LIMIT 1;

    -- Si no tiene restricciones, está todo bien
    IF v_restriccion IS NULL THEN
        RETURN json_build_object(
            'status', 'success',
            'message', 'El paquete no tiene restricciones. Compra permitida.',
            'cumple', true
        );
    END IF;

    -- Paso 5: Validar según el tipo de restricción
    v_descripcion_lower := LOWER(v_restriccion.RP_Descripción);

    -- ===== CASO 1: RESTRICCIÓN POR EDAD =====
    IF LOWER(v_restriccion.RP_Tipo) = 'edad' THEN
        -- Intentar extraer la edad de la descripción
        -- Buscamos números en la descripción (ej: "15 años", "solo para 18")
        v_edad_requerida := NULL;
        
        -- Buscar patrones comunes de edad
        IF v_descripcion_lower ~ '\d+' THEN
            v_edad_requerida := (regexp_match(v_descripcion_lower, '(\d+)'))[1]::INTEGER;
        END IF;

        IF v_edad_requerida IS NULL THEN
            RETURN json_build_object(
                'status', 'error',
                'message', 'No se pudo determinar la edad requerida en la restricción'
            );
        END IF;

        -- Contar cuántos pasajeros tienen la edad requerida
        SELECT COUNT(*) INTO v_pasajeros_cumplen
        FROM Pasajero
        WHERE Reserva_Res_COD = p_reserva_id
        AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, Pas_Fecha_Nacimiento)) = v_edad_requerida;

        -- Al menos UN pasajero debe tener la edad requerida
        IF v_pasajeros_cumplen = 0 THEN
            RETURN json_build_object(
                'status', 'error',
                'message', 'No se cumple la restricción: Al menos un pasajero debe tener ' || v_edad_requerida || ' años',
                'cumple', false,
                'tipo_restriccion', 'Edad',
                'edad_requerida', v_edad_requerida
            );
        END IF;

        RETURN json_build_object(
            'status', 'success',
            'message', 'Restricción de edad cumplida correctamente',
            'cumple', true,
            'pasajeros_que_cumplen', v_pasajeros_cumplen
        );
    END IF;

    -- ===== CASO 2: RESTRICCIÓN POR ESTADO CIVIL =====
    IF LOWER(v_restriccion.RP_Tipo) = 'estado civil' THEN
        
        -- Sub-caso 2A: Luna de miel / Matrimonio (TODOS deben estar casados)
        IF v_descripcion_lower LIKE '%casad%' OR 
           v_descripcion_lower LIKE '%matrimonio%' OR 
           v_descripcion_lower LIKE '%luna de miel%' THEN
            
            -- Contar cuántos están casados
            SELECT COUNT(*) INTO v_pasajeros_cumplen
            FROM Pasajero
            WHERE Reserva_Res_COD = p_reserva_id
            AND LOWER(Pas_Estado_Civil) = 'casado';

            -- TODOS los pasajeros deben estar casados
            IF v_pasajeros_cumplen < v_pasajeros_count THEN
                RETURN json_build_object(
                    'status', 'error',
                    'message', 'No se cumple la restricción: Todos los pasajeros deben estar casados',
                    'cumple', false,
                    'tipo_restriccion', 'Estado Civil',
                    'pasajeros_totales', v_pasajeros_count,
                    'pasajeros_casados', v_pasajeros_cumplen
                );
            END IF;

            RETURN json_build_object(
                'status', 'success',
                'message', 'Restricción de estado civil cumplida: Todos están casados',
                'cumple', true
            );
        END IF;

        -- Sub-caso 2B: Divorcio (AL MENOS UNO debe estar divorciado)
        IF v_descripcion_lower LIKE '%divorciad%' OR 
           v_descripcion_lower LIKE '%divorcio%' THEN
            
            -- Contar cuántos están divorciados
            SELECT COUNT(*) INTO v_pasajeros_cumplen
            FROM Pasajero
            WHERE Reserva_Res_COD = p_reserva_id
            AND LOWER(Pas_Estado_Civil) = 'divorciado';

            -- Al menos UNO debe estar divorciado
            IF v_pasajeros_cumplen = 0 THEN
                RETURN json_build_object(
                    'status', 'error',
                    'message', 'No se cumple la restricción: Al menos un pasajero debe estar divorciado',
                    'cumple', false,
                    'tipo_restriccion', 'Estado Civil'
                );
            END IF;

            RETURN json_build_object(
                'status', 'success',
                'message', 'Restricción de estado civil cumplida: Hay pasajeros divorciados',
                'cumple', true,
                'pasajeros_divorciados', v_pasajeros_cumplen
            );
        END IF;

        -- Si no se identifica el tipo específico de estado civil
        RETURN json_build_object(
            'status', 'error',
            'message', 'No se pudo identificar el tipo específico de restricción de estado civil'
        );
    END IF;

    -- Si llegamos aquí, es un tipo de restricción no soportado
    RETURN json_build_object(
        'status', 'error',
        'message', 'Tipo de restricción no soportado: ' || v_restriccion.RP_Tipo
    );

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Error al validar restricciones: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

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

    IF LOWER(PaqTur_Tipo) = 'especial' AND PaqTur_Restriccion_Tipo IS NULL THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'Los paquetes especiales requieren especificar el tipo de restricción (Edad o Estado Civil)'
        );
    END IF;

    IF PaqTur_Restriccion_Tipo IS NOT NULL AND 
       LOWER(PaqTur_Restriccion_Tipo) NOT IN ('edad', 'estado civil') THEN
        RETURN json_build_object(
            'status', 'error',
            'message', 'El tipo de restricción debe ser "Edad" o "Estado Civil"'
        );
    END IF;

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


CREATE OR REPLACE FUNCTION validar_restricciones_paquete_json(
    p_paquete_id INTEGER,
    p_pasajeros JSON
)
RETURNS JSON AS $$
DECLARE
    tipo_rest VARCHAR;
    desc_rest TEXT;
    total_pasajeros INTEGER;
    pasajeros_ok INTEGER;
    edad INTEGER;
    descripcion TEXT;
    pasajero RECORD;
    fecha_nac DATE;
    estado_civil_lower TEXT;
BEGIN

    IF NOT EXISTS (SELECT 1 FROM Paquete_Turistico WHERE PT_COD = p_paquete_id) THEN
        RETURN json_build_object('status', 'error', 'message', 'El paquete no existe');
    END IF;


    SELECT json_array_length(p_pasajeros) INTO total_pasajeros;
    
    IF total_pasajeros = 0 THEN
        RETURN json_build_object('status', 'error', 'message', 'No hay pasajeros para validar');
    END IF;


    SELECT RP_Tipo, RP_Descripción INTO tipo_rest, desc_rest
    FROM Restriccion_Paquete 
    WHERE Paquete_Turistico_PT_COD = p_paquete_id
    LIMIT 1;


    IF tipo_rest IS NULL THEN
        RETURN json_build_object('status', 'success', 'message', 'No tiene restricciones', 'cumple', true);
    END IF;

    descripcion := LOWER(desc_rest);

    -- EDAD
    IF LOWER(tipo_rest) = 'edad' THEN
        IF descripcion LIKE '%15%' THEN
            edad := 15;
        ELSIF descripcion LIKE '%18%' THEN
            edad := 18;
        ELSIF descripcion LIKE '%60%' THEN
            edad := 60;
        ELSIF descripcion LIKE '%21%' THEN
            edad := 21;
        ELSE
            RETURN json_build_object('status', 'error', 'message', 'No se encuentra la edad en la restricción');
        END IF;


        pasajeros_ok := 0;
        
        FOR pasajero IN SELECT * FROM json_array_elements(p_pasajeros)
        LOOP

            fecha_nac := (pasajero.value->>'fechaNacimiento')::DATE;
            

            IF DATE_PART('year', AGE(fecha_nac)) = edad THEN
                pasajeros_ok := pasajeros_ok + 1;
            END IF;
        END LOOP;

        IF pasajeros_ok = 0 THEN
            RETURN json_build_object(
                'status', 'error', 
                'message', 'Debe haber al menos un pasajero de ' || edad || ' años',
                'cumple', false
            );
        END IF;

        RETURN json_build_object('status', 'success', 'message', 'Cumple con la restricción de edad', 'cumple', true);
    END IF;

    --ESTADO CIVIL
    IF LOWER(tipo_rest) = 'estado civil' THEN
        
        IF descripcion LIKE '%casad%' OR descripcion LIKE '%matrimonio%' OR descripcion LIKE '%luna de miel%' THEN
            pasajeros_ok := 0;
            
            FOR pasajero IN SELECT * FROM json_array_elements(p_pasajeros)
            LOOP
                estado_civil_lower := LOWER(pasajero.value->>'estadoCivil');
                
                IF estado_civil_lower = 'casado' THEN
                    pasajeros_ok := pasajeros_ok + 1;
                END IF;
            END LOOP;

            IF pasajeros_ok < total_pasajeros THEN
                RETURN json_build_object(
                    'status', 'error',
                    'message', 'Todos los pasajeros deben estar casados para este paquete',
                    'cumple', false
                );
            END IF;

            RETURN json_build_object('status', 'success', 'message', 'Todos los pasajeros cumplen con el estado civil requerido', 'cumple', true);
        END IF;

        IF descripcion LIKE '%divorciad%' OR descripcion LIKE '%divorcio%' THEN
            pasajeros_ok := 0;
            
            FOR pasajero IN SELECT * FROM json_array_elements(p_pasajeros)
            LOOP
                estado_civil_lower := LOWER(pasajero.value->>'estadoCivil');
                
                IF estado_civil_lower = 'divorciado' THEN
                    pasajeros_ok := pasajeros_ok + 1;
                END IF;
            END LOOP;

            IF pasajeros_ok = 0 THEN
                RETURN json_build_object(
                    'status', 'error',
                    'message', 'Debe haber al menos un pasajero divorciado',
                    'cumple', false
                );
            END IF;

            RETURN json_build_object('status', 'success', 'message', 'Cumple con la restricción de estado civil', 'cumple', true);
        END IF;

        RETURN json_build_object('status', 'error', 'message', 'No se pudo identificar el tipo de estado civil requerido');
    END IF;

    RETURN json_build_object('status', 'error', 'message', 'Tipo de restricción no válido');

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object('status', 'error', 'message', 'Error al validar: ' || SQLERRM);
END;
$$ LANGUAGE plpgsql;

