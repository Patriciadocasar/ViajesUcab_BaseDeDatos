"use client"

import type React from "react"
import { useEffect, useState } from "react"
import { useRouter, useParams } from "next/navigation"
import { useUser } from "@/lib/user-context"
import { useCurrency } from "@/lib/currency-context"
import { usePurchaseHistory } from "@/lib/purchase-history-context"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { ArrowLeft, CreditCard, User, Mail, Phone, MapPin } from "lucide-react"
import { useToast } from "@/hooks/use-toast"
import { SelectorMetodosPagoMultiple, type MetodoPagoConMonto } from "@/components/selector-metodos-pago-multiple"
import { Checkbox } from "@/components/ui/checkbox"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"

export default function PagoItinerarioPage() {
  const params = useParams()
  const router = useRouter()
  const { user, isAuthenticated } = useUser()
  const { convertPrice } = useCurrency()
  const { addPurchase } = usePurchaseHistory()
  const { toast } = useToast()

  const [purchaseData, setPurchaseData] = useState<any>(null)
  const [metodosPago, setMetodosPago] = useState<MetodoPagoConMonto[]>([
    {
      id: `metodo-${Date.now()}`,
      tipo: "Tarjeta_Credito",
      monto: 0,
      datos: {},
    },
  ])
  const [usarFinanciamiento, setUsarFinanciamiento] = useState(false)
  const [numeroCuotas, setNumeroCuotas] = useState("6")

  useEffect(() => {
    if (!isAuthenticated) {
      router.push("/")
      return
    }

    const stored = localStorage.getItem("itineraryPurchase")
    if (!stored) {
      toast({
        title: "Error",
        description: "No se encontró información de compra",
        variant: "destructive",
      })
      router.push("/clientes/perfil?tab=itineraries")
      return
    }

    const parsed = JSON.parse(stored)
    setPurchaseData(parsed)

    // Inicializar el monto del primer método de pago con el total
    const total = parsed.itinerary.totalPrice
    setMetodosPago([
      {
        id: `metodo-${Date.now()}`,
        tipo: "Tarjeta_Credito",
        monto: total,
        datos: {},
      },
    ])
  }, [isAuthenticated, router, toast])

  if (!purchaseData || !user) {
    return null
  }

  const { itinerary, selections, pasajeros = [], reservaInfo } = purchaseData

  const calculateTotalWithSelections = () => {
    const total = itinerary.totalPrice
    Object.entries(selections).forEach(([itemId, selection]: [string, any]) => {
      const item = itinerary.items.find((i: any) => i.id === itemId)
      if (item) {
        // Add selection price logic here if needed
      }
    })
    return total
  }

  const totalPrice = calculateTotalWithSelections()
  const convertedTotal = convertPrice(totalPrice)

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    })
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()

    // Si usa financiamiento, no validar el monto total (solo necesita un método de pago para las cuotas)
    if (!usarFinanciamiento) {
      // Validar que el total esté completo solo si NO usa financiamiento
      const totalAsignado = metodosPago.reduce((sum, m) => sum + m.monto, 0)
      const diferencia = Math.abs(totalPrice - totalAsignado)

      if (diferencia > 0.01) {
        toast({
          title: "Monto incompleto",
          description: `Faltan $${(totalPrice - totalAsignado).toFixed(2)} por asignar`,
          variant: "destructive",
        })
        return
      }
    }

    try {
      // Obtener la información de la reserva del localStorage
      const storedData = JSON.parse(localStorage.getItem("itineraryPurchase") || "{}")
      const reserva_id = storedData.reservaInfo?.reserva_id

      if (!reserva_id) {
        toast({
          title: "Error",
          description: "No se encontró información de la reserva",
          variant: "destructive",
        })
        return
      }

      let financiamientoInfo = null
      let pagosRealizados = []
      let millasObtenidas = 0
      const metodosRegistrados: Array<{ metodo_pago_id: number; monto: number }> = []

      if (usarFinanciamiento) {
        // FLUJO CON FINANCIAMIENTO: Solo registrar método de pago para las cuotas
        toast({
          title: "Registrando método de pago...",
          description: "Este método se usará para las cuotas mensuales",
        })

        // Registrar solo el primer método de pago (para las cuotas futuras)
        if (metodosPago.length > 0) {
          const registrarMetodoPagoResponse = await fetch("/api/metodo-pago/registrar-universal", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              tipo: metodosPago[0].tipo,
              cliente_id: parseInt(user.clienteId),
              datos: metodosPago[0].datos,
            }),
          })

          const metodoPagoResult = await registrarMetodoPagoResponse.json()

          if (metodoPagoResult.status === "error") {
            toast({
              title: "Error al registrar método de pago",
              description: metodoPagoResult.message,
              variant: "destructive",
            })
            return
          }

          metodosRegistrados.push({
            metodo_pago_id: metodoPagoResult.data.metodo_pago_id,
            monto: 0, // No se paga ahora
          })

          console.log("✅ Método de pago registrado para cuotas:", metodoPagoResult.data.metodo_pago_id)
        }

        // NO procesar pagos ahora (se pagarán por cuotas)
        toast({
          title: "Registrando financiamiento...",
          description: `Creando plan de ${numeroCuotas} cuotas`,
        })

        const financiamientoResponse = await fetch("/api/financiamiento", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            reserva_id: reserva_id,
            numero_cuotas: parseInt(numeroCuotas),
          }),
        })

        const financiamientoResult = await financiamientoResponse.json()

        if (financiamientoResult.status === "error") {
          toast({
            title: "Error al crear financiamiento",
            description: financiamientoResult.message,
            variant: "destructive",
          })
          return
        }

        financiamientoInfo = financiamientoResult.data
        console.log("✅ Financiamiento registrado:", financiamientoInfo)

      } else {
        // FLUJO SIN FINANCIAMIENTO: Pagar el monto completo ahora
        toast({
          title: "Procesando pago...",
          description: "Registrando métodos de pago",
        })

        // Paso 1: Registrar todos los métodos de pago
        for (const metodo of metodosPago) {
          const registrarMetodoPagoResponse = await fetch("/api/metodo-pago/registrar-universal", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              tipo: metodo.tipo,
              cliente_id: parseInt(user.clienteId),
              datos: metodo.datos,
            }),
          })

          const metodoPagoResult = await registrarMetodoPagoResponse.json()

          if (metodoPagoResult.status === "error") {
            toast({
              title: "Error al registrar método de pago",
              description: metodoPagoResult.message,
              variant: "destructive",
            })
            return
          }

          metodosRegistrados.push({
            metodo_pago_id: metodoPagoResult.data.metodo_pago_id,
            monto: metodo.monto,
          })

          console.log(`✅ Método ${metodosRegistrados.length} registrado:`, {
            tipo: metodo.tipo,
            id: metodoPagoResult.data.metodo_pago_id,
            monto: metodo.monto,
          })
        }

        toast({
          title: "Procesando pagos...",
          description: `Procesando ${metodosRegistrados.length} método(s) de pago`,
        })

        // Paso 2: Procesar cada pago
        for (const metodoRegistrado of metodosRegistrados) {
          const usaMillas = metodosPago.find(
            (m) => m.tipo === "Milla_MP" && metodosRegistrados.some((mr) => mr.metodo_pago_id === metodoRegistrado.metodo_pago_id)
          )

          console.log(`💳 Procesando pago ${pagosRealizados.length + 1}/${metodosRegistrados.length}:`, {
            reserva_id: reserva_id,
            cliente_id: parseInt(user.clienteId),
            metodo_pago_id: metodoRegistrado.metodo_pago_id,
            monto_pago: metodoRegistrado.monto,
          })

          const procesarPagoResponse = await fetch("/api/pago/procesar", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              reserva_id: reserva_id,
              cliente_id: parseInt(user.clienteId),
              metodo_pago_id: metodoRegistrado.metodo_pago_id,
              monto_pago: metodoRegistrado.monto,
              pago_con_millas: usaMillas ? true : false,
              cantidad_millas: usaMillas ? Math.floor(metodoRegistrado.monto * 10) : 0,
            }),
          })

          const pagoResult = await procesarPagoResponse.json()

          if (pagoResult.status === "error") {
            toast({
              title: `Error al procesar pago ${pagosRealizados.length + 1}`,
              description: pagoResult.message,
              variant: "destructive",
            })
            return
          }

          pagosRealizados.push(pagoResult)
          millasObtenidas += pagoResult.data.millas_obtenidas || 0

          console.log(`✅ Pago ${pagosRealizados.length} procesado:`, pagoResult)
        }

        console.log("✅ Todos los pagos procesados:", {
          total_pagos: pagosRealizados.length,
          millas_totales: millasObtenidas,
        })
      }

      // Continuar con el resto del flujo (confirmación)
      const reservationNumber = storedData.reservaInfo.numero_reserva || `VU${Date.now().toString().slice(-8)}`

      // Convert itinerary items to cart items format
      const cartItems = itinerary.items.map((item: any) => ({
        id: Number.parseInt(item.id),
        title: item.title,
        location: item.location || item.description,
        price: item.price,
        image: "/placeholder.svg",
        type: item.type === "transport" ? "flight" : item.type === "accommodation" ? "hotel" : "tour",
        companyName: item.companyName || "ViajesUCAB",
        dates: {
          checkIn: item.date,
          checkOut: item.date,
        },
      }))

      addPurchase({
        id: reservationNumber.toString(),
        reservationNumber: reservationNumber.toString(),
        items: cartItems,
        totalPrice,
        purchaseDate: new Date().toISOString(),
        status: "completed",
        milesEarned: millasObtenidas,
      })

      const confirmationData = {
        reservationNumber,
        reservaInfo: storedData.reservaInfo,
        pasajeros: storedData.pasajeros || [],
        customerInfo: {
          name: user.name,
          email: user.email,
          phone: user.phone,
          address: user.address || "",
          passport: user.travelDocuments?.passport || "",
        },
        metodosPago: metodosPago.map((m, i) => ({
          tipo: m.tipo,
          monto: m.monto,
          metodoPagoId: metodosRegistrados[i]?.metodo_pago_id,
        })),
        items: cartItems,
        totalPrice,
        purchaseDate: new Date().toISOString(),
        pagoInfo: {
          pagos: pagosRealizados,
          millas_obtenidas: millasObtenidas,
          total_pagos: pagosRealizados.length,
        },
        financiamientoInfo: financiamientoInfo,
      }

      localStorage.setItem("lastPurchase", JSON.stringify(confirmationData))
      localStorage.removeItem("itineraryPurchase")
      localStorage.removeItem("currentItineraryPurchase")

      const descripcionToast = usarFinanciamiento && financiamientoInfo
        ? `Plan de ${numeroCuotas} cuotas creado. Pagarás $${(totalPrice / parseInt(numeroCuotas)).toFixed(2)}/mes. Sin intereses.`
        : `${pagosRealizados.length} método(s) procesado(s). Has ganado ${millasObtenidas} millas`

      const tituloToast = usarFinanciamiento ? "¡Financiamiento creado!" : "¡Pago exitoso!"

      toast({
        title: tituloToast,
        description: descripcionToast,
      })

      router.push(`/clientes/confirmacion?reservation=${reservationNumber}`)
    } catch (error: any) {
      console.error("Error al procesar pago:", error)
      toast({
        title: "Error",
        description: "No se pudo procesar el pago. Por favor intenta nuevamente.",
        variant: "destructive",
      })
    }
  }

  return (
    <div className="min-h-screen bg-background py-12">
      <div className="container mx-auto px-4 lg:px-8">
        <div className="max-w-6xl mx-auto">
          <div className="mb-6">
            <Button variant="ghost" onClick={() => router.push(`/clientes/itinerario/comprar/${params.id}`)} className="gap-2">
              <ArrowLeft className="h-4 w-4" />
              Volver
            </Button>
          </div>

          <h1 className="text-3xl font-bold mb-8">Finalizar Compra</h1>

          <form onSubmit={handleSubmit}>
            <div className="grid gap-8 lg:grid-cols-3">
              <div className="lg:col-span-2 space-y-6">
                <Card>
                  <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                      <User className="h-5 w-5" />
                      Información Personal
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="space-y-2">
                      <Label>Nombre Completo</Label>
                      <Input value={user.name} disabled />
                    </div>
                    <div className="space-y-2">
                      <Label className="flex items-center gap-2">
                        <Mail className="h-4 w-4" />
                        Email
                      </Label>
                      <Input value={user.email} disabled />
                    </div>
                    <div className="space-y-2">
                      <Label className="flex items-center gap-2">
                        <Phone className="h-4 w-4" />
                        Teléfono
                      </Label>
                      <Input value={user.phone} disabled />
                    </div>
                    <div className="space-y-2">
                      <Label className="flex items-center gap-2">
                        <MapPin className="h-4 w-4" />
                        Dirección
                      </Label>
                      <Input value={user.address} disabled />
                    </div>
                  </CardContent>
                </Card>

                {/* Sección de Financiamiento */}
                <Card>
                  <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                      <CreditCard className="h-5 w-5" />
                      Opciones de Pago
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="flex items-center space-x-2">
                      <Checkbox
                        id="financiamiento"
                        checked={usarFinanciamiento}
                        onCheckedChange={(checked) => setUsarFinanciamiento(checked as boolean)}
                      />
                      <label
                        htmlFor="financiamiento"
                        className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                      >
                        Financiar esta compra (pagar en cuotas)
                      </label>
                    </div>

                    {usarFinanciamiento && (
                      <div className="space-y-4 pt-4 border-t">
                        <div className="bg-blue-50 dark:bg-blue-950 p-4 rounded-lg border border-blue-200 dark:border-blue-800">
                          <p className="text-sm text-blue-900 dark:text-blue-100 mb-2">
                            ℹ️ <strong>Pago con financiamiento:</strong> No pagarás ahora. Solo necesitas registrar un método de pago para
                            las cuotas mensuales.
                          </p>
                        </div>

                        <div className="space-y-2">
                          <Label htmlFor="cuotas">Número de cuotas mensuales</Label>
                          <Select value={numeroCuotas} onValueChange={setNumeroCuotas}>
                            <SelectTrigger id="cuotas">
                              <SelectValue placeholder="Selecciona las cuotas" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="3">3 meses (${(totalPrice / 3).toFixed(2)}/mes)</SelectItem>
                              <SelectItem value="6">6 meses (${(totalPrice / 6).toFixed(2)}/mes)</SelectItem>
                              <SelectItem value="9">9 meses (${(totalPrice / 9).toFixed(2)}/mes)</SelectItem>
                              <SelectItem value="12">12 meses (${(totalPrice / 12).toFixed(2)}/mes)</SelectItem>
                              <SelectItem value="18">18 meses (${(totalPrice / 18).toFixed(2)}/mes)</SelectItem>
                              <SelectItem value="24">24 meses (${(totalPrice / 24).toFixed(2)}/mes)</SelectItem>
                            </SelectContent>
                          </Select>
                          <p className="text-xs text-muted-foreground">
                            💳 Pagarás <span className="font-semibold">${(totalPrice / parseInt(numeroCuotas)).toFixed(2)}</span> por mes
                            durante {numeroCuotas} meses. Sin intereses.
                          </p>
                        </div>
                      </div>
                    )}
                  </CardContent>
                </Card>

                {/* Métodos de Pago - Solo mostrar si NO usa financiamiento O si usa financiamiento (para registrar método) */}
                <SelectorMetodosPagoMultiple
                  metodos={metodosPago}
                  totalRequerido={usarFinanciamiento ? 0 : totalPrice}
                  onChange={setMetodosPago}
                />
              </div>

              <div className="lg:col-span-1">
                <Card className="sticky top-20">
                  <CardHeader>
                    <CardTitle>Resumen del Pedido</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="space-y-3">
                      <div className="flex justify-between text-sm">
                        <span className="text-muted-foreground">Itinerario: {itinerary.name}</span>
                      </div>
                      <div className="flex justify-between text-sm">
                        <span className="text-muted-foreground">{itinerary.items.length} servicios</span>
                      </div>
                    </div>
                    <div className="border-t pt-4 space-y-2">
                      <div className="flex justify-between">
                        <span className="text-muted-foreground">Subtotal</span>
                        <span className="font-semibold">
                          {convertedTotal.symbol}
                          {convertedTotal.value.toLocaleString()}
                        </span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-muted-foreground">Impuestos</span>
                        <span className="font-semibold">Incluidos</span>
                      </div>
                      <div className="border-t pt-2 flex justify-between">
                        <span className="font-bold text-lg">Total</span>
                        <span className="font-bold text-lg text-primary">
                          {convertedTotal.symbol}
                          {convertedTotal.value.toLocaleString()}
                        </span>
                      </div>
                    </div>
                    <Button type="submit" className="w-full" size="lg">
                      Confirmar y Pagar
                    </Button>
                  </CardContent>
                </Card>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  )
}
