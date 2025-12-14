-- =====================================================
-- SCRIPT DE PRUEBA PARA FUNCIONES DE ITINERARIO Y PAGO
-- =====================================================
-- Este script contiene ejemplos de prueba para las funciones
-- Ejecutar después de crear las tablas y funciones

-- =====================================================
-- PREPARACIÓN: Datos de Prueba
-- =====================================================

-- 1. Verificar que existen los datos necesarios
SELECT 'Verificando datos de prueba...' AS mensaje;

-- Verificar clientes
SELECT 
    'Clientes disponibles: ' || COUNT(*) AS resultado
FROM Cliente;

-- Verificar vuelos
SELECT 
    'Vuelos disponibles: ' || COUNT(*) AS resultado
FROM Vuelo;

-- Verificar hospedajes
SELECT 
    'Hospedajes disponibles: ' || COUNT(*) AS resultado
FROM Hospedaje;

-- =====================================================
-- PRUEBA 1: Crear Itinerario Simple
-- =====================================================
SELECT '
=====================================================
PRUEBA 1: Crear Itinerario Simple (Vuelo + Hotel)
=====================================================' AS test;

-- Crear un itinerario con un vuelo y un hospedaje
SELECT crear_itinerario_con_reserva(
    p_cliente_id := 1,
    p_vuelo_ids := ARRAY[1],
    p_hospedaje_ids := ARRAY[1],
    p_fechas_inicio := ARRAY[CURRENT_DATE + 30],
    p_fechas_fin := ARRAY[CURRENT_DATE + 37]
) AS resultado_prueba_1;

-- =====================================================
-- PRUEBA 2: Crear Itinerario Complejo
-- =====================================================
SELECT '
=====================================================
PRUEBA 2: Crear Itinerario Complejo (Múltiples Servicios)
=====================================================' AS test;

-- Crear un itinerario con múltiples servicios
SELECT crear_itinerario_con_reserva(
    p_cliente_id := 1,
    p_vuelo_ids := ARRAY[1, 2],
    p_hospedaje_ids := ARRAY[1, 2],
    p_servicio_adicional_ids := ARRAY[1],
    p_fechas_inicio := ARRAY[CURRENT_DATE + 60, CURRENT_DATE + 67],
    p_fechas_fin := ARRAY[CURRENT_DATE + 67, CURRENT_DATE + 74]
) AS resultado_prueba_2;

-- =====================================================
-- PRUEBA 3: Registrar Método de Pago
-- =====================================================
SELECT '
=====================================================
PRUEBA 3: Registrar Método de Pago (Tarjeta)
=====================================================' AS test;

-- Registrar una tarjeta de crédito
SELECT registrar_metodo_pago_tarjeta(
    p_tipo := 'Tarjeta_Credito',
    p_num_tarjeta := 4111111111111111,
    p_cod_seguridad := 123,
    p_emisor := 'Banco de Venezuela',
    p_marca := 'Visa',
    p_fecha_vencimiento := '2027-12-31'::DATE,
    p_nombre_titular := 'Juan Perez'
) AS resultado_prueba_3;

-- =====================================================
-- PRUEBA 4: Obtener Detalle de Reserva
-- =====================================================
SELECT '
=====================================================
PRUEBA 4: Obtener Detalle de Reserva
=====================================================' AS test;

-- Obtener el detalle de la primera reserva creada
-- Nota: Ajustar el ID según las reservas creadas
SELECT obtener_detalle_reserva(
    p_reserva_id := 1
) AS resultado_prueba_4;

-- =====================================================
-- PRUEBA 5: Procesar Pago Simple
-- =====================================================
SELECT '
=====================================================
PRUEBA 5: Procesar Pago Simple (Sin Millas)
=====================================================' AS test;

-- Primero, obtener el total de la reserva
DO $$
DECLARE
    v_reserva_id INTEGER := 1;
    v_total NUMERIC(10,2);
    v_cliente_id INTEGER := 1;
    v_metodo_pago_id INTEGER;
