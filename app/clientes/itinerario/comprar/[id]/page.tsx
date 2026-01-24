"use client"

import { useEffect, useState } from "react"
import { useRouter, useParams } from "next/navigation"
import { useItinerary } from "@/lib/itinerary-context"
import { useUser } from "@/lib/user-context"
import { useCurrency } from "@/lib/currency-context"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Label } from "@/components/ui/label"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group"
import { Badge } from "@/components/ui/badge"
import { ArrowLeft, Plane, Hotel, Calendar, MapPin, Ship, Bus, Utensils, Compass } from "lucide-react"
import { useToast } from "@/hooks/use-toast"
import { FormularioPasajeros, type Pasajero } from "@/components/formulario-pasajeros"

export default function ComprarItinerarioPage() {
  const params = useParams()
  const router = useRouter()
  const { savedItineraries } = useItinerary()
  const { user, isAuthenticated } = useUser()
  const { formatPrice } = useCurrency()
  const { toast } = useToast()
  const [selections, setSelections] = useState<Record<string, string>>({})
  const [pasajeros, setPasajeros] = useState<Pasajero[]>([
    {
      primerNombre: "",
      segundoNombre: "",
      primerApellido: "",
      segundoApellido: "",
      fechaNacimiento: "",
      estadoCivil: "Soltero",
    },
  ])
  const [itinerary, setItinerary] = useState<any>(null)

  useEffect(() => {
    if (!isAuthenticated) {
      toast({
        title: "Inicia sesión",
        description: "Debes iniciar sesión para comprar un itinerario",
        variant: "destructive",
      })
      router.push("/")
      return
    }

    // Primero intentar obtener de localStorage (flujo directo de compra)
    const storedItinerary = localStorage.getItem("currentItineraryPurchase")
    if (storedItinerary) {
      const parsedItinerary = JSON.parse(storedItinerary)
      if (parsedItinerary.id === params.id) {
        setItinerary(parsedItinerary)
        return
      }
    }

    // Si no está en localStorage, buscar en savedItineraries
    const foundItinerary = savedItineraries.find((it) => it.id === params.id)
    if (foundItinerary) {
      setItinerary(foundItinerary)
    } else {
      toast({
        title: "Itinerario no encontrado",
        description: "El itinerario que buscas no existe",
        variant: "destructive",
      })
      router.push("/clientes/perfil?tab=itineraries")
    }
  }, [isAuthenticated, params.id, savedItineraries, router, toast])

  if (!itinerary || !user) {
    return null
  }

  const handleSelectionChange = (itemId: string, value: string) => {
    setSelections((prev) => ({
      ...prev,
      [itemId]: value,
    }))
  }

  const handleContinueToPayment = async () => {
    // Validate all selections are made
    const requiredSelections = itinerary.items.filter((item: any) => {
      const options = getSelectionOptions(item)
      return options.length > 0
    })

    const missingSelections = requiredSelections.filter((item: any) => !selections[item.id])

    if (missingSelections.length > 0) {
      toast({
        title: "Selecciones incompletas",
        description: "Por favor completa todas las selecciones antes de continuar",
        variant: "destructive",
      })
      return
    }

    // Validar datos de pasajeros
    const pasajerosIncompletos = pasajeros.filter(
      (p) => !p.primerNombre || !p.primerApellido || !p.fechaNacimiento || !p.estadoCivil
    )

    if (pasajerosIncompletos.length > 0) {
      toast({
        title: "Datos de pasajeros incompletos",
        description: "Por favor completa los datos obligatorios de todos los pasajeros",
        variant: "destructive",
      })
      return
    }

    // Validar restricciones de paquetes ANTES de crear la reserva
    const paquetes = itinerary.items.filter((item: any) => item.type === "paquete" && item.realId)
    
    if (paquetes.length > 0) {
      toast({
        title: "Validando restricciones...",
        description: "Verificando requisitos de paquetes especiales",
      })

      for (const paquete of paquetes) {
        try {
          const validacionResponse = await fetch("/api/paquete-turistico/validar-restricciones", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              paquete_id: paquete.realId,
              pasajeros: pasajeros,
            }),
          })

          const validacionResult = await validacionResponse.json()

          if (validacionResult.status === "error" || validacionResult.cumple === false) {
            toast({
              title: "Restricción no cumplida",
              description: validacionResult.message,
              variant: "destructive",
            })
            return
          }

          console.log(`✅ Paquete ${paquete.realId} validado correctamente:`, validacionResult)
        } catch (error) {
          console.error("Error al validar restricciones:", error)
          toast({
            title: "Error de validación",
            description: "No se pudieron validar las restricciones del paquete",
            variant: "destructive",
          })
          return
        }
      }
    }

    // Crear la reserva en la base de datos
    try {
      toast({
        title: "Procesando...",
        description: "Creando tu reserva",
      })

      // Preparar los datos según el tipo de servicio con IDs reales de la BD
      const vuelo_ids: number[] = []
      const crucero_ids: number[] = []
      const traslado_ids: number[] = []
      const hospedaje_ids: number[] = []
      const servicio_adicional_ids: number[] = []
      const restaurante_ids: number[] = []
      const paquete_turistico_ids: number[] = []
      const fechas_inicio: string[] = []
      const fechas_fin: string[] = []

      // Usar las fechas del itinerario completo (no las de cada servicio)
      const fechaInicioItinerario = itinerary.startDate || itinerary.items[0]?.date
      const fechaFinItinerario = itinerary.endDate || itinerary.items[itinerary.items.length - 1]?.date

      itinerary.items.forEach((item: any) => {
        // Extraer IDs reales según el tipo
        if (item.type === "vuelo" && item.realId) {
          vuelo_ids.push(item.realId)
          fechas_inicio.push(fechaInicioItinerario)
          fechas_fin.push(fechaFinItinerario)
        } else if (item.type === "crucero" && item.realId) {
          crucero_ids.push(item.realId)
          fechas_inicio.push(fechaInicioItinerario)
          fechas_fin.push(fechaFinItinerario)
        } else if (item.type === "traslado" && item.realId) {
          traslado_ids.push(item.realId)
          fechas_inicio.push(fechaInicioItinerario)
          fechas_fin.push(fechaFinItinerario)
        } else if (item.type === "hospedaje" && item.realId) {
          hospedaje_ids.push(item.realId)
          fechas_inicio.push(fechaInicioItinerario)
          fechas_fin.push(fechaFinItinerario)
        } else if (item.type === "servicio" && item.realId) {
          servicio_adicional_ids.push(item.realId)
          fechas_inicio.push(fechaInicioItinerario)
          fechas_fin.push(fechaFinItinerario)
        } else if (item.type === "restaurante" && item.realId) {
          restaurante_ids.push(item.realId)
          fechas_inicio.push(fechaInicioItinerario)
          fechas_fin.push(fechaFinItinerario)
        } else if (item.type === "paquete" && item.realId) {
          paquete_turistico_ids.push(item.realId)
          fechas_inicio.push(fechaInicioItinerario)
          fechas_fin.push(fechaFinItinerario)
        }
      })

      console.log("📅 Fechas del itinerario:", {
        fechaInicio: fechaInicioItinerario,
        fechaFin: fechaFinItinerario,
        fechas_inicio,
        fechas_fin
      })

      // Llamar a la API para crear la reserva
      console.log("🔑 Usuario:", { id: user.id, clienteId: user.clienteId, name: user.name })
      
      const response = await fetch("/api/itinerario/crear", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          cliente_id: parseInt(user.clienteId),
          paquete_turistico_ids: paquete_turistico_ids.length > 0 ? paquete_turistico_ids : null,
          vuelo_ids: vuelo_ids.length > 0 ? vuelo_ids : null,
          crucero_ids: crucero_ids.length > 0 ? crucero_ids : null,
          transporte_terrestre_ids: traslado_ids.length > 0 ? traslado_ids : null,
          hospedaje_ids: hospedaje_ids.length > 0 ? hospedaje_ids : null,
          servicio_adicional_ids: servicio_adicional_ids.length > 0 ? servicio_adicional_ids : null,
          restaurante_ids: restaurante_ids.length > 0 ? restaurante_ids : null,
          fechas_inicio: fechas_inicio.length > 0 ? fechas_inicio : null,
          fechas_fin: fechas_fin.length > 0 ? fechas_fin : null,
        }),
      })

      const result = await response.json()

      if (result.status === "error") {
        toast({
          title: "Error",
          description: result.message,
          variant: "destructive",
        })
        return
      }

      console.log("✅ Reserva creada:", result)

      // Registrar pasajeros
      const reserva_id = result.data.reserva_id
      
      try {
        const pasajerosResponse = await fetch("/api/pasajeros/registrar", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            cliente_id: parseInt(user.clienteId),
            reserva_id: reserva_id,
            pasajeros: pasajeros,
          }),
        })

        const pasajerosResult = await pasajerosResponse.json()

        if (pasajerosResult.status === "error") {
          console.warn("⚠️ Error al registrar pasajeros:", pasajerosResult.message)
          // No bloqueamos el flujo, solo mostramos advertencia
          toast({
            title: "Advertencia",
            description: "Reserva creada pero hubo un problema al registrar los pasajeros",
            variant: "default",
          })
        } else {
          console.log("✅ Pasajeros registrados:", pasajerosResult)
        }
      } catch (error) {
        console.warn("⚠️ Error al registrar pasajeros:", error)
      }

      // Store purchase data with reservation info
      const purchaseData = {
        itinerary,
        selections,
        pasajeros,  // Incluir pasajeros
        reservaInfo: result.data,
        customerInfo: {
          name: user.name,
          email: user.email,
          phone: "",
          passport: "",
        },
      }

      localStorage.setItem("itineraryPurchase", JSON.stringify(purchaseData))
      
      toast({
        title: "¡Reserva creada!",
        description: `Número de reserva: ${result.data.numero_reserva}`,
      })

      router.push(`/clientes/itinerario/pago/${itinerary.id}`)
    } catch (error: any) {
      console.error("Error al crear reserva:", error)
      toast({
        title: "Error",
        description: "No se pudo crear la reserva. Por favor intenta nuevamente.",
        variant: "destructive",
      })
    }
  }

  const getSelectionOptions = (item: any) => {
    switch (item.type) {
      // Nuevos tipos de servicios de la BD
      case "vuelo":
        return [
          { value: "economy-window", label: "Económica - Ventana", price: 0 },
          { value: "economy-aisle", label: "Económica - Pasillo", price: 0 },
          { value: "business-window", label: "Business - Ventana", price: 500 },
          { value: "business-aisle", label: "Business - Pasillo", price: 500 },
        ]

      case "crucero":
        return [
          { value: "interior", label: "Camarote Interior", price: 0 },
          { value: "oceanview", label: "Camarote con Vista al Mar", price: 300 },
          { value: "balcony", label: "Camarote con Balcón", price: 600 },
          { value: "suite", label: "Suite", price: 1200 },
        ]

      case "traslado":
        return [
          { value: "standard", label: "Asiento Estándar", price: 0 },
          { value: "comfort", label: "Asiento Confort", price: 50 },
          { value: "premium", label: "Asiento Premium", price: 100 },
        ]

      case "hospedaje":
        return [
          { value: "standard", label: "Habitación Estándar", price: 0 },
          { value: "deluxe", label: "Habitación Deluxe", price: 100 },
          { value: "suite", label: "Suite", price: 250 },
          { value: "presidential", label: "Suite Presidencial", price: 500 },
        ]

      // Tipos antiguos (para compatibilidad)
      case "transport":
        if (item.title.toLowerCase().includes("vuelo") || item.title.toLowerCase().includes("avión")) {
          return [
            { value: "economy-window", label: "Económica - Ventana", price: 0 },
            { value: "economy-aisle", label: "Económica - Pasillo", price: 0 },
            { value: "business-window", label: "Business - Ventana", price: 500 },
            { value: "business-aisle", label: "Business - Pasillo", price: 500 },
          ]
        }
        if (item.title.toLowerCase().includes("tren")) {
          return [
            { value: "standard", label: "Asiento Estándar", price: 0 },
            { value: "comfort", label: "Asiento Confort", price: 50 },
            { value: "first-class", label: "Primera Clase", price: 150 },
          ]
        }
        if (item.title.toLowerCase().includes("crucero")) {
          return [
            { value: "interior", label: "Camarote Interior", price: 0 },
            { value: "oceanview", label: "Camarote con Vista al Mar", price: 300 },
            { value: "balcony", label: "Camarote con Balcón", price: 600 },
            { value: "suite", label: "Suite", price: 1200 },
          ]
        }
        return []

      case "accommodation":
        return [
          { value: "standard", label: "Habitación Estándar", price: 0 },
          { value: "deluxe", label: "Habitación Deluxe", price: 100 },
          { value: "suite", label: "Suite", price: 250 },
          { value: "presidential", label: "Suite Presidencial", price: 500 },
        ]

      // Servicios y restaurantes no requieren selección
      case "servicio":
      case "restaurante":
      case "activity":
      case "destination":
      default:
        return []
    }
  }

  const getItemIcon = (type: string) => {
    switch (type) {
      case "vuelo":
      case "transport":
        return <Plane className="h-5 w-5" />
      case "hospedaje":
      case "accommodation":
        return <Hotel className="h-5 w-5" />
      case "crucero":
        return <Ship className="h-5 w-5" />
      case "traslado":
        return <Bus className="h-5 w-5" />
      case "restaurante":
        return <Utensils className="h-5 w-5" />
      case "servicio":
      case "activity":
        return <Compass className="h-5 w-5" />
      case "destination":
        return <MapPin className="h-5 w-5" />
      default:
        return <MapPin className="h-5 w-5" />
    }
  }

  const calculateTotalWithSelections = () => {
    let total = itinerary.totalPrice
    Object.entries(selections).forEach(([itemId, selection]) => {
      const item = itinerary.items.find((i: any) => i.id === itemId)
      if (item) {
        const options = getSelectionOptions(item)
        const selectedOption = options.find((opt) => opt.value === selection)
        if (selectedOption) {
          total += selectedOption.price
        }
      }
    })
    return total
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8 lg:px-8">
        <div className="mb-6">
          <Button variant="ghost" onClick={() => router.push("/clientes/perfil?tab=itineraries")} className="gap-2">
            <ArrowLeft className="h-4 w-4" />
            Volver a Mis Itinerarios
          </Button>
        </div>

        <div className="mb-8">
          <h1 className="text-4xl font-bold mb-2">Comprar Itinerario</h1>
          <p className="text-muted-foreground">Selecciona tus preferencias para cada servicio</p>
        </div>

        <div className="grid gap-6 lg:grid-cols-3">
          <div className="lg:col-span-2 space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>{itinerary.name}</CardTitle>
                <CardDescription>
                  {itinerary.items.length} servicios incluidos
                  {itinerary.startDate && itinerary.endDate && (
                    <span className="ml-2">
                      • {new Date(itinerary.startDate).toLocaleDateString("es-ES")} -{" "}
                      {new Date(itinerary.endDate).toLocaleDateString("es-ES")}
                    </span>
                  )}
                </CardDescription>
              </CardHeader>
            </Card>

            <FormularioPasajeros pasajeros={pasajeros} onChange={setPasajeros} />

            {itinerary.items
              .sort((a: any, b: any) => new Date(a.date).getTime() - new Date(b.date).getTime())
              .map((item: any) => {
                const options = getSelectionOptions(item)
                const requiresSelection = options.length > 0

                return (
                  <Card key={item.id}>
                    <CardHeader>
                      <div className="flex items-start gap-3">
                        <div className="flex-shrink-0">
                          <div className="h-12 w-12 rounded-full bg-primary/10 flex items-center justify-center text-primary">
                            {getItemIcon(item.type)}
                          </div>
                        </div>
                        <div className="flex-1">
                          <div className="flex items-start justify-between gap-2 mb-2">
                            <div>
                              <CardTitle className="text-lg">{item.title}</CardTitle>
                              <CardDescription>{item.description}</CardDescription>
                            </div>
                            <Badge variant="secondary">{formatPrice(item.price)}</Badge>
                          </div>
                          <div className="flex items-center gap-4 text-sm text-muted-foreground">
                            <span className="flex items-center gap-1">
                              <Calendar className="h-4 w-4" />
                              {new Date(item.date).toLocaleDateString("es-ES", {
                                day: "numeric",
                                month: "long",
                                year: "numeric",
                              })}
                            </span>
                            {item.location && (
                              <span className="flex items-center gap-1">
                                <MapPin className="h-4 w-4" />
                                {item.location}
                              </span>
                            )}
                          </div>
                        </div>
                      </div>
                    </CardHeader>
                    {requiresSelection && (
                      <CardContent>
                        <Label className="text-base font-semibold mb-3 block">Selecciona tu preferencia</Label>
                        <RadioGroup
                          value={selections[item.id] || ""}
                          onValueChange={(value) => handleSelectionChange(item.id, value)}
                        >
                          <div className="space-y-3">
                            {options.map((option) => (
                              <div
                                key={option.value}
                                className="flex items-center space-x-3 border rounded-lg p-4 hover:border-primary transition-colors"
                              >
                                <RadioGroupItem value={option.value} id={`${item.id}-${option.value}`} />
                                <Label
                                  htmlFor={`${item.id}-${option.value}`}
                                  className="flex-1 cursor-pointer flex items-center justify-between"
                                >
                                  <span>{option.label}</span>
                                  {option.price > 0 && (
                                    <span className="text-primary font-semibold">+{formatPrice(option.price)}</span>
                                  )}
                                </Label>
                              </div>
                            ))}
                          </div>
                        </RadioGroup>
                      </CardContent>
                    )}
                  </Card>
                )
              })}
          </div>

          <div className="lg:col-span-1">
            <Card className="sticky top-20">
              <CardHeader>
                <CardTitle>Resumen de Compra</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="space-y-3">
                  <div className="flex justify-between text-sm">
                    <span className="text-muted-foreground">Precio base del itinerario</span>
                    <span className="font-semibold">{formatPrice(itinerary.totalPrice)}</span>
                  </div>
                  {Object.entries(selections).map(([itemId, selection]) => {
                    const item = itinerary.items.find((i: any) => i.id === itemId)
                    if (!item) return null
                    const options = getSelectionOptions(item)
                    const selectedOption = options.find((opt) => opt.value === selection)
                    if (!selectedOption || selectedOption.price === 0) return null
                    return (
                      <div key={itemId} className="flex justify-between text-sm">
                        <span className="text-muted-foreground truncate pr-2">{selectedOption.label}</span>
                        <span className="font-semibold whitespace-nowrap">+{formatPrice(selectedOption.price)}</span>
                      </div>
                    )
                  })}
                </div>
                <div className="border-t pt-4">
                  <div className="flex justify-between items-center">
                    <span className="font-bold text-lg">Total</span>
                    <span className="font-bold text-xl text-primary">
                      {formatPrice(calculateTotalWithSelections())}
                    </span>
                  </div>
                </div>
                <Button onClick={handleContinueToPayment} className="w-full" size="lg">
                  Realizar Reserva y Comprar
                </Button>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  )
}
