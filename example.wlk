class Aventurero {
  var vida = 1000
  var defensa

  method vida() = vida

  method recibirDanio(danio) {
    vida -= danio - defensa
  }
}

class Guerrero inherits Aventurero {
  var property equipamiento
  var aniosEnServicio

  method atacar(contrincante) {
    contrincante.recibirDanio(self.fuerzaAtaque())
    self.actualizarEquipamiento()
  }

  method fuerzaAtaque() = self.danioEquipamiento() + self.plusFuerzaAtaque()

  method plusFuerzaAtaque() = 100 * aniosEnServicio

  method danioEquipamiento() = equipamiento.sum({ equipo => equipo.danio() })

  method actualizarEquipamiento() {
    equipamiento = equipamiento.map({ equipo => equipo.registrarUso() })
  }
}

class Mago inherits Aventurero {
  var companiero

  method atacar(contrincante){
    companiero.atacar(contrincante)
  }
}

class Clerigo inherits Guerrero {
  override method plusFuerzaAtaque() = 50

  override method recibirDanio(danio) {
    super(danio)
    vida += 5
  }
}

class Espada {
  var desgaste

  method danio() = 100 - desgaste

  method afilar() {
    desgaste = 0
  }

  method registrarUso() {}
}

object armadura {
  method danio() = 0

  method registrarUso() {}
}

class Baston {
  var cantidadUsos = 0
  var tipo = new BastonComun()

  method registrarUso() {
    cantidadUsos += 1
    if (cantidadUsos >= 3) {
      tipo = new Clava(cantidadClavos = 2)
    } else if (cantidadUsos >= 8) {
      tipo = new Maza(peso = 1)
    }
  }

  method danio() = tipo.danio()
}

class BastonComun {
  method danio() = 10
}

class Clava {
  const cantidadClavos

  method danio() = 12 + cantidadClavos
}

class Maza {
  const peso

  method danio() = 15 * peso
}
