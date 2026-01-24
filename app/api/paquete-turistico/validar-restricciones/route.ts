import { NextResponse } from "next/server"
import { pool } from "@/lib/db"

export async function POST(req: Request) {
  try {
    const { paquete_id, pasajeros } = await req.json()

    console.log("=== POST /api/paquete-turistico/validar-restricciones ===")
    console.log("Paquete ID:", paquete_id)
    console.log("Pasajeros:", pasajeros)

    // Validar que vengan los datos necesarios
    if (!paquete_id) {
      return NextResponse.json(
        {
          status: "error",
          message: "El ID del paquete es requerido",
        },
        { status: 400 }
      )
    }

    if (!pasajeros || !Array.isArray(pasajeros) || pasajeros.length === 0) {
      return NextResponse.json(
        {
          status: "error",
          message: "Debe proporcionar al menos un pasajero",
        },
        { status: 400 }
      )
    }

    // Llamar a la función SQL
    const query = `
      SELECT validar_restricciones_paquete_json($1::INTEGER, $2::JSON) as resultado
    `

    const result = await pool.query(query, [paquete_id, JSON.stringify(pasajeros)])

    const respuesta = result.rows[0].resultado

    console.log("✅ Resultado de validación:", respuesta)

    // Si la validación falla, devolver error 400
    if (respuesta.status === "error" || respuesta.cumple === false) {
      return NextResponse.json(respuesta, { status: 400 })
    }

    return NextResponse.json(respuesta, { status: 200 })
  } catch (error: any) {
    console.error("❌ Error al validar restricciones:", error)
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    )
  }
}


