"use client"

import { useState, useEffect } from "react"
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog"
import { Badge } from "@/components/ui/badge"
import { Separator } from "@/components/ui/separator"
import { Button } from "@/components/ui/button"
import { Textarea } from "@/components/ui/textarea"
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
  const [respuesta, setRespuesta] = useState("")
  const isAdmin = hasRole(1)

  if (!reclamo) return null

  const estadoConfig = estadosConfig[reclamo.estado]
  const [nuevoEstado, setNuevoEstado] = useState<ClaimStatus>(reclamo.estado)

  useEffect(() => {
    if (reclamo) {
      setNuevoEstado(reclamo.estado)
      setRespuesta(reclamo.respuestaAdmin || "")
    }
  }, [reclamo])

  const handleResponder = () => {
    if (!respuesta.trim()) {
      toast({
        title: "Error",
        description: "Por favor escribe una respuesta",
        variant: "destructive",
      })
      return
    }

    updateClaim(reclamo.id, {
      respuestaAdmin: respuesta,
      estado: nuevoEstado,
    })

    toast({
      title: "Respuesta enviada",
      description: "La respuesta ha sido guardada exitosamente",
    })

    setRespuesta("")
    onOpenChange(false)
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

          {reclamo.respuestaAdmin && (
            <>
              <Separator />
              <div>
                <h4 className="text-sm font-medium mb-3 flex items-center gap-2">
                  <MessageSquare className="h-4 w-4" />
                  Respuesta del Administrador
                </h4>
                <div className="pl-6">
                  <p className="text-sm text-muted-foreground leading-relaxed bg-muted p-3 rounded-lg">
                    {reclamo.respuestaAdmin}
                  </p>
                </div>
              </div>
            </>
          )}

          {isAdmin && (
            <>
              <Separator />
              <div>
                <h4 className="text-sm font-medium mb-3 flex items-center gap-2">
                  <MessageSquare className="h-4 w-4" />
                  Responder al Reclamo
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
                  <div className="space-y-2">
                    <Label htmlFor="respuesta">Respuesta</Label>
                    <Textarea
                      id="respuesta"
                      placeholder="Escribe tu respuesta al cliente..."
                      rows={4}
                      value={respuesta}
                      onChange={(e) => setRespuesta(e.target.value)}
                    />
                  </div>
                  <Button onClick={handleResponder} className="w-full">
                    <Send className="h-4 w-4 mr-2" />
                    Enviar Respuesta
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
