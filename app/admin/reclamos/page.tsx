"use client"

import type React from "react"

import { useState } from "react"
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
import { useClaims, type Claim } from "@/lib/claims-context"
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
  "en-proceso": {
    label: "En Proceso",
    icon: AlertCircle,
    variant: "default" as const,
    description: "Estamos trabajando en resolver tu reclamo",
  },
  resuelto: {
    label: "Resuelto",
    icon: CheckCircle,
    variant: "outline" as const,
    description: "Tu reclamo ha sido resuelto satisfactoriamente",
  },
  rechazado: {
    label: "Rechazado",
    icon: XCircle,
    variant: "destructive" as const,
    description: "Tu reclamo no pudo ser procesado",
  },
  cancelado: {
    label: "Cancelado",
    icon: XCircle,
    variant: "destructive" as const,
    description: "Tu reclamo ha sido cancelado",
  },
}

const categorias = ["Vuelo", "Hotel", "Crucero", "Tour", "Traslado", "Tren", "Paquete", "Reembolso", "Otro"]

export default function ReclamosPage() {
  const { claims } = useClaims()
  const { user, isAuthenticated, hasRole } = useUser()
  const { toast } = useToast()
  const router = useRouter()
  const [reclamoSeleccionado, setReclamoSeleccionado] = useState<Claim | null>(null)
  const [dialogOpen, setDialogOpen] = useState(false)

  // Obtener todos los reclamos del sistema (solo para admin)
  const allClaims = hasRole(1) ? claims : []

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

        {allClaims.length === 0 ? (
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
                    const estadoConfig = estadosConfig[reclamo.estado]
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

      <ReclamoDialog open={dialogOpen} onOpenChange={setDialogOpen} reclamo={reclamoSeleccionado} />
    </div>
  )
}
