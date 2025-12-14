"use client"

import { useEffect, useState } from "react"
import { useSearchParams, useRouter } from "next/navigation"
import { Header } from "@/components/header"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Ticket } from "@/components/ticket"
import { Invoice } from "@/components/invoice"
import { CheckCircle, Download, Home, Mail } from "lucide-react"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import type { CartItem } from "@/lib/cart-context"
import { useUser } from "@/lib/user-context"
import { useToast } from "@/hooks/use-toast"

interface Pasajero {
  primerNombre: string
  segundoNombre?: string
  primerApellido: string
  segundoApellido?: string
  fechaNacimiento: string
  estadoCivil: string
}

interface ReservaInfo {
  reserva_id: number
  numero_reserva: number
  subtotal: number
  total: number
  millas_obtenidas?: number
}

interface MetodoPagoUtilizado {
  tipo: string
  monto: number
  metodoPagoId: number
}

interface PurchaseData {
  reservationNumber: string
  reservaInfo?: ReservaInfo
  pasajeros?: Pasajero[]
  metodosPago?: MetodoPagoUtilizado[]
  customerInfo: {
    name: string
    email: string
    phone: string
    address: string
    passport?: string
  }
  items: CartItem[]
  totalPrice: number
  purchaseDate: string
  pagoInfo?: any
}

