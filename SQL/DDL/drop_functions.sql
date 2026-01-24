
-- Funciones de Usuario y Autenticación
DROP FUNCTION IF EXISTS registrar_usuario(VARCHAR, VARCHAR, VARCHAR, VARCHAR, INTEGER);
DROP FUNCTION IF EXISTS registrar_usuario_cliente(VARCHAR, VARCHAR, VARCHAR, VARCHAR, INTEGER, VARCHAR, VARCHAR, VARCHAR, VARCHAR, DATE, VARCHAR, INTEGER);
DROP FUNCTION IF EXISTS inicio_sesion(VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS mostrar_usuario(INTEGER);

-- Funciones de Aerolíneas
DROP FUNCTION IF EXISTS insertar_aerolinea(VARCHAR, TEXT, NUMERIC, VARCHAR, DATE, INTEGER);
DROP FUNCTION IF EXISTS consultar_aerolinea(INTEGER);
DROP FUNCTION IF EXISTS actualizar_aerolinea(INTEGER, VARCHAR, TEXT, NUMERIC, VARCHAR, DATE, INTEGER);
DROP FUNCTION IF EXISTS eliminar_aerolinea(INTEGER);

-- Funciones de Roles
DROP FUNCTION IF EXISTS crear_rol(VARCHAR);
DROP FUNCTION IF EXISTS consultar_roles();
DROP FUNCTION IF EXISTS actualizar_rol(INTEGER, VARCHAR);
DROP FUNCTION IF EXISTS eliminar_rol(INTEGER);

-- Funciones de Tasas de Cambio
DROP FUNCTION IF EXISTS obtener_tasas_cambio();

-- Funciones de Promociones
DROP FUNCTION IF EXISTS registrar_promocion(VARCHAR, DATE, DATE, NUMERIC);
DROP FUNCTION IF EXISTS consultar_promocion(INTEGER);

-- Funciones de Proveedores
DROP FUNCTION IF EXISTS consultar_compania_crucero(INTEGER);
DROP FUNCTION IF EXISTS consultar_transporte_terrestre(INTEGER);
DROP FUNCTION IF EXISTS consultar_operador_turistico(INTEGER);

-- Funciones de Reclamos
DROP FUNCTION IF EXISTS consultar_reclamos(INTEGER);

-- Funciones de Vuelos
DROP FUNCTION IF EXISTS mostrar_vuelo_json(INTEGER);

-- Funciones de Cruceros
DROP FUNCTION IF EXISTS mostrar_crucero_json(INTEGER);

-- Funciones de Transporte Terrestre
DROP FUNCTION IF EXISTS mostrar_transporte_json(INTEGER);
DROP FUNCTION IF EXISTS mostrar_transporte(INTEGER);

-- Funciones de Hospedaje
DROP FUNCTION IF EXISTS mostrar_hospedaje(INTEGER);

-- Funciones de Restaurantes
DROP FUNCTION IF EXISTS mostrar_restaurante(INTEGER);

-- Funciones de Servicios Adicionales
DROP FUNCTION IF EXISTS mostrar_servicio_adicional(INTEGER);

-- Funciones de Lugares
DROP FUNCTION IF EXISTS filtrar_pais_json();
DROP FUNCTION IF EXISTS obtener_direcciones_filtro();

-- Funciones de Pasajeros
DROP FUNCTION IF EXISTS insertar_pasajero(VARCHAR, VARCHAR, DATE, VARCHAR, VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS registrar_pasajeros(INTEGER, INTEGER, JSONB);
DROP FUNCTION IF EXISTS obtener_pasajeros_reserva(INTEGER);

-- Funciones de Documentos
DROP FUNCTION IF EXISTS obtener_documento(VARCHAR, VARCHAR, DATE, DATE);

-- Funciones de Métodos de Pago
DROP FUNCTION IF EXISTS obtener_metodo_pago(INTEGER);
DROP FUNCTION IF EXISTS registrar_metodo_pago_tarjeta(VARCHAR, NUMERIC, NUMERIC, VARCHAR, VARCHAR, DATE, VARCHAR);
DROP FUNCTION IF EXISTS registrar_metodo_pago(VARCHAR, INTEGER, JSONB);

-- Funciones de Paquetes Turísticos
DROP FUNCTION IF EXISTS insertar_paquete_turistico(VARCHAR, TEXT, NUMERIC, NUMERIC, NUMERIC, VARCHAR);
DROP FUNCTION IF EXISTS consultar_paquete_turistico(INTEGER);
DROP FUNCTION IF EXISTS actualizar_paquete_turistico(INTEGER, VARCHAR, TEXT, NUMERIC, NUMERIC, NUMERIC, VARCHAR);
DROP FUNCTION IF EXISTS eliminar_paquete_turistico(INTEGER);

-- =====================================================
-- FUNCIONES PRINCIPALES DE ITINERARIO Y RESERVA
-- =====================================================

-- Función para crear itinerario con reserva
DROP FUNCTION IF EXISTS crear_itinerario_con_reserva(
    INTEGER, VARCHAR, INTEGER[], INTEGER[], INTEGER[], INTEGER[], 
    INTEGER[], INTEGER[], INTEGER[], DATE[], DATE[]
);

-- Función para procesar pago de reserva
DROP FUNCTION IF EXISTS procesar_pago_reserva(
    INTEGER, INTEGER, INTEGER, NUMERIC, BOOLEAN, INTEGER, 
    INTEGER, BOOLEAN, INTEGER, NUMERIC
);

-- Función para obtener detalle de reserva
DROP FUNCTION IF EXISTS obtener_detalle_reserva(INTEGER);

-- Función para cancelar reserva con reembolso
DROP FUNCTION IF EXISTS cancelar_reserva_con_reembolso(
    INTEGER, NUMERIC, INTEGER, INTEGER
);


DROP FUNCTION IF EXISTS obtener_itinerarios_cliente(INTEGER);





