"use client"

import type React from "react"

import { useState, useEffect } from "react"
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { useToast } from "@/hooks/use-toast"

type Vuelo = {
  id: string
  numero: string
  origen: string
  destino: string
  fecha: string
  asientosTotal: number
  asientosDisponibles: number
}

type Crucero = {
  id: string
  nombre: string
  ruta: string
  fechaSalida: string
  capacidadTotal: number
  capacidadDisponible: number
}

type Tour = {
  id: string
  nombre: string
  destino: string
  fecha: string
  capacidadTotal: number
  capacidadDisponible: number
}

type Aerolinea = {
  id: string
  nombre: string
  direccion: string
  telefono: string
  correo: string
  fechaFundacion: string
}

type CompaniaCrucero = {
  id: string
  nombre: string
  direccion: string
  telefono: string
  correo: string
  fechaFundacion: string
}

type CompaniaTransporteTerrestre = {
  id: string
  nombre: string
  direccion: string
  telefono: string
  correo: string
  fechaFundacion: string
}

type PaqueteTuristico = {
  id: string
  nombre: string
  descripcion: string
  costo: number
  costoMillas: number
  millasOtorga: number
  tipo: "especial" | "regular"
}

type Promocion = {
  id: string
  tipo: string
  fechaInicio: string
  fechaFin: string
  porcentajeDescuento: number | null
}

type Hotel = {
  id: string
  nombre: string
  direccion: string
  telefono: string
  correo: string
  fechaFundacion: string
}

type InventarioDialogProps = {
  open: boolean
  onOpenChange: (open: boolean) => void
  tipo: "vuelo" | "crucero" | "tour" | "aerolinea" | "compania-crucero" | "compania-transporte" | "paquete" | "promocion" | "hotel"
  item: Vuelo | Crucero | Tour | Aerolinea | CompaniaCrucero | CompaniaTransporteTerrestre | PaqueteTuristico | Promocion | Hotel | null
  onGuardar: (item: Vuelo | Crucero | Tour | Aerolinea | CompaniaCrucero | CompaniaTransporteTerrestre | PaqueteTuristico | Promocion | Hotel) => void
  modoEdicion: boolean
}

