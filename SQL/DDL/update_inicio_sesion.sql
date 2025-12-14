-- =====================================================
-- ACTUALIZACIÓN DE FUNCIÓN inicio_sesion
-- Fecha: Diciembre 2024
-- Cambio: Agregar cliente_ID en la respuesta
-- =====================================================

-- Eliminar la función anterior
DROP FUNCTION IF EXISTS inicio_sesion(VARCHAR, VARCHAR);

-- Crear la función actualizada
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

-- Verificar que la función se creó correctamente
SELECT 'Función inicio_sesion actualizada correctamente' as mensaje;

-- Probar la función (opcional)
-- SELECT inicio_sesion('tu_email@ejemplo.com', 'tu_contraseña');

