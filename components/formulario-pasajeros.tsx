"use client"

import { useState } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { UserPlus, X, Users } from "lucide-react"

export interface Pasajero {
  primerNombre: string
  segundoNombre: string
  primerApellido: string
  segundoApellido: string
  fechaNacimiento: string
  estadoCivil: string
}

interface FormularioPasajerosProps {
  pasajeros: Pasajero[]
  onChange: (pasajeros: Pasajero[]) => void
}

export function FormularioPasajeros({ pasajeros, onChange }: FormularioPasajerosProps) {
  const agregarPasajero = () => {
    onChange([
      ...pasajeros,
      {
        primerNombre: "",
        segundoNombre: "",
        primerApellido: "",
        segundoApellido: "",
        fechaNacimiento: "",
        estadoCivil: "Soltero",
      },
    ])
  }

  const eliminarPasajero = (index: number) => {
    if (pasajeros.length > 1) {
      onChange(pasajeros.filter((_, i) => i !== index))
    }
  }

  const actualizarPasajero = (index: number, campo: keyof Pasajero, valor: string) => {
    const nuevosPasajeros = [...pasajeros]
    nuevosPasajeros[index] = {
      ...nuevosPasajeros[index],
      [campo]: valor,
    }
    onChange(nuevosPasajeros)
  }

  return (
    <Card>
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="flex items-center gap-2">
              <Users className="h-5 w-5" />
              Información de Pasajeros
            </CardTitle>
            <CardDescription>
              Registra los datos de todos los pasajeros que viajarán ({pasajeros.length} pasajero
              {pasajeros.length !== 1 ? "s" : ""})
            </CardDescription>
          </div>
          <Button type="button" variant="outline" size="sm" onClick={agregarPasajero} className="gap-2">
            <UserPlus className="h-4 w-4" />
            Agregar Pasajero
          </Button>
        </div>
      </CardHeader>
      <CardContent className="space-y-6">
        {pasajeros.map((pasajero, index) => (
          <div key={index} className="border rounded-lg p-4 space-y-4 relative">
            <div className="flex items-center justify-between mb-2">
              <h4 className="font-semibold">Pasajero {index + 1}</h4>
              {pasajeros.length > 1 && (
                <Button
                  type="button"
                  variant="ghost"
                  size="sm"
                  onClick={() => eliminarPasajero(index)}
                  className="h-8 w-8 p-0"
                >
                  <X className="h-4 w-4" />
                </Button>
              )}
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor={`primerNombre-${index}`}>
                  Primer Nombre <span className="text-destructive">*</span>
                </Label>
                <Input
                  id={`primerNombre-${index}`}
                  value={pasajero.primerNombre}
                  onChange={(e) => actualizarPasajero(index, "primerNombre", e.target.value)}
                  placeholder="Juan"
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor={`segundoNombre-${index}`}>Segundo Nombre</Label>
                <Input
                  id={`segundoNombre-${index}`}
                  value={pasajero.segundoNombre}
                  onChange={(e) => actualizarPasajero(index, "segundoNombre", e.target.value)}
                  placeholder="Carlos"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor={`primerApellido-${index}`}>
                  Primer Apellido <span className="text-destructive">*</span>
                </Label>
                <Input
                  id={`primerApellido-${index}`}
                  value={pasajero.primerApellido}
                  onChange={(e) => actualizarPasajero(index, "primerApellido", e.target.value)}
                  placeholder="Pérez"
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor={`segundoApellido-${index}`}>Segundo Apellido</Label>
                <Input
                  id={`segundoApellido-${index}`}
                  value={pasajero.segundoApellido}
                  onChange={(e) => actualizarPasajero(index, "segundoApellido", e.target.value)}
                  placeholder="González"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor={`fechaNacimiento-${index}`}>
                  Fecha de Nacimiento <span className="text-destructive">*</span>
                </Label>
                <Input
                  id={`fechaNacimiento-${index}`}
                  type="date"
                  value={pasajero.fechaNacimiento}
                  onChange={(e) => actualizarPasajero(index, "fechaNacimiento", e.target.value)}
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor={`estadoCivil-${index}`}>
                  Estado Civil <span className="text-destructive">*</span>
                </Label>
                <Select
                  value={pasajero.estadoCivil}
                  onValueChange={(value) => actualizarPasajero(index, "estadoCivil", value)}
                >
                  <SelectTrigger id={`estadoCivil-${index}`}>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Soltero">Soltero</SelectItem>
                    <SelectItem value="Casado">Casado</SelectItem>
                    <SelectItem value="Divorciado">Divorciado</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </div>
        ))}
      </CardContent>
    </Card>
  )
}

