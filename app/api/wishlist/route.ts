import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// POST - Agregar a wishlist
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { cliente_id, itinerario_id, descripcion } = body;

    console.log("=== POST /api/wishlist ===");
    console.log("Datos recibidos:", { cliente_id, itinerario_id, descripcion });

    // Validar datos requeridos
    if (!cliente_id || !itinerario_id) {
      return NextResponse.json(
        {
          status: "error",
          message: "cliente_id e itinerario_id son requeridos",
        },
        { status: 400 }
      );
    }

    // Llamar a la función de PostgreSQL
    const query = `
      SELECT sp_agregar_wishlist_json($1::INTEGER, $2::INTEGER, $3::TEXT) as resultado
    `;

    console.log("🔍 Agregando a wishlist...");
    const result = await pool.query(query, [
      cliente_id,
      itinerario_id,
      descripcion || "Sin descripción",
    ]);

    const response = result.rows[0].resultado;
    console.log("✅ Resultado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 201 });
  } catch (error: any) {
    console.error("❌ Error al agregar a wishlist:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}

// GET - Obtener wishlist de un cliente
export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const clienteId = searchParams.get("cliente_id");

    console.log(`=== GET /api/wishlist?cliente_id=${clienteId} ===`);

    if (!clienteId) {
      return NextResponse.json(
        {
          status: "error",
          message: "cliente_id es requerido",
        },
        { status: 400 }
      );
    }

    // Llamar a la función SQL
    const query = `
      SELECT sp_obtener_wishlist_cliente($1::INTEGER) as resultado
    `;

    console.log("🔍 Obteniendo wishlist del cliente...");
    const result = await pool.query(query, [parseInt(clienteId)]);
    const response = result.rows[0].resultado;

    console.log("✅ Resultado wishlist:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 404 });
    }

    // Retornar solo el array de wishlist para mantener compatibilidad con el frontend
    return NextResponse.json(
      {
        status: "success",
        data: response.data.wishlist,
      },
      { status: 200 }
    );
  } catch (error: any) {
    console.error("❌ Error al obtener wishlist:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}

// DELETE - Eliminar de wishlist
export async function DELETE(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const wishlistId = searchParams.get("wishlist_id");

    console.log(`=== DELETE /api/wishlist?wishlist_id=${wishlistId} ===`);

    if (!wishlistId) {
      return NextResponse.json(
        {
          status: "error",
          message: "wishlist_id es requerido",
        },
        { status: 400 }
      );
    }

    // Eliminar de la wishlist
    const query = `
      DELETE FROM Wishlist
      WHERE Wis_COD = $1
      RETURNING Wis_COD
    `;

    console.log("🔍 Eliminando de wishlist...");
    const result = await pool.query(query, [parseInt(wishlistId)]);

    if (result.rowCount === 0) {
      return NextResponse.json(
        {
          status: "error",
          message: "Item no encontrado en la wishlist",
        },
        { status: 404 }
      );
    }

    console.log(`✅ Item eliminado de la wishlist`);

    return NextResponse.json(
      {
        status: "success",
        message: "Item eliminado de la wishlist",
      },
      { status: 200 }
    );
  } catch (error: any) {
    console.error("❌ Error al eliminar de wishlist:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}
