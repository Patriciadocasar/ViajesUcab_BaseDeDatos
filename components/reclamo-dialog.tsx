"use client"

import { useState, useEffect } from "react"
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog"
import { Badge } from "@/components/ui/badge"
import { Separator } from "@/components/ui/separator"
import { Button } from "@/components/ui/button"
import { Label } from "@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Calendar, FileText, AlertCircle, MessageSquare, Send } from "lucide-react"
import type { Claim, ClaimStatus } from "@/lib/claims-context"
import { useUser } from "@/lib/user-context"
import { useClaims } from "@/lib/claims-context"
import { useToast } from "@/hooks/use-toast"

type ReclamoDialogProps = {
  open: boolean
  onOpenChange: (open: boolean) => void
  reclamo: Claim | null
}

const estadosConfig = {
  pendiente: { label: "Pendiente", variant: "secondary" as const },
  listo: { label: "Listo", variant: "outline" as const },
}

export function ReclamoDialog({ open, onOpenChange, reclamo }: ReclamoDialogProps) {
  const { hasRole } = useUser()
  const { updateClaim } = useClaims()
  const { toast } = useToast()
  const [nuevoEstado, setNuevoEstado] = useState<ClaimStatus>("pendiente")
  const isAdmin = hasRole(1)

  useEffect(() => {
    if (reclamo) {
      setNuevoEstado(reclamo.estado)
    }
  }, [reclamo])

  if (!reclamo) return null

  const estadoConfig = estadosConfig[reclamo.estado]

  const handleCambiarEstado = async () => {
    if (nuevoEstado === reclamo.estado) {
      toast({
        title: "Sin cambios",
        description: "El estado no ha cambiado",
        variant: "destructive",
      })
      return
    }

    // Si se cambió el estado a "Listo", actualizar en la BD
    if (nuevoEstado === "listo" && reclamo.estado === "pendiente") {
      try {
        // Actualizar estado en la BD usando el endpoint PUT
        const registroId = (reclamo as any).registroId
        
        if (!registroId) {
          toast({
            title: "Error",
            description: "No se puede actualizar: falta el ID del registro",
            variant: "destructive",
          })
          return
        }

        const response = await fetch("/api/reclamos", {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            registro_id: registroId,
            fecha_fin: new Date().toISOString().split('T')[0], // YYYY-MM-DD
          }),
        })

        const result = await response.json()

        if (result.status === "success") {
          toast({
            title: "Estado actualizado",
            description: "El reclamo ha sido marcado como Listo",
          })
          
          // También actualizar en el contexto local si existe
          updateClaim(reclamo.id, {
            estado: nuevoEstado,
          })

          onOpenChange(false)
        } else {
          toast({
            title: "Error",
            description: result.message || "No se pudo actualizar el estado",
            variant: "destructive",
          })
        }
      } catch (error: any) {
        console.error("Error actualizando estado:", error)
        toast({
          title: "Error",
          description: error.message || "Error al actualizar el estado",
          variant: "destructive",
        })
      }
    } else {
      // Solo guardar estado sin cambiar en BD (contexto local)
      updateClaim(reclamo.id, {
        estado: nuevoEstado,
      })

      toast({
        title: "Estado actualizado",
        description: "El estado ha sido actualizado",
      })

      onOpenChange(false)
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px]">
        <DialogHeader>
          <div className="flex items-start justify-between">
            <div>
              <DialogTitle className="text-xl">{reclamo.numeroReclamo}</DialogTitle>
              <DialogDescription>Detalles de tu reclamo</DialogDescription>
            </div>
            <Badge variant={estadoConfig.variant}>{estadoConfig.label}</Badge>
          </div>
        </DialogHeader>

        <div className="space-y-6">
          <div>
            <h4 className="text-sm font-medium mb-3 flex items-center gap-2">
              <AlertCircle className="h-4 w-4" />
              Detalles del Reclamo
            </h4>
            <div className="space-y-3 pl-6">
              <div>
                <p className="text-xs text-muted-foreground mb-1">Categoría</p>
                <Badge variant="outline">{reclamo.categoria}</Badge>
              </div>
              <div>
                <p className="text-xs text-muted-foreground mb-1">Motivo del reclamo</p>
                <p className="text-sm font-medium">{reclamo.razon}</p>
              </div>
              <div>
                <p className="text-xs text-muted-foreground mb-1">Descripción</p>
                <p className="text-sm text-muted-foreground leading-relaxed">{reclamo.descripcion}</p>
              </div>
              {reclamo.urgente && (
                <div>
                  <Badge variant="destructive" className="gap-1">
                    <AlertCircle className="h-3 w-3" />
                    Marcado como urgente
                  </Badge>
                </div>
              )}
            </div>
          </div>

          <Separator />

          <div>
            <h4 className="text-sm font-medium mb-3 flex items-center gap-2">
              <FileText className="h-4 w-4" />
              Información Adicional
            </h4>
            <div className="space-y-2 pl-6">
              <div className="flex items-center gap-2 text-sm">
                <Calendar className="h-3 w-3 text-muted-foreground" />
                <span className="text-muted-foreground">
                  Fecha de envío: {new Date(reclamo.fechaCreacion).toLocaleString("es-ES")}
                </span>
              </div>
              {reclamo.reservaRelacionada && (
                <div className="flex items-center gap-2 text-sm">
                  <FileText className="h-3 w-3 text-muted-foreground" />
                  <span className="text-muted-foreground">Reserva relacionada: {reclamo.reservaRelacionada}</span>
                </div>
              )}
            </div>
          </div>

          {isAdmin && (
            <>
              <Separator />
              <div>
                <h4 className="text-sm font-medium mb-3 flex items-center gap-2">
                  <MessageSquare className="h-4 w-4" />
                  Gestionar Reclamo
                </h4>
                <div className="space-y-4 pl-6">
                  <div className="space-y-2">
                    <Label htmlFor="estado">Cambiar Estado</Label>
                    <Select value={nuevoEstado} onValueChange={(value) => setNuevoEstado(value as ClaimStatus)}>
                      <SelectTrigger id="estado">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="pendiente">Pendiente</SelectItem>
                        <SelectItem value="listo">Listo</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <Button onClick={handleCambiarEstado} className="w-full">
                    <Send className="h-4 w-4 mr-2" />
                    Actualizar Estado
                  </Button>
                </div>
              </div>
            </>
          )}
        </div>
      </DialogContent>
    </Dialog>
  )
}