export default function ConfirmacionPage() {
  const searchParams = useSearchParams()
  const router = useRouter()
  const { user } = useUser()
  const { toast } = useToast()
  const [purchaseData, setPurchaseData] = useState<PurchaseData | null>(null)
  const reservationNumber = searchParams.get("reservation")

  useEffect(() => {
    if (!reservationNumber) {
      router.push("/")
      return
    }

    const storedData = localStorage.getItem("lastPurchase")
    if (storedData) {
      const data = JSON.parse(storedData)
      if (data.reservationNumber === reservationNumber) {
        setPurchaseData({
          ...data,
          customerInfo: {
            ...data.customerInfo,
            passport: user?.travelDocuments?.passport || data.customerInfo.passport,
          },
        })
      } else {
        router.push("/")
      }
    } else {
      router.push("/")
    }
  }, [reservationNumber, router, user])

  const handlePrint = () => {
    window.print()
  }

  const handleDownload = () => {
    window.print()
  }

  const handleSendEmail = () => {
    if (!purchaseData) return

    toast({
      title: "Correo enviado exitosamente",
      description: `La factura y los boletos han sido enviados a ${purchaseData.customerInfo.email}`,
    })
  }

  if (!purchaseData) {
    return (
      <>
        <Header />
        <main className="min-h-screen bg-background flex items-center justify-center">
          <div className="text-center">
            <p className="text-muted-foreground">Cargando información de compra...</p>
          </div>
        </main>
      </>
    )
  }

  return (
    <>
      <Header />
      <main className="min-h-screen bg-background py-12">
        <div className="container mx-auto px-4 lg:px-8">
          <div className="max-w-5xl mx-auto">
            {/* Success Message */}
            <Card className="mb-8 border-2 border-green-500/20 bg-green-50/50 dark:bg-green-950/20">
              <CardContent className="pt-6">
                <div className="flex items-start gap-4">
                  <div className="flex-shrink-0">
                    <CheckCircle className="h-12 w-12 text-green-600 dark:text-green-400" />
                  </div>
                  <div className="flex-1">
                    <h1 className="text-2xl font-bold mb-2">¡Compra Confirmada!</h1>
                    <p className="text-muted-foreground mb-4">
                      Tu reserva ha sido procesada exitosamente. Hemos enviado un correo de confirmación a{" "}
                      <strong>{purchaseData.customerInfo.email}</strong>
                    </p>
                    <div className="flex flex-wrap gap-3">
                      <Button onClick={() => router.push("/")} className="gap-2">
                        <Home className="h-4 w-4" />
                        Volver al Inicio
                      </Button>
                      <Button variant="outline" onClick={handlePrint} className="gap-2 bg-transparent">
                        <Download className="h-4 w-4" />
                        Imprimir
                      </Button>
                      <Button variant="outline" onClick={handleSendEmail} className="gap-2 bg-transparent">
                        <Mail className="h-4 w-4" />
                        Reenviar Email
                      </Button>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Reservation Info */}
            <Card className="mb-8">
              <CardHeader>
                <CardTitle>Información de Reserva</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid gap-4 md:grid-cols-2">
                  <div>
                    <p className="text-sm text-muted-foreground">Número de Reserva</p>
                    <p className="text-xl font-bold font-mono">{purchaseData.reservationNumber}</p>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">Fecha de Compra</p>
                    <p className="text-lg font-semibold">
                      {new Date(purchaseData.purchaseDate).toLocaleDateString("es-ES", {
                        day: "numeric",
                        month: "long",
                        year: "numeric",
                        hour: "2-digit",
                        minute: "2-digit",
                      })}
                    </p>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">Cliente</p>
                    <p className="text-lg font-semibold">{purchaseData.customerInfo.name}</p>
                  </div>
                  {purchaseData.customerInfo.passport && (
                    <div>
                      <p className="text-sm text-muted-foreground">Pasaporte</p>
                      <p className="text-lg font-semibold">{purchaseData.customerInfo.passport}</p>
                    </div>
                  )}
                  <div>
                    <p className="text-sm text-muted-foreground">Total de Servicios</p>
                    <p className="text-lg font-semibold">{purchaseData.items.length}</p>
                  </div>
                  {purchaseData.pagoInfo?.millas_obtenidas && (
                    <div>
                      <p className="text-sm text-muted-foreground">Millas Obtenidas</p>
                      <p className="text-lg font-semibold text-green-600">
                        +{purchaseData.pagoInfo.millas_obtenidas} millas
                      </p>
                    </div>
                  )}
                </div>
              </CardContent>
            </Card>

            {/* Pasajeros Info */}
            {purchaseData.pasajeros && purchaseData.pasajeros.length > 0 && (
              <Card className="mb-8">
                <CardHeader>
                  <CardTitle>Pasajeros Registrados</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {purchaseData.pasajeros.map((pasajero, index) => (
                      <div key={index} className="border rounded-lg p-4">
                        <div className="flex items-center justify-between mb-2">
                          <h4 className="font-semibold">Pasajero {index + 1}</h4>
                          <span className="text-sm text-muted-foreground">{pasajero.estadoCivil}</span>
                        </div>
                        <div className="grid gap-2 md:grid-cols-2">
                          <div>
                            <p className="text-sm text-muted-foreground">Nombre Completo</p>
                            <p className="font-medium">
                              {pasajero.primerNombre} {pasajero.segundoNombre || ""} {pasajero.primerApellido}{" "}
                              {pasajero.segundoApellido || ""}
                            </p>
                          </div>
                          <div>
                            <p className="text-sm text-muted-foreground">Fecha de Nacimiento</p>
                            <p className="font-medium">
                              {new Date(pasajero.fechaNacimiento).toLocaleDateString("es-ES", {
                                day: "numeric",
                                month: "long",
                                year: "numeric",
                              })}
                            </p>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            )}

            {/* Métodos de Pago Utilizados */}
            {purchaseData.metodosPago && purchaseData.metodosPago.length > 0 && (
              <Card className="mb-8">
                <CardHeader>
                  <CardTitle>Métodos de Pago Utilizados</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    {purchaseData.metodosPago.map((metodo, index) => (
                      <div key={index} className="flex items-center justify-between border rounded-lg p-4">
                        <div className="flex items-center gap-3">
                          <div className="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center">
                            <CreditCard className="h-5 w-5 text-primary" />
                          </div>
                          <div>
                            <p className="font-medium">{metodo.tipo.replace(/_/g, " ")}</p>
                            <p className="text-sm text-muted-foreground">ID: {metodo.metodoPagoId}</p>
                          </div>
                        </div>
                        <p className="font-bold text-lg">${metodo.monto.toFixed(2)}</p>
                      </div>
                    ))}
                    <div className="border-t pt-3 flex items-center justify-between">
                      <span className="font-semibold">Total Pagado:</span>
                      <span className="font-bold text-xl text-primary">
                        ${purchaseData.metodosPago.reduce((sum, m) => sum + m.monto, 0).toFixed(2)}
                      </span>
                    </div>
                  </div>
                </CardContent>
              </Card>
            )}

            {/* Tickets and Invoice */}
            <Card className="mt-8">
              <CardHeader className="border-b">
                <CardTitle className="text-2xl">Documentos de Viaje</CardTitle>
              </CardHeader>
              <CardContent className="p-6">
                <Tabs defaultValue="invoice" className="space-y-6">
                  <TabsList className="grid w-full grid-cols-2 h-14 bg-muted">
                    <TabsTrigger
                      value="invoice"
                      className="text-base font-semibold data-[state=active]:bg-primary data-[state=active]:text-primary-foreground"
                    >
                      🧾 Factura
                    </TabsTrigger>
                    <TabsTrigger
                      value="tickets"
                      className="text-base font-semibold data-[state=active]:bg-primary data-[state=active]:text-primary-foreground"
                    >
                      📋 Boletos de Viaje
                    </TabsTrigger>
                  </TabsList>

                  <TabsContent value="invoice" className="space-y-6 mt-6">
                    <Invoice
                      items={purchaseData.items}
                      customerInfo={purchaseData.customerInfo}
                      reservationNumber={purchaseData.reservationNumber}
                      purchaseDate={purchaseData.purchaseDate}
                      totalPrice={purchaseData.totalPrice}
                      onDownload={handleDownload}
                      onEmail={handleSendEmail}
                    />
                  </TabsContent>

                  <TabsContent value="tickets" className="space-y-6 mt-6">
                    <div className="flex items-center justify-between mb-6">
                      <div>
                        <h2 className="text-2xl font-bold">Tus Boletos</h2>
                        <p className="text-muted-foreground">Descarga o imprime tus boletos de viaje</p>
                      </div>
                      <Button onClick={handleDownload} className="gap-2">
                        <Download className="h-4 w-4" />
                        Descargar Todos
                      </Button>
                    </div>
                    {purchaseData.items.map((item) => (
                      <Ticket
                        key={item.id}
                        item={item}
                        customerName={purchaseData.customerInfo.name}
                        reservationNumber={purchaseData.reservationNumber}
                        purchaseDate={purchaseData.purchaseDate}
                      />
                    ))}
                  </TabsContent>
                </Tabs>
              </CardContent>
            </Card>

            {/* Important Information */}
            <Card className="mt-8">
              <CardHeader>
                <CardTitle>Información Importante</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3 text-sm text-muted-foreground">
                <p>
                  <strong>Check-in:</strong> Por favor, llegue al menos 2 horas antes de su vuelo o 1 hora antes para
                  servicios terrestres.
                </p>
                <p>
                  <strong>Documentación:</strong> Asegúrese de llevar su identificación oficial y este boleto de
                  confirmación.
                </p>
                <p>
                  <strong>Cambios y Cancelaciones:</strong> Para modificar o cancelar su reserva, contacte a nuestro
                  servicio al cliente con al menos 48 horas de anticipación.
                </p>
                <p>
                  <strong>Soporte:</strong> Si tiene alguna pregunta, contáctenos en soporte@viajesucab.com o llame al
                  +58 212-555-0100.
                </p>
              </CardContent>
            </Card>
          </div>
        </div>
      </main>
    </>
  )
}
