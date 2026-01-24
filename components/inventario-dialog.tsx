"use client"

import type React from "react"

import { useState, useEffect } from "react"
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Badge } from "@/components/ui/badge"
import { Plus, Trash2 } from "lucide-react"
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
  numero: string
  descripcion: string
  origen: string
  destino: string
  fechaSalida: string
  fechaLlegada: string
  tarifa?: number
  huellaCarbono?: number
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

type Restriccion = {
  id?: string
  tipo: string
  descripcion: string
}

type Promocion = {
  id: string
  tipo: string
  fechaInicio: string
  fechaFin: string
  porcentajeDescuento: number | null
}

type Hospedaje = {
  id: string
  hotelNombre: string
  hotelId: string
  fechaInicio: string
  fechaFin: string
  cantidadMillas: number
  costo: number
}

type OperadorTuristico = {
  id: string
  nombre: string
  direccion: string
  telefono: string
  correo: string
  fechaFundacion: string
}

type ServicioAdicional = {
  id: string
  nombre: string
  descripcion: string
  costo: number
  tipo: string
}

type InventarioDialogProps = {
  open: boolean
  onOpenChange: (open: boolean) => void
  tipo: "vuelo" | "crucero" | "tour" | "aerolinea" | "compania-crucero" | "compania-transporte" | "paquete" | "hospedaje" | "operador-turistico" | "servicio-adicional"
  item: Vuelo | Crucero | Tour | Aerolinea | CompaniaCrucero | CompaniaTransporteTerrestre | PaqueteTuristico | Hospedaje | OperadorTuristico | ServicioAdicional | null
  onGuardar: (item: Vuelo | Crucero | Tour | Aerolinea | CompaniaCrucero | CompaniaTransporteTerrestre | PaqueteTuristico | Hospedaje | OperadorTuristico | ServicioAdicional) => void
  modoEdicion: boolean
}

