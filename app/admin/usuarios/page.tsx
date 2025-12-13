"use client"

import { useState, useEffect } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Badge } from "@/components/ui/badge"
import { ArrowLeft, Users, Search, Mail, User, UserCircle } from "lucide-react"
import { useRouter } from "next/navigation"
import { useToast } from "@/hooks/use-toast"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"

type Usuario = {
  id: number
  correo: string
  primer_nombre: string
  segundo_nombre?: string
  primer_apellido: string
  segundo_apellido?: string
  rol_id: number
  rol_tipo: string
  cliente_id?: number
  proveedor_nombre?: string
  tipo_proveedor?: string
  compania_crucero_id?: number
  operador_turistico_id?: number
  aerolinea_id?: number
  transporte_terrestre_id?: number
  hotel_id?: number
  empleado_id?: number
}

export default function UsuariosPage() {
  const router = useRouter()
  const { toast } = useToast()
  const [usuarios, setUsuarios] = useState<Usuario[]>([])
  const [usuariosFiltrados, setUsuariosFiltrados] = useState<Usuario[]>([])
  const [searchTerm, setSearchTerm] = useState("")
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    cargarDatos()
  }, [])

  useEffect(() => {
    filtrarUsuarios()
  }, [searchTerm, usuarios])

  const cargarDatos = async () => {
    try {
      setIsLoading(true)
      
      // Cargar usuarios
      console.log("🔍 Cargando usuarios desde /api/gestion-usuario...")
      const resUsuarios = await fetch("/api/gestion-usuario")
      console.log("📡 Respuesta status:", resUsuarios.status)
      
      const dataUsuarios = await resUsuarios.json()
      console.log("📦 Datos recibidos:", dataUsuarios)
      
      if (dataUsuarios.status === "success" && Array.isArray(dataUsuarios.data)) {
        console.log("✅ Usuarios encontrados:", dataUsuarios.data.length)
        console.log("👥 Primer usuario:", dataUsuarios.data[0])
        setUsuarios(dataUsuarios.data)
        setUsuariosFiltrados(dataUsuarios.data)
      } else {
        console.error("❌ Formato de respuesta inesperado o sin datos")
      }

    } catch (error) {
      console.error("❌ Error cargando datos:", error)
      toast({
        title: "Error",
        description: error instanceof Error ? error.message : "Error al cargar los datos",
        variant: "destructive",
      })
    } finally {
      setIsLoading(false)
    }
  }

  const filtrarUsuarios = () => {
    if (!searchTerm.trim()) {
      setUsuariosFiltrados(usuarios)
      return
    }

    const term = searchTerm.toLowerCase()
    const filtrados = usuarios.filter(usuario => 
      usuario.correo.toLowerCase().includes(term) ||
      usuario.primer_nombre.toLowerCase().includes(term) ||
      usuario.primer_apellido.toLowerCase().includes(term) ||
      usuario.rol_tipo.toLowerCase().includes(term) ||
      (usuario.proveedor_nombre && usuario.proveedor_nombre.toLowerCase().includes(term))
    )
    setUsuariosFiltrados(filtrados)
  }

  const getNombreCompleto = (usuario: Usuario) => {
    const partes = [
      usuario.primer_nombre,
      usuario.segundo_nombre,
      usuario.primer_apellido,
      usuario.segundo_apellido
    ].filter(Boolean)
    return partes.join(" ")
  }

  const getRolBadge = (rol: string) => {
    const roleColors: { [key: string]: string } = {
      "Administrador": "bg-red-500",
      "Proveedor": "bg-blue-500",
      "Cliente": "bg-green-500",
    }
    
    return roleColors[rol] || "bg-gray-500"
  }

  return (
    <div className="container mx-auto p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Button
            variant="ghost"
            size="icon"
            onClick={() => router.push("/admin")}
          >
            <ArrowLeft className="h-5 w-5" />
          </Button>
          <div>
            <h1 className="text-3xl font-bold flex items-center gap-2">
              <Users className="h-8 w-8" />
              Gestionar Usuarios
            </h1>
            <p className="text-muted-foreground">
              Visualiza todos los usuarios registrados en el sistema
            </p>
          </div>
        </div>
      </div>

      {/* Search Bar */}
      <Card>
        <CardContent className="pt-6">
          <div className="flex gap-4 items-center">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input
                placeholder="Buscar por nombre, correo, rol o proveedor..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="pl-10"
              />
            </div>
            <Badge variant="secondary" className="text-sm">
              {usuariosFiltrados.length} usuario{usuariosFiltrados.length !== 1 ? 's' : ''}
            </Badge>
          </div>
        </CardContent>
      </Card>

      {/* Tabla de Usuarios */}
      <Card>
        <CardHeader>
          <CardTitle>Lista de Usuarios</CardTitle>
          <CardDescription>
            Visualiza todos los usuarios registrados en el sistema
          </CardDescription>
        </CardHeader>
        <CardContent>
          {isLoading ? (
            <div className="flex items-center justify-center py-12">
              <p className="text-muted-foreground">Cargando usuarios...</p>
            </div>
          ) : usuariosFiltrados.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-12">
              <UserCircle className="h-12 w-12 text-muted-foreground mb-4" />
              <p className="text-muted-foreground">
                {searchTerm ? "No se encontraron usuarios" : "No hay usuarios registrados"}
              </p>
            </div>
          ) : (
            <div className="overflow-x-auto">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>ID</TableHead>
                    <TableHead>Nombre Completo</TableHead>
                    <TableHead>Correo</TableHead>
                    <TableHead>Rol</TableHead>
                    <TableHead>Proveedor</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {usuariosFiltrados.map((usuario) => (
                    <TableRow key={usuario.id}>
                      <TableCell className="font-mono text-sm">{usuario.id}</TableCell>
                      <TableCell className="font-medium">
                        <div className="flex items-center gap-2">
                          <User className="h-4 w-4 text-muted-foreground" />
                          {getNombreCompleto(usuario)}
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <Mail className="h-4 w-4 text-muted-foreground" />
                          {usuario.correo}
                        </div>
                      </TableCell>
                      <TableCell>
                        <Badge className={getRolBadge(usuario.rol_tipo)}>
                          {usuario.rol_tipo}
                        </Badge>
                      </TableCell>
                      <TableCell>
                        {usuario.aerolinea_id ? (
                          <span className="text-sm">Aerolínea #{usuario.aerolinea_id}</span>
                        ) : usuario.hotel_id ? (
                          <span className="text-sm">Hotel #{usuario.hotel_id}</span>
                        ) : usuario.operador_turistico_id ? (
                          <span className="text-sm">Operador Turístico #{usuario.operador_turistico_id}</span>
                        ) : usuario.compania_crucero_id ? (
                          <span className="text-sm">Crucero #{usuario.compania_crucero_id}</span>
                        ) : usuario.transporte_terrestre_id ? (
                          <span className="text-sm">Transporte #{usuario.transporte_terrestre_id}</span>
                        ) : (
                          <span className="text-muted-foreground text-sm">N/A</span>
                        )}
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}

