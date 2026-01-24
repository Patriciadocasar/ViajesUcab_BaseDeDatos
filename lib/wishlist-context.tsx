"use client"

import { createContext, useContext, useState, useEffect, type ReactNode } from "react"
import { useUser } from "./user-context"
import { useToast } from "@/hooks/use-toast"

export interface WishlistItem {
  wishlist_id: string
  itinerario_id: string
  descripcion: string
  fecha_agregado: string
  costo_total: number
  fecha_inicio: string
  fecha_fin: string
}

interface WishlistContextType {
  wishlist: WishlistItem[]
  isLoading: boolean
  addToWishlist: (itinerario_id: number, descripcion?: string) => Promise<boolean>
  removeFromWishlist: (wishlist_id: string) => Promise<boolean>
  refreshWishlist: () => Promise<void>
  isInWishlist: (itinerario_id: number) => boolean
}

const WishlistContext = createContext<WishlistContextType | undefined>(undefined)

export function WishlistProvider({ children }: { children: ReactNode }) {
  const [wishlist, setWishlist] = useState<WishlistItem[]>([])
  const [isLoading, setIsLoading] = useState(false)
  const { user, isAuthenticated } = useUser()
  const { toast } = useToast()

  // Cargar wishlist cuando el usuario está autenticado
  useEffect(() => {
    if (isAuthenticated && user?.clienteId) {
      loadWishlist()
    } else {
      setWishlist([])
    }
  }, [isAuthenticated, user?.clienteId])

  const loadWishlist = async () => {
    if (!user?.clienteId) return

    setIsLoading(true)
    try {
      const response = await fetch(`/api/wishlist?cliente_id=${user.clienteId}`)
      const result = await response.json()

      if (result.status === "success") {
        setWishlist(result.data)
      }
    } catch (error) {
      console.error("Error loading wishlist:", error)
    } finally {
      setIsLoading(false)
    }
  }

  const addToWishlist = async (itinerario_id: number, descripcion?: string): Promise<boolean> => {
    if (!user?.clienteId) {
      toast({
        title: "Error",
        description: "Debes iniciar sesión para agregar a tu lista de deseos",
        variant: "destructive",
      })
      return false
    }

    try {
      const response = await fetch("/api/wishlist", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          cliente_id: parseInt(user.clienteId),
          itinerario_id,
          descripcion: descripcion || "Itinerario guardado",
        }),
      })

      const result = await response.json()

      if (result.status === "success") {
        toast({
          title: "¡Agregado a wishlist!",
          description: "El itinerario se ha agregado a tu lista de deseos",
        })
        await loadWishlist() // Recargar la wishlist
        return true
      } else {
        toast({
          title: "Error",
          description: result.message || "No se pudo agregar a la wishlist",
          variant: "destructive",
        })
        return false
      }
    } catch (error) {
      console.error("Error adding to wishlist:", error)
      toast({
        title: "Error",
        description: "Ocurrió un error al agregar a la wishlist",
        variant: "destructive",
      })
      return false
    }
  }

  const removeFromWishlist = async (wishlist_id: string): Promise<boolean> => {
    try {
      const response = await fetch(`/api/wishlist?wishlist_id=${wishlist_id}`, {
        method: "DELETE",
      })

      const result = await response.json()

      if (result.status === "success") {
        toast({
          title: "Eliminado",
          description: "El itinerario se ha eliminado de tu wishlist",
        })
        await loadWishlist() // Recargar la wishlist
        return true
      } else {
        toast({
          title: "Error",
          description: result.message || "No se pudo eliminar de la wishlist",
          variant: "destructive",
        })
        return false
      }
    } catch (error) {
      console.error("Error removing from wishlist:", error)
      toast({
        title: "Error",
        description: "Ocurrió un error al eliminar de la wishlist",
        variant: "destructive",
      })
      return false
    }
  }

  const refreshWishlist = async () => {
    await loadWishlist()
  }

  const isInWishlist = (itinerario_id: number): boolean => {
    return wishlist.some((item) => item.itinerario_id === itinerario_id)
  }

  return (
    <WishlistContext.Provider
      value={{
        wishlist,
        isLoading,
        addToWishlist,
        removeFromWishlist,
        refreshWishlist,
        isInWishlist,
      }}
    >
      {children}
    </WishlistContext.Provider>
  )
}

export function useWishlist() {
  const context = useContext(WishlistContext)
  if (!context) {
    throw new Error("useWishlist must be used within WishlistProvider")
  }
  return context
}
