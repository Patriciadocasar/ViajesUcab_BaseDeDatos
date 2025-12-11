"use client"

import { useState, useEffect } from "react"
import { useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Search, Tag, ArrowLeft, Plus } from "lucide-react"
import { InventarioDialog } from "@/components/inventario-dialog"
import { useToast } from "@/hooks/use-toast"

type Promocion = {
  id: string
  tipo: string
  fechaInicio: string
  fechaFin: string
  porcentajeDescuento: number | null
}

export default function PromocionesPage() {
  const router = useRouter()
  const { toast } = useToast()
  const [promociones, setPromociones] = useState<Promocion[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [busqueda, setBusqueda] = useState("")
  const [dialogOpen, setDialogOpen] = useState(false)

  // Cargar promociones de la base de datos
  useEffect(() => {
    const cargarPromociones = async () => {
      try {
        setIsLoading(true)
        const res = await fetch("/api/promocion")
        const data = await res.json()
        
        if (!res.ok) {
          console.error("Error en respuesta de API:", res.status, res.statusText)
          toast({
            title: "Error",
            description: `Error al cargar promociones: ${res.status} ${res.statusText}`,
            variant: "destructive",
          })
          setIsLoading(false)
          return
        }

        if (data.status === "success" && Array.isArray(data.data)) {
          // Normalizar los datos de la base de datos al formato esperado
          const promocionesFormateadas = data.data.map((p: any, index: number) => {
            // Buscar el ID en todas las posibles variaciones
            const idRaw = p.Prom_COD || p.prom_cod || p.prom_COD || p.Prom_cod || p.PromCod || p.promCod || p.cod || p.COD || p.id || Object.values(p).find((val: any) => typeof val === 'number' && val > 0)
            const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
            
            return {
              id: id,
              tipo: p.Prom_Tipo || p.prom_tipo || p.tipo || p.Tipo || "",
              fechaInicio: p.Prom_Fecha_Inicio || p.prom_fecha_inicio || p.fechaInicio || p.fecha_inicio || p.Fecha_Inicio || "",
              fechaFin: p.Prom_Fecha_Fin || p.prom_fecha_fin || p.fechaFin || p.fecha_fin || p.Fecha_Fin || "",
              porcentajeDescuento: p.Prom_Porcentaje != null ? Number(p.Prom_Porcentaje) : (p.prom_porcentaje != null ? Number(p.prom_porcentaje) : (p.porcentajeDescuento != null ? Number(p.porcentajeDescuento) : null)),
            }
          })
          
          setPromociones(promocionesFormateadas)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
          toast({
            title: "Error",
            description: data.message || "Estructura de respuesta inesperada",
            variant: "destructive",
          })
        }
      } catch (error: any) {
        console.error("Error cargando promociones:", error)
        toast({
          title: "Error",
          description: error.message || "Error de conexión con el servidor",
          variant: "destructive",
        })
      } finally {
        setIsLoading(false)
      }
    }

    cargarPromociones()
  }, [])

  const promocionesFiltradas = promociones.filter(
    (promo) =>
      promo.tipo.toLowerCase().includes(busqueda.toLowerCase())
  )

  const handleAgregar = () => {
    setDialogOpen(true)
  }

  const handleGuardar = async (item: any) => {
    const promocion = item as Promocion
    try {
      const res = await fetch("/api/promocion", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          tipo: promocion.tipo,
          fechaInicio: promocion.fechaInicio,
          fechaFin: promocion.fechaFin,
          porcentaje: promocion.porcentajeDescuento,
        }),
      })

      const data = await res.json()

      if (data.status === "success") {
        // Recargar promociones
        const resReload = await fetch("/api/promocion")
        const dataReload = await resReload.json()
        
        if (dataReload.status === "success" && Array.isArray(dataReload.data)) {
          const promocionesFormateadas = dataReload.data.map((p: any, index: number) => {
            const idRaw = p.Prom_COD || p.prom_cod || p.prom_COD || p.Prom_cod || p.PromCod || p.promCod || p.cod || p.COD || p.id || Object.values(p).find((val: any) => typeof val === 'number' && val > 0)
            const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
            
            return {
              id: id,
              tipo: p.Prom_Tipo || p.prom_tipo || p.tipo || p.Tipo || "",
              fechaInicio: p.Prom_Fecha_Inicio || p.prom_fecha_inicio || p.fechaInicio || p.fecha_inicio || p.Fecha_Inicio || "",
              fechaFin: p.Prom_Fecha_Fin || p.prom_fecha_fin || p.fechaFin || p.fecha_fin || p.Fecha_Fin || "",
              porcentajeDescuento: p.Prom_Porcentaje != null ? Number(p.Prom_Porcentaje) : (p.prom_porcentaje != null ? Number(p.prom_porcentaje) : (p.porcentajeDescuento != null ? Number(p.porcentajeDescuento) : null)),
            }
          })
          setPromociones(promocionesFormateadas)
        }
        
        toast({
          title: "Promoción agregada",
          description: "La promoción se ha guardado exitosamente en la base de datos",
        })
        setDialogOpen(false)
      } else {
        toast({
          title: "Error",
          description: data.message || "No se pudo guardar la promoción",
          variant: "destructive",
        })
      }
    } catch (error: any) {
      console.error("Error guardando promoción:", error)
      toast({
        title: "Error",
        description: error.message || "Error de conexión con el servidor",
        variant: "destructive",
      })
    }
  }

  return (
    <div className="space-y-6">
      <Button variant="ghost" onClick={() => router.push("/admin")} className="gap-2 mb-4">
        <ArrowLeft className="h-4 w-4" />
        Volver al Dashboard
      </Button>

      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">Gestión de Promociones</h1>
          <p className="text-muted-foreground">Administra las promociones del sistema</p>
        </div>
        <Button onClick={handleAgregar} className="gap-2">
          <Plus className="h-4 w-4" />
          Agregar Promoción
        </Button>
      </div>

      <div className="relative">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input
          placeholder="Buscar promociones por tipo..."
          value={busqueda}
          onChange={(e) => setBusqueda(e.target.value)}
          className="pl-10"
        />
      </div>

      {isLoading ? (
        <Card>
          <CardContent className="flex items-center justify-center py-12">
            <p className="text-muted-foreground">Cargando promociones...</p>
          </CardContent>
        </Card>
      ) : promocionesFiltradas.length === 0 ? (
        <div className="text-center py-12">
          <Tag className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
          <h3 className="text-lg font-medium text-foreground mb-2">
            {busqueda ? "No se encontraron promociones" : "No hay promociones registradas"}
          </h3>
          <p className="text-muted-foreground">
            {busqueda ? "Intenta con otros términos de búsqueda" : "Agrega una nueva promoción para comenzar"}
          </p>
        </div>
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {promocionesFiltradas.map((promocion) => (
            <Card key={promocion.id} className="hover:shadow-lg transition-shadow">
              <CardHeader>
                <div className="flex items-start justify-between">
                  <div className="flex items-center gap-2">
                    <Tag className="h-5 w-5 text-primary" />
                    <CardTitle className="text-lg">{promocion.tipo}</CardTitle>
                  </div>
                  {promocion.porcentajeDescuento != null && (
                    <Badge variant="secondary" className="text-lg font-bold">
                      -{promocion.porcentajeDescuento}%
                    </Badge>
                  )}
                </div>
                <CardDescription>
                  Válido del {new Date(promocion.fechaInicio).toLocaleDateString("es-ES")} al{" "}
                  {new Date(promocion.fechaFin).toLocaleDateString("es-ES")}
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-2 text-sm">
                <div>
                  <p className="text-muted-foreground">Fecha de Inicio</p>
                  <p className="font-medium">{new Date(promocion.fechaInicio).toLocaleDateString("es-ES")}</p>
                </div>
                <div>
                  <p className="text-muted-foreground">Fecha de Fin</p>
                  <p className="font-medium">{new Date(promocion.fechaFin).toLocaleDateString("es-ES")}</p>
                </div>
                {promocion.porcentajeDescuento != null && (
                  <div>
                    <p className="text-muted-foreground">Descuento</p>
                    <p className="font-medium text-primary">{promocion.porcentajeDescuento}%</p>
                  </div>
                )}
              </CardContent>
            </Card>
          ))}
        </div>
      )}

      <InventarioDialog
        open={dialogOpen}
        onOpenChange={setDialogOpen}
        tipo="promocion"
        item={null}
        onGuardar={handleGuardar}
        modoEdicion={false}
      />
    </div>
  )
}
