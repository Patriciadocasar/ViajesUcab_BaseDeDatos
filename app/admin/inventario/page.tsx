"use client"

import { useState, useEffect } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Progress } from "@/components/ui/progress"
import { Plane, Ship, MapPin, AlertTriangle, Plus, Pencil, Trash2, Building2, Car, Package, Hotel, User, Briefcase, UtensilsCrossed } from "lucide-react"
import { InventarioDialog } from "@/components/inventario-dialog"
import { Textarea } from "@/components/ui/textarea"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { useToast } from "@/hooks/use-toast"

type Vuelo = {
  id: string
  numero: string
  origen: string
  destino: string
  fecha: string
  fechaLlegada?: string
  asientosTotal: number
  asientosDisponibles: number
  huellaCarbono?: number
  cantidadMillas?: number
}

type Crucero = {
  id: string
  nombre: string
  ruta: string
  origen?: string
  destino?: string
  fechaSalida: string
  fechaLlegada?: string
  capacidadTotal: number
  capacidadDisponible: number
  huellaCarbono?: number
  cantidadMillas?: number
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
  cantidadMillas?: number
}

type Aerolinea = {
  id: string
  idReal?: string | null
  nombre: string
  direccion: string
  telefono: string
  correo: string
  fechaFundacion: string
  lugarId?: number
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

type Hospedaje = {
  id: string
  hotelNombre: string
  hotelId: string
  fechaInicio: string
  fechaFin: string
  cantidadMillas: number
  costo: number
}

type Restaurante = {
  id: string
  nombre: string
  direccion: string
  clasificacion: string
  lugarId: string
  tipoComida: string
  ambiente: string
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
  cantidadMillas?: number
}

const vuelosDataInicial: Vuelo[] = [
  {
    id: "1",
    numero: "VU-101",
    origen: "Caracas",
    destino: "Miami",
    fecha: "2025-03-25",
    asientosTotal: 180,
    asientosDisponibles: 12,
  },
  {
    id: "2",
    numero: "VU-202",
    origen: "Caracas",
    destino: "Madrid",
    fecha: "2025-03-28",
    asientosTotal: 250,
    asientosDisponibles: 45,
  },
  {
    id: "3",
    numero: "VU-303",
    origen: "Caracas",
    destino: "Cancún",
    fecha: "2025-03-30",
    asientosTotal: 150,
    asientosDisponibles: 3,
  },
]

const crucerosDataInicial: Crucero[] = [
  {
    id: "1",
    nombre: "Caribbean Dream",
    ruta: "Caribe Oriental",
    fechaSalida: "2025-04-10",
    capacidadTotal: 2000,
    capacidadDisponible: 150,
  },
  {
    id: "2",
    nombre: "Ocean Paradise",
    ruta: "Mediterráneo",
    fechaSalida: "2025-05-15",
    capacidadTotal: 3000,
    capacidadDisponible: 800,
  },
  {
    id: "3",
    nombre: "Tropical Explorer",
    ruta: "Caribe Sur",
    fechaSalida: "2025-04-20",
    capacidadTotal: 1500,
    capacidadDisponible: 50,
  },
]

export default function InventarioPage() {
  const { toast } = useToast()
  const [vuelos, setVuelos] = useState<Vuelo[]>([])
  const [cruceros, setCruceros] = useState<Crucero[]>([])
  const [tours, setTours] = useState<Tour[]>([])
  const [aerolineas, setAerolineas] = useState<Aerolinea[]>([])
  const [companiasCrucero, setCompaniasCrucero] = useState<CompaniaCrucero[]>([])
  const [companiasTransporte, setCompaniasTransporte] = useState<CompaniaTransporteTerrestre[]>([])
  const [paquetesTuristicos, setPaquetesTuristicos] = useState<PaqueteTuristico[]>([])
  const [promociones, setPromociones] = useState<Promocion[]>([])
  const [hospedajes, setHospedajes] = useState<Hospedaje[]>([])
  const [restaurantes, setRestaurantes] = useState<Restaurante[]>([])
  const [operadoresTuristicos, setOperadoresTuristicos] = useState<OperadorTuristico[]>([])
  const [serviciosAdicionales, setServiciosAdicionales] = useState<ServicioAdicional[]>([])
  const [isLoadingVuelos, setIsLoadingVuelos] = useState(true)
  const [isLoadingCruceros, setIsLoadingCruceros] = useState(true)
  const [isLoadingTours, setIsLoadingTours] = useState(true)
  const [isLoadingPromociones, setIsLoadingPromociones] = useState(true)
  const [isLoadingCompaniasCrucero, setIsLoadingCompaniasCrucero] = useState(true)
  const [isLoadingCompaniasTransporte, setIsLoadingCompaniasTransporte] = useState(true)
  const [isLoadingHospedajes, setIsLoadingHospedajes] = useState(true)
  const [isLoadingRestaurantes, setIsLoadingRestaurantes] = useState(true)
  const [isLoadingOperadoresTuristicos, setIsLoadingOperadoresTuristicos] = useState(true)
  const [isLoadingServiciosAdicionales, setIsLoadingServiciosAdicionales] = useState(true)
  const [isLoadingPaquetes, setIsLoadingPaquetes] = useState(true)
  const [dialogOpen, setDialogOpen] = useState(false)
  const [tipoActual, setTipoActual] = useState<
    "vuelo" | "crucero" | "tour" | "aerolinea" | "compania-crucero" | "compania-transporte" | "paquete" | "hospedaje" | "operador-turistico" | "servicio-adicional"
  >("vuelo")
  const [itemSeleccionado, setItemSeleccionado] = useState<
    Vuelo | Crucero | Tour | Aerolinea | CompaniaCrucero | CompaniaTransporteTerrestre | PaqueteTuristico | Hospedaje | OperadorTuristico | ServicioAdicional | null
  >(null)
  const [modoEdicion, setModoEdicion] = useState(false)

  // Función helper para mapear vuelos de la base de datos
  const mapearVuelo = (v: any, index: number): Vuelo => {
    const idRaw = v.vue_cod || v.Vue_COD || v.vue_COD || v.Vue_cod || v.id || Object.values(v).find((val: any) => typeof val === 'number' && val > 0)
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    // Generar número de vuelo
    const origen = v.origen || v.Origen || ""
    const destino = v.destino || v.Destino || ""
    const numero = `VU-${id}`
    
    // Guardar la fecha completa con hora (timestamp)
    const fechaSalida = v.vue_fecha_hora_salida || v.Vue_Fecha_Hora_Salida || v.fecha || ""
    const fechaLlegada = v.vue_fecha_hora_llegada || v.Vue_Fecha_Hora_Llegada || ""
    const huellaCarbono = v.vue_huella_carbono || v.Vue_Huella_Carbono || v.VUE_HUELLA_CARBONO || 0
    const cantidadMillas = v.vue_cant_millas || v.Vue_Cant_Millas || v.VUE_CANT_MILLAS || 0
    
    return {
      id: id,
      numero: numero,
      origen: origen,
      destino: destino,
      fecha: fechaSalida,
      fechaLlegada: fechaLlegada,
      asientosTotal: 0,
      asientosDisponibles: 0,
      huellaCarbono: huellaCarbono,
      cantidadMillas: cantidadMillas,
    }
  }

  // Función helper para mapear cruceros de la base de datos
  const mapearCrucero = (c: any, index: number): Crucero => {
    const idRaw = c.cru_cod || c.Cru_COD || c.cru_COD || c.Cru_cod || c.id || Object.values(c).find((val: any) => typeof val === 'number' && val > 0)
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    const nombre = c.cru_nombre || c.Cru_nombre || c.Cru_Nombre || c.nombre || c.Nombre || ""
    const origen = c.origen || c.Origen || ""
    const destino = c.destino || c.Destino || ""
    const ruta = origen && destino ? `${origen} - ${destino}` : ""
    
    // Guardar la fecha completa con hora (timestamp)
    const fechaSalida = c.cru_fecha_hora_salida || c.Cru_Fecha_Hora_Salida || c.fechaSalida || ""
    const fechaLlegada = c.cru_fecha_hora_lllegada || c.Cru_Fecha_Hora_Lllegada || c.fechaLlegada || ""
    const huellaCarbono = c.cru_huella_carbono || c.Cru_Huella_Carbono || c.CRU_HUELLA_CARBONO || 0
    const cantidadMillas = c.cru_cant_millas || c.Cru_Cant_Millas || c.CRU_CANT_MILLAS || 0
    
    return {
      id: id,
      nombre: nombre,
      ruta: ruta,
      origen: origen,
      destino: destino,
      fechaSalida: fechaSalida,
      fechaLlegada: fechaLlegada,
      capacidadTotal: 0,
      capacidadDisponible: 0,
      huellaCarbono: huellaCarbono,
      cantidadMillas: cantidadMillas,
    }
  }

  const mapearTraslado = (t: any, index: number): Tour => {
    // Mapear desde Transporte_Terrestre
    const idRaw = t.tt_cod || t.TT_COD || t.Tt_Cod || t.id || Object.values(t).find((val: any) => typeof val === 'number' && val > 0)
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    const descripcion = "Transporte Terrestre" // No hay descripción en la BD
    const origen = t.origen || t.Origen || "No especificado"
    const destino = t.destino || t.Destino || "No especificado"
    const numero = `TT-${id}`
    
    // Mapear fechas
    const fechaSalida = t.tt_fecha_hora_salida || t.TT_Fecha_Hora_Salida || t.TT_FECHA_HORA_SALIDA || ""
    const fechaLlegada = t.tt_fecha_hora_llegada || t.TT_Fecha_Hora_Llegada || t.TT_FECHA_HORA_LLEGADA || ""
    const tarifa = t.tt_costo || t.TT_Costo || t.TT_COSTO || 0
    const huellaCarbono = t.tt_huella_carbono || t.TT_Huella_Carbono || t.TT_HUELLA_CARBONO || 0
    const cantidadMillas = t.tt_cant_millas || t.TT_Cant_Millas || t.TT_CANT_MILLAS || 0
    
    console.log("Mapeando traslado:", { id, origen, destino, fechaSalida, fechaLlegada, tarifa, huellaCarbono, cantidadMillas })
    
    return {
      id: id,
      numero: numero,
      descripcion: descripcion,
      origen: origen,
      destino: destino,
      fechaSalida: fechaSalida,
      fechaLlegada: fechaLlegada,
      tarifa: tarifa,
      huellaCarbono: huellaCarbono,
      cantidadMillas: cantidadMillas,
    }
  }

  // Función helper para mapear aerolíneas de la base de datos
  const mapearAerolinea = (a: any, index: number): Aerolinea => {
    // Buscar el ID en todas las posibles variaciones de nombres de columnas
    const idRaw = a.Aerolinea_COD 
      || a.aerolinea_cod 
      || a.aerolinea_COD
      || a.Aerolinea_cod
      || a.AerolineaCod
      || a.aerolineaCod
      || a.Pro_COD
      || a.pro_cod
      || a.cod
      || a.COD
      || a.id
      || Object.values(a).find((val: any) => typeof val === 'number' && val > 0)
    
    // Solo usar el ID si es un número válido
    const idReal = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : null
    
    const lugarId = a.Lugar_Lug_COD || a.lugar_lug_cod || a.lugarId || a.lugar_id
    
    return {
      id: idReal || `temp-${index}`,
      idReal: idReal,
      nombre: a.Aerolinea_Nombre || a.aerolinea_nombre || a.Pro_Nombre || a.pro_nombre || a.nombre || a.Nombre || "",
      direccion: a.Aerolinea_Direccion || a.aerolinea_direccion || a.Pro_Direccion || a.pro_direccion || a.direccion || a.Direccion || "",
      telefono: a.Aerolinea_Telefono?.toString() || a.aerolinea_telefono?.toString() || a.Pro_Telefono?.toString() || a.pro_telefono?.toString() || a.telefono?.toString() || a.Telefono?.toString() || "",
      correo: a.Aerolinea_Correo || a.aerolinea_correo || a.Pro_Correo || a.pro_correo || a.correo || a.Correo || "",
      fechaFundacion: a.Aerolinea_Fecha_Fundacion || a.aerolinea_fecha_fundacion || a.A_Fecha_Fundacion || a.a_fecha_fundacion || a.fechaFundacion || a.fecha_fundacion || a.Fecha_Fundacion || "",
      lugarId: lugarId ? Number(lugarId) : undefined,
    }
  }

  // Función helper para mapear compañías de crucero de la base de datos
  const mapearCompaniaCrucero = (c: any, index: number): CompaniaCrucero => {
    const idRaw = c.Compania_Crucero_COD 
      || c.compania_crucero_cod 
      || c.compania_crucero_COD
      || c.Compania_Crucero_cod
      || c.CompaniaCruceroCod
      || c.companiaCruceroCod
      || c.Pro_COD
      || c.pro_cod
      || c.cod
      || c.COD
      || c.id
      || Object.values(c).find((val: any) => typeof val === 'number' && val > 0)
    
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    console.log("Mapeando compañía de crucero:", c) // Debug
    
    return {
      id: id,
      nombre: c.Compania_Crucero_Nombre || c.compania_crucero_nombre || c.Pro_Nombre || c.pro_nombre || c.nombre || c.Nombre || "",
      direccion: c.Compania_Crucero_Direccion || c.compania_crucero_direccion || c.Pro_Direccion || c.pro_direccion || c.direccion || c.Direccion || "",
      telefono: c.Compania_Crucero_Telefono?.toString() || c.compania_crucero_telefono?.toString() || c.Pro_Telefono?.toString() || c.pro_telefono?.toString() || c.telefono?.toString() || c.Telefono?.toString() || "",
      correo: c.Compania_Crucero_Correo || c.compania_crucero_correo || c.Pro_Correo || c.pro_correo || c.correo || c.Correo || "",
      fechaFundacion: c.CC_Fecha_Fundacion || c.cc_fecha_fundacion || c.Compania_Crucero_Fecha_Fundacion || c.compania_crucero_fecha_fundacion || c.Pro_Fecha_Fundacion || c.pro_fecha_fundacion || c.Fecha_Fundacion || c.fecha_fundacion || c.fechaFundacion || "",
    }
  }

  // Función helper para mapear compañías de transporte terrestre de la base de datos
  const mapearCompaniaTransporte = (t: any, index: number): CompaniaTransporteTerrestre => {
    const idRaw = t.Compania_Transporte_Terrestre_COD 
      || t.compania_transporte_terrestre_cod 
      || t.compania_transporte_terrestre_COD
      || t.Compania_Transporte_Terrestre_cod
      || t.CompaniaTransporteTerrestreCod
      || t.companiaTransporteTerrestreCod
      || t.Pro_COD
      || t.pro_cod
      || t.cod
      || t.COD
      || t.id
      || Object.values(t).find((val: any) => typeof val === 'number' && val > 0)
    
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    console.log("Mapeando compañía de transporte:", t) // Debug
    
    return {
      id: id,
      nombre: t.Compania_Transporte_Terrestre_Nombre || t.compania_transporte_terrestre_nombre || t.Pro_Nombre || t.pro_nombre || t.nombre || t.Nombre || "",
      direccion: t.Compania_Transporte_Terrestre_Direccion || t.compania_transporte_terrestre_direccion || t.Pro_Direccion || t.pro_direccion || t.direccion || t.Direccion || "",
      telefono: t.Compania_Transporte_Terrestre_Telefono?.toString() || t.compania_transporte_terrestre_telefono?.toString() || t.Pro_Telefono?.toString() || t.pro_telefono?.toString() || t.telefono?.toString() || t.Telefono?.toString() || "",
      correo: t.Compania_Transporte_Terrestre_Correo || t.compania_transporte_terrestre_correo || t.Pro_Correo || t.pro_correo || t.correo || t.Correo || "",
      fechaFundacion: t.CTT_Fecha_Fundacion || t.ctt_fecha_fundacion || t.Compania_Transporte_Terrestre_Fecha_Fundacion || t.compania_transporte_terrestre_fecha_fundacion || t.Pro_Fecha_Fundacion || t.pro_fecha_fundacion || t.Fecha_Fundacion || t.fecha_fundacion || t.fechaFundacion || "",
    }
  }

  // Función helper para mapear hoteles de la base de datos
  const mapearHospedaje = (h: any, index: number): Hospedaje => {
    const idRaw = h.hos_cod || h.Hos_COD || h.Hos_cod || h.id || Object.values(h).find((val: any) => typeof val === 'number' && val > 0)
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    console.log("Mapeando hospedaje:", h) // Debug
    
    return {
      id: id,
      hotelNombre: h.hotel_nombre || h.Hotel_Nombre || h.HOTEL_NOMBRE || "Hotel no especificado",
      hotelId: (h.hotel_pro_cod || h.Hotel_Pro_COD || h.HOTEL_PRO_COD || "").toString(),
      fechaInicio: h.hos_fecha_hora_inicio || h.Hos_Fecha_Hora_Inicio || h.HOS_FECHA_HORA_INICIO || "",
      fechaFin: h.hos_fecha_hora_fin || h.Hos_Fecha_Hora_Fin || h.HOS_FECHA_HORA_FIN || "",
      cantidadMillas: h.hot_cant_milla || h.Hot_Cant_Milla || h.HOT_CANT_MILLA || 0,
      costo: h.hos_costo || h.Hos_Costo || h.HOS_COSTO || 0,
    }
  }

  const mapearRestaurante = (r: any, index: number): Restaurante => {
    const idRaw = r.rest_cod || r.Rest_COD || r.REST_COD || r.id || Object.values(r).find((val: any) => typeof val === 'number' && val > 0)
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    console.log("Mapeando restaurante:", r) // Debug
    
    return {
      id: id,
      nombre: r.rest_nombre || r.Rest_Nombre || r.REST_NOMBRE || r.nombre || "",
      direccion: r.rest_direccion || r.Rest_Direccion || r.REST_DIRECCION || r.direccion || "",
      clasificacion: r.rest_clasificacion || r.Rest_Clasificacion || r.REST_CLASIFICACION || r.clasificacion || "",
      lugarId: (r.lugar_lug_cod || r.Lugar_Lug_COD || r.LUGAR_LUG_COD || "").toString(),
      tipoComida: r.rest_tipo_comida || r.Rest_Tipo_Comida || r.REST_TIPO_COMIDA || r.tipoComida || "",
      ambiente: r.rest_ambiente || r.Rest_Ambiente || r.REST_AMBIENTE || r.ambiente || "",
    }
  }

  const mapearServicioAdicional = (s: any, index: number): ServicioAdicional => {
    const idRaw = s.sa_cod || s.Sa_COD || s.SA_COD || s.id || Object.values(s).find((val: any) => typeof val === 'number' && val > 0)
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    // Convertir costo a número
    const costoRaw = s.sa_costo || s.Sa_Costo || s.SA_COSTO || s.costo || 0
    const costo = typeof costoRaw === 'number' ? costoRaw : Number(costoRaw) || 0
    
    // Convertir millas a número - NOMBRE CORRECTO: sa_cant_milla (sin 's' final)
    const millasRaw = s.sa_cant_milla || s.Sa_Cant_Milla || s.SA_Cant_Milla || s.sa_cantidad_millas || s.cantidadMillas
    const millas = millasRaw != null && millasRaw > 0 ? (typeof millasRaw === 'number' ? millasRaw : Number(millasRaw)) : undefined
    
    console.log("🔍 Mapeando servicio adicional:", s) // Debug
    console.log("  - Millas raw:", millasRaw, "| Millas final:", millas) // Debug extra
    
    return {
      id: id,
      nombre: s.sa_nombre || s.Sa_Nombre || s.SA_NOMBRE || s.nombre || "",
      descripcion: s.sa_descripcion || s.Sa_Descripcion || s.SA_DESCRIPCION || s.descripcion || "",
      costo: costo,
      tipo: s.sa_tipo || s.Sa_Tipo || s.SA_TIPO || s.tipo || "",
      cantidadMillas: millas,
    }
  }

  const mapearPaqueteTuristico = (p: any, index: number): PaqueteTuristico => {
    const idRaw = p.pt_cod || p.PT_COD || p.PT_cod || p.id || Object.values(p).find((val: any) => typeof val === 'number' && val > 0)
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    console.log("🔍 Mapeando paquete turístico:", p) // Debug
    
    return {
      id: id,
      nombre: p.pt_nombre || p.PT_Nombre || p.PT_NOMBRE || p.nombre || "",
      descripcion: p.pt_descripcion || p.PT_Descripcion || p.PT_DESCRIPCION || p.descripcion || "",
      costo: Number(p.pt_costo || p.PT_Costo || p.PT_COSTO || p.costo || 0),
      costoMillas: Number(p.pt_costo_millas || p.PT_Costo_Millas || p.PT_COSTO_MILLAS || p.costoMillas || 0),
      millasOtorga: Number(p.pt_cant_milla || p.PT_Cant_Milla || p.PT_CANT_MILLA || p.millasOtorga || 0),
      tipo: (p.pt_tipo || p.PT_Tipo || p.PT_TIPO || p.tipo || "regular").toLowerCase() as "especial" | "regular",
    }
  }

  const mapearOperadorTuristico = (o: any, index: number): OperadorTuristico => {
    const idRaw = o.pro_cod || o.Pro_COD || o.PRO_COD || o.id || Object.values(o).find((val: any) => typeof val === 'number' && val > 0)
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    console.log("Mapeando operador turístico:", o) // Debug
    
    return {
      id: id,
      nombre: o.pro_nombre || o.Pro_Nombre || o.PRO_NOMBRE || o.nombre || "",
      direccion: o.pro_direccion || o.Pro_Direccion || o.PRO_DIRECCION || o.direccion || "",
      telefono: o.pro_telefono?.toString() || o.Pro_Telefono?.toString() || o.PRO_TELEFONO?.toString() || o.telefono?.toString() || "",
      correo: o.pro_correo || o.Pro_Correo || o.PRO_CORREO || o.correo || "",
      fechaFundacion: o.ot_fecha_fundacion || o.OT_Fecha_Fundacion || o.pro_fecha_fundacion || o.Pro_Fecha_Fundacion || o.fechaFundacion || "",
    }
  }

  // Cargar vuelos desde la base de datos al montar el componente
  useEffect(() => {
    const cargarVuelos = async () => {
      try {
        setIsLoadingVuelos(true)
        const res = await fetch("/api/vuelo")
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        console.log("Respuesta completa de API vuelos:", data) // Debug
        
        if (data.status === "success" && Array.isArray(data.data)) {
          if (data.data.length > 0) {
            console.log("Estructura de un vuelo:", data.data[0])
          }
          
          const vuelosFormateados = data.data.map((v: any, index: number) => mapearVuelo(v, index))
          // Ordenar por ID numérico de forma ascendente
          vuelosFormateados.sort((a: Vuelo, b: Vuelo) => Number(a.id) - Number(b.id))
          console.log("Vuelos formateados:", vuelosFormateados) // Debug
          console.log("IDs en orden:", vuelosFormateados.map((v: Vuelo) => v.id))
          setVuelos(vuelosFormateados)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error: any) {
        console.error("Error cargando vuelos:", error)
        toast({
          title: "Error",
          description: "Error al cargar vuelos",
          variant: "destructive",
        })
      } finally {
        setIsLoadingVuelos(false)
      }
    }

    cargarVuelos()
  }, [toast])

  // Cargar cruceros desde la base de datos al montar el componente
  useEffect(() => {
    const cargarCruceros = async () => {
      try {
        setIsLoadingCruceros(true)
        const res = await fetch("/api/crucero")
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        console.log("Respuesta completa de API cruceros:", data) // Debug
        
        if (data.status === "success" && Array.isArray(data.data)) {
          if (data.data.length > 0) {
            console.log("Estructura de un crucero:", data.data[0])
          }
          
          const crucerosFormateados = data.data.map((c: any, index: number) => mapearCrucero(c, index))
          // Ordenar por ID numérico de forma ascendente
          crucerosFormateados.sort((a: Crucero, b: Crucero) => Number(a.id) - Number(b.id))
          console.log("Cruceros formateados:", crucerosFormateados) // Debug
          console.log("IDs en orden:", crucerosFormateados.map((c: Crucero) => c.id))
          setCruceros(crucerosFormateados)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error: any) {
        console.error("Error cargando cruceros:", error)
        toast({
          title: "Error",
          description: "Error al cargar cruceros",
          variant: "destructive",
        })
      } finally {
        setIsLoadingCruceros(false)
      }
    }

    cargarCruceros()
  }, [toast])

  // Cargar traslados desde la base de datos al montar el componente
  useEffect(() => {
    const cargarTraslados = async () => {
      try {
        setIsLoadingTours(true)
        const res = await fetch("/api/traslado")
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        console.log("Respuesta completa de API traslados:", data) // Debug
        
        if (data.status === "success" && Array.isArray(data.data)) {
          if (data.data.length > 0) {
            console.log("Estructura de un traslado:", data.data[0])
          }
          
          const trasladosFormateados = data.data.map((t: any, index: number) => mapearTraslado(t, index))
          // Ordenar por ID numérico de forma ascendente
          trasladosFormateados.sort((a: Tour, b: Tour) => Number(a.id) - Number(b.id))
          console.log("Traslados formateados:", trasladosFormateados) // Debug
          console.log("IDs en orden:", trasladosFormateados.map((t: Tour) => t.id))
          setTours(trasladosFormateados)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error: any) {
        console.error("Error cargando traslados:", error)
        toast({
          title: "Error",
          description: "Error al cargar traslados",
          variant: "destructive",
        })
      } finally {
        setIsLoadingTours(false)
      }
    }

    cargarTraslados()
  }, [toast])

  // Cargar aerolíneas desde la base de datos al montar el componente
  useEffect(() => {
    const cargarAerolineas = async () => {
      try {
        const res = await fetch("/api/aerolinea")
        const data = await res.json()
        
        console.log("Respuesta completa de API aerolíneas:", data) // Debug
        
        if (data.status === "success" && Array.isArray(data.data)) {
          // Log para ver la estructura del primer elemento
          if (data.data.length > 0) {
            console.log("Estructura de una aerolínea:", data.data[0])
          }
          
          // Normalizar los datos usando la función helper
          const aerolineasFormateadas = data.data.map((a: any, index: number) => mapearAerolinea(a, index))
          
          console.log("Aerolíneas formateadas:", aerolineasFormateadas) // Debug
          setAerolineas(aerolineasFormateadas)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error) {
        console.error("Error cargando aerolíneas:", error)
      }
    }

    cargarAerolineas()
  }, [toast])

  // Cargar promociones desde la base de datos al montar el componente
  useEffect(() => {
    const cargarPromociones = async () => {
      try {
        setIsLoadingPromociones(true)
        const res = await fetch("/api/promocion")
        const data = await res.json()
        
        console.log("Respuesta completa de API promociones:", data) // Debug
        
        if (!res.ok) {
          console.error("Error en respuesta de API:", res.status, res.statusText)
          toast({
            title: "Error",
            description: `Error al cargar promociones: ${res.status} ${res.statusText}`,
            variant: "destructive",
          })
          setIsLoadingPromociones(false)
          return
        }

        if (data.status === "success" && Array.isArray(data.data)) {
          // Log para ver la estructura del primer elemento
          if (data.data.length > 0) {
            console.log("Estructura de una promoción:", data.data[0])
          }
          
          // Normalizar los datos de la base de datos al formato esperado
          const promocionesFormateadas = data.data.map((p: any, index: number) => {
            // Buscar el ID en todas las posibles variaciones
            const idRaw = p.Prom_COD || p.prom_cod || p.prom_COD || p.Prom_cod || p.PromCod || p.promCod || p.cod || p.COD || p.id || Object.values(p).find((val: any) => typeof val === 'number' && val > 0)
            const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
            
            return {
              id: id,
              idReal: idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : null,
              tipo: p.Prom_Tipo || p.prom_tipo || p.tipo || p.Tipo || "",
              fechaInicio: p.Prom_Fecha_Inicio || p.prom_fecha_inicio || p.fechaInicio || p.fecha_inicio || p.Fecha_Inicio || "",
              fechaFin: p.Prom_Fecha_Fin || p.prom_fecha_fin || p.fechaFin || p.fecha_fin || p.Fecha_Fin || "",
              porcentajeDescuento: p.Prom_Porcentaje != null ? Number(p.Prom_Porcentaje) : (p.prom_porcentaje != null ? Number(p.prom_porcentaje) : (p.porcentajeDescuento != null ? Number(p.porcentajeDescuento) : null)),
            }
          })
          
          console.log("Promociones formateadas:", promocionesFormateadas) // Debug
          setPromociones(promocionesFormateadas)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
          toast({
            title: "Error",
            description: data.message || "Estructura de respuesta inesperada",
            variant: "destructive",
          })
        }
      } catch (error: any) {
        console.error("Error cargando promociones:", error)
        toast({
          title: "Error",
          description: error.message || "Error de conexión con el servidor",
          variant: "destructive",
        })
      } finally {
        setIsLoadingPromociones(false)
      }
    }

    cargarPromociones()
  }, [toast])

  // Cargar compañías de crucero desde la base de datos al montar el componente
  useEffect(() => {
    const cargarCompaniasCrucero = async () => {
      try {
        setIsLoadingCompaniasCrucero(true)
        const res = await fetch("/api/compania-crucero")
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        if (data.status === "success" && Array.isArray(data.data)) {
          const companiasFormateadas = data.data.map((c: any, index: number) => mapearCompaniaCrucero(c, index))
          setCompaniasCrucero(companiasFormateadas)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error: any) {
        console.error("Error cargando compañías de crucero:", error)
        // Solo mostrar toast si no es un error de servidor crítico
        if (error.message && !error.message.includes("500")) {
          toast({
            title: "Error",
            description: "Error al cargar compañías de crucero",
            variant: "destructive",
          })
        }
      } finally {
        setIsLoadingCompaniasCrucero(false)
      }
    }

    cargarCompaniasCrucero()
  }, [toast])

  // Cargar compañías de transporte terrestre desde la base de datos al montar el componente
  useEffect(() => {
    const cargarCompaniasTransporte = async () => {
      try {
        setIsLoadingCompaniasTransporte(true)
        const res = await fetch("/api/compania-traslado")
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        if (data.status === "success" && Array.isArray(data.data)) {
          const companiasFormateadas = data.data.map((t: any, index: number) => mapearCompaniaTransporte(t, index))
          setCompaniasTransporte(companiasFormateadas)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error: any) {
        console.error("Error cargando compañías de transporte:", error)
        // Solo mostrar toast si no es un error de servidor crítico
        if (error.message && !error.message.includes("500")) {
          toast({
            title: "Error",
            description: "Error al cargar compañías de transporte terrestre",
            variant: "destructive",
          })
        }
      } finally {
        setIsLoadingCompaniasTransporte(false)
      }
    }

    cargarCompaniasTransporte()
  }, [toast])

  // Cargar hospedajes desde la base de datos al montar el componente
  useEffect(() => {
    const cargarHospedajes = async () => {
      try {
        setIsLoadingHospedajes(true)
        const res = await fetch("/api/hospedaje")
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        console.log("Respuesta completa de API hospedajes:", data) // Debug
        
        if (data.status === "success" && Array.isArray(data.data)) {
          if (data.data.length > 0) {
            console.log("Estructura de un hospedaje:", data.data[0])
          }
          
          const hospedajesFormateados = data.data.map((h: any, index: number) => mapearHospedaje(h, index))
          // Ordenar por ID numérico de forma ascendente
          hospedajesFormateados.sort((a: Hospedaje, b: Hospedaje) => Number(a.id) - Number(b.id))
          console.log("Hospedajes formateados:", hospedajesFormateados) // Debug
          setHospedajes(hospedajesFormateados)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error: any) {
        console.error("Error cargando hospedajes:", error)
        toast({
          title: "Error",
          description: "Error al cargar hospedajes",
          variant: "destructive",
        })
      } finally {
        setIsLoadingHospedajes(false)
      }
    }

    cargarHospedajes()
  }, [toast])

  // Cargar restaurantes desde la base de datos al montar el componente
  useEffect(() => {
    const cargarRestaurantes = async () => {
      try {
        setIsLoadingRestaurantes(true)
        const res = await fetch("/api/restaurante")
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        console.log("Respuesta completa de API restaurantes:", data) // Debug
        
        if (data.status === "success" && Array.isArray(data.data)) {
          if (data.data.length > 0) {
            console.log("Estructura de un restaurante:", data.data[0])
          }
          
          const restaurantesFormateados = data.data.map((r: any, index: number) => mapearRestaurante(r, index))
          // Ordenar por ID numérico de forma ascendente
          restaurantesFormateados.sort((a: Restaurante, b: Restaurante) => Number(a.id) - Number(b.id))
          console.log("Restaurantes formateados:", restaurantesFormateados) // Debug
          setRestaurantes(restaurantesFormateados)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error: any) {
        console.error("Error cargando restaurantes:", error)
        toast({
          title: "Error",
          description: "Error al cargar restaurantes",
          variant: "destructive",
        })
      } finally {
        setIsLoadingRestaurantes(false)
      }
    }

    cargarRestaurantes()
  }, [toast])

  // Cargar operadores turísticos desde la base de datos al montar el componente
  useEffect(() => {
    const cargarOperadoresTuristicos = async () => {
      try {
        setIsLoadingOperadoresTuristicos(true)
        const res = await fetch("/api/operador-turistico")
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        console.log("Respuesta completa de API operadores turísticos:", data) // Debug
        
        if (data.status === "success" && Array.isArray(data.data)) {
          if (data.data.length > 0) {
            console.log("Estructura de un operador turístico:", data.data[0])
          }
          
          const operadoresFormateados = data.data.map((o: any, index: number) => mapearOperadorTuristico(o, index))
          // Ordenar por ID numérico de forma ascendente
          operadoresFormateados.sort((a: OperadorTuristico, b: OperadorTuristico) => Number(a.id) - Number(b.id))
          console.log("Operadores turísticos formateados:", operadoresFormateados) // Debug
          setOperadoresTuristicos(operadoresFormateados)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error: any) {
        console.error("Error cargando operadores turísticos:", error)
        toast({
          title: "Error",
          description: "Error al cargar operadores turísticos",
          variant: "destructive",
        })
      } finally {
        setIsLoadingOperadoresTuristicos(false)
      }
    }

    cargarOperadoresTuristicos()
  }, [toast])

  // Cargar servicios adicionales desde la base de datos al montar el componente
  useEffect(() => {
    const cargarServiciosAdicionales = async () => {
      try {
        setIsLoadingServiciosAdicionales(true)
        const res = await fetch("/api/servicio-adicional")
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        console.log("Respuesta completa de API servicios adicionales:", data) // Debug
        
        if (data.status === "success" && Array.isArray(data.data)) {
          if (data.data.length > 0) {
            console.log("Estructura de un servicio adicional:", data.data[0])
          }
          
          const serviciosFormateados = data.data.map((s: any, index: number) => mapearServicioAdicional(s, index))
          // Ordenar por ID numérico de forma ascendente
          serviciosFormateados.sort((a: ServicioAdicional, b: ServicioAdicional) => Number(a.id) - Number(b.id))
          console.log("Servicios adicionales formateados:", serviciosFormateados) // Debug
          setServiciosAdicionales(serviciosFormateados)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error: any) {
        console.error("Error cargando servicios adicionales:", error)
        toast({
          title: "Error",
          description: "Error al cargar servicios adicionales",
          variant: "destructive",
        })
      } finally {
        setIsLoadingServiciosAdicionales(false)
      }
    }

    cargarServiciosAdicionales()
  }, [toast])

  // Cargar paquetes turísticos desde la base de datos al montar el componente
  useEffect(() => {
    const cargarPaquetesTuristicos = async () => {
      try {
        setIsLoadingPaquetes(true)
        const res = await fetch("/api/paquete-turistico?id=0") // id=0 para obtener todos
        
        if (!res.ok) {
          throw new Error(`Error ${res.status}: ${res.statusText}`)
        }
        
        const data = await res.json()
        
        console.log("Respuesta completa de API paquetes turísticos:", data) // Debug
        
        if (data.status === "success" && Array.isArray(data.data)) {
          if (data.data.length > 0) {
            console.log("Estructura de un paquete turístico:", data.data[0])
          }
          
          const paquetesFormateados = data.data.map((p: any, index: number) => mapearPaqueteTuristico(p, index))
          // Ordenar por ID numérico de forma ascendente
          paquetesFormateados.sort((a: PaqueteTuristico, b: PaqueteTuristico) => Number(a.id) - Number(b.id))
          console.log("Paquetes turísticos formateados:", paquetesFormateados) // Debug
          setPaquetesTuristicos(paquetesFormateados)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error: any) {
        console.error("Error cargando paquetes turísticos:", error)
        toast({
          title: "Error",
          description: "Error al cargar paquetes turísticos",
          variant: "destructive",
        })
      } finally {
        setIsLoadingPaquetes(false)
      }
    }

    cargarPaquetesTuristicos()
  }, [toast])

  const calcularPorcentaje = (disponible: number, total: number) => {
    return ((disponible / total) * 100).toFixed(0)
  }

  const obtenerEstado = (disponible: number, total: number) => {
    const porcentaje = (disponible / total) * 100
    if (porcentaje <= 10) return { label: "Crítico", variant: "destructive" as const }
    if (porcentaje <= 30) return { label: "Bajo", variant: "default" as const }
    return { label: "Disponible", variant: "secondary" as const }
  }

  const handleAgregar = (
    tipo: "vuelo" | "crucero" | "tour" | "hospedaje" | "aerolinea" | "compania-crucero" | "compania-transporte" | "paquete" | "operador-turistico" | "servicio-adicional"
  ) => {
    setTipoActual(tipo)
    setItemSeleccionado(null)
    setModoEdicion(false)
    setDialogOpen(true)
  }

  const handleEditar = (
    item: Vuelo | Crucero | Tour | Hospedaje | Aerolinea | CompaniaCrucero | CompaniaTransporteTerrestre | PaqueteTuristico | OperadorTuristico | ServicioAdicional,
    tipo: "vuelo" | "crucero" | "tour" | "hospedaje" | "aerolinea" | "compania-crucero" | "compania-transporte" | "paquete" | "operador-turistico" | "servicio-adicional"
  ) => {
    setTipoActual(tipo)
    setItemSeleccionado(item)
    setModoEdicion(true)
    setDialogOpen(true)
  }

  const handleEliminar = async (
    id: string,
    tipo: "vuelo" | "crucero" | "tour" | "hospedaje" | "aerolinea" | "compania-crucero" | "compania-transporte" | "paquete" | "operador-turistico" | "servicio-adicional"
  ) => {
    if (confirm("¿Estás seguro de que deseas eliminar este elemento?")) {
      if (tipo === "vuelo") {
        setVuelos(vuelos.filter((v) => v.id !== id))
      } else if (tipo === "crucero") {
        setCruceros(cruceros.filter((c) => c.id !== id))
      } else if (tipo === "tour") {
        setTours(tours.filter((t) => t.id !== id))
      } else if (tipo === "hospedaje") {
        setHospedajes(hospedajes.filter((h) => h.id !== id))
      } else if (tipo === "aerolinea") {
        // Buscar la aerolínea para obtener el ID real
        const aerolinea = aerolineas.find(a => a.id === id)
        const idReal = aerolinea?.idReal || (id.startsWith("temp-") ? null : id)
        
        // Validar que tengamos un ID válido (numérico)
        if (!idReal || idReal.startsWith("temp-") || idReal.startsWith("aerolinea-")) {
          toast({
            title: "Error",
            description: "No se puede eliminar esta aerolínea porque no tiene un ID válido de la base de datos",
            variant: "destructive",
          })
          return
        }
        
        try {
          const res = await fetch("/api/aerolinea", {
            method: "DELETE",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ id: idReal }),
          })

          if (!res.ok) {
            const errorData = await res.json().catch(() => ({ message: "Error de conexión con el servidor" }))
            toast({
              title: "Error",
              description: errorData.message || `Error ${res.status}: ${res.statusText}`,
              variant: "destructive",
            })
            return
          }

          const data = await res.json()

          if (data.status === "success") {
            // Recargar aerolíneas desde la base de datos
            const resGet = await fetch("/api/aerolinea")
            const dataGet = await resGet.json()
            
            if (dataGet.status === "success" && Array.isArray(dataGet.data)) {
              const aerolineasFormateadas = dataGet.data.map((a: any, index: number) => mapearAerolinea(a, index))
              setAerolineas(aerolineasFormateadas)
            }
            toast({
              title: "Aerolínea eliminada",
              description: "La aerolínea se ha eliminado exitosamente",
            })
          } else {
            toast({
              title: "Error",
              description: data.message || "No se pudo eliminar la aerolínea",
              variant: "destructive",
            })
          }
        } catch (error) {
          toast({
            title: "Error",
            description: "Error de conexión con el servidor",
            variant: "destructive",
          })
        }
      } else if (tipo === "compania-crucero") {
        setCompaniasCrucero(companiasCrucero.filter((c) => c.id !== id))
      } else if (tipo === "compania-transporte") {
        setCompaniasTransporte(companiasTransporte.filter((c) => c.id !== id))
      } else if (tipo === "paquete") {
        // Eliminar paquete turístico de la base de datos
        try {
          const res = await fetch("/api/paquete-turistico", {
            method: "DELETE",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ id: parseInt(id) }),
          })

          if (!res.ok) {
            const errorData = await res.json().catch(() => ({ message: "Error de conexión con el servidor" }))
            toast({
              title: "Error",
              description: errorData.message || `Error ${res.status}: ${res.statusText}`,
              variant: "destructive",
            })
            return
          }

          const data = await res.json()

          if (data.status === "success") {
            // Recargar paquetes desde la base de datos
            const resGet = await fetch("/api/paquete-turistico?id=0")
            const dataGet = await resGet.json()
            
            if (dataGet.status === "success" && Array.isArray(dataGet.data)) {
              const paquetesFormateados = dataGet.data.map((p: any, index: number) => mapearPaqueteTuristico(p, index))
              paquetesFormateados.sort((a: PaqueteTuristico, b: PaqueteTuristico) => Number(a.id) - Number(b.id))
              setPaquetesTuristicos(paquetesFormateados)
            }
            toast({
              title: "Paquete eliminado",
              description: "El paquete turístico se ha eliminado exitosamente",
            })
          } else {
            toast({
              title: "Error",
              description: data.message || "No se pudo eliminar el paquete",
              variant: "destructive",
            })
          }
        } catch (error) {
          toast({
            title: "Error",
            description: "Error de conexión con el servidor",
            variant: "destructive",
          })
        }
      } else if (tipo === "operador-turistico") {
        setOperadoresTuristicos(operadoresTuristicos.filter((o) => o.id !== id))
      } else if (tipo === "servicio-adicional") {
        setServiciosAdicionales(serviciosAdicionales.filter((s) => s.id !== id))
      }
    }
  }

  const handleGuardar = async (
    item: Vuelo | Crucero | Tour | Aerolinea | CompaniaCrucero | CompaniaTransporteTerrestre | PaqueteTuristico | Hospedaje | OperadorTuristico | ServicioAdicional
  ) => {
    console.log("=== handleGuardar en page.tsx ===")
    console.log("Tipo actual:", tipoActual)
    console.log("Item recibido:", item)
    
    if (tipoActual === "vuelo") {
      const vuelo = item as Vuelo
      if (modoEdicion) {
        setVuelos(vuelos.map((v) => (v.id === vuelo.id ? vuelo : v)))
      } else {
        setVuelos([...vuelos, { ...vuelo, id: Date.now().toString() }])
      }
    } else if (tipoActual === "crucero") {
      const crucero = item as Crucero
      if (modoEdicion) {
        setCruceros(cruceros.map((c) => (c.id === crucero.id ? crucero : c)))
      } else {
        setCruceros([...cruceros, { ...crucero, id: Date.now().toString() }])
      }
    } else if (tipoActual === "tour") {
      const tour = item as Tour
      if (modoEdicion) {
        setTours(tours.map((t) => (t.id === tour.id ? tour : t)))
      } else {
        setTours([...tours, { ...tour, id: Date.now().toString() }])
      }
    } else if (tipoActual === "hospedaje") {
      const hospedaje = item as Hospedaje
      if (modoEdicion) {
        setHospedajes(hospedajes.map((h) => (h.id === hospedaje.id ? hospedaje : h)))
      } else {
        setHospedajes([...hospedajes, { ...hospedaje, id: Date.now().toString() }])
      }
    } else if (tipoActual === "aerolinea") {
      const aerolinea = item as Aerolinea
      if (modoEdicion) {
        try {
          const payload = {
            id: aerolinea.id,
            nombre: aerolinea.nombre,
            direccion: aerolinea.direccion,
            telefono: aerolinea.telefono,
            correo: aerolinea.correo,
            fechaFundacion: aerolinea.fechaFundacion,
            lugarId: aerolinea.lugarId,
          }
          
          console.log("=== Enviando PUT a /api/aerolinea ===")
          console.log("Datos de aerolínea:", aerolinea)
          console.log("Payload a enviar:", payload)
          console.log("lugarId:", aerolinea.lugarId, "Tipo:", typeof aerolinea.lugarId)
          
          const res = await fetch("/api/aerolinea", {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload),
          })

          const data = await res.json()

          if (data.status === "success") {
            // Recargar aerolíneas desde la base de datos
            const resGet = await fetch("/api/aerolinea")
            const dataGet = await resGet.json()
            
            if (dataGet.status === "success" && Array.isArray(dataGet.data)) {
              const aerolineasFormateadas = dataGet.data.map((a: any, index: number) => mapearAerolinea(a, index))
              setAerolineas(aerolineasFormateadas)
            }
            toast({
              title: "Aerolínea actualizada",
              description: "La aerolínea se ha actualizado exitosamente",
            })
          } else {
            toast({
              title: "Error",
              description: data.message || "No se pudo actualizar la aerolínea",
              variant: "destructive",
            })
            return
          }
        } catch (error) {
          toast({
            title: "Error",
            description: "Error de conexión con el servidor",
            variant: "destructive",
          })
          return
        }
      } else {
        try {
          const payload = {
            nombre: aerolinea.nombre,
            direccion: aerolinea.direccion,
            telefono: aerolinea.telefono,
            correo: aerolinea.correo,
            fechaFundacion: aerolinea.fechaFundacion,
            lugarId: aerolinea.lugarId,
          }
          
          console.log("=== Enviando POST a /api/aerolinea ===")
          console.log("Datos de aerolínea:", aerolinea)
          console.log("Payload a enviar:", payload)
          console.log("lugarId:", aerolinea.lugarId, "Tipo:", typeof aerolinea.lugarId)
          
          const res = await fetch("/api/aerolinea", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload),
          })

          if (!res.ok) {
            const errorData = await res.json().catch(() => ({ message: "Error de conexión con el servidor" }))
            toast({
              title: "Error",
              description: errorData.message || `Error ${res.status}: ${res.statusText}`,
              variant: "destructive",
            })
            return
          }

          const data = await res.json()

          if (data.status === "success") {
            // Recargar aerolíneas desde la base de datos
            const resGet = await fetch("/api/aerolinea")
            const dataGet = await resGet.json()
            
            if (dataGet.status === "success" && Array.isArray(dataGet.data)) {
              const aerolineasFormateadas = dataGet.data.map((a: any, index: number) => mapearAerolinea(a, index))
              setAerolineas(aerolineasFormateadas)
            }
            toast({
              title: "Aerolínea agregada",
              description: "La aerolínea se ha guardado exitosamente en la base de datos",
            })
          } else {
            toast({
              title: "Error",
              description: data.message || "No se pudo guardar la aerolínea",
              variant: "destructive",
            })
            return
          }
        } catch (error) {
          toast({
            title: "Error",
            description: "Error de conexión con el servidor",
            variant: "destructive",
          })
          return
        }
      }
    } else if (tipoActual === "compania-crucero") {
      const compania = item as CompaniaCrucero
      if (modoEdicion) {
        setCompaniasCrucero(companiasCrucero.map((c) => (c.id === compania.id ? compania : c)))
      } else {
        setCompaniasCrucero([...companiasCrucero, { ...compania, id: Date.now().toString() }])
      }
    } else if (tipoActual === "compania-transporte") {
      const compania = item as CompaniaTransporteTerrestre
      if (modoEdicion) {
        setCompaniasTransporte(companiasTransporte.map((c) => (c.id === compania.id ? compania : c)))
      } else {
        setCompaniasTransporte([...companiasTransporte, { ...compania, id: Date.now().toString() }])
      }
    } else if (tipoActual === "paquete") {
      const paquete = item as PaqueteTuristico
      if (modoEdicion) {
        // Actualizar paquete turístico
        try {
          const payload = {
            id: parseInt(paquete.id),
            nombre: paquete.nombre,
            descripcion: paquete.descripcion,
            costo: paquete.costo,
            costo_millas: paquete.costoMillas,
            cant_milla: paquete.millasOtorga,
            tipo: paquete.tipo.charAt(0).toUpperCase() + paquete.tipo.slice(1), // Capitalizar
          }
          
          console.log("=== Enviando PUT a /api/paquete-turistico ===")
          console.log("Payload a enviar:", payload)
          
          const res = await fetch("/api/paquete-turistico", {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload),
          })

          const data = await res.json()

          if (data.status === "success") {
            // Recargar paquetes desde la base de datos
            const resGet = await fetch("/api/paquete-turistico?id=0")
            const dataGet = await resGet.json()
            
            if (dataGet.status === "success" && Array.isArray(dataGet.data)) {
              const paquetesFormateados = dataGet.data.map((p: any, index: number) => mapearPaqueteTuristico(p, index))
              paquetesFormateados.sort((a: PaqueteTuristico, b: PaqueteTuristico) => Number(a.id) - Number(b.id))
              setPaquetesTuristicos(paquetesFormateados)
            }
            toast({
              title: "Paquete actualizado",
              description: "El paquete turístico se ha actualizado exitosamente",
            })
          } else {
            toast({
              title: "Error",
              description: data.message || "No se pudo actualizar el paquete",
              variant: "destructive",
            })
            return
          }
        } catch (error) {
          toast({
            title: "Error",
            description: "Error de conexión con el servidor",
            variant: "destructive",
          })
          return
        }
      } else {
        // Crear nuevo paquete turístico
        try {
          const payload = {
            nombre: paquete.nombre,
            descripcion: paquete.descripcion,
            costo: paquete.costo,
            costo_millas: paquete.costoMillas,
            cant_milla: paquete.millasOtorga,
            tipo: paquete.tipo.charAt(0).toUpperCase() + paquete.tipo.slice(1), // Capitalizar
          }
          
          console.log("=== Enviando POST a /api/paquete-turistico ===")
          console.log("Payload a enviar:", payload)
          
          const res = await fetch("/api/paquete-turistico", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload),
          })

          if (!res.ok) {
            const errorData = await res.json().catch(() => ({ message: "Error de conexión con el servidor" }))
            toast({
              title: "Error",
              description: errorData.message || `Error ${res.status}: ${res.statusText}`,
              variant: "destructive",
            })
            return
          }

          const data = await res.json()

          if (data.status === "success") {
            // Recargar paquetes desde la base de datos
            const resGet = await fetch("/api/paquete-turistico?id=0")
            const dataGet = await resGet.json()
            
            if (dataGet.status === "success" && Array.isArray(dataGet.data)) {
              const paquetesFormateados = dataGet.data.map((p: any, index: number) => mapearPaqueteTuristico(p, index))
              paquetesFormateados.sort((a: PaqueteTuristico, b: PaqueteTuristico) => Number(a.id) - Number(b.id))
              setPaquetesTuristicos(paquetesFormateados)
            }
            toast({
              title: "Paquete agregado",
              description: "El paquete turístico se ha guardado exitosamente en la base de datos",
            })
          } else {
            toast({
              title: "Error",
              description: data.message || "No se pudo guardar el paquete",
              variant: "destructive",
            })
            return
          }
        } catch (error) {
          toast({
            title: "Error",
            description: "Error de conexión con el servidor",
            variant: "destructive",
          })
          return
        }
      }
    } else if (tipoActual === "operador-turistico") {
      const operador = item as OperadorTuristico
      if (modoEdicion) {
        setOperadoresTuristicos(operadoresTuristicos.map((o) => (o.id === operador.id ? operador : o)))
      } else {
        setOperadoresTuristicos([...operadoresTuristicos, { ...operador, id: Date.now().toString() }])
      }
    } else if (tipoActual === "servicio-adicional") {
      const servicio = item as ServicioAdicional
      if (modoEdicion) {
        setServiciosAdicionales(serviciosAdicionales.map((s) => (s.id === servicio.id ? servicio : s)))
      } else {
        setServiciosAdicionales([...serviciosAdicionales, { ...servicio, id: Date.now().toString() }])
      }
    }
    setDialogOpen(false)
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-foreground">Inventario</h1>
        <p className="text-muted-foreground">Gestiona todos los recursos del sistema turístico</p>
      </div>

      <Tabs defaultValue="vuelos" className="space-y-4">
        <TabsList className="grid w-full grid-cols-6 grid-rows-2 h-auto gap-2 p-2 justify-center">
          <TabsTrigger value="vuelos" className="gap-2 py-3">
            <Plane className="h-4 w-4" />
            Vuelos
          </TabsTrigger>
          <TabsTrigger value="cruceros" className="gap-2 py-3">
            <Ship className="h-4 w-4" />
            Cruceros
          </TabsTrigger>
          <TabsTrigger value="tours" className="gap-2 py-3">
            <MapPin className="h-4 w-4" />
            Traslados
          </TabsTrigger>
          <TabsTrigger value="hospedajes" className="gap-2 py-3">
            <Hotel className="h-4 w-4" />
            Hospedajes
          </TabsTrigger>
          <TabsTrigger value="restaurantes" className="gap-2 py-3">
            <UtensilsCrossed className="h-4 w-4" />
            Restaurantes
          </TabsTrigger>
          <TabsTrigger value="aerolineas" className="gap-2 py-3">
            <Building2 className="h-4 w-4" />
            Aerolíneas
          </TabsTrigger>
          <TabsTrigger value="companias-crucero" className="gap-2 py-3">
            <Ship className="h-4 w-4" />
            Cías. Crucero
          </TabsTrigger>
          <TabsTrigger value="companias-transporte" className="gap-2 py-3">
            <Car className="h-4 w-4" />
            Cías. Transporte
          </TabsTrigger>
          <TabsTrigger value="paquetes" className="gap-2 py-3">
            <Package className="h-4 w-4" />
            Paquetes
          </TabsTrigger>
          <TabsTrigger value="operador-turistico" className="gap-2 py-3">
            <User className="h-4 w-4" />
            Op. Turístico
          </TabsTrigger>
          <TabsTrigger value="servicio-adicional" className="gap-2 py-3">
            <Briefcase className="h-4 w-4" />
            Serv. Adicional
          </TabsTrigger>
        </TabsList>

        <TabsContent value="vuelos" className="space-y-4">
          {isLoadingVuelos ? (
            <Card>
              <CardContent className="flex items-center justify-center py-12">
                <p className="text-muted-foreground">Cargando vuelos...</p>
              </CardContent>
            </Card>
          ) : vuelos.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Plane className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay vuelos registrados</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {vuelos.map((vuelo) => (
                <Card key={vuelo.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Plane className="h-5 w-5 text-primary" />
                          Vuelo {vuelo.numero}
                        </CardTitle>
                        <CardDescription>
                          {vuelo.origen} → {vuelo.destino}
                        </CardDescription>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha y Hora de Salida</p>
                      <p className="font-medium">
                        {vuelo.fecha 
                          ? new Date(vuelo.fecha).toLocaleString("es-ES", {
                              year: 'numeric',
                              month: '2-digit',
                              day: '2-digit',
                              hour: '2-digit',
                              minute: '2-digit'
                            })
                          : "No disponible"}
                      </p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha y Hora de Llegada</p>
                      <p className="font-medium">
                        {vuelo.fechaLlegada 
                          ? new Date(vuelo.fechaLlegada).toLocaleString("es-ES", {
                              year: 'numeric',
                              month: '2-digit',
                              day: '2-digit',
                              hour: '2-digit',
                              minute: '2-digit'
                            })
                          : "No disponible"}
                      </p>
                    </div>
                    {((vuelo.huellaCarbono && vuelo.huellaCarbono > 0) || (vuelo.cantidadMillas && vuelo.cantidadMillas > 0)) && (
                      <div className="pt-2 border-t grid grid-cols-2 gap-4">
                        {vuelo.huellaCarbono && vuelo.huellaCarbono > 0 && (
                          <div>
                            <p className="text-muted-foreground">Huella de Carbono</p>
                            <p className="font-medium text-green-600">{Number(vuelo.huellaCarbono).toFixed(2)} kg CO₂</p>
                          </div>
                        )}
                        {vuelo.cantidadMillas && vuelo.cantidadMillas > 0 && (
                          <div>
                            <p className="text-muted-foreground">Millas</p>
                            <p className="font-medium text-blue-600">{Number(vuelo.cantidadMillas).toLocaleString()}</p>
                          </div>
                        )}
                      </div>
                    )}
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        <TabsContent value="cruceros" className="space-y-4">
          {isLoadingCruceros ? (
            <Card>
              <CardContent className="flex items-center justify-center py-12">
                <p className="text-muted-foreground">Cargando cruceros...</p>
              </CardContent>
            </Card>
          ) : cruceros.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Ship className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay cruceros registrados</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {cruceros.map((crucero) => (
                <Card key={crucero.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Ship className="h-5 w-5 text-accent" />
                          {crucero.nombre}
                        </CardTitle>
                        <CardDescription>
                          {crucero.origen && crucero.destino 
                            ? `${crucero.origen} → ${crucero.destino}`
                            : crucero.ruta || "Ruta no disponible"}
                        </CardDescription>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha y Hora de Salida</p>
                      <p className="font-medium">
                        {crucero.fechaSalida 
                          ? new Date(crucero.fechaSalida).toLocaleString("es-ES", {
                              year: 'numeric',
                              month: '2-digit',
                              day: '2-digit',
                              hour: '2-digit',
                              minute: '2-digit'
                            })
                          : "No disponible"}
                      </p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha y Hora de Llegada</p>
                      <p className="font-medium">
                        {crucero.fechaLlegada 
                          ? new Date(crucero.fechaLlegada).toLocaleString("es-ES", {
                              year: 'numeric',
                              month: '2-digit',
                              day: '2-digit',
                              hour: '2-digit',
                              minute: '2-digit'
                            })
                          : "No disponible"}
                      </p>
                    </div>
                    {((crucero.huellaCarbono && crucero.huellaCarbono > 0) || (crucero.cantidadMillas && crucero.cantidadMillas > 0)) && (
                      <div className="pt-2 border-t grid grid-cols-2 gap-4">
                        {crucero.huellaCarbono && crucero.huellaCarbono > 0 && (
                          <div>
                            <p className="text-muted-foreground">Huella de Carbono</p>
                            <p className="font-medium text-green-600">{Number(crucero.huellaCarbono).toFixed(2)} kg CO₂</p>
                          </div>
                        )}
                        {crucero.cantidadMillas && crucero.cantidadMillas > 0 && (
                          <div>
                            <p className="text-muted-foreground">Millas</p>
                            <p className="font-medium text-blue-600">{Number(crucero.cantidadMillas).toLocaleString()}</p>
                          </div>
                        )}
                      </div>
                    )}
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        <TabsContent value="tours" className="space-y-4">
          {isLoadingTours ? (
            <Card>
              <CardContent className="flex items-center justify-center py-12">
                <p className="text-muted-foreground">Cargando traslados...</p>
              </CardContent>
            </Card>
          ) : tours.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Car className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay traslados registrados</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {tours.map((tour) => (
                <Card key={tour.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Car className="h-5 w-5 text-secondary" />
                          {tour.numero}
                        </CardTitle>
                        <CardDescription>
                          {tour.origen} → {tour.destino}
                        </CardDescription>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha y Hora de Salida</p>
                      <p className="font-medium">
                        {tour.fechaSalida 
                          ? new Date(tour.fechaSalida).toLocaleString("es-ES", {
                              year: 'numeric',
                              month: '2-digit',
                              day: '2-digit',
                              hour: '2-digit',
                              minute: '2-digit'
                            })
                          : "No disponible"}
                      </p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha y Hora de Llegada</p>
                      <p className="font-medium">
                        {tour.fechaLlegada 
                          ? new Date(tour.fechaLlegada).toLocaleString("es-ES", {
                              year: 'numeric',
                              month: '2-digit',
                              day: '2-digit',
                              hour: '2-digit',
                              minute: '2-digit'
                            })
                          : "No disponible"}
                      </p>
                    </div>
                    {((tour.tarifa && tour.tarifa > 0) || (tour.huellaCarbono && tour.huellaCarbono > 0) || (tour.cantidadMillas && tour.cantidadMillas > 0)) && (
                      <div className="pt-2 border-t grid grid-cols-2 gap-4">
                        {tour.tarifa && tour.tarifa > 0 && (
                          <div>
                            <p className="text-muted-foreground">Costo</p>
                            <p className="font-medium">${Number(tour.tarifa).toFixed(2)}</p>
                          </div>
                        )}
                        {tour.cantidadMillas && tour.cantidadMillas > 0 && (
                          <div>
                            <p className="text-muted-foreground">Millas</p>
                            <p className="font-medium text-blue-600">{Number(tour.cantidadMillas).toLocaleString()}</p>
                          </div>
                        )}
                        {tour.huellaCarbono && tour.huellaCarbono > 0 && (
                          <div>
                            <p className="text-muted-foreground">Huella de Carbono</p>
                            <p className="font-medium text-green-600">{Number(tour.huellaCarbono).toFixed(2)} kg CO₂</p>
                          </div>
                        )}
                      </div>
                    )}
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Hospedajes */}
        <TabsContent value="hospedajes" className="space-y-4">
          {isLoadingHospedajes ? (
            <Card>
              <CardContent className="flex items-center justify-center py-12">
                <p className="text-muted-foreground">Cargando hospedajes...</p>
              </CardContent>
            </Card>
          ) : hospedajes.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Hotel className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay hospedajes registrados</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {hospedajes.map((hospedaje) => (
                <Card key={hospedaje.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Hotel className="h-5 w-5 text-primary" />
                          Hospedaje #{hospedaje.id}
                        </CardTitle>
                        <CardDescription>
                          {hospedaje.hotelNombre}
                        </CardDescription>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha de Inicio</p>
                      <p className="font-medium">
                        {hospedaje.fechaInicio 
                          ? new Date(hospedaje.fechaInicio).toLocaleString("es-ES", {
                              year: 'numeric',
                              month: '2-digit',
                              day: '2-digit',
                              hour: '2-digit',
                              minute: '2-digit'
                            })
                          : "No disponible"}
                      </p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha de Fin</p>
                      <p className="font-medium">
                        {hospedaje.fechaFin 
                          ? new Date(hospedaje.fechaFin).toLocaleString("es-ES", {
                              year: 'numeric',
                              month: '2-digit',
                              day: '2-digit',
                              hour: '2-digit',
                              minute: '2-digit'
                            })
                          : "No disponible"}
                      </p>
                    </div>
                    {(hospedaje.costo && hospedaje.costo > 0) || (hospedaje.cantidadMillas && hospedaje.cantidadMillas > 0) ? (
                      <div className="pt-2 border-t space-y-2">
                        {hospedaje.costo && hospedaje.costo > 0 && (
                          <div>
                            <p className="text-muted-foreground">Costo</p>
                            <p className="font-medium">${Number(hospedaje.costo).toFixed(2)}</p>
                          </div>
                        )}
                        {hospedaje.cantidadMillas && hospedaje.cantidadMillas > 0 && (
                          <div>
                            <p className="text-muted-foreground">Millas</p>
                            <p className="font-medium text-blue-600">{Number(hospedaje.cantidadMillas).toLocaleString()}</p>
                          </div>
                        )}
                      </div>
                    ) : null}
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Restaurantes */}
        <TabsContent value="restaurantes" className="space-y-4">
          {isLoadingRestaurantes ? (
            <Card>
              <CardContent className="flex items-center justify-center py-12">
                <p className="text-muted-foreground">Cargando restaurantes...</p>
              </CardContent>
            </Card>
          ) : restaurantes.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <UtensilsCrossed className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay restaurantes registrados</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {restaurantes.map((restaurante) => (
                <Card key={restaurante.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <UtensilsCrossed className="h-5 w-5 text-orange-500" />
                          {restaurante.nombre}
                        </CardTitle>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Dirección</p>
                      <p className="font-medium">{restaurante.direccion || "No disponible"}</p>
                    </div>
                    {restaurante.clasificacion && (
                      <div>
                        <p className="text-muted-foreground">Clasificación</p>
                        <p className="font-medium">{restaurante.clasificacion}</p>
                      </div>
                    )}
                    {restaurante.tipoComida && (
                      <div>
                        <p className="text-muted-foreground">Tipo de Comida</p>
                        <p className="font-medium">{restaurante.tipoComida}</p>
                      </div>
                    )}
                    {restaurante.ambiente && (
                      <div>
                        <p className="text-muted-foreground">Ambiente</p>
                        <p className="font-medium">{restaurante.ambiente}</p>
                      </div>
                    )}
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Aerolíneas */}
        <TabsContent value="aerolineas" className="space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => handleAgregar("aerolinea")} className="gap-2">
              <Plus className="h-4 w-4" />
              Agregar Aerolínea
            </Button>
          </div>

          {aerolineas.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Building2 className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay aerolíneas registradas</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {aerolineas.map((aerolinea) => (
                <Card key={aerolinea.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Building2 className="h-5 w-5 text-primary" />
                          {aerolinea.nombre}
                        </CardTitle>
                      </div>
                      <div className="flex items-center gap-2">
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEditar(aerolinea, "aerolinea")}
                          className="h-8 w-8"
                        >
                          <Pencil className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEliminar(aerolinea.id, "aerolinea")}
                          className="h-8 w-8 text-destructive hover:text-destructive"
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Dirección</p>
                      <p className="font-medium">{aerolinea.direccion}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Teléfono</p>
                      <p className="font-medium">{aerolinea.telefono}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Correo</p>
                      <p className="font-medium">{aerolinea.correo}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha de Fundación</p>
                      <p className="font-medium">
                        {aerolinea.fechaFundacion 
                          ? (aerolinea.fechaFundacion.includes("T") 
                              ? new Date(aerolinea.fechaFundacion).toLocaleDateString("es-ES")
                              : aerolinea.fechaFundacion.split("T")[0])
                          : "No disponible"}
                      </p>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Compañías de Crucero */}
        <TabsContent value="companias-crucero" className="space-y-4">
          {isLoadingCompaniasCrucero ? (
            <Card>
              <CardContent className="flex items-center justify-center py-12">
                <p className="text-muted-foreground">Cargando compañías de crucero...</p>
              </CardContent>
            </Card>
          ) : companiasCrucero.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Ship className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay compañías de crucero registradas</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {companiasCrucero.map((compania) => (
                <Card key={compania.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Ship className="h-5 w-5 text-accent" />
                          {compania.nombre}
                        </CardTitle>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Dirección</p>
                      <p className="font-medium">{compania.direccion}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Teléfono</p>
                      <p className="font-medium">{compania.telefono}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Correo</p>
                      <p className="font-medium">{compania.correo}</p>
                    </div>
                    {compania.fechaFundacion && (
                      <div>
                        <p className="text-muted-foreground">Fecha de Fundación</p>
                        <p className="font-medium">
                          {(() => {
                            try {
                              const fecha = new Date(compania.fechaFundacion);
                              return isNaN(fecha.getTime()) 
                                ? compania.fechaFundacion 
                                : fecha.toLocaleDateString("es-ES", {
                                    year: 'numeric',
                                    month: '2-digit',
                                    day: '2-digit'
                                  });
                            } catch {
                              return compania.fechaFundacion;
                            }
                          })()}
                        </p>
                      </div>
                    )}
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Compañías de Transporte Terrestre */}
        <TabsContent value="companias-transporte" className="space-y-4">
          {isLoadingCompaniasTransporte ? (
            <Card>
              <CardContent className="flex items-center justify-center py-12">
                <p className="text-muted-foreground">Cargando compañías de transporte...</p>
              </CardContent>
            </Card>
          ) : companiasTransporte.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Car className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay compañías de transporte registradas</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {companiasTransporte.map((compania) => (
                <Card key={compania.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Car className="h-5 w-5 text-secondary" />
                          {compania.nombre}
                        </CardTitle>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Dirección</p>
                      <p className="font-medium">{compania.direccion}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Teléfono</p>
                      <p className="font-medium">{compania.telefono}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Correo</p>
                      <p className="font-medium">{compania.correo}</p>
                    </div>
                    {compania.fechaFundacion && (
                      <div>
                        <p className="text-muted-foreground">Fecha de Fundación</p>
                        <p className="font-medium">
                          {(() => {
                            try {
                              const fecha = new Date(compania.fechaFundacion);
                              return isNaN(fecha.getTime()) 
                                ? compania.fechaFundacion 
                                : fecha.toLocaleDateString("es-ES", {
                                    year: 'numeric',
                                    month: '2-digit',
                                    day: '2-digit'
                                  });
                            } catch {
                              return compania.fechaFundacion;
                            }
                          })()}
                        </p>
                      </div>
                    )}
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Paquetes Turísticos */}
        <TabsContent value="paquetes" className="space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => handleAgregar("paquete")} className="gap-2">
              <Plus className="h-4 w-4" />
              Agregar Paquete Turístico
            </Button>
          </div>

          {isLoadingPaquetes ? (
            <Card>
              <CardContent className="flex items-center justify-center py-12">
                <p className="text-muted-foreground">Cargando paquetes turísticos...</p>
              </CardContent>
            </Card>
          ) : paquetesTuristicos.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Package className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay paquetes turísticos registrados</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {paquetesTuristicos.map((paquete) => (
                <Card key={paquete.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Package className="h-5 w-5 text-primary" />
                          {paquete.nombre}
                        </CardTitle>
                        <CardDescription className="line-clamp-2">{paquete.descripcion}</CardDescription>
                      </div>
                      <div className="flex items-center gap-2">
                        <Badge variant={paquete.tipo === "especial" ? "default" : "secondary"}>
                          {paquete.tipo}
                        </Badge>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEditar(paquete, "paquete")}
                          className="h-8 w-8"
                        >
                          <Pencil className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEliminar(paquete.id, "paquete")}
                          className="h-8 w-8 text-destructive hover:text-destructive"
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div className="grid grid-cols-2 gap-4">
                      <div>
                        <p className="text-muted-foreground">Costo</p>
                        <p className="font-medium">${Number(paquete.costo).toFixed(2)}</p>
                      </div>
                      <div>
                        <p className="text-muted-foreground">Costo en Millas</p>
                        <p className="font-medium">{paquete.costoMillas}</p>
                      </div>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Millas que Otorga</p>
                      <p className="font-medium">{paquete.millasOtorga}</p>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Operador Turístico */}
        <TabsContent value="operador-turistico" className="space-y-4">
          {isLoadingOperadoresTuristicos ? (
            <Card>
              <CardContent className="flex items-center justify-center py-12">
                <p className="text-muted-foreground">Cargando operadores turísticos...</p>
              </CardContent>
            </Card>
          ) : operadoresTuristicos.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <User className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay operadores turísticos registrados</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {operadoresTuristicos.map((operador) => (
                <Card key={operador.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <User className="h-5 w-5 text-primary" />
                          {operador.nombre}
                        </CardTitle>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    {operador.direccion && (
                      <div>
                        <p className="text-muted-foreground">Dirección</p>
                        <p className="font-medium">{operador.direccion}</p>
                      </div>
                    )}
                    {operador.telefono && (
                      <div>
                        <p className="text-muted-foreground">Teléfono</p>
                        <p className="font-medium">{operador.telefono}</p>
                      </div>
                    )}
                    {operador.correo && (
                      <div>
                        <p className="text-muted-foreground">Correo</p>
                        <p className="font-medium">{operador.correo}</p>
                      </div>
                    )}
                    {operador.fechaFundacion && (
                      <div>
                        <p className="text-muted-foreground">Fecha de Fundación</p>
                        <p className="font-medium">
                          {(() => {
                            try {
                              const fecha = new Date(operador.fechaFundacion);
                              return isNaN(fecha.getTime()) 
                                ? operador.fechaFundacion 
                                : fecha.toLocaleDateString("es-ES", {
                                    year: 'numeric',
                                    month: '2-digit',
                                    day: '2-digit'
                                  });
                            } catch {
                              return operador.fechaFundacion;
                            }
                          })()}
                        </p>
                      </div>
                    )}
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Servicio Adicional */}
        <TabsContent value="servicio-adicional" className="space-y-4">
          {isLoadingServiciosAdicionales ? (
            <Card>
              <CardContent className="flex items-center justify-center py-12">
                <p className="text-muted-foreground">Cargando servicios adicionales...</p>
              </CardContent>
            </Card>
          ) : serviciosAdicionales.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Briefcase className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay servicios adicionales registrados</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {serviciosAdicionales.map((servicio) => (
                <Card key={servicio.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Briefcase className="h-5 w-5 text-primary" />
                          {servicio.nombre}
                        </CardTitle>
                        <CardDescription className="line-clamp-2">{servicio.descripcion}</CardDescription>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    {servicio.tipo && (
                      <div>
                        <p className="text-muted-foreground">Tipo</p>
                        <p className="font-medium">{servicio.tipo}</p>
                      </div>
                    )}
                    {servicio.costo && servicio.costo > 0 && (
                      <div>
                        <p className="text-muted-foreground">Costo</p>
                        <p className="font-medium">${Number(servicio.costo).toFixed(2)}</p>
                      </div>
                    )}
                    {servicio.cantidadMillas && servicio.cantidadMillas > 0 && (
                      <div>
                        <p className="text-muted-foreground">Millas</p>
                        <p className="font-medium text-blue-600">{Number(servicio.cantidadMillas).toLocaleString()}</p>
                      </div>
                    )}
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>
      </Tabs>

      <InventarioDialog
        open={dialogOpen}
        onOpenChange={setDialogOpen}
        tipo={tipoActual}
        item={itemSeleccionado}
        onGuardar={handleGuardar}
        modoEdicion={modoEdicion}
      />
    </div>
  )
}
