"use client"

import { HeroSearch } from "@/components/hero-search"
import { ServicesShowcase } from "@/components/services-showcase"
import { Benefits } from "@/components/benefits"
import { Footer } from "@/components/footer"

export default function ClientesHomePage() {
  return (
    <div className="min-h-screen bg-background">
      <main>
        <HeroSearch />
        <ServicesShowcase />
        <Benefits />
      </main>
      <Footer />
    </div>
  )
}