export function InventarioDialog({ open, onOpenChange, tipo, item, onGuardar, modoEdicion }: InventarioDialogProps) {
  const [formData, setFormData] = useState<any>({})
  const { toast } = useToast()

  useEffect(() => {
    if (item) {
      setFormData(item)
    } else {
      // Inicializar formulario vacío según el tipo
      if (tipo === "vuelo") {
        setFormData({
          numero: "",
          origen: "",
          destino: "",
          fecha: "",
          asientosTotal: 0,
          asientosDisponibles: 0,
        })
      } else if (tipo === "crucero") {
        setFormData({
          nombre: "",
          ruta: "",
          fechaSalida: "",
          capacidadTotal: 0,
          capacidadDisponible: 0,
        })
      } else if (tipo === "aerolinea") {
        setFormData({
          nombre: "",
          direccion: "",
          telefono: "",
          correo: "",
          fechaFundacion: "",
        })
      } else if (tipo === "hotel") {
        setFormData({
          nombre: "",
          direccion: "",
          telefono: "",
          correo: "",
          fechaFundacion: "",
        })
      } else if (tipo === "compania-crucero") {
        setFormData({
          nombre: "",
          direccion: "",
          telefono: "",
          correo: "",
          fechaFundacion: "",
        })
      } else if (tipo === "compania-transporte") {
        setFormData({
          nombre: "",
          direccion: "",
          telefono: "",
          correo: "",
          fechaFundacion: "",
        })
      } else if (tipo === "paquete") {
        setFormData({
          nombre: "",
          descripcion: "",
          costo: 0,
          costoMillas: 0,
          millasOtorga: 0,
          tipo: "regular",
        })
      } else if (tipo === "promocion") {
        setFormData({
          tipo: "",
          fechaInicio: "",
          fechaFin: "",
          porcentajeDescuento: null,
        })
      } else {
        setFormData({
          nombre: "",
          destino: "",
          fecha: "",
          capacidadTotal: 0,
          capacidadDisponible: 0,
        })
      }
    }
  }, [item, tipo, open])

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    
    // Validaciones específicas para promociones
    if (tipo === "promocion") {
      const hoy = new Date()
      hoy.setHours(0, 0, 0, 0) // Resetear horas para comparar solo fechas
      
      const fechaInicio = formData.fechaInicio ? new Date(formData.fechaInicio) : null
      const fechaFin = formData.fechaFin ? new Date(formData.fechaFin) : null
      
      // Validar que la fecha de inicio no sea pasada
      if (fechaInicio && fechaInicio < hoy) {
        toast({
          title: "Error de validación",
          description: "La fecha de inicio no puede ser una fecha pasada",
          variant: "destructive",
        })
        return
      }
      
      // Validar que la fecha fin no sea antes de la fecha de inicio
      if (fechaInicio && fechaFin && fechaFin < fechaInicio) {
        toast({
          title: "Error de validación",
          description: "La fecha de fin no puede ser anterior a la fecha de inicio",
          variant: "destructive",
        })
        return
      }
    }
    
    onGuardar(formData)
  }

  const handleChange = (field: string, value: string | number | null) => {
    setFormData({ ...formData, [field]: value })
  }

  const getTitulo = () => {
    const tipos: Record<string, string> = {
      vuelo: "Vuelo",
      crucero: "Crucero",
      tour: "Tour",
      hotel: "Hotel",
      aerolinea: "Aerolínea",
      "compania-crucero": "Compañía de Crucero",
      "compania-transporte": "Compañía de Transporte Terrestre",
      paquete: "Paquete Turístico",
      promocion: "Promoción",
    }
    const nombreTipo = tipos[tipo] || "Elemento"
    if (modoEdicion) {
      return `Editar ${nombreTipo}`
    }
    return `Agregar ${nombreTipo}`
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>{getTitulo()}</DialogTitle>
          <DialogDescription>
            {modoEdicion ? "Modifica los datos del elemento" : "Completa los datos para agregar un nuevo elemento"}
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          {tipo === "vuelo" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="numero">Número de Vuelo</Label>
                <Input
                  id="numero"
                  value={formData.numero || ""}
                  onChange={(e) => handleChange("numero", e.target.value)}
                  placeholder="VU-101"
                  required
                />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="origen">Origen</Label>
                  <Input
                    id="origen"
                    value={formData.origen || ""}
                    onChange={(e) => handleChange("origen", e.target.value)}
                    placeholder="Caracas"
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="destino">Destino</Label>
                  <Input
                    id="destino"
                    value={formData.destino || ""}
                    onChange={(e) => handleChange("destino", e.target.value)}
                    placeholder="Miami"
                    required
                  />
                </div>
              </div>
              <div className="space-y-2">
                <Label htmlFor="fecha">Fecha de Salida</Label>
                <Input
                  id="fecha"
                  type="date"
                  value={formData.fecha || ""}
                  onChange={(e) => handleChange("fecha", e.target.value)}
                  required
                />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="asientosTotal">Asientos Totales</Label>
                  <Input
                    id="asientosTotal"
                    type="number"
                    value={formData.asientosTotal || 0}
                    onChange={(e) => handleChange("asientosTotal", Number.parseInt(e.target.value))}
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="asientosDisponibles">Asientos Disponibles</Label>
                  <Input
                    id="asientosDisponibles"
                    type="number"
                    value={formData.asientosDisponibles || 0}
                    onChange={(e) => handleChange("asientosDisponibles", Number.parseInt(e.target.value))}
                    required
                  />
                </div>
              </div>
            </>
          )}

          {tipo === "crucero" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="nombre">Nombre del Crucero</Label>
                <Input
                  id="nombre"
                  value={formData.nombre || ""}
                  onChange={(e) => handleChange("nombre", e.target.value)}
                  placeholder="Caribbean Dream"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="ruta">Ruta</Label>
                <Input
                  id="ruta"
                  value={formData.ruta || ""}
                  onChange={(e) => handleChange("ruta", e.target.value)}
                  placeholder="Caribe Oriental"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="fechaSalida">Fecha de Salida</Label>
                <Input
                  id="fechaSalida"
                  type="date"
                  value={formData.fechaSalida || ""}
                  onChange={(e) => handleChange("fechaSalida", e.target.value)}
                  required
                />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="capacidadTotal">Capacidad Total</Label>
                  <Input
                    id="capacidadTotal"
                    type="number"
                    value={formData.capacidadTotal || 0}
                    onChange={(e) => handleChange("capacidadTotal", Number.parseInt(e.target.value))}
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="capacidadDisponible">Capacidad Disponible</Label>
                  <Input
                    id="capacidadDisponible"
                    type="number"
                    value={formData.capacidadDisponible || 0}
                    onChange={(e) => handleChange("capacidadDisponible", Number.parseInt(e.target.value))}
                    required
                  />
                </div>
              </div>
            </>
          )}

          {tipo === "tour" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="nombre">Nombre del Tour</Label>
                <Input
                  id="nombre"
                  value={formData.nombre || ""}
                  onChange={(e) => handleChange("nombre", e.target.value)}
                  placeholder="Tour Machu Picchu"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="destino">Destino</Label>
                <Input
                  id="destino"
                  value={formData.destino || ""}
                  onChange={(e) => handleChange("destino", e.target.value)}
                  placeholder="Perú"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="fecha">Fecha de Salida</Label>
                <Input
                  id="fecha"
                  type="date"
                  value={formData.fecha || ""}
                  onChange={(e) => handleChange("fecha", e.target.value)}
                  required
                />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="capacidadTotal">Capacidad Total</Label>
                  <Input
                    id="capacidadTotal"
                    type="number"
                    value={formData.capacidadTotal || 0}
                    onChange={(e) => handleChange("capacidadTotal", Number.parseInt(e.target.value))}
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="capacidadDisponible">Capacidad Disponible</Label>
                  <Input
                    id="capacidadDisponible"
                    type="number"
                    value={formData.capacidadDisponible || 0}
                    onChange={(e) => handleChange("capacidadDisponible", Number.parseInt(e.target.value))}
                    required
                  />
                </div>
              </div>
            </>
          )}

          {/* Formulario Aerolínea */}
          {tipo === "aerolinea" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="nombre">Nombre</Label>
                <Input
                  id="nombre"
                  value={formData.nombre || ""}
                  onChange={(e) => handleChange("nombre", e.target.value)}
                  placeholder="Nombre de la aerolínea"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="direccion">Dirección</Label>
                <Input
                  id="direccion"
                  value={formData.direccion || ""}
                  onChange={(e) => handleChange("direccion", e.target.value)}
                  placeholder="Dirección completa"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="telefono">Teléfono</Label>
                <Input
                  id="telefono"
                  type="tel"
                  value={formData.telefono || ""}
                  onChange={(e) => handleChange("telefono", e.target.value)}
                  placeholder="+58 412-555-0100"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="correo">Correo</Label>
                <Input
                  id="correo"
                  type="email"
                  value={formData.correo || ""}
                  onChange={(e) => handleChange("correo", e.target.value)}
                  placeholder="contacto@aerolinea.com"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="fechaFundacion">Fecha de Fundación</Label>
                <Input
                  id="fechaFundacion"
                  type="date"
                  value={formData.fechaFundacion || ""}
                  onChange={(e) => handleChange("fechaFundacion", e.target.value)}
                  required
                />
              </div>
            </>
          )}

          {/* Formulario Hotel */}
          {tipo === "hotel" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="nombre">Nombre</Label>
                <Input
                  id="nombre"
                  value={formData.nombre || ""}
                  onChange={(e) => handleChange("nombre", e.target.value)}
                  placeholder="Nombre del hotel"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="direccion">Dirección</Label>
                <Input
                  id="direccion"
                  value={formData.direccion || ""}
                  onChange={(e) => handleChange("direccion", e.target.value)}
                  placeholder="Dirección completa"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="telefono">Teléfono</Label>
                <Input
                  id="telefono"
                  type="tel"
                  value={formData.telefono || ""}
                  onChange={(e) => handleChange("telefono", e.target.value)}
                  placeholder="+58 412-555-0100"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="correo">Correo</Label>
                <Input
                  id="correo"
                  type="email"
                  value={formData.correo || ""}
                  onChange={(e) => handleChange("correo", e.target.value)}
                  placeholder="contacto@hotel.com"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="fechaFundacion">Fecha de Fundación</Label>
                <Input
                  id="fechaFundacion"
                  type="date"
                  value={formData.fechaFundacion || ""}
                  onChange={(e) => handleChange("fechaFundacion", e.target.value)}
                  required
                />
              </div>
            </>
          )}

          {/* Formulario Compañía de Crucero */}
          {tipo === "compania-crucero" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="nombre">Nombre</Label>
                <Input
                  id="nombre"
                  value={formData.nombre || ""}
                  onChange={(e) => handleChange("nombre", e.target.value)}
                  placeholder="Nombre de la compañía"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="direccion">Dirección</Label>
                <Input
                  id="direccion"
                  value={formData.direccion || ""}
                  onChange={(e) => handleChange("direccion", e.target.value)}
                  placeholder="Dirección completa"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="telefono">Teléfono</Label>
                <Input
                  id="telefono"
                  type="tel"
                  value={formData.telefono || ""}
                  onChange={(e) => handleChange("telefono", e.target.value)}
                  placeholder="+58 412-555-0100"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="correo">Correo</Label>
                <Input
                  id="correo"
                  type="email"
                  value={formData.correo || ""}
                  onChange={(e) => handleChange("correo", e.target.value)}
                  placeholder="contacto@cruceros.com"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="fechaFundacion">Fecha de Fundación</Label>
                <Input
                  id="fechaFundacion"
                  type="date"
                  value={formData.fechaFundacion || ""}
                  onChange={(e) => handleChange("fechaFundacion", e.target.value)}
                  required
                />
              </div>
            </>
          )}

          {/* Formulario Compañía de Transporte Terrestre */}
          {tipo === "compania-transporte" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="nombre">Nombre</Label>
                <Input
                  id="nombre"
                  value={formData.nombre || ""}
                  onChange={(e) => handleChange("nombre", e.target.value)}
                  placeholder="Nombre de la compañía"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="direccion">Dirección</Label>
                <Input
                  id="direccion"
                  value={formData.direccion || ""}
                  onChange={(e) => handleChange("direccion", e.target.value)}
                  placeholder="Dirección completa"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="telefono">Teléfono</Label>
                <Input
                  id="telefono"
                  type="tel"
                  value={formData.telefono || ""}
                  onChange={(e) => handleChange("telefono", e.target.value)}
                  placeholder="+58 412-555-0100"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="correo">Correo</Label>
                <Input
                  id="correo"
                  type="email"
                  value={formData.correo || ""}
                  onChange={(e) => handleChange("correo", e.target.value)}
                  placeholder="contacto@transporte.com"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="fechaFundacion">Fecha de Fundación</Label>
                <Input
                  id="fechaFundacion"
                  type="date"
                  value={formData.fechaFundacion || ""}
                  onChange={(e) => handleChange("fechaFundacion", e.target.value)}
                  required
                />
              </div>
            </>
          )}

          {/* Formulario Paquete Turístico */}
          {tipo === "paquete" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="nombre">Nombre</Label>
                <Input
                  id="nombre"
                  value={formData.nombre || ""}
                  onChange={(e) => handleChange("nombre", e.target.value)}
                  placeholder="Nombre del paquete"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="descripcion">Descripción</Label>
                <Textarea
                  id="descripcion"
                  value={formData.descripcion || ""}
                  onChange={(e) => handleChange("descripcion", e.target.value)}
                  placeholder="Descripción del paquete turístico"
                  rows={4}
                  required
                />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="costo">Costo</Label>
                  <Input
                    id="costo"
                    type="number"
                    step="0.01"
                    value={formData.costo || 0}
                    onChange={(e) => handleChange("costo", Number.parseFloat(e.target.value))}
                    placeholder="0.00"
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="costoMillas">Costo en Millas</Label>
                  <Input
                    id="costoMillas"
                    type="number"
                    value={formData.costoMillas || 0}
                    onChange={(e) => handleChange("costoMillas", Number.parseInt(e.target.value))}
                    placeholder="0"
                    required
                  />
                </div>
              </div>
              <div className="space-y-2">
                <Label htmlFor="millasOtorga">Millas que Otorga</Label>
                <Input
                  id="millasOtorga"
                  type="number"
                  value={formData.millasOtorga || 0}
                  onChange={(e) => handleChange("millasOtorga", Number.parseInt(e.target.value))}
                  placeholder="0"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="tipo">Tipo</Label>
                <Select
                  value={formData.tipo || "regular"}
                  onValueChange={(value) => handleChange("tipo", value)}
                >
                  <SelectTrigger id="tipo">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="regular">Regular</SelectItem>
                    <SelectItem value="especial">Especial</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </>
          )}

          {/* Formulario Promoción */}
          {tipo === "promocion" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="tipo">Tipo</Label>
                <Input
                  id="tipo"
                  value={formData.tipo || ""}
                  onChange={(e) => handleChange("tipo", e.target.value)}
                  placeholder="Ej: Navideñas, Temporada Baja, Black Friday, Semana Santa"
                  required
                />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="fechaInicio">Fecha de Inicio</Label>
                  <Input
                    id="fechaInicio"
                    type="date"
                    value={formData.fechaInicio || ""}
                    onChange={(e) => {
                      const nuevaFechaInicio = e.target.value
                      const hoy = new Date()
                      hoy.setHours(0, 0, 0, 0)
                      
                      // Validar que no sea una fecha pasada
                      if (nuevaFechaInicio && new Date(nuevaFechaInicio) < hoy) {
                        toast({
                          title: "Error de validación",
                          description: "La fecha de inicio no puede ser una fecha pasada",
                          variant: "destructive",
                        })
                        return
                      }
                      
                      // Si la fecha fin es anterior a la nueva fecha inicio, resetearla
                      if (formData.fechaFin && new Date(formData.fechaFin) < new Date(nuevaFechaInicio)) {
                        handleChange("fechaFin", "")
                        toast({
                          title: "Fecha de fin actualizada",
                          description: "La fecha de fin se ha reseteado porque era anterior a la nueva fecha de inicio",
                        })
                      }
                      
                      handleChange("fechaInicio", nuevaFechaInicio)
                    }}
                    min={new Date().toISOString().split('T')[0]} // No permitir fechas pasadas
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="fechaFin">Fecha de Fin</Label>
                  <Input
                    id="fechaFin"
                    type="date"
                    value={formData.fechaFin || ""}
                    onChange={(e) => {
                      const nuevaFechaFin = e.target.value
                      // Si la nueva fecha fin es anterior a la fecha inicio, no permitir el cambio
                      if (formData.fechaInicio && nuevaFechaFin && new Date(nuevaFechaFin) < new Date(formData.fechaInicio)) {
                        toast({
                          title: "Error de validación",
                          description: "La fecha de fin no puede ser anterior a la fecha de inicio",
                          variant: "destructive",
                        })
                        return
                      }
                      handleChange("fechaFin", nuevaFechaFin)
                    }}
                    min={formData.fechaInicio || new Date().toISOString().split('T')[0]} // No permitir fechas antes de la fecha de inicio
                    required
                  />
                </div>
              </div>
              <div className="space-y-2">
                <Label htmlFor="porcentajeDescuento">Porcentaje de Descuento (Opcional)</Label>
                <Input
                  id="porcentajeDescuento"
                  type="number"
                  min="0"
                  max="100"
                  value={formData.porcentajeDescuento || ""}
                  onChange={(e) => handleChange("porcentajeDescuento", e.target.value ? Number.parseInt(e.target.value) : null)}
                  placeholder="Ej: 10, 20, 30..."
                />
              </div>
            </>
          )}

          <div className="flex justify-end gap-3 pt-4">
            <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
              Cancelar
            </Button>
            <Button type="submit">{modoEdicion ? "Guardar Cambios" : "Agregar"}</Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}