BEGIN
    -- Obtener el total de la reserva
    SELECT Res_Total INTO v_total
    FROM Reserva
    WHERE Res_COD = v_reserva_id;
    
    -- Obtener un método de pago del cliente
    SELECT MP_COD INTO v_metodo_pago_id
    FROM Metodo_de_Pago
    LIMIT 1;
    
    -- Procesar el pago
    RAISE NOTICE 'Procesando pago de reserva % por monto %', v_reserva_id, v_total;
    
    PERFORM procesar_pago_reserva(
        p_reserva_id := v_reserva_id,
        p_cliente_id := v_cliente_id,
        p_metodo_pago_id := v_metodo_pago_id,
        p_monto_pago := v_total
    );
END $$;

-- =====================================================
-- PRUEBA 6: Procesar Pago con Millas
-- =====================================================
SELECT '
=====================================================
PRUEBA 6: Procesar Pago con Millas
=====================================================' AS test;

-- Primero, crear una nueva reserva para esta prueba
DO $$
DECLARE
    v_nueva_reserva JSON;
    v_reserva_id INTEGER;
    v_total NUMERIC(10,2);
    v_cliente_id INTEGER := 1;
    v_metodo_pago_id INTEGER;
    v_millas_cliente NUMERIC(6);
BEGIN
    -- Crear una nueva reserva
    SELECT crear_itinerario_con_reserva(
        p_cliente_id := v_cliente_id,
        p_vuelo_ids := ARRAY[1],
        p_hospedaje_ids := ARRAY[1],
        p_fechas_inicio := ARRAY[CURRENT_DATE + 90],
        p_fechas_fin := ARRAY[CURRENT_DATE + 97]
    ) INTO v_nueva_reserva;
    
    -- Extraer el ID de la reserva del JSON
    v_reserva_id := (v_nueva_reserva->>'data')::JSON->>'reserva_id';
    
    -- Obtener el total de la reserva
    SELECT Res_Total INTO v_total
    FROM Reserva
    WHERE Res_COD = v_reserva_id;
    
    -- Obtener millas del cliente
    SELECT Cli_Millas_Acum INTO v_millas_cliente
    FROM Cliente
    WHERE Cli_COD = v_cliente_id;
    
    -- Obtener un método de pago
    SELECT MP_COD INTO v_metodo_pago_id
    FROM Metodo_de_Pago
    LIMIT 1;
    
    RAISE NOTICE 'Cliente tiene % millas. Usando 50 millas para el pago.', v_millas_cliente;
    
    -- Procesar pago con millas (usar 50 millas)
    IF v_millas_cliente >= 50 THEN
        PERFORM procesar_pago_reserva(
            p_reserva_id := v_reserva_id,
            p_cliente_id := v_cliente_id,
            p_metodo_pago_id := v_metodo_pago_id,
            p_monto_pago := v_total,
            p_pago_con_millas := TRUE,
            p_cantidad_millas := 50
        );
    ELSE
        RAISE NOTICE 'Cliente no tiene suficientes millas. Saltando prueba.';
    END IF;
END $$;

-- =====================================================
-- PRUEBA 7: Procesar Pago con Financiamiento
-- =====================================================
SELECT '
=====================================================
PRUEBA 7: Procesar Pago con Financiamiento (6 Cuotas)
=====================================================' AS test;

-- Crear una reserva y pagarla con financiamiento
DO $$
DECLARE
    v_nueva_reserva JSON;
    v_reserva_id INTEGER;
    v_total NUMERIC(10,2);
    v_cliente_id INTEGER := 1;
    v_metodo_pago_id INTEGER;
    v_pago_inicial NUMERIC(10,2);
