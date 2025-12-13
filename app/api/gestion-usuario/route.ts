import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// ✅ LISTAR TODOS LOS USUARIOS
export async function GET() {
  try {
    console.log("=== GET /api/gestion-usuario - Listar usuarios ===");

    // Primero consulta simple sin JOINs para verificar que funcione
    let query = `
      SELECT 
        Usu_COD as id,
        Usu_Correo as correo,
        Usu_Primer_Nombre as primer_nombre,
        Usu_Segundo_Nombre as segundo_nombre,
        Usu_Primer_Apellido as primer_apellido,
        Usu_Segundo_Apellido as segundo_apellido,
        Rol_Rol_COD as rol_id,
        Cliente_Cli_COD as cliente_id,
        Compania_Crucero as compania_crucero_id,
        Operador_Turistico as operador_turistico_id,
        Aerolinea as aerolinea_id,
        Transporte_Terrestre as transporte_terrestre_id,
        Hotel as hotel_id,
        Empleado_Emp_COD as empleado_id
      FROM Usuario
      ORDER BY Usu_COD DESC
    `;

    let result = await pool.query(query);
    console.log("✅ Usuarios base encontrados:", result.rows.length);
    
    // Ahora agregar el rol
    query = `
      SELECT 
        u.Usu_COD as id,
        u.Usu_Correo as correo,
        u.Usu_Primer_Nombre as primer_nombre,
        u.Usu_Segundo_Nombre as segundo_nombre,
        u.Usu_Primer_Apellido as primer_apellido,
        u.Usu_Segundo_Apellido as segundo_apellido,
        u.Rol_Rol_COD as rol_id,
        COALESCE(r.Rol_Tipo, 'Sin Rol') as rol_tipo,
        u.Cliente_Cli_COD as cliente_id,
        u.Compania_Crucero as compania_crucero_id,
        u.Operador_Turistico as operador_turistico_id,
        u.Aerolinea as aerolinea_id,
        u.Transporte_Terrestre as transporte_terrestre_id,
        u.Hotel as hotel_id,
        u.Empleado_Emp_COD as empleado_id
      FROM Usuario u
      LEFT JOIN Rol r ON u.Rol_Rol_COD = r.Rol_COD
      ORDER BY u.Usu_COD DESC
    `;

    result = await pool.query(query);
    console.log("✅ Usuarios con roles encontrados:", result.rows.length);
    if (result.rows.length > 0) {
      console.log("👤 Primer usuario:", JSON.stringify(result.rows[0], null, 2));
    }

    return NextResponse.json(
      { status: "success", data: result.rows },
      { status: 200 }
    );

  } catch (error: any) {
    console.error("❌ Error en GET /api/gestion-usuario:", error);
    return NextResponse.json(
      { status: "error", message: error.message || "Error al obtener usuarios" },
      { status: 500 }
    );
  }
}

// ✅ OBTENER UN USUARIO POR ID (usa tu función JSON)
export async function POST(req: Request) {
  try {
    const { id } = await req.json();

    if (!id) {
      return NextResponse.json(
        { status: "error", message: "Debe proporcionar un ID de usuario" },
        { status: 400 }
      );
    }

    // Intentar usar la función si existe
    try {
      const query = `SELECT mostrar_usuario($1) AS data;`;
      const result = await pool.query(query, [id]);
      const data = result.rows[0]?.data;

      if (!data) {
        return NextResponse.json(
          { status: "error", message: "Usuario no encontrado" },
          { status: 404 }
        );
      }

      return NextResponse.json(
        { status: "success", data },
        { status: 200 }
      );
    } catch (funcError: any) {
      // Si la función no existe, usar consulta directa
      console.log("⚠️ Función mostrar_usuario no existe, usando consulta directa");
      
      const query = `
        SELECT 
          u.Usu_COD as id,
          u.Usu_Correo as correo,
          u.Usu_Primer_Nombre as primer_nombre,
          u.Usu_Segundo_Nombre as segundo_nombre,
          u.Usu_Primer_Apellido as primer_apellido,
          u.Usu_Segundo_Apellido as segundo_apellido,
          u.Rol_Rol_COD as rol_id,
          r.Rol_Tipo as rol_tipo,
          u.Cliente_Cli_COD as cliente_id,
          u.Compania_Crucero as compania_crucero_id,
          u.Operador_Turistico as operador_turistico_id,
          u.Aerolinea as aerolinea_id,
          u.Transporte_Terrestre as transporte_terrestre_id,
          u.Hotel as hotel_id
        FROM Usuario u
        LEFT JOIN Rol r ON u.Rol_Rol_COD = r.Rol_COD
        WHERE u.Usu_COD = $1
      `;
      
      const result = await pool.query(query, [id]);
      
      if (result.rows.length === 0) {
        return NextResponse.json(
          { status: "error", message: "Usuario no encontrado" },
          { status: 404 }
        );
      }

      return NextResponse.json(
        { status: "success", data: result.rows[0] },
        { status: 200 }
      );
    }

  } catch (error: any) {
    console.error("❌ Error en POST /api/gestion-usuario:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}

// ✅ ACTUALIZAR ROL DE USUARIO
export async function PUT(req: Request) {
  try {
    const { id, rol_id } = await req.json();

    if (!id || !rol_id) {
      return NextResponse.json(
        { status: "error", message: "ID de usuario y rol son requeridos" },
        { status: 400 }
      );
    }

    const query = `
      UPDATE Usuario
      SET Rol_Rol_COD = $1
      WHERE Usu_COD = $2
      RETURNING Usu_COD
    `;

    const result = await pool.query(query, [rol_id, id]);

    if (result.rows.length === 0) {
      return NextResponse.json(
        { status: "error", message: "Usuario no encontrado" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      { status: "success", message: "Usuario actualizado correctamente" },
      { status: 200 }
    );

  } catch (error: any) {
    console.error("❌ Error en PUT /api/gestion-usuario:", error);
    return NextResponse.json(
      { status: "error", message: error.message || "Error al actualizar usuario" },
      { status: 500 }
    );
  }
}

// ✅ ELIMINAR USUARIO
export async function DELETE(req: Request) {
  try {
    const { id } = await req.json();

    if (!id) {
      return NextResponse.json(
        { status: "error", message: "ID de usuario es requerido" },
        { status: 400 }
      );
    }

    const query = `DELETE FROM Usuario WHERE Usu_COD = $1 RETURNING Usu_COD`;
    const result = await pool.query(query, [id]);

    if (result.rows.length === 0) {
      return NextResponse.json(
        { status: "error", message: "Usuario no encontrado" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      { status: "success", message: "Usuario eliminado correctamente" },
      { status: 200 }
    );

  } catch (error: any) {
    console.error("❌ Error en DELETE /api/gestion-usuario:", error);
    return NextResponse.json(
      { status: "error", message: error.message || "Error al eliminar usuario" },
      { status: 500 }
    );
  }
}

