"use client"

import { createContext, useContext, useState, useEffect, type ReactNode } from "react"
export interface User {
  id: string
  name: string
  email: string
  role: number // ahora es numérico
}

interface UserContextType {
  user: User | null
  isAuthenticated: boolean
  login: (email: string, password: string) => Promise<void>
  logout: () => void
  updateProfile: (updates: Partial<User>) => void
 hasRole: (role: number | number[]) => boolean

  canAccess: (path: string) => boolean
}

const UserContext = createContext<UserContextType | undefined>(undefined)

export function UserProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null)

  // Load user from localStorage on mount
  useEffect(() => {
    const storedUser = localStorage.getItem("currentUser")
    if (storedUser) {
      try {
        setUser(JSON.parse(storedUser))
      } catch (e) {
        console.error("Error loading user:", e)
      }
    }
  }, [])

  // Save user to localStorage whenever it changes
  useEffect(() => {
    if (user) {
      localStorage.setItem("currentUser", JSON.stringify(user))
    } else {
      localStorage.removeItem("currentUser")
    }
  }, [user])

  const login = async (email: string, password: string) => {
    if (!email || !password) {
      throw new Error("Email y contraseña son requeridos")
    }

    const res = await fetch("/api/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password }),
    })

    const data = await res.json()

    if (!res.ok || data.status === "error") {
      throw new Error(data.message || "Error al iniciar sesión")
    }

    // Mapear respuesta de Postgres a nuestro User
    const loggedUser: User = {
      id: data.usuario_ID.toString(),
      name: `${data.primerNombre} ${data.primerApellido}`,
      email: data.email,
      role: data.rol_ID, // numérico directo
    }

    setUser(loggedUser)
  }

  const logout = () => {
    setUser(null)
  }

  const updateProfile = (updates: Partial<User>) => {
    if (user) {
      setUser({ ...user, ...updates })
    }
  }

  const hasRole = (role: number | number[]): boolean => {
    if (!user) return false
    if (Array.isArray(role)) {
      return role.includes(user.role)
    }
    return user.role === role
  }

  const canAccess = (path: string): boolean => {
    if (!user) return false
  
    if (user.role === 1) return true // admin
    if (path.startsWith("/auth") || path === "/") return true
  
    if (user.role === 3) { // cliente
      return path.startsWith("/clientes")
    }
  
    if (user.role === 2) { // proveedor
      return path.startsWith("/proveedores")
    }
  
    return false
  }

  return (
    <UserContext.Provider
      value={{ user, isAuthenticated: !!user, login, logout, updateProfile, hasRole, canAccess }}
    >
      {children}
    </UserContext.Provider>
  )
}

export function useUser() {
  const context = useContext(UserContext)
  if (!context) {
    throw new Error("useUser must be used within UserProvider")
  }
  return context
}
