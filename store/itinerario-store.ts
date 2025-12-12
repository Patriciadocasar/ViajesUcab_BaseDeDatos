import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'

// ==================== TYPES ====================

export interface Usuario {
  usu_cod: number
  usu_primer_nombre: string
  usu_segundo_nombre?: string
  usu_primer_apellido: string
  usu_segundo_apellido?: string
  usu_correo: string
  cliente_cli_cod?: number
  compania_crucero?: number
  operador_turistico?: number
  aerolinea?: number
  transporte_terrestre?: number
  hotel?: number
  empleado_emp_cod?: number
  rol_rol_cod?: number
}

export interface Hospedaje {
  hos_cod: number
  hos_fecha_hora_inicio: string
  hos_fecha_hora_fin: string
  hos_costo: number
  hotel_pro_cod?: number
  hot_cant_milla: number
  hotel_nombre?: string
  hotel_direccion?: string
  lugar_nombre?: string
  imagen?: string
}

export interface PaqueteTuristico {
  pt_cod: number
  pt_nombre: string
  pt_descripcion: string
  pt_costo: number
  pt_costo_millas: number
  pt_cant_milla: number
  pt_tipo: string
  promocion_promocion_id?: number
  imagen?: string
}

export interface Restaurante {
  rest_cod: number
  rest_nombre: string
  rest_direccion: string
  rest_clasificacion: number
  lugar_lug_cod?: number
  rest_tipo_comida: string
  rest_ambiente: string
  costo?: number
  cant_millas?: number
  imagen?: string
}

export interface Vuelo {
  vue_cod: number
  avion_avi_cod?: number
  vue_huella_carbono: number
  vue_fecha_hora_salida: string
  vue_fecha_hora_llegada: string
  vue_cant_millas: number
  costo?: number
  origen?: string
  destino?: string
  aerolinea_nombre?: string
  imagen?: string
}

export interface Crucero {
  cru_cod: number
  cru_nombre: string
  barco_bar_cod?: number
  cru_huella_carbono: number
  cru_fecha_hora_salida: string
  cru_fecha_hora_llegada: string
  cru_cant_millas: number
  costo?: number
  origen?: string
  destino?: string
  compania_nombre?: string
  imagen?: string
}

export interface ServicioAdicional {
  sa_cod: number
  sa_tipo: string
  sa_nombre: string
  operador_turistico_pro_cod?: number
  sa_descripcion?: string
  sa_costo: number
  sa_cant_milla: number
  sa_fecha_hora_inicio: string
  sa_fecha_hora_fin: string
  operador_nombre?: string
  imagen?: string
}

export interface TransporteTerrestre {
  tt_cod: number
  tt_nombre: string
  vehiculo_veh_cod?: number
  tt_huella_carbono: number
  tt_fecha_hora_salida: string
  tt_fecha_hora_llegada: string
  tt_cant_millas: number
  costo?: number
  origen?: string
  destino?: string
  compania_nombre?: string
  tipo_vehiculo?: string
  imagen?: string
}

export interface Itinerario {
  iti_cod?: number
  paquete_turistico?: PaqueteTuristico
  hospedajes: Hospedaje[]
  restaurantes: Restaurante[]
  vuelos: Vuelo[]
  cruceros: Crucero[]
  transportes_terrestres: TransporteTerrestre[]
  servicios_adicionales: ServicioAdicional[]
  iti_costo_total: number
  iti_cant_milla_total: number
  iti_fecha_inicio?: string
  iti_fecha_fin?: string
  compensacion_carbono?: number
}

// ==================== STORE STATE ====================

interface ItinerarioState {
  // Usuario autenticado
  usuario: Usuario | null
  isAuthenticated: boolean

  // Itinerario (carrito)
  itinerario: Itinerario

  // Actions - Autenticación
  login: (usuario: Usuario) => void
  logout: () => void
  updateUsuario: (usuario: Partial<Usuario>) => void

  // Actions - Paquete Turístico
  setPaqueteTuristico: (paquete: PaqueteTuristico) => void
  removePaqueteTuristico: () => void