BEGIN
    -- Crear una nueva reserva
    SELECT crear_itinerario_con_reserva(
        p_cliente_id := v_cliente_id,
        p_vuelo_ids := ARRAY[1],
        p_hospedaje_ids := ARRAY[1],
        p_servicio_adicional_ids := ARRAY[1],
        p_fechas_inicio := ARRAY[CURRENT_DATE + 120],
        p_fechas_fin := ARRAY[CURRENT_DATE + 127]
    ) INTO v_nueva_reserva;
    
    -- Extraer el ID de la reserva
    v_reserva_id := (v_nueva_reserva->>'data')::JSON->>'reserva_id';
    
    -- Obtener el total
    SELECT Res_Total INTO v_total
    FROM Reserva
    WHERE Res_COD = v_reserva_id;
    
    -- Calcular pago inicial (20% del total)
    v_pago_inicial := v_total * 0.20;
    
    -- Obtener método de pago
    SELECT MP_COD INTO v_metodo_pago_id
    FROM Metodo_de_Pago
    LIMIT 1;
    
    RAISE NOTICE 'Total: %. Pago inicial: %. Financiado: %', 
                 v_total, v_pago_inicial, (v_total - v_pago_inicial);
    
    -- Procesar pago con financiamiento
    PERFORM procesar_pago_reserva(
        p_reserva_id := v_reserva_id,
        p_cliente_id := v_cliente_id,
        p_metodo_pago_id := v_metodo_pago_id,
        p_monto_pago := v_pago_inicial,
        p_usar_financiamiento := TRUE,
        p_numero_cuotas := 6,
        p_monto_financiado := (v_total - v_pago_inicial)
    );
END $$;

-- =====================================================
-- PRUEBA 8: Cancelar Reserva con Reembolso
-- =====================================================
SELECT '
=====================================================
PRUEBA 8: Cancelar Reserva con Reembolso (10% Retención)
=====================================================' AS test;

-- Crear una reserva y cancelarla inmediatamente
DO $$
DECLARE
    v_nueva_reserva JSON;
    v_reserva_id INTEGER;
    v_metodo_pago_id INTEGER;
BEGIN
    -- Crear una nueva reserva
    SELECT crear_itinerario_con_reserva(
        p_cliente_id := 1,
        p_vuelo_ids := ARRAY[1],
        p_hospedaje_ids := ARRAY[1],
        p_fechas_inicio := ARRAY[CURRENT_DATE + 150],
        p_fechas_fin := ARRAY[CURRENT_DATE + 157]
    ) INTO v_nueva_reserva;
    
    -- Extraer el ID de la reserva
    v_reserva_id := (v_nueva_reserva->>'data')::JSON->>'reserva_id';
    
    -- Obtener método de pago
    SELECT MP_COD INTO v_metodo_pago_id
    FROM Metodo_de_Pago
    LIMIT 1;
    
    RAISE NOTICE 'Cancelando reserva %...', v_reserva_id;
    
    -- Cancelar la reserva con 10% de retención
    PERFORM cancelar_reserva_con_reembolso(
        p_reserva_id := v_reserva_id,
        p_porcentaje_retencion := 10.00,
        p_metodo_pago_reembolso_id := v_metodo_pago_id
    );
END $$;

-- =====================================================
-- VERIFICACIÓN FINAL
-- =====================================================
SELECT '
=====================================================
VERIFICACIÓN FINAL: Resumen de Datos Creados
=====================================================' AS test;

-- Contar reservas creadas
SELECT 
    'Total de Reservas: ' || COUNT(*) AS resultado
FROM Reserva;

-- Contar itinerarios creados
SELECT 
    'Total de Itinerarios: ' || COUNT(*) AS resultado
FROM Itinerario;

-- Contar pagos procesados
SELECT 
    'Total de Pagos: ' || COUNT(*) AS resultado
FROM Pago;

-- Contar financiamientos
SELECT 
    'Total de Financiamientos: ' || COUNT(*) AS resultado
FROM Financiamiento;

-- Contar reembolsos
SELECT 
    'Total de Reembolsos: ' || COUNT(*) AS resultado
FROM Reembolso;

-- Ver millas actuales del cliente de prueba
SELECT 
    Cli_COD,
    Cli_Primer_Nombre || ' ' || Cli_Apellido AS nombre_cliente,
    Cli_Millas_Acum AS millas_actuales
FROM Cliente
WHERE Cli_COD = 1;

-- Ver últimas 5 reservas creadas
SELECT 
    R.Res_COD,
    R.Res_Numero_Reserva,
    R.Res_Total,
    R.Res_Milla_Obtenida,
    R.Res_Fecha_Hora,
    C.Cli_Primer_Nombre || ' ' || C.Cli_Apellido AS cliente
FROM Reserva R
JOIN Cliente C ON R.Cliente_Cli_COD = C.Cli_COD
ORDER BY R.Res_Fecha_Hora DESC
LIMIT 5;

SELECT '
=====================================================
PRUEBAS COMPLETADAS
=====================================================' AS test;

