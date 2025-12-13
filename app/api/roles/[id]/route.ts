// app/api/roles/[id]/route.ts
import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

// DELETE - Eliminar un rol
export async function DELETE(
  req: Request,
  { params }: { params: { id: string } }
) {
  const id = parseInt(params.id);

  if (isNaN(id)) {
    return NextResponse.json(
      { status: "error", message: "ID de rol inválido" },
      { status: 400 }
    );
  }

  try {
    // Verificar si hay usuarios con este rol
    const usuariosResult = await pool.query(
      "SELECT COUNT(*) as count FROM Usuario WHERE Rol_Rol_COD = $1",
      [id]
    );

    const usuariosCount = parseInt(usuariosResult.rows[0].count);

    if (usuariosCount > 0) {
      return NextResponse.json(
        { 
          status: "error", 
          message: `No se puede eliminar el rol porque hay ${usuariosCount} usuario(s) asignado(s) a este rol` 
        },
        { status: 400 }
      );
    }

    const result = await pool.query(
      "DELETE FROM Rol WHERE Rol_COD = $1 RETURNING Rol_COD as id, Rol_Tipo as tipo",
      [id]
    );

    if (result.rows.length === 0) {
      return NextResponse.json(
        { status: "error", message: "Rol no encontrado" },
        { status: 404 }
      );
    }

    return NextResponse.json({
      status: "success",
      message: "Rol eliminado exitosamente",
    }, { status: 200 });
  } catch (error: any) {
    console.error(error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}