export function InventarioDialog({ open, onOpenChange, tipo, item, onGuardar, modoEdicion }: InventarioDialogProps) {
  const [formData, setFormData] = useState<any>({})
  const [paises, setPaises] = useState<any[]>([])
  const [restricciones, setRestricciones] = useState<Restriccion[]>([])
  const [nuevaRestriccion, setNuevaRestriccion] = useState<Restriccion>({ tipo: "", descripcion: "" })
  const { toast } = useToast()

  // Cargar países cuando se abre el diálogo para aerolíneas
  useEffect(() => {
    if (open && tipo === "aerolinea") {
      const cargarPaises = async () => {
        try {
          const res = await fetch("/api/listas-desplegables/paises")
          
          if (!res.ok) {
            console.error("Error al cargar países:", res.status, res.statusText)
            return
          }
          
          const data = await res.json()
          console.log("Datos de países recibidos:", data)
          
          if (data.status === "success" && Array.isArray(data.data)) {
            setPaises(data.data)
          } else {
            console.error("Formato de respuesta inválido:", data)
          }
        } catch (error) {
          console.error("Error cargando países:", error)
          toast({
            title: "Error",
            description: "No se pudieron cargar los países",
            variant: "destructive",
          })
        }
      }
      cargarPaises()
    }
  }, [open, tipo, toast])

  useEffect(() => {
    if (item) {
      console.log("Cargando item existente en formData:", item)
      setFormData(item)
    } else {
      // Limpiar restricciones al abrir para nuevo paquete
      if (tipo === "paquete") {
        setRestricciones([])
      }
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
        const formInicial = {
          nombre: "",
          direccion: "",
          telefono: "",
          correo: "",
          fechaFundacion: "",
          lugarId: undefined,
        }
        console.log("Inicializando formData para aerolínea:", formInicial)
        setFormData(formInicial)
      } else if (tipo === "hospedaje") {
        setFormData({
          hotelNombre: "",
          hotelId: "",
          fechaInicio: "",
          fechaFin: "",
          cantidadMillas: 0,
          costo: 0,
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
      } else if (tipo === "operador-turistico") {
        setFormData({
          nombre: "",
          direccion: "",
          telefono: "",
          correo: "",
          fechaFundacion: "",
        })
      } else if (tipo === "servicio-adicional") {
        setFormData({
          nombre: "",
          descripcion: "",
          costo: 0,
          tipo: "",
        })
      } else {
        setFormData({
          numero: "",
          descripcion: "",
          origen: "",
          destino: "",
          fechaSalida: "",
          fechaLlegada: "",
          tarifa: 0,
        })
      }
    }
  }, [item, tipo, open])

  // Cargar restricciones cuando se edita un paquete especial
  useEffect(() => {
    if (open && tipo === "paquete" && item && item.id) {
      const cargarRestricciones = async () => {
        try {
          const res = await fetch(`/api/restriccion-paquete?paquete_id=${item.id}`)
          if (res.ok) {
            const data = await res.json()
            if (data.status === "success" && Array.isArray(data.data)) {
              setRestricciones(data.data)
            }
          }
        } catch (error) {
          console.error("Error cargando restricciones:", error)
        }
      }
      cargarRestricciones()
    } else if (tipo === "paquete" && !item) {
      setRestricciones([])
    }
  }, [open, tipo, item])

  // Funciones para manejar restricciones
  const handleAgregarRestriccion = () => {
    if (!nuevaRestriccion.tipo || !nuevaRestriccion.descripcion) {
      toast({
        title: "Error",
        description: "Debes completar el tipo y descripción de la restricción",
        variant: "destructive",
      })
      return
    }
    setRestricciones([...restricciones, { ...nuevaRestriccion }])
    setNuevaRestriccion({ tipo: "", descripcion: "" })
  }

  const handleEliminarRestriccion = (index: number) => {
    setRestricciones(restricciones.filter((_, i) => i !== index))
  }

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    
    console.log("=== handleSubmit en InventarioDialog ===")
    console.log("Tipo:", tipo)
    console.log("formData completo:", formData)
    if (tipo === "aerolinea") {
      console.log("lugarId en formData:", formData.lugarId, "Tipo:", typeof formData.lugarId)
      
      // Validar que se haya seleccionado un país
      if (!formData.lugarId) {
        toast({
          title: "Error de validación",
          description: "Debes seleccionar un país para la aerolínea",
          variant: "destructive",
        })
        return
      }
    }
    
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
    
    // Pasar las restricciones junto con los datos del formulario si es paquete
    const dataAGuardar = tipo === "paquete" ? { ...formData, restricciones } : formData
    onGuardar(dataAGuardar)
  }

  const handleChange = (field: string, value: string | number | null) => {
    const nuevoFormData = { ...formData, [field]: value }
    console.log(`=== handleChange ===`)
    console.log(`Campo: ${field}, Valor: ${value}, Tipo: ${typeof value}`)
    console.log("formData actualizado:", nuevoFormData)
    setFormData(nuevoFormData)
  }

  const getTitulo = () => {
    const tipos: Record<string, string> = {
      vuelo: "Vuelo",
      crucero: "Crucero",
      tour: "Traslado",
      hospedaje: "Hospedaje",
      aerolinea: "Aerolínea",
      "compania-crucero": "Compañía de Crucero",
      "compania-transporte": "Compañía de Transporte Terrestre",
      paquete: "Paquete Turístico",
      "operador-turistico": "Operador Turístico",
      "servicio-adicional": "Servicio Adicional",
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
                <Label htmlFor="descripcion">Descripción</Label>
                <Input
                  id="descripcion"
                  value={formData.descripcion || ""}
                  onChange={(e) => handleChange("descripcion", e.target.value)}
                  placeholder="Descripción del traslado"
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
                    placeholder="Ciudad de origen"
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="destino">Destino</Label>
                  <Input
                    id="destino"
                    value={formData.destino || ""}
                    onChange={(e) => handleChange("destino", e.target.value)}
                    placeholder="Ciudad de destino"
                    required
                  />
                </div>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="fechaSalida">Fecha y Hora de Salida</Label>
                  <Input
                    id="fechaSalida"
                    type="datetime-local"
                    value={formData.fechaSalida || ""}
                    onChange={(e) => handleChange("fechaSalida", e.target.value)}
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="fechaLlegada">Fecha y Hora de Llegada</Label>
                  <Input
                    id="fechaLlegada"
                    type="datetime-local"
                    value={formData.fechaLlegada || ""}
                    onChange={(e) => handleChange("fechaLlegada", e.target.value)}
                    required
                  />
                </div>
              </div>
              <div className="space-y-2">
                <Label htmlFor="tarifa">Tarifa</Label>
                <Input
                  id="tarifa"
                  type="number"
                  step="0.01"
                  value={formData.tarifa || 0}
                  onChange={(e) => handleChange("tarifa", Number.parseFloat(e.target.value))}
                  placeholder="0.00"
                />
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
              <div className="space-y-2">
                <Label htmlFor="lugarId">País <span className="text-red-500">*</span></Label>
                <Select
                  value={formData.lugarId?.toString() || ""}
                  onValueChange={(value) => {
                    console.log("=== País seleccionado ===")
                    console.log("Valor string recibido:", value)
                    const lugarIdNumero = Number(value)
                    console.log("Convertido a número:", lugarIdNumero)
                    
                    // Actualizar formData directamente
                    setFormData(prev => {
                      const nuevoFormData = {
                        ...prev,
                        lugarId: lugarIdNumero
                      }
                      console.log("formData actualizado con lugarId:", nuevoFormData)
                      return nuevoFormData
                    })
                  }}
                  disabled={paises.length === 0}
                  required
                >
                  <SelectTrigger id="lugarId">
                    <SelectValue placeholder={paises.length === 0 ? "No hay países disponibles" : "Selecciona un país"} />
                  </SelectTrigger>
                  <SelectContent>
                    {paises.map((pais) => (
                      <SelectItem key={pais.lug_cod} value={pais.lug_cod.toString()}>
                        {pais.lug_nombre}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                {paises.length === 0 && (
                  <p className="text-sm text-muted-foreground">Cargando países...</p>
                )}
              </div>
            </>
          )}

          {/* Formulario Hospedaje (solo lectura - no se usa) */}
          {tipo === "hospedaje" && (
            <>
              <p className="text-muted-foreground text-center py-4">
                Los hospedajes solo pueden visualizarse
              </p>
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

              {/* Restricciones para paquetes especiales */}
              {formData.tipo === "especial" && (
                <div className="space-y-4 p-4 border rounded-lg bg-muted/50">
                  <div className="flex items-center justify-between">
                    <Label className="text-base font-semibold">Restricciones del Paquete</Label>
                    <Badge variant="secondary">{restricciones.length} restricción(es)</Badge>
                  </div>

                  {/* Formulario para agregar nueva restricción */}
                  <div className="space-y-3 p-3 border rounded bg-background">
                    <Label className="text-sm font-medium">Agregar Restricción</Label>
                    <div className="space-y-2">
                      <Select
                        value={nuevaRestriccion.tipo}
                        onValueChange={(value) => setNuevaRestriccion({ ...nuevaRestriccion, tipo: value })}
                      >
                        <SelectTrigger>
                          <SelectValue placeholder="Selecciona el tipo de restricción" />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="Edad">Edad</SelectItem>
                          <SelectItem value="Estado Civil">Estado Civil</SelectItem>
                        </SelectContent>
                      </Select>
                      <Textarea
                        placeholder="Descripción detallada de la restricción"
                        value={nuevaRestriccion.descripcion}
                        onChange={(e) => setNuevaRestriccion({ ...nuevaRestriccion, descripcion: e.target.value })}
                        rows={2}
                      />
                      <Button
                        type="button"
                        size="sm"
                        className="w-full"
                        onClick={handleAgregarRestriccion}
                      >
                        <Plus className="h-4 w-4 mr-2" />
                        Agregar Restricción
                      </Button>
                    </div>
                  </div>

                  {/* Lista de restricciones */}
                  {restricciones.length > 0 && (
                    <div className="space-y-2">
                      <Label className="text-sm font-medium">Restricciones Agregadas</Label>
                      {restricciones.map((restriccion, index) => (
                        <div key={index} className="p-3 border rounded bg-background space-y-1">
                          <div className="flex items-start justify-between">
                            <div className="flex-1">
                              <p className="font-medium text-sm">{restriccion.tipo}</p>
                              <p className="text-sm text-muted-foreground">{restriccion.descripcion}</p>
                            </div>
                            <Button
                              type="button"
                              variant="ghost"
                              size="sm"
                              onClick={() => handleEliminarRestriccion(index)}
                              className="text-destructive hover:text-destructive"
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              )}
            </>
          )}

          {/* Formulario Operador Turístico */}
          {tipo === "operador-turistico" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="nombre">Nombre</Label>
                <Input
                  id="nombre"
                  value={formData.nombre || ""}
                  onChange={(e) => handleChange("nombre", e.target.value)}
                  placeholder="Nombre del operador turístico"
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
                  placeholder="contacto@operadorturistico.com"
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

          {/* Formulario Servicio Adicional */}
          {tipo === "servicio-adicional" && (
            <>
              <div className="space-y-2">
                <Label htmlFor="nombre">Nombre</Label>
                <Input
                  id="nombre"
                  value={formData.nombre || ""}
                  onChange={(e) => handleChange("nombre", e.target.value)}
                  placeholder="Nombre del servicio"
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="descripcion">Descripción</Label>
                <Textarea
                  id="descripcion"
                  value={formData.descripcion || ""}
                  onChange={(e) => handleChange("descripcion", e.target.value)}
                  placeholder="Descripción del servicio adicional"
                  rows={4}
                  required
                />
              </div>
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
                <Label htmlFor="tipo">Tipo</Label>
                <Input
                  id="tipo"
                  value={formData.tipo || ""}
                  onChange={(e) => handleChange("tipo", e.target.value)}
                  placeholder="Ej: Seguro, Guía, Transporte, etc."
                  required
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
