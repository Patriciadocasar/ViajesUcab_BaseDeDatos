import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

export async function GET() {
  try {
    console.log("=== GET /api/traslado ===");

    const query = `
      SELECT 
        TT.TT_COD,
        TT.Vehiculo_Veh_COD,
        TT.TT_Huella_Carbono,
        TT.TT_Fecha_Hora_Salida,
        TT.TT_Fecha_Hora_Llegada,
        TT.TT_Cant_Millas,
        TT.TT_Costo,
        
        -- ORIGEN
        (
            SELECT L.Lug_Nombre
            FROM Ruta R, Terminal T, Lugar L
            WHERE R.Transporte_Terrestre_TT_COD = TT.TT_COD
            AND T.Ter_COD = R.Terminal_Ter_COD
            AND L.Lug_COD = T.Lugar_Lug_COD
            LIMIT 1
        ) AS origen,

        -- DESTINO
        (
            SELECT L.Lug_Nombre
            FROM Ruta R, Terminal T, Lugar L
            WHERE R.Transporte_Terrestre_TT_COD = TT.TT_COD
            AND T.Ter_COD = R.Terminal_Ter_COD
            AND L.Lug_COD = T.Lugar_Lug_COD2
            LIMIT 1
        ) AS destino

      FROM Transporte_Terrestre TT
      ORDER BY TT.TT_COD ASC
      LIMIT 10
    `;

    const result = await pool.query(query);

    console.log("✅ Columnas de traslados:", result.fields.map(f => f.name));
    if (result.rows.length > 0) {
      console.log("✅ Primer traslado:", result.rows[0]);
    } else {
      console.log("⚠️ No hay traslados en la base de datos");
    }

    return NextResponse.json({
      status: "success",
      data: result.rows,
    }, { status: 200 });

  } catch (error: any) {
    console.error("❌ Error en GET /api/traslado:", error);
    console.error("Código:", error.code);
    console.error("Mensaje:", error.message);

    return NextResponse.json(
      { 
        status: "error", 
        message: process.env.NODE_ENV === 'development' ? error.message : "Error al obtener traslados" 
      },
      { status: 500 }
    );
  }
}