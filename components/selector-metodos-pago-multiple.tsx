"use client"

import { useState } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Label } from "@/components/ui/label"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { CreditCard, Smartphone, Wallet, DollarSign, Plus, X, CheckCircle } from "lucide-react"
import { Badge } from "@/components/ui/badge"

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

export interface MetodoPagoConMonto {
  id: string
  tipo: TipoMetodoPago
  monto: number
  datos: DatosMetodoPago
}

interface SelectorMetodosPagoMultipleProps {
  metodos: MetodoPagoConMonto[]
  totalRequerido: number
  onChange: (metodos: MetodoPagoConMonto[]) => void
}

export function SelectorMetodosPagoMultiple({ metodos, totalRequerido, onChange }: SelectorMetodosPagoMultipleProps) {
  const agregarMetodo = () => {
    const montoRestante = totalRequerido - metodos.reduce((sum, m) => sum + m.monto, 0)
    onChange([
      ...metodos,
      {
        id: `metodo-${Date.now()}`,
        tipo: "Tarjeta_Credito",
        monto: Math.max(0, montoRestante),
        datos: {},
      },
    ])
  }

  const eliminarMetodo = (id: string) => {
    if (metodos.length > 1) {
      onChange(metodos.filter((m) => m.id !== id))
    }
  }

  const actualizarMetodo = (id: string, campo: keyof MetodoPagoConMonto, valor: any) => {
    onChange(
      metodos.map((m) => {
        if (m.id === id) {
          return { ...m, [campo]: valor }
        }
        return m
      })
    )
  }

  const actualizarDatos = (id: string, datos: DatosMetodoPago) => {
    onChange(
      metodos.map((m) => {
        if (m.id === id) {
          return { ...m, datos }
        }
        return m
      })
    )
  }

  const totalAsignado = metodos.reduce((sum, m) => sum + m.monto, 0)
  const montoRestante = totalRequerido - totalAsignado
  const isComplete = Math.abs(montoRestante) < 0.01 // Tolerancia para decimales

  const renderFormularioMetodo = (metodo: MetodoPagoConMonto) => {
    switch (metodo.tipo) {
      case "Tarjeta_Credito":
      case "Tarjeta_Debito":
        return (
          <div className="space-y-3">
            <div className="space-y-2">
              <Label>
                Número de Tarjeta <span className="text-destructive">*</span>
              </Label>
              <Input
                placeholder="1234 5678 9012 3456"
                value={metodo.datos.numTarjeta || ""}
                onChange={(e) =>
                  actualizarDatos(metodo.id, { ...metodo.datos, numTarjeta: e.target.value.replace(/\s/g, "") })
                }
                maxLength={16}
                required
              />
            </div>
            <div className="grid gap-3 md:grid-cols-2">
              <div className="space-y-2">
                <Label>
                  Fecha Venc. <span className="text-destructive">*</span>
                </Label>
                <Input
                  type="date"
                  value={metodo.datos.fechaVencimiento || ""}
                  onChange={(e) =>
                    actualizarDatos(metodo.id, { ...metodo.datos, fechaVencimiento: e.target.value })
                  }
                  required
                />
              </div>
              <div className="space-y-2">
                <Label>
                  CVV <span className="text-destructive">*</span>
                </Label>
                <Input
                  placeholder="123"
                  value={metodo.datos.codSeguridad || ""}
                  onChange={(e) => actualizarDatos(metodo.id, { ...metodo.datos, codSeguridad: e.target.value })}
                  maxLength={3}
                  required
                />
              </div>
            </div>
            <div className="space-y-2">
              <Label>
                Nombre del Titular <span className="text-destructive">*</span>
              </Label>
              <Input
                placeholder="JUAN PEREZ"
                value={metodo.datos.nombreTitular || ""}
                onChange={(e) =>
                  actualizarDatos(metodo.id, { ...metodo.datos, nombreTitular: e.target.value.toUpperCase() })
                }
                required
              />
            </div>
            <div className="grid gap-3 md:grid-cols-2">
              <div className="space-y-2">
                <Label>Banco Emisor</Label>
                <Input
                  placeholder="Banco XYZ"
                  value={metodo.datos.emisor || ""}
                  onChange={(e) => actualizarDatos(metodo.id, { ...metodo.datos, emisor: e.target.value })}
                />
              </div>
              <div className="space-y-2">
                <Label>Marca</Label>
                <Select
                  value={metodo.datos.marca || "Visa"}
                  onValueChange={(value) => actualizarDatos(metodo.id, { ...metodo.datos, marca: value })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Visa">Visa</SelectItem>
                    <SelectItem value="Mastercard">Mastercard</SelectItem>
                    <SelectItem value="American Express">American Express</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </div>
        )

      case "Pago_Movil":
        return (
          <div className="space-y-3">
            <div className="space-y-2">
              <Label>
                Número de Referencia <span className="text-destructive">*</span>
              </Label>
              <Input
                placeholder="123456789012345"
                value={metodo.datos.numReferencia || ""}
                onChange={(e) => actualizarDatos(metodo.id, { ...metodo.datos, numReferencia: e.target.value })}
                maxLength={15}
                required
              />
            </div>
            <div className="space-y-2">
              <Label>
                Banco <span className="text-destructive">*</span>
              </Label>
              <Select
                value={metodo.datos.banco || ""}
                onValueChange={(value) => actualizarDatos(metodo.id, { ...metodo.datos, banco: value })}
              >
                <SelectTrigger>
                  <SelectValue placeholder="Selecciona un banco" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Banco de Venezuela">Banco de Venezuela</SelectItem>
                  <SelectItem value="Banco Provincial">Banco Provincial</SelectItem>
                  <SelectItem value="Banesco">Banesco</SelectItem>
                  <SelectItem value="Banco Mercantil">Banco Mercantil</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
        )

      case "Zelle":
        return (
          <div className="space-y-3">
            <div className="space-y-2">
              <Label>
                Correo/Teléfono Destino <span className="text-destructive">*</span>
              </Label>
              <Input
                placeholder="ejemplo@email.com"
                value={metodo.datos.numCuentaDestino || ""}
                onChange={(e) => actualizarDatos(metodo.id, { ...metodo.datos, numCuentaDestino: e.target.value })}
                required
              />
            </div>
            <div className="space-y-2">
              <Label>
                Número de Referencia <span className="text-destructive">*</span>
              </Label>
              <Input
                placeholder="987654321"
                value={metodo.datos.numReferencia || ""}
                onChange={(e) => actualizarDatos(metodo.id, { ...metodo.datos, numReferencia: e.target.value })}
                required
              />
            </div>
          </div>
        )

      case "PayPal":
      case "Zinli":
        return (
          <div className="space-y-3">
            <div className="space-y-2">
              <Label>
                Número de Confirmación <span className="text-destructive">*</span>
              </Label>
              <Input
                placeholder="12345678901234567890"
                value={metodo.datos.numConfirmacion || ""}
                onChange={(e) => actualizarDatos(metodo.id, { ...metodo.datos, numConfirmacion: e.target.value })}
                maxLength={20}
                required
              />
            </div>
          </div>
        )

      case "Transferencia":
        return (
          <div className="space-y-3">
            <div className="space-y-2">
              <Label>
                Número de Cuenta Destino <span className="text-destructive">*</span>
              </Label>
              <Input
                placeholder="01020123456789012345"
                value={metodo.datos.numCuentaDestino || ""}
                onChange={(e) => actualizarDatos(metodo.id, { ...metodo.datos, numCuentaDestino: e.target.value })}
                required
              />
            </div>
            <div className="space-y-2">
              <Label>
                Banco <span className="text-destructive">*</span>
              </Label>
              <Input
                placeholder="Banco Mercantil"
                value={metodo.datos.banco || ""}
                onChange={(e) => actualizarDatos(metodo.id, { ...metodo.datos, banco: e.target.value })}
                required
              />
            </div>
            <div className="space-y-2">
              <Label>
                Número de Referencia <span className="text-destructive">*</span>
              </Label>
              <Input
                placeholder="987654321"
                value={metodo.datos.numReferencia || ""}
                onChange={(e) => actualizarDatos(metodo.id, { ...metodo.datos, numReferencia: e.target.value })}
                required
              />
            </div>
          </div>
        )

      case "Efectivo":
        return (
          <div className="space-y-3">
            <div className="space-y-2">
              <Label>Tipo de Moneda</Label>
              <Select
                value={metodo.datos.tipoMoneda || "USD"}
                onValueChange={(value) => actualizarDatos(metodo.id, { ...metodo.datos, tipoMoneda: value })}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="USD">USD</SelectItem>
                  <SelectItem value="EUR">EUR</SelectItem>
                  <SelectItem value="VES">VES</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <p className="text-xs text-muted-foreground">Pago al recoger documentos</p>
          </div>
        )

      case "Milla_MP":
        return (
          <div className="space-y-3">
            <p className="text-sm text-muted-foreground">
              Se deducirán ${metodo.monto.toFixed(2)} en millas de tu cuenta
            </p>
          </div>
        )

      default:
        return null
    }
  }

  const getNombreMetodo = (tipo: TipoMetodoPago) => {
    const nombres: Record<TipoMetodoPago, string> = {
      Tarjeta_Credito: "Tarjeta de Crédito",
      Tarjeta_Debito: "Tarjeta de Débito",
      Pago_Movil: "Pago Móvil",
      Zelle: "Zelle",
      PayPal: "PayPal",
      Zinli: "Zinli",
      Transferencia: "Transferencia",
      Efectivo: "Efectivo",
      Milla_MP: "Millas",
    }
    return nombres[tipo]
  }

  return (
    <div className="space-y-6">
      {/* Resumen de Métodos */}
      <Card>
        <CardHeader>
          <CardTitle>Métodos de Pago</CardTitle>
          <CardDescription>
            Puedes dividir el pago en múltiples métodos. Total a pagar: ${totalRequerido.toFixed(2)}
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {/* Indicador de Progreso */}
            <div className="space-y-2">
              <div className="flex items-center justify-between text-sm">
                <span className="text-muted-foreground">Total asignado:</span>
                <span className={`font-bold ${isComplete ? "text-green-600" : "text-orange-600"}`}>
                  ${totalAsignado.toFixed(2)}
                </span>
              </div>
              <div className="flex items-center justify-between text-sm">
                <span className="text-muted-foreground">Monto restante:</span>
                <span className={`font-bold ${isComplete ? "text-green-600" : "text-orange-600"}`}>
                  ${montoRestante.toFixed(2)}
                </span>
              </div>
              <div className="h-2 bg-muted rounded-full overflow-hidden">
                <div
                  className={`h-full transition-all ${isComplete ? "bg-green-500" : "bg-orange-500"}`}
                  style={{ width: `${Math.min((totalAsignado / totalRequerido) * 100, 100)}%` }}
                />
              </div>
              {isComplete && (
                <div className="flex items-center gap-2 text-sm text-green-600">
                  <CheckCircle className="h-4 w-4" />
                  <span>Total completo</span>
                </div>
              )}
            </div>

            {/* Botón Agregar Método */}
            <Button
              type="button"
              variant="outline"
              onClick={agregarMetodo}
              className="w-full gap-2"
              disabled={metodos.length >= 5}
            >
              <Plus className="h-4 w-4" />
              Agregar Método de Pago
            </Button>
          </div>
        </CardContent>
      </Card>

      {/* Formularios de Métodos */}
      {metodos.map((metodo, index) => (
        <Card key={metodo.id}>
          <CardHeader>
            <div className="flex items-center justify-between">
              <div>
                <CardTitle className="text-lg">Método {index + 1}</CardTitle>
                <CardDescription>Asigna un monto para este método de pago</CardDescription>
              </div>
              {metodos.length > 1 && (
                <Button
                  type="button"
                  variant="ghost"
                  size="sm"
                  onClick={() => eliminarMetodo(metodo.id)}
                  className="h-8 w-8 p-0"
                >
                  <X className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="space-y-4">
            {/* Monto Asignado */}
            <div className="space-y-2">
              <Label>
                Monto a Pagar con este Método <span className="text-destructive">*</span>
              </Label>
              <div className="relative">
                <span className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground">$</span>
                <Input
                  type="number"
                  step="0.01"
                  min="0"
                  max={totalRequerido}
                  value={metodo.monto}
                  onChange={(e) => actualizarMetodo(metodo.id, "monto", parseFloat(e.target.value) || 0)}
                  className="pl-7"
                  required
                />
              </div>
              <div className="flex gap-2">
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => actualizarMetodo(metodo.id, "monto", totalRequerido / metodos.length)}
                >
                  Dividir Equitativo
                </Button>
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => actualizarMetodo(metodo.id, "monto", montoRestante + metodo.monto)}
                >
                  Completar Total
                </Button>
              </div>
            </div>

            {/* Tipo de Método */}
            <div className="space-y-2">
              <Label>
                Tipo de Método de Pago <span className="text-destructive">*</span>
              </Label>
              <Select value={metodo.tipo} onValueChange={(value) => actualizarMetodo(metodo.id, "tipo", value)}>
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Tarjeta_Credito">💳 Tarjeta de Crédito</SelectItem>
                  <SelectItem value="Tarjeta_Debito">💳 Tarjeta de Débito</SelectItem>
                  <SelectItem value="Pago_Movil">📱 Pago Móvil</SelectItem>
                  <SelectItem value="Zelle">💵 Zelle</SelectItem>
                  <SelectItem value="PayPal">🌐 PayPal</SelectItem>
                  <SelectItem value="Zinli">💰 Zinli</SelectItem>
                  <SelectItem value="Transferencia">🏦 Transferencia</SelectItem>
                  <SelectItem value="Efectivo">💵 Efectivo</SelectItem>
                  <SelectItem value="Milla_MP">✈️ Millas</SelectItem>
                </SelectContent>
              </Select>
            </div>

            {/* Formulario Específico del Método */}
            <div className="border-t pt-4">{renderFormularioMetodo(metodo)}</div>
          </CardContent>
        </Card>
      ))}
    </div>
  )
}











