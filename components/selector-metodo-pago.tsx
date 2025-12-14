"use client"

import { useState } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Label } from "@/components/ui/label"
import { Input } from "@/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group"
import { CreditCard, Smartphone, Wallet, DollarSign, Bitcoin, Building } from "lucide-react"

export type TipoMetodoPago =
  | "Tarjeta_Credito"
  | "Tarjeta_Debito"
  | "Pago_Movil"
  | "Zelle"
  | "PayPal"
  | "Zinli"
  | "Transferencia"
  | "Efectivo"
  | "Milla_MP"

export interface DatosMetodoPago {
  // Tarjetas
  numTarjeta?: string
  codSeguridad?: string
  emisor?: string
  marca?: string
  fechaVencimiento?: string
  nombreTitular?: string

  // Pago Móvil
  numReferencia?: string
  banco?: string
  fecha?: string

  // Transferencia/Zelle
  numCuentaDestino?: string

  // PayPal/Zinli/Billetera
  numConfirmacion?: string
  montoBilletera?: string

  // Efectivo
  tipoMoneda?: string
}

interface SelectorMetodoPagoProps {
  tipoSeleccionado: TipoMetodoPago
  datos: DatosMetodoPago
  onTipoChange: (tipo: TipoMetodoPago) => void
  onDatosChange: (datos: DatosMetodoPago) => void
}

