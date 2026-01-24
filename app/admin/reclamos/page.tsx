"use client"

import type React from "react"

import { useState, useEffect } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import {
  AlertCircle,
  Clock,
  CheckCircle,
  XCircle,
  FileText,
  AlertTriangle,
  ArrowLeft,
} from "lucide-react"
import { ReclamoDialog } from "@/components/reclamo-dialog"
import { useClaims, type Claim, type ClaimStatus } from "@/lib/claims-context"
import { useUser } from "@/lib/user-context"
import { useToast } from "@/hooks/use-toast"
import { useRouter } from "next/navigation"

const estadosConfig = {
  pendiente: {
    label: "Pendiente",
    icon: Clock,
    variant: "secondary" as const,
    description: "Tu reclamo ha sido recibido y está en espera de revisión",
  },
  listo: {
    label: "Listo",
    icon: CheckCircle,
    variant: "outline" as const,
    description: "Tu reclamo ha sido resuelto satisfactoriamente",
  },
}

const categorias = ["Vuelo", "Hotel", "Crucero", "Tour", "Traslado", "Tren", "Paquete", "Reembolso", "Otro"]

export default function ReclamosPage() {
  const { updateClaim } = useClaims()
  const { user, isAuthenticated, hasRole } = useUser()
  const { toast } = useToast()
  const router = useRouter()
  const [reclamoSeleccionado, setReclamoSeleccionado] = useState<Claim | null>(null)
  const [dialogOpen, setDialogOpen] = useState(false)
  const [allClaims, setAllClaims] = useState<Claim[]>([])
  const [isLoading, setIsLoading] = useState(true)

  // Función para mapear reclamos de la base de datos
  const mapearReclamo = (r: any, index: number): Claim => {
    const id = r.reclamo_id?.toString() || `temp-${index}`
    
    // Por ahora todos los reclamos están pendientes
    const estado: ClaimStatus = "pendiente"
    
    // Extraer información del itinerario
    const itinerarioId = r.itinerario_id?.toString() || ""
    
    return {
      id: id,
      numeroReclamo: `REC-${id}`,
      userId: "", // No disponible en la versión simplificada
      categoria: "Itinerario",
      razon: "Reclamo de itinerario",
      descripcion: r.descripcion || "",
      estado: estado,
      urgente: false,
      fechaCreacion: new Date().toISOString(),
      reservaRelacionada: itinerarioId,
      respuestaAdmin: undefined,
    }
  }

  // Cargar reclamos desde la base de datos
  useEffect(() => {
    const cargarReclamos = async () => {
      if (!hasRole(1)) {
        setIsLoading(false)
        return
      }

      try {
        setIsLoading(true)
        const res = await fetch("/api/reclamos")
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        if (data.status === "success" && Array.isArray(data.data)) {
          console.log("Datos recibidos de la API:", data.data.length, "reclamos")
          const reclamosFormateados = data.data.map((r: any, index: number) => {
            try {
              return mapearReclamo(r, index)
            } catch (error: any) {
              console.error(`Error mapeando reclamo ${index}:`, error, r)
              return null
            }
          }).filter((r: any) => r !== null) as Claim[]
          
          console.log("Reclamos formateados:", reclamosFormateados.length)
          setAllClaims(reclamosFormateados)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
          toast({
            title: "Error",
            description: data.message || "Estructura de respuesta inesperada",
            variant: "destructive",
          })
        }
      } catch (error: any) {
        console.error("Error cargando reclamos:", error)
        toast({
          title: "Error",
          description: error.message || "Error al cargar reclamos",
          variant: "destructive",
        })
      } finally {
        setIsLoading(false)
      }
    }

    cargarReclamos()
  }, [hasRole, toast])

  // Recargar reclamos cuando se cierre el diálogo (por si se actualizó algo)
  const handleDialogChange = (open: boolean) => {
    setDialogOpen(open)
    if (!open) {
      // Recargar reclamos cuando se cierra el diálogo
      setTimeout(() => {
        const recargar = async () => {
          try {
            const res = await fetch("/api/reclamos")
            if (res.ok) {
              const data = await res.json()
              if (data.status === "success" && Array.isArray(data.data)) {
                const reclamosFormateados = data.data.map((r: any, index: number) => mapearReclamo(r, index))
                setAllClaims(reclamosFormateados)
              }
            }
          } catch (error) {
            console.error("Error recargando reclamos:", error)
          }
        }
        recargar()
      }, 500) // Pequeño delay para asegurar que la actualización en BD se complete
    }
  }

  const handleVerDetalle = (reclamo: Claim) => {
    setReclamoSeleccionado(reclamo)
    setDialogOpen(true)
  }

  return (
    <div className="space-y-8">
      <Button variant="ghost" onClick={() => router.push("/admin")} className="gap-2">
        <ArrowLeft className="h-4 w-4" />
        Volver al Dashboard
      </Button>

      <div>
        <h1 className="text-3xl font-bold text-foreground">Gestión de Reclamos</h1>
        <p className="text-muted-foreground">Administra y da seguimiento a los reclamos del sistema</p>
      </div>

      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-2xl font-bold text-foreground">Todos los Reclamos</h2>
          <Badge variant="secondary" className="text-base px-3 py-1">
            {allClaims.length} {allClaims.length === 1 ? "reclamo" : "reclamos"}
          </Badge>
        </div>

        {isLoading ? (
          <Card>
            <CardContent className="flex items-center justify-center py-12">
              <p className="text-muted-foreground">Cargando reclamos...</p>
            </CardContent>
          </Card>
        ) : allClaims.length === 0 ? (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <FileText className="h-12 w-12 text-muted-foreground mb-4" />
              <h3 className="text-lg font-medium text-foreground mb-2">No hay reclamos registrados</h3>
              <p className="text-muted-foreground text-center">
                Los reclamos de los clientes aparecerán aquí para que puedas gestionarlos
              </p>
            </CardContent>
          </Card>
        ) : (
          <div className="grid gap-4 md:grid-cols-2">
            {allClaims.map((reclamo) => {
                    const estadoConfig = estadosConfig[reclamo.estado] || estadosConfig.pendiente
                    const IconoEstado = estadoConfig.icon

                    return (
                      <Card
                        key={reclamo.id}
                        className="hover:shadow-lg transition-shadow cursor-pointer"
                        onClick={() => handleVerDetalle(reclamo)}
                      >
                        <CardHeader>
                          <div className="flex items-start justify-between">
                            <div>
                              <CardTitle className="text-lg flex items-center gap-2">
                                {reclamo.numeroReclamo}
                                {reclamo.urgente && (
                                  <Badge variant="destructive" className="gap-1">
                                    <AlertTriangle className="h-3 w-3" />
                                    Urgente
                                  </Badge>
                                )}
                              </CardTitle>
                              <CardDescription>
                                {new Date(reclamo.fechaCreacion).toLocaleDateString("es-ES")}
                              </CardDescription>
                            </div>
                            <Badge variant={estadoConfig.variant} className="gap-1">
                              <IconoEstado className="h-3 w-3" />
                              {estadoConfig.label}
                            </Badge>
                          </div>
                        </CardHeader>
                        <CardContent className="space-y-3">
                          <div>
                            <Badge variant="outline" className="mb-2">
                              {reclamo.categoria}
                            </Badge>
                            <p className="font-medium text-sm text-foreground">{reclamo.razon}</p>
                            <p className="text-sm text-muted-foreground line-clamp-2 mt-1">{reclamo.descripcion}</p>
                          </div>
                          {reclamo.reservaRelacionada && (
                            <div className="flex items-center gap-2 text-xs text-muted-foreground">
                              <FileText className="h-3 w-3" />
                              <span>Reserva: {reclamo.reservaRelacionada}</span>
                            </div>
                          )}
                          <div className="pt-2 border-t">
                            <p className="text-xs text-muted-foreground">{estadoConfig.description}</p>
                          </div>
                        </CardContent>
                      </Card>
                    )
                  })}
                </div>
              )}
            </div>

      <ReclamoDialog open={dialogOpen} onOpenChange={handleDialogChange} reclamo={reclamoSeleccionado} />
    </div>
  )
}
