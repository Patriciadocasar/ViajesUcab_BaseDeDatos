"use client"

import { useRouter } from "next/navigation"
import { useEffect } from "react"

export default function ProveedorDashboard() {
  const router = useRouter()

  useEffect(() => {
    // Redirigir directamente a la flota
    router.push("/proveedores/flota")
  }, [router])

  return null
}

