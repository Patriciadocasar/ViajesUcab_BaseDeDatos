"use client"

import { useState, useEffect } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Badge } from "@/components/ui/badge"
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog"
import { ArrowLeft, Plus, Shield, Pencil, Trash2 } from "lucide-react"
import { useRouter } from "next/navigation"
import { useToast } from "@/hooks/use-toast"

type Rol = {
  id: number
  tipo: string
}

export default function RolesPage() {
  const router = useRouter()
  const { toast } = useToast()
  const [roles, setRoles] = useState<Rol[]>([])
  const [dialogOpen, setDialogOpen] = useState(false)
  const [isLoading, setIsLoading] = useState(false)
  const [tipoRol, setTipoRol] = useState("")
  const [isLoadingRoles, setIsLoadingRoles] = useState(true)
  const [rolEditando, setRolEditando] = useState<Rol | null>(null)

  useEffect(() => {
    cargarRoles()
  }, [])

  const cargarRoles = async () => {
    try {
      setIsLoadingRoles(true)
      const res = await fetch("/api/roles")
      const data = await res.json()
      
      if (data.status === "success" && Array.isArray(data.roles)) {
        // Normalizar los roles para asegurar el formato correcto
        const rolesFormateados = data.roles.map((rol: any) => ({
          id: rol.id || rol.Rol_COD || rol.rol_cod || rol.rol_id,
          tipo: rol.tipo || rol.Rol_Tipo || rol.rol_tipo || rol.nombre || rol.Nombre || "",
        }))
        
        setRoles(rolesFormateados)
      } else {
        console.error("Estructura de respuesta inesperada:", data)
        toast({
          title: "Error",
          description: data.message || "No se pudieron cargar los roles",
          variant: "destructive",
        })
      }
    } catch (error) {
      console.error("Error cargando roles:", error)
      toast({
        title: "Error",
        description: "Error de conexión con el servidor",
        variant: "destructive",
      })
    } finally {
      setIsLoadingRoles(false)
    }
  }

  const handleAgregar = () => {
    setRolEditando(null)
    setTipoRol("")
    setDialogOpen(true)
  }

  const handleEditar = (rol: Rol) => {
    setRolEditando(rol)
    setTipoRol(rol.tipo)
    setDialogOpen(true)
  }

  const handleGuardar = async () => {
    if (!tipoRol.trim()) {
      toast({
        title: "Error",
        description: "El tipo de rol es requerido",
        variant: "destructive",
      })
      return
    }

    setIsLoading(true)
    try {
      const isEditing = rolEditando !== null
      const url = "/api/roles"
      const method = isEditing ? "PUT" : "POST"
      const body = isEditing
        ? { id: rolEditando.id, tipo: tipoRol.trim() }
        : { tipo: tipoRol.trim() }

      const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      })

      const data = await res.json()

      if (data.status === "success") {
        toast({
          title: isEditing ? "Rol actualizado" : "Rol agregado",
          description: isEditing
            ? "El rol se ha actualizado exitosamente"
            : "El rol se ha guardado exitosamente",
        })
        setDialogOpen(false)
        setTipoRol("")
        setRolEditando(null)
        cargarRoles()
      } else {
        toast({
          title: "Error",
          description: data.message || (isEditing ? "No se pudo actualizar el rol" : "No se pudo guardar el rol"),
          variant: "destructive",
        })
      }
    } catch (error) {
      toast({
        title: "Error",
        description: "Error de conexión con el servidor",
        variant: "destructive",
      })
    } finally {
      setIsLoading(false)
    }
  }

  const handleEliminar = async (id: number) => {
    if (!confirm("¿Estás seguro de que deseas eliminar este rol?")) {
      return
    }

    try {
      const res = await fetch("/api/roles", {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id }),
      })

      const data = await res.json()

      if (data.status === "success") {
        toast({
          title: "Rol eliminado",
          description: "El rol se ha eliminado exitosamente",
        })
        cargarRoles()
      } else {
        toast({
          title: "Error",
          description: data.message || "No se pudo eliminar el rol",
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
  }

  return (
    <div className="space-y-6">
      <Button variant="ghost" onClick={() => router.push("/admin")} className="gap-2 mb-4">
        <ArrowLeft className="h-4 w-4" />
        Volver al Dashboard
      </Button>

      <div>
        <h1 className="text-3xl font-bold text-foreground">Administración de Roles</h1>
        <p className="text-muted-foreground">Gestiona los roles del sistema</p>
      </div>

      <div className="flex justify-end">
        <Button onClick={handleAgregar} className="gap-2">
          <Plus className="h-4 w-4" />
          Agregar Rol
        </Button>
      </div>

      {isLoadingRoles ? (
        <Card>
          <CardContent className="flex items-center justify-center py-12">
            <p className="text-muted-foreground">Cargando roles...</p>
          </CardContent>
        </Card>
      ) : roles.length === 0 ? (
        <Card>
          <CardContent className="flex flex-col items-center justify-center py-12">
            <Shield className="h-12 w-12 text-muted-foreground mb-4" />
            <p className="text-muted-foreground">No hay roles registrados</p>
          </CardContent>
        </Card>
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {roles.map((rol) => (
            <Card key={rol.id} className="hover:shadow-lg transition-shadow">
              <CardHeader>
                <div className="flex items-start justify-between">
                  <div>
                    <CardTitle className="flex items-center gap-2">
                      <Shield className="h-5 w-5 text-primary" />
                      {rol.tipo}
                    </CardTitle>
                    <CardDescription>ID: {rol.id}</CardDescription>
                  </div>
                  <div className="flex items-center gap-1">
                    <Button
                      variant="ghost"
                      size="icon"
                      onClick={() => handleEditar(rol)}
                      className="h-8 w-8"
                    >
                      <Pencil className="h-4 w-4" />
                    </Button>
                    <Button
                      variant="ghost"
                      size="icon"
                      onClick={() => handleEliminar(rol.id)}
                      className="h-8 w-8 text-destructive hover:text-destructive"
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                </div>
              </CardHeader>
            </Card>
          ))}
        </div>
      )}

      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>{rolEditando ? "Editar Rol" : "Agregar Nuevo Rol"}</DialogTitle>
            <DialogDescription>
              {rolEditando
                ? "Modifica el tipo de rol"
                : "Ingresa el tipo de rol que deseas agregar"}
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="tipo">Tipo de Rol</Label>
              <Input
                id="tipo"
                placeholder="Ej: Administrador, Cliente, Proveedor"
                value={tipoRol}
                onChange={(e) => setTipoRol(e.target.value)}
                required
              />
            </div>
            <div className="flex justify-end gap-3 pt-4">
              <Button
                type="button"
                variant="outline"
                onClick={() => {
                  setDialogOpen(false)
                  setRolEditando(null)
                  setTipoRol("")
                }}
              >
                Cancelar
              </Button>
              <Button onClick={handleGuardar} disabled={isLoading}>
                {isLoading
                  ? "Guardando..."
                  : rolEditando
                  ? "Actualizar"
                  : "Agregar"}
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  )
}