export function SelectorMetodoPago({
  tipoSeleccionado,
  datos,
  onTipoChange,
  onDatosChange,
}: SelectorMetodoPagoProps) {
  const actualizarDato = (campo: keyof DatosMetodoPago, valor: string) => {
    onDatosChange({
      ...datos,
      [campo]: valor,
    })
  }

  const renderFormulario = () => {
    switch (tipoSeleccionado) {
      case "Tarjeta_Credito":
      case "Tarjeta_Debito":
        return (
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="numTarjeta">
                Número de Tarjeta <span className="text-destructive">*</span>
              </Label>
              <Input
                id="numTarjeta"
                placeholder="1234 5678 9012 3456"
                value={datos.numTarjeta || ""}
                onChange={(e) => actualizarDato("numTarjeta", e.target.value.replace(/\s/g, ""))}
                maxLength={16}
                required
              />
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="fechaVencimiento">
                  Fecha de Vencimiento <span className="text-destructive">*</span>
                </Label>
                <Input
                  id="fechaVencimiento"
                  type="date"
                  value={datos.fechaVencimiento || ""}
                  onChange={(e) => actualizarDato("fechaVencimiento", e.target.value)}
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="codSeguridad">
                  CVV <span className="text-destructive">*</span>
                </Label>
                <Input
                  id="codSeguridad"
                  placeholder="123"
                  value={datos.codSeguridad || ""}
                  onChange={(e) => actualizarDato("codSeguridad", e.target.value)}
                  maxLength={3}
                  required
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="nombreTitular">
                Nombre del Titular <span className="text-destructive">*</span>
              </Label>
              <Input
                id="nombreTitular"
                placeholder="JUAN PEREZ"
                value={datos.nombreTitular || ""}
                onChange={(e) => actualizarDato("nombreTitular", e.target.value.toUpperCase())}
                required
              />
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="emisor">Banco Emisor</Label>
                <Input
                  id="emisor"
                  placeholder="Banco XYZ"
                  value={datos.emisor || ""}
                  onChange={(e) => actualizarDato("emisor", e.target.value)}
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="marca">Marca</Label>
                <Select value={datos.marca || "Visa"} onValueChange={(value) => actualizarDato("marca", value)}>
                  <SelectTrigger id="marca">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Visa">Visa</SelectItem>
                    <SelectItem value="Mastercard">Mastercard</SelectItem>
                    <SelectItem value="American Express">American Express</SelectItem>
                    <SelectItem value="Discover">Discover</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </div>
        )

      case "Pago_Movil":
        return (
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="numReferencia">
                Número de Referencia <span className="text-destructive">*</span>
              </Label>
              <Input
                id="numReferencia"
                placeholder="123456789012345"
                value={datos.numReferencia || ""}
                onChange={(e) => actualizarDato("numReferencia", e.target.value)}
                maxLength={15}
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="banco">
                Banco <span className="text-destructive">*</span>
              </Label>
              <Select value={datos.banco || ""} onValueChange={(value) => actualizarDato("banco", value)}>
                <SelectTrigger id="banco">
                  <SelectValue placeholder="Selecciona un banco" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Banco de Venezuela">Banco de Venezuela</SelectItem>
                  <SelectItem value="Banco Provincial">Banco Provincial</SelectItem>
                  <SelectItem value="Banesco">Banesco</SelectItem>
                  <SelectItem value="Banco Mercantil">Banco Mercantil</SelectItem>
                  <SelectItem value="Banco Bicentenario">Banco Bicentenario</SelectItem>
                  <SelectItem value="Banco Exterior">Banco Exterior</SelectItem>
                  <SelectItem value="Otro">Otro</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="fecha">Fecha de Transacción</Label>
              <Input
                id="fecha"
                type="date"
                value={datos.fecha || new Date().toISOString().split("T")[0]}
                onChange={(e) => actualizarDato("fecha", e.target.value)}
              />
            </div>
          </div>
        )

      case "Zelle":
        return (
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="numCuentaDestino">
                Correo/Teléfono Destino <span className="text-destructive">*</span>
              </Label>
              <Input
                id="numCuentaDestino"
                placeholder="ejemplo@email.com o +1234567890"
                value={datos.numCuentaDestino || ""}
                onChange={(e) => actualizarDato("numCuentaDestino", e.target.value)}
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="banco">Banco</Label>
              <Input
                id="banco"
                placeholder="Bank of America"
                value={datos.banco || ""}
                onChange={(e) => actualizarDato("banco", e.target.value)}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="numReferencia">
                Número de Referencia/Confirmación <span className="text-destructive">*</span>
              </Label>
              <Input
                id="numReferencia"
                placeholder="987654321"
                value={datos.numReferencia || ""}
                onChange={(e) => actualizarDato("numReferencia", e.target.value)}
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="fecha">Fecha de Transacción</Label>
              <Input
                id="fecha"
                type="date"
                value={datos.fecha || new Date().toISOString().split("T")[0]}
                onChange={(e) => actualizarDato("fecha", e.target.value)}
              />
            </div>
          </div>
        )

      case "PayPal":
      case "Zinli":
        return (
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="numConfirmacion">
                Número de Confirmación <span className="text-destructive">*</span>
              </Label>
              <Input
                id="numConfirmacion"
                placeholder="12345678901234567890"
                value={datos.numConfirmacion || ""}
                onChange={(e) => actualizarDato("numConfirmacion", e.target.value)}
                maxLength={20}
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="montoBilletera">Monto en Billetera</Label>
              <Input
                id="montoBilletera"
                type="number"
                step="0.01"
                placeholder="850.00"
                value={datos.montoBilletera || ""}
                onChange={(e) => actualizarDato("montoBilletera", e.target.value)}
              />
            </div>
          </div>
        )

      case "Transferencia":
        return (
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="numCuentaDestino">
                Número de Cuenta Destino <span className="text-destructive">*</span>
              </Label>
              <Input
                id="numCuentaDestino"
                placeholder="01020123456789012345"
                value={datos.numCuentaDestino || ""}
                onChange={(e) => actualizarDato("numCuentaDestino", e.target.value)}
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="banco">
                Banco <span className="text-destructive">*</span>
              </Label>
              <Input
                id="banco"
                placeholder="Banco Mercantil"
                value={datos.banco || ""}
                onChange={(e) => actualizarDato("banco", e.target.value)}
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="numReferencia">
                Número de Referencia <span className="text-destructive">*</span>
              </Label>
              <Input
                id="numReferencia"
                placeholder="987654321"
                value={datos.numReferencia || ""}
                onChange={(e) => actualizarDato("numReferencia", e.target.value)}
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="fecha">Fecha de Transacción</Label>
              <Input
                id="fecha"
                type="date"
                value={datos.fecha || new Date().toISOString().split("T")[0]}
                onChange={(e) => actualizarDato("fecha", e.target.value)}
              />
            </div>
          </div>
        )

      case "Efectivo":
        return (
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="tipoMoneda">Tipo de Moneda</Label>
              <Select
                value={datos.tipoMoneda || "USD"}
                onValueChange={(value) => actualizarDato("tipoMoneda", value)}
              >
                <SelectTrigger id="tipoMoneda">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="USD">Dólares Americanos (USD)</SelectItem>
                  <SelectItem value="EUR">Euros (EUR)</SelectItem>
                  <SelectItem value="VES">Bolívares (VES)</SelectItem>
                  <SelectItem value="COP">Pesos Colombianos (COP)</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <p className="text-sm text-muted-foreground">
              El pago en efectivo se realizará al momento de recoger los documentos de viaje.
            </p>
          </div>
        )

      case "Milla_MP":
        return (
          <div className="space-y-4">
            <p className="text-sm text-muted-foreground">
              Se utilizarán las millas acumuladas de tu cuenta para realizar este pago.
            </p>
            <div className="rounded-lg bg-muted p-4">
              <p className="text-sm font-medium">Nota:</p>
              <p className="text-sm text-muted-foreground">
                Las millas serán deducidas automáticamente de tu saldo al procesar el pago.
              </p>
            </div>
          </div>
        )

      default:
        return null
    }
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <CreditCard className="h-5 w-5" />
          Método de Pago
        </CardTitle>
        <CardDescription>Selecciona cómo deseas pagar</CardDescription>
      </CardHeader>
      <CardContent className="space-y-6">
        <RadioGroup value={tipoSeleccionado} onValueChange={(value) => onTipoChange(value as TipoMetodoPago)}>
          <div className="space-y-3">
            <div className="flex items-center space-x-3 border rounded-lg p-4 hover:border-primary transition-colors">
              <RadioGroupItem value="Tarjeta_Credito" id="tarjeta_credito" />
              <Label htmlFor="tarjeta_credito" className="flex-1 cursor-pointer flex items-center gap-2">
                <CreditCard className="h-4 w-4" />
                <span>Tarjeta de Crédito</span>
              </Label>
            </div>

            <div className="flex items-center space-x-3 border rounded-lg p-4 hover:border-primary transition-colors">
              <RadioGroupItem value="Tarjeta_Debito" id="tarjeta_debito" />
              <Label htmlFor="tarjeta_debito" className="flex-1 cursor-pointer flex items-center gap-2">
                <CreditCard className="h-4 w-4" />
                <span>Tarjeta de Débito</span>
              </Label>
            </div>

            <div className="flex items-center space-x-3 border rounded-lg p-4 hover:border-primary transition-colors">
              <RadioGroupItem value="Pago_Movil" id="pago_movil" />
              <Label htmlFor="pago_movil" className="flex-1 cursor-pointer flex items-center gap-2">
                <Smartphone className="h-4 w-4" />
                <span>Pago Móvil</span>
              </Label>
            </div>

            <div className="flex items-center space-x-3 border rounded-lg p-4 hover:border-primary transition-colors">
              <RadioGroupItem value="Zelle" id="zelle" />
              <Label htmlFor="zelle" className="flex-1 cursor-pointer flex items-center gap-2">
                <DollarSign className="h-4 w-4" />
                <span>Zelle</span>
              </Label>
            </div>

            <div className="flex items-center space-x-3 border rounded-lg p-4 hover:border-primary transition-colors">
              <RadioGroupItem value="PayPal" id="paypal" />
              <Label htmlFor="paypal" className="flex-1 cursor-pointer flex items-center gap-2">
                <Wallet className="h-4 w-4" />
                <span>PayPal</span>
              </Label>
            </div>

            <div className="flex items-center space-x-3 border rounded-lg p-4 hover:border-primary transition-colors">
              <RadioGroupItem value="Zinli" id="zinli" />
              <Label htmlFor="zinli" className="flex-1 cursor-pointer flex items-center gap-2">
                <Wallet className="h-4 w-4" />
                <span>Zinli</span>
              </Label>
            </div>

            <div className="flex items-center space-x-3 border rounded-lg p-4 hover:border-primary transition-colors">
              <RadioGroupItem value="Transferencia" id="transferencia" />
              <Label htmlFor="transferencia" className="flex-1 cursor-pointer flex items-center gap-2">
                <Building className="h-4 w-4" />
                <span>Transferencia Bancaria</span>
              </Label>
            </div>

            <div className="flex items-center space-x-3 border rounded-lg p-4 hover:border-primary transition-colors">
              <RadioGroupItem value="Efectivo" id="efectivo" />
              <Label htmlFor="efectivo" className="flex-1 cursor-pointer flex items-center gap-2">
                <DollarSign className="h-4 w-4" />
                <span>Efectivo</span>
              </Label>
            </div>

            <div className="flex items-center space-x-3 border rounded-lg p-4 hover:border-primary transition-colors">
              <RadioGroupItem value="Milla_MP" id="millas" />
              <Label htmlFor="millas" className="flex-1 cursor-pointer flex items-center gap-2">
                <Bitcoin className="h-4 w-4" />
                <span>Pagar con Millas</span>
              </Label>
            </div>
          </div>
        </RadioGroup>

        <div className="border-t pt-6">{renderFormulario()}</div>
      </CardContent>
    </Card>
  )
}

