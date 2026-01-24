"use client"

import { createContext, useContext, useState, useEffect, type ReactNode } from "react"
import type { CartItem } from "./cart-context"
import { useUser } from "./user-context"

export interface Purchase {
  id: string
  reservationNumber: string
  items: CartItem[]
  totalPrice: number
  purchaseDate: string
  status: "completed" | "pending" | "cancelled"
  milesEarned: number
}

interface PurchaseHistoryContextType {
  purchases: Purchase[]
  addPurchase: (purchase: Purchase) => void
  getTotalSpent: () => number
  getTotalMilesEarned: () => number
  isLoading: boolean
}

const PurchaseHistoryContext = createContext<PurchaseHistoryContextType | undefined>(undefined)

export function PurchaseHistoryProvider({ children }: { children: ReactNode }) {
  const [purchases, setPurchases] = useState<Purchase[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const { user, isAuthenticated } = useUser()

  // Load purchases from database when user is authenticated
  useEffect(() => {
    const loadPurchasesFromDB = async () => {
      console.log("=== PURCHASE HISTORY CONTEXT ===")
      console.log("isAuthenticated:", isAuthenticated)
      console.log("user:", user)
      console.log("user?.clienteId:", user?.clienteId)
      
      if (!isAuthenticated || !user?.clienteId) {
        console.log("❌ No hay clienteId o no está autenticado")
        setPurchases([])
        setIsLoading(false)
        return
      }

      setIsLoading(true)
      try {
        console.log("🔍 Cargando itinerarios comprados del cliente:", user.clienteId)
        const response = await fetch(`/api/itinerarios/cliente/${user.clienteId}`)
        
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`)
        }

        const result = await response.json()
        console.log("📦 Resultado de la API:", result)

        if (result.status === "success" && result.data?.reservas) {
          // Transform database data to Purchase[] format
          const transformedPurchases: Purchase[] = result.data.reservas.map((reserva: any) => {
            // Transform itinerarios to CartItem[]
            const items: CartItem[] = reserva.itinerarios?.map((itinerario: any) => {
              // Determine service type and create appropriate item
              let serviceType = "itinerary"
              let serviceTitle = `Itinerario #${itinerario.itinerario_id}`
              
              if (itinerario.vuelo) {
                serviceType = "flight"
                serviceTitle = "Vuelo"
              } else if (itinerario.hospedaje) {
                serviceType = "hotel"
                serviceTitle = itinerario.hospedaje.hotel_nombre || "Hospedaje"
              } else if (itinerario.crucero) {
                serviceType = "cruise"
                serviceTitle = itinerario.crucero.nombre || "Crucero"
              } else if (itinerario.transporte_terrestre) {
                serviceType = "transport"
                serviceTitle = "Transporte Terrestre"
              } else if (itinerario.paquete_turistico) {
                serviceType = "package"
                serviceTitle = itinerario.paquete_turistico.nombre || "Paquete Turístico"
              } else if (itinerario.servicio_adicional) {
                serviceType = "activity"
                serviceTitle = itinerario.servicio_adicional.nombre || "Servicio Adicional"
              }

              return {
                id: itinerario.itinerario_id.toString(),
                title: serviceTitle,
                location: "Múltiples destinos",
                price: parseFloat(itinerario.costo_total) || 0,
                type: serviceType as any,
                quantity: 1,
                millas: parseInt(itinerario.millas_totales) || 0,
              }
            }) || []

            return {
              id: reserva.reserva_id.toString(),
              reservationNumber: reserva.numero_reserva.toString(),
              items: items,
              totalPrice: parseFloat(reserva.total) || 0,
              purchaseDate: reserva.fecha_reserva || new Date().toISOString(),
              status: "completed" as const,
              milesEarned: parseInt(reserva.millas_obtenidas) || 0,
            }
          })

          console.log("✅ Compras transformadas:", transformedPurchases)
          setPurchases(transformedPurchases)
        } else {
          console.log("ℹ️ No hay reservas para este cliente")
          setPurchases([])
        }
      } catch (e) {
        console.error("❌ Error loading purchase history from DB:", e)
        setPurchases([])
      } finally {
        setIsLoading(false)
      }
    }

    loadPurchasesFromDB()
  }, [isAuthenticated, user?.clienteId])

  const addPurchase = (purchase: Purchase) => {
    setPurchases((prev) => [purchase, ...prev])
  }

  const getTotalSpent = () => {
    return purchases.reduce((sum, purchase) => sum + purchase.totalPrice, 0)
  }

  const getTotalMilesEarned = () => {
    return purchases.reduce((sum, purchase) => sum + purchase.milesEarned, 0)
  }

  return (
    <PurchaseHistoryContext.Provider value={{ purchases, addPurchase, getTotalSpent, getTotalMilesEarned, isLoading }}>
      {children}
    </PurchaseHistoryContext.Provider>
  )
}

export function usePurchaseHistory() {
  const context = useContext(PurchaseHistoryContext)
  if (!context) {
    throw new Error("usePurchaseHistory must be used within PurchaseHistoryProvider")
  }
  return context
}
