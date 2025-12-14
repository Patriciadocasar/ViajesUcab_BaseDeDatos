"use client"

import { useEffect, useState } from "react"
import { useRouter, useParams } from "next/navigation"
import { useUser } from "@/lib/user-context"
import { useCurrency } from "@/lib/currency-context"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Separator } from "@/components/ui/separator"
import { ArrowLeft, Calendar, MapPin, Plane, Hotel, Utensils, Ship, Bus, Package } from "lucide-react"
import { useToast } from "@/hooks/use-toast"

interface ReservaDetalle {
  reserva: {
    reserva_id: number
    numero_reserva: number
    fecha_hora: string
    subtotal: number
    total: number
    millas_obtenidas: number
    camarote: string | null
    cliente: {
      cliente_id: number
      nombre: string
    }
  }
  itinerarios: Array<{
    itinerario_id: number
    costo_total: number
    fecha_inicio: string
    fecha_fin: string
    millas_totales: number
    paquete_turistico_id: number | null
    hospedaje_id: number | null
    restaurante_id: number | null
    vuelo_id: number | null
    crucero_id: number | null
    transporte_terrestre_id: number | null
    servicio_adicional_id: number | null
  }>
}

export default function ReservaDetallePage() {
  const params = useParams()
  const router = useRouter()
  const { user, isAuthenticated } = useUser()
  const { formatPrice } = useCurrency()
  const { toast } = useToast()
  const [reserva, setReserva] = useState<ReservaDetalle | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!isAuthenticated) {
      toast({
        title: "Inicia sesión",
        description: "Debes iniciar sesión para ver tus reservas",
        variant: "destructive",
      })
      router.push("/auth/login")
      return
    }

    cargarReserva()
  }, [isAuthenticated, params.id])

  const cargarReserva = async () => {
    try {
      setLoading(true)
      const response = await fetch(`/api/reserva/${params.id}`)
      const result = await response.json()

      if (result.status === "error") {
        toast({
          title: "Error",
          description: result.message,
          variant: "destructive",
        })
        return
      }

      setReserva(result.data)
    } catch (error) {
      console.error("Error al cargar reserva:", error)
      toast({
        title: "Error",
        description: "No se pudo cargar la reserva",
        variant: "destructive",
      })
    } finally {
      setLoading(false)
    }
  }

  const getServiceIcon = (itinerario: any) => {
    if (itinerario.vuelo_id) return <Plane className="h-5 w-5" />
    if (itinerario.hospedaje_id) return <Hotel className="h-5 w-5" />
    if (itinerario.crucero_id) return <Ship className="h-5 w-5" />
    if (itinerario.transporte_terrestre_id) return <Bus className="h-5 w-5" />
    if (itinerario.restaurante_id) return <Utensils className="h-5 w-5" />
    if (itinerario.paquete_turistico_id) return <Package className="h-5 w-5" />
    return <MapPin className="h-5 w-5" />
  }

  const getServiceType = (itinerario: any) => {
    if (itinerario.vuelo_id) return "Vuelo"
    if (itinerario.hospedaje_id) return "Hospedaje"
    if (itinerario.crucero_id) return "Crucero"
    if (itinerario.transporte_terrestre_id) return "Transporte Terrestre"
    if (itinerario.restaurante_id) return "Restaurante"
    if (itinerario.paquete_turistico_id) return "Paquete Turístico"
    if (itinerario.servicio_adicional_id) return "Servicio Adicional"
    return "Servicio"
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-background py-12">
        <div className="container mx-auto px-4 lg:px-8">
          <div className="flex items-center justify-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
          </div>
        </div>
      </div>
    )
  }

  if (!reserva) {
    return (
      <div className="min-h-screen bg-background py-12">
        <div className="container mx-auto px-4 lg:px-8">
          <Card>
            <CardContent className="pt-6">
              <p className="text-center text-muted-foreground">No se encontró la reserva</p>
            </CardContent>
          </Card>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-background py-12">
      <div className="container mx-auto px-4 lg:px-8">
        <div className="max-w-4xl mx-auto">
          <div className="mb-6">
            <Button variant="ghost" onClick={() => router.push("/perfil?tab=purchases")} className="gap-2">
              <ArrowLeft className="h-4 w-4" />
              Volver a Mis Reservas
            </Button>
          </div>

          {/* Header */}
          <Card className="mb-6">
            <CardHeader>
              <div className="flex items-start justify-between">
                <div>
                  <CardTitle className="text-3xl mb-2">Reserva #{reserva.reserva.numero_reserva}</CardTitle>
                  <CardDescription>
                    Reservado el {new Date(reserva.reserva.fecha_hora).toLocaleDateString("es-ES", {
                      day: "numeric",
                      month: "long",
                      year: "numeric",
                      hour: "2-digit",
                      minute: "2-digit",
                    })}
                  </CardDescription>
                </div>
                <Badge variant="default" className="text-lg px-4 py-2">
                  Confirmado
                </Badge>
              </div>
            </CardHeader>
            <CardContent>
              <div className="grid gap-4 md:grid-cols-2">
                <div>
                  <p className="text-sm text-muted-foreground">Cliente</p>
                  <p className="font-semibold">{reserva.reserva.cliente.nombre}</p>
                </div>
                {reserva.reserva.camarote && (
                  <div>
                    <p className="text-sm text-muted-foreground">Camarote</p>
                    <p className="font-semibold">{reserva.reserva.camarote}</p>
                  </div>
                )}
                <div>
                  <p className="text-sm text-muted-foreground">Millas Obtenidas</p>
                  <p className="font-semibold text-primary">{reserva.reserva.millas_obtenidas} millas</p>
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Itinerarios */}
          <Card className="mb-6">
            <CardHeader>
              <CardTitle>Itinerarios ({reserva.itinerarios.length})</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              {reserva.itinerarios.map((itinerario, index) => (
                <div key={itinerario.itinerario_id}>
                  <div className="flex gap-4">
                    <div className="flex-shrink-0">
                      <div className="h-12 w-12 rounded-full bg-primary/10 flex items-center justify-center text-primary">
                        {getServiceIcon(itinerario)}
                      </div>
                    </div>
                    <div className="flex-1">
                      <div className="flex items-start justify-between gap-2 mb-2">
                        <div>
                          <Badge variant="secondary" className="mb-2">
                            {getServiceType(itinerario)}
                          </Badge>
                          <h3 className="font-semibold text-lg">Itinerario #{index + 1}</h3>
                        </div>
                        <div className="text-right">
                          <p className="font-semibold text-primary">{formatPrice(itinerario.costo_total)}</p>
                          <p className="text-sm text-muted-foreground">{itinerario.millas_totales} millas</p>
                        </div>
                      </div>
                      <div className="flex items-center gap-4 text-sm text-muted-foreground">
                        <span className="flex items-center gap-1">
                          <Calendar className="h-4 w-4" />
                          {new Date(itinerario.fecha_inicio).toLocaleDateString("es-ES")} -{" "}
                          {new Date(itinerario.fecha_fin).toLocaleDateString("es-ES")}
                        </span>
                      </div>
                      <div className="mt-2 text-sm">
                        {itinerario.vuelo_id && <p>• Vuelo ID: {itinerario.vuelo_id}</p>}
                        {itinerario.hospedaje_id && <p>• Hospedaje ID: {itinerario.hospedaje_id}</p>}
                        {itinerario.crucero_id && <p>• Crucero ID: {itinerario.crucero_id}</p>}
                        {itinerario.transporte_terrestre_id && (
                          <p>• Transporte ID: {itinerario.transporte_terrestre_id}</p>
                        )}
                        {itinerario.restaurante_id && <p>• Restaurante ID: {itinerario.restaurante_id}</p>}
                        {itinerario.servicio_adicional_id && (
                          <p>• Servicio Adicional ID: {itinerario.servicio_adicional_id}</p>
                        )}
                        {itinerario.paquete_turistico_id && (
                          <p>• Paquete Turístico ID: {itinerario.paquete_turistico_id}</p>
                        )}
                      </div>
                    </div>
                  </div>
                  {index < reserva.itinerarios.length - 1 && <Separator className="mt-4" />}
                </div>
              ))}
            </CardContent>
          </Card>

          {/* Resumen de Costos */}
          <Card>
            <CardHeader>
              <CardTitle>Resumen de Costos</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <div className="flex justify-between">
                <span className="text-muted-foreground">Subtotal</span>
                <span className="font-semibold">{formatPrice(reserva.reserva.subtotal)}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-muted-foreground">Impuestos</span>
                <span className="font-semibold">Incluidos</span>
              </div>
              <Separator />
              <div className="flex justify-between text-lg">
                <span className="font-bold">Total</span>
                <span className="font-bold text-primary">{formatPrice(reserva.reserva.total)}</span>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  )
}
