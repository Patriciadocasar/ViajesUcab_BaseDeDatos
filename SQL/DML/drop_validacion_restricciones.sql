-- ========================================================
-- DROP de funciones de validación de restricciones
-- ========================================================
-- Ejecutar este script ANTES de correr funcionesSegundaEntrega.sql
-- si tienes problemas con funciones duplicadas
-- ========================================================

-- Eliminar la función NUEVA (con JSON)
DROP FUNCTION IF EXISTS validar_restricciones_paquete_json(INTEGER, JSON);

-- Eliminar la función ANTIGUA (con reserva_id)
DROP FUNCTION IF EXISTS validar_restricciones_paquete(INTEGER, INTEGER);

-- Mensaje de confirmación
DO $$
BEGIN
    RAISE NOTICE 'Funciones de validación de restricciones eliminadas correctamente';
END $$;