  // Actions - Hospedaje
  addHospedaje: (hospedaje: Hospedaje) => void
  removeHospedaje: (hos_cod: number) => void
  clearHospedajes: () => void

  // Actions - Restaurante
  addRestaurante: (restaurante: Restaurante) => void
  removeRestaurante: (rest_cod: number) => void
  clearRestaurantes: () => void

  // Actions - Vuelo
  addVuelo: (vuelo: Vuelo) => void
  removeVuelo: (vue_cod: number) => void
  clearVuelos: () => void

  // Actions - Crucero
  addCrucero: (crucero: Crucero) => void
  removeCrucero: (cru_cod: number) => void
  clearCruceros: () => void

  // Actions - Transporte Terrestre
  addTransporteTerrestre: (transporte: TransporteTerrestre) => void
  removeTransporteTerrestre: (tt_cod: number) => void
  clearTransportesTerrestres: () => void

  // Actions - Servicio Adicional
  addServicioAdicional: (servicio: ServicioAdicional) => void
  removeServicioAdicional: (sa_cod: number) => void
  clearServiciosAdicionales: () => void

  // Actions - Compensación de carbono
  setCompensacionCarbono: (monto: number) => void
  removeCompensacionCarbono: () => void

  // Actions - Fechas del itinerario
  setFechasItinerario: (fechaInicio: string, fechaFin: string) => void

  // Actions - Limpiar todo
  clearItinerario: () => void

  // Computed values
  getTotalItems: () => number
  getTotalCosto: () => number
  getTotalMillas: () => number
  getHuellaCarbono: () => number
}

// ==================== INITIAL STATE ====================

const initialItinerario: Itinerario = {
  hospedajes: [],
  restaurantes: [],
  vuelos: [],
  cruceros: [],
  transportes_terrestres: [],
  servicios_adicionales: [],
  iti_costo_total: 0,
  iti_cant_milla_total: 0,
}

// ==================== HELPER FUNCTIONS ====================

const calculateTotalCosto = (itinerario: Itinerario): number => {
  let total = 0

  // Paquete turístico
  if (itinerario.paquete_turistico) {
    total += itinerario.paquete_turistico.pt_costo
  }

  // Hospedajes
  itinerario.hospedajes.forEach(h => total += h.hos_costo)

  // Restaurantes
  itinerario.restaurantes.forEach(r => total += r.costo || 0)

  // Vuelos
  itinerario.vuelos.forEach(v => total += v.costo || 0)

  // Cruceros
  itinerario.cruceros.forEach(c => total += c.costo || 0)

  // Transportes terrestres
  itinerario.transportes_terrestres.forEach(t => total += t.costo || 0)

  // Servicios adicionales
  itinerario.servicios_adicionales.forEach(s => total += s.sa_costo)

  // Compensación de carbono
  if (itinerario.compensacion_carbono) {
    total += itinerario.compensacion_carbono
  }

  return total
}

const calculateTotalMillas = (itinerario: Itinerario): number => {
  let total = 0

  // Paquete turístico
  if (itinerario.paquete_turistico) {
    total += itinerario.paquete_turistico.pt_cant_milla
  }

  // Hospedajes
  itinerario.hospedajes.forEach(h => total += h.hot_cant_milla)

  // Restaurantes
  itinerario.restaurantes.forEach(r => total += r.cant_millas || 0)

  // Vuelos
  itinerario.vuelos.forEach(v => total += v.vue_cant_millas)

  // Cruceros
  itinerario.cruceros.forEach(c => total += c.cru_cant_millas)

  // Transportes terrestres
  itinerario.transportes_terrestres.forEach(t => total += t.tt_cant_millas)

  // Servicios adicionales
  itinerario.servicios_adicionales.forEach(s => total += s.sa_cant_milla)

  return total
}

