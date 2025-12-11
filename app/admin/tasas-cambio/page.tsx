"use client"

import { useState, useEffect } from "react"
import { useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { TrendingUp, TrendingDown, ArrowLeft } from "lucide-react"
import { useToast } from "@/components/ui/use-toast"
import MonedaDialog from "@/components/MonedaDialog"
import { useUser } from "@/lib/user-context"


export default function TasasCambioPage() {
  const router = useRouter()
  const { isAuthenticated } = useUser()
  const [monedas, setMonedas] = useState<any[]>([])
  const { toast } = useToast()

  const [dialogOpen, setDialogOpen] = useState(false)
  //const [historialOpen, setHistorialOpen] = useState(false)
  //const [monedaSeleccionada, setMonedaSeleccionada] = useState<Moneda | null>(null)

  // 🔹 Cargar tasas desde el backend
  useEffect(() => {
    const fetchTasas = async () => {
      try {
        const res = await fetch("/api/tasas-cambio")
        const data = await res.json()
  
        if (data.status === "success") {
          // Guardamos los datos crudos, sin mapear
          setMonedas(data.data)
          console.log("Tasas cargadas crudas:", data.data)
        }
      } catch (error) {
        console.error("Error al cargar tasas:", error)
      }
    }
    fetchTasas()
  }, [])
  // 🔹 Crear nueva tasa
  /*const handleAgregarMoneda = async (moneda: any) => {
    try {
      const res = await fetch("/api/tasas-cambio", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(moneda),
      })
      const data = await res.json()
      if (data.status === "success" || data.tc_cod) {
        setMonedas((prev) => [...prev, data])
        toast({
          title: "Moneda agregada",
          description: `La moneda ${moneda.TC_Tipo_Moneda} fue registrada correctamente.`
        })
      } else {
        toast({
          title: "Error al agregar",
          description: data.message || "No se pudo registrar la moneda.",
          variant: "destructive",
        })
      }
    } catch (error) {
      console.error("Error al crear tasa:", error)
      toast({
        title: "Error de servidor",
        description: "Ocurrió un problema al registrar la moneda.",
        variant: "destructive",
      })
    }
    setDialogOpen(false)
  }
  // Eliminar tasa
  const handleEliminarMoneda = async (id: number) => {
    try {
      const res = await fetch("/api/tasas-cambio", {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ tc_cod: id }),
      })
      const data = await res.json()
      if (data.status === "success") {
        setMonedas((prev) => prev.filter((m) => m.tc_cod !== id))
        toast({
          title: "Moneda eliminada",
          description: `La tasa con código ${id} fue eliminada correctamente.`,
        })
      } else {
        toast({
          title: "Error al eliminar",
          description: data.message || "No se pudo eliminar la moneda.",
          variant: "destructive",
        })
      }
    } catch (error) {
      console.error("Error al eliminar tasa:", error)
      toast({
        title: "Error de servidor",
        description: "Ocurrió un problema al eliminar la moneda.",
        variant: "destructive",
      })
    }
  }

// Editar tasa
const handleEditarMoneda = async (moneda: any) => {
  try {
    const res = await fetch("/api/tasas-cambio", {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(moneda),
    })
    const data = await res.json()
    if (data.status === "success") {
      setMonedas((prev) =>
        prev.map((m) => (m.tc_cod === moneda.tc_cod ? data.data : m))
      )
      toast({
        title: "Moneda actualizada",
        description: `La moneda ${moneda.TC_Tipo_Moneda} fue editada correctamente.`,
      })
    } else {
      toast({
        title: "Error al editar",
        description: data.message || "No se pudo actualizar la moneda.",
        variant: "destructive",
      })
    }
  } catch (error) {
    console.error("Error al editar tasa:", error)
    toast({
      title: "Error de servidor",
      description: "Ocurrió un problema al editar la moneda.",
      variant: "destructive",
    })
  }
}*/

  /*const handleVerHistorial = (moneda: Moneda) => {
    setMonedaSeleccionada(moneda)
    setHistorialOpen(true)
  }*/

  const bolivar = {
    codigo: "VES",
    nombre: "Bolívar Venezolano",
    descripcion: "Moneda base del sistema",
  }

  return (
    <div className="space-y-6">
      <Button variant="ghost" onClick={() => router.push("/admin")} className="gap-2 mb-4">
        <ArrowLeft className="h-4 w-4" />
        Volver al Dashboard
      </Button>

      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">Tasas de Cambio</h1>
          <p className="text-muted-foreground">
            Gestiona las tasas de cambio del sistema
          </p>
        </div>
        <Button onClick={() => setDialogOpen(true)} className="gap-2">
          Agregar Moneda
        </Button>
      </div>

      <div className="space-y-6">
        <Card className="bg-gradient-to-br from-primary/10 to-primary/5 border-primary/20">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <span className="text-2xl">🇻🇪</span>
              {bolivar.nombre} ({bolivar.codigo})
            </CardTitle>
            <CardDescription>{bolivar.descripcion}</CardDescription>
          </CardHeader>
          <CardContent>
            <p className="text-sm text-muted-foreground">
              Todas las tasas están expresadas en Bolívares. Última actualización:{" "}
              {new Date().toLocaleString("es-ES")}
            </p>
          </CardContent>
        </Card>

        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {monedas.map((moneda) => {
            return (
              <Card key={moneda.tc_cod} className="hover:shadow-lg transition-shadow">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div>
                      <CardTitle className="text-xl">{moneda.tc_tipo_moneda} / VES</CardTitle>
                      <CardDescription>
                        Valor: Bs. {typeof moneda.tc_valor === "number" ? moneda.tc_valor.toFixed(2) : "—"}
                      </CardDescription>
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="text-xs text-muted-foreground">
                    Actualizado: {moneda.tc_fecha_actualizacion
                      ? new Date(moneda.tc_fecha_actualizacion).toLocaleDateString("es-ES")
                      : "Sin fecha"}
                  </div>
                  {/*<div className="flex gap-2">
                    <Button size="sm" onClick={() => handleEditarMoneda(moneda)}>Editar</Button>
                    <Button size="sm" variant="destructive" onClick={() => handleEliminarMoneda(moneda.tc_cod)}>Eliminar</Button>
                  </div>*/}
                </CardContent>
              </Card>
            )
          })}
        </div>

        {monedas.length === 0 && (
          <div className="text-center py-12">
            <p className="text-muted-foreground">No hay tasas de cambio disponibles en este momento.</p>
          </div>
        )}
      </div>

      {/*<MonedaDialog
  open={dialogOpen}
  onOpenChange={setDialogOpen}
  onGuardar={handleAgregarMoneda}   // 👈 asegúrate de que esté aquí
/>*/}

      {/*<MonedaDialog open={dialogOpen} onOpenChange={setDialogOpen} onGuardar={handleAgregarMoneda} />
      {/*<HistorialDialog
        open={historialOpen}
        onOpenChange={setHistorialOpen}
        moneda={monedaSeleccionada}
        historial={[]} // aquí luego puedes cargar historial real desde backend
      />*/}
    </div>
  )
}