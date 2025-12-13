import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// ✅ LISTAR TODOS LOS USUARIOS
export async function GET() {
  try {
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
        u.Proveedor_Pro_COD as proveedor_id,
        CASE 
          WHEN u.Proveedor_Pro_COD IS NOT NULL THEN 
            (SELECT p.Pro_Nombre FROM Proveedor p WHERE p.Pro_COD = u.Proveedor_Pro_COD)
          ELSE NULL
        END as proveedor_nombre
      FROM Usuario u
      LEFT JOIN Rol r ON u.Rol_Rol_COD = r.Rol_COD
      ORDER BY u.Usu_COD DESC
    `;

    const result = await pool.query(query);

    return NextResponse.json(
      { status: "success", data: result.rows },
      { status: 200 }
    );

  } catch (error: any) {
    console.error("❌ Error en GET /api/usuarios:", error);
    return NextResponse.json(
      { status: "error", message: error.message || "Error al obtener usuarios" },
      { status: 500 }
    );
  }
}

// ✅ ACTUALIZAR ROL O ESTADO DE USUARIO
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
    console.error("❌ Error en PUT /api/usuarios:", error);
    return NextResponse.json(
      { status: "error", message: error.message || "Error al actualizar usuario" },
      { status: 500 }
    );
  }
}

// ✅ ELIMINAR USUARIO (opcional, por si se necesita)
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
    console.error("❌ Error en DELETE /api/usuarios:", error);
    return NextResponse.json(
      { status: "error", message: error.message || "Error al eliminar usuario" },
      { status: 500 }
    );
  }
}