const calculateHuellaCarbono = (itinerario: Itinerario): number => {
  let total = 0

  // Vuelos
  itinerario.vuelos.forEach(v => total += v.vue_huella_carbono)

  // Cruceros
  itinerario.cruceros.forEach(c => total += c.cru_huella_carbono)

  // Transportes terrestres
  itinerario.transportes_terrestres.forEach(t => total += t.tt_huella_carbono)

  return total
}

// ==================== ZUSTAND STORE ====================

export const useItinerarioStore = create<ItinerarioState>()(
  persist(
    (set, get) => ({
      // Estado inicial
      usuario: null,
      isAuthenticated: false,
      itinerario: initialItinerario,

      // ========== AUTENTICACIÓN ==========

      login: (usuario: Usuario) => {
        set({
          usuario,
          isAuthenticated: true
        })
      },

      logout: () => {
        set({
          usuario: null,
          isAuthenticated: false,
          itinerario: initialItinerario
        })
      },

      updateUsuario: (usuarioUpdate: Partial<Usuario>) => {
        set((state) => ({
          usuario: state.usuario ? { ...state.usuario, ...usuarioUpdate } : null
        }))
      },

      // ========== PAQUETE TURÍSTICO ==========

      setPaqueteTuristico: (paquete: PaqueteTuristico) => {
        set((state) => {
          const newItinerario = { ...state.itinerario, paquete_turistico: paquete }
          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      removePaqueteTuristico: () => {
        set((state) => {
          const newItinerario = { ...state.itinerario, paquete_turistico: undefined }
          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      // ========== HOSPEDAJE ==========

      addHospedaje: (hospedaje: Hospedaje) => {
        set((state) => {
          const exists = state.itinerario.hospedajes.find(h => h.hos_cod === hospedaje.hos_cod)
          if (exists) return state

          const newItinerario = {
            ...state.itinerario,
            hospedajes: [...state.itinerario.hospedajes, hospedaje]
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      removeHospedaje: (hos_cod: number) => {
        set((state) => {
          const newItinerario = {
            ...state.itinerario,
            hospedajes: state.itinerario.hospedajes.filter(h => h.hos_cod !== hos_cod)
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      clearHospedajes: () => {
        set((state) => {
          const newItinerario = { ...state.itinerario, hospedajes: [] }
          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      // ========== RESTAURANTE ==========

      addRestaurante: (restaurante: Restaurante) => {
        set((state) => {
          const exists = state.itinerario.restaurantes.find(r => r.rest_cod === restaurante.rest_cod)
          if (exists) return state

          const newItinerario = {
            ...state.itinerario,
            restaurantes: [...state.itinerario.restaurantes, restaurante]
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      removeRestaurante: (rest_cod: number) => {
        set((state) => {
          const newItinerario = {
            ...state.itinerario,
            restaurantes: state.itinerario.restaurantes.filter(r => r.rest_cod !== rest_cod)
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      clearRestaurantes: () => {
        set((state) => {
          const newItinerario = { ...state.itinerario, restaurantes: [] }
          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      // ========== VUELO ==========

      addVuelo: (vuelo: Vuelo) => {
        set((state) => {
          const exists = state.itinerario.vuelos.find(v => v.vue_cod === vuelo.vue_cod)
          if (exists) return state

          const newItinerario = {
            ...state.itinerario,
            vuelos: [...state.itinerario.vuelos, vuelo]
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      removeVuelo: (vue_cod: number) => {
        set((state) => {
          const newItinerario = {
            ...state.itinerario,
            vuelos: state.itinerario.vuelos.filter(v => v.vue_cod !== vue_cod)
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      clearVuelos: () => {
        set((state) => {
          const newItinerario = { ...state.itinerario, vuelos: [] }
          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      // ========== CRUCERO ==========

      addCrucero: (crucero: Crucero) => {
        set((state) => {
          const exists = state.itinerario.cruceros.find(c => c.cru_cod === crucero.cru_cod)
          if (exists) return state

          const newItinerario = {
            ...state.itinerario,
            cruceros: [...state.itinerario.cruceros, crucero]
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      removeCrucero: (cru_cod: number) => {
        set((state) => {
          const newItinerario = {
            ...state.itinerario,
            cruceros: state.itinerario.cruceros.filter(c => c.cru_cod !== cru_cod)
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      clearCruceros: () => {
        set((state) => {
          const newItinerario = { ...state.itinerario, cruceros: [] }
          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      // ========== TRANSPORTE TERRESTRE ==========

      addTransporteTerrestre: (transporte: TransporteTerrestre) => {
        set((state) => {
          const exists = state.itinerario.transportes_terrestres.find(t => t.tt_cod === transporte.tt_cod)
          if (exists) return state

          const newItinerario = {
            ...state.itinerario,
            transportes_terrestres: [...state.itinerario.transportes_terrestres, transporte]
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      removeTransporteTerrestre: (tt_cod: number) => {
        set((state) => {
          const newItinerario = {
            ...state.itinerario,
            transportes_terrestres: state.itinerario.transportes_terrestres.filter(t => t.tt_cod !== tt_cod)
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      clearTransportesTerrestres: () => {
        set((state) => {
          const newItinerario = { ...state.itinerario, transportes_terrestres: [] }
          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      // ========== SERVICIO ADICIONAL ==========

      addServicioAdicional: (servicio: ServicioAdicional) => {
        set((state) => {
          const exists = state.itinerario.servicios_adicionales.find(s => s.sa_cod === servicio.sa_cod)
          if (exists) return state

          const newItinerario = {
            ...state.itinerario,
            servicios_adicionales: [...state.itinerario.servicios_adicionales, servicio]
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      removeServicioAdicional: (sa_cod: number) => {
        set((state) => {
          const newItinerario = {
            ...state.itinerario,
            servicios_adicionales: state.itinerario.servicios_adicionales.filter(s => s.sa_cod !== sa_cod)
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      clearServiciosAdicionales: () => {
        set((state) => {
          const newItinerario = { ...state.itinerario, servicios_adicionales: [] }
          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario),
              iti_cant_milla_total: calculateTotalMillas(newItinerario)
            }
          }
        })
      },

      // ========== COMPENSACIÓN DE CARBONO ==========

      setCompensacionCarbono: (monto: number) => {
        set((state) => {
          const newItinerario = {
            ...state.itinerario,
            compensacion_carbono: monto
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario)
            }
          }
        })
      },

      removeCompensacionCarbono: () => {
        set((state) => {
          const newItinerario = {
            ...state.itinerario,
            compensacion_carbono: undefined
          }

          return {
            itinerario: {
              ...newItinerario,
              iti_costo_total: calculateTotalCosto(newItinerario)
            }
          }
        })
      },

      // ========== FECHAS ==========

      setFechasItinerario: (fechaInicio: string, fechaFin: string) => {
        set((state) => ({
          itinerario: {
            ...state.itinerario,
            iti_fecha_inicio: fechaInicio,
            iti_fecha_fin: fechaFin
          }
        }))
      },

      // ========== LIMPIAR TODO ==========

      clearItinerario: () => {
        set({ itinerario: initialItinerario })
      },

      // ========== COMPUTED VALUES ==========

      getTotalItems: () => {
        const state = get()
        return (
          state.itinerario.hospedajes.length +
          state.itinerario.restaurantes.length +
          state.itinerario.vuelos.length +
          state.itinerario.cruceros.length +
          state.itinerario.transportes_terrestres.length +
          state.itinerario.servicios_adicionales.length +
          (state.itinerario.paquete_turistico ? 1 : 0)
        )
      },

      getTotalCosto: () => {
        const state = get()
        return state.itinerario.iti_costo_total
      },

      getTotalMillas: () => {
        const state = get()
        return state.itinerario.iti_cant_milla_total
      },

      getHuellaCarbono: () => {
        const state = get()
        return calculateHuellaCarbono(state.itinerario)
      }
    }),
    {
      name: 'viajes-ucab-itinerario',
      storage: createJSONStorage(() => localStorage),
      partialize: (state) => ({
        usuario: state.usuario,
        isAuthenticated: state.isAuthenticated,
        itinerario: state.itinerario
      })
    }
  )
)
