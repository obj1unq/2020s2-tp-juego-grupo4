import wollok.game.*
import indicadores.*
import jugador.*
import obstaculos.*

class AyudaSinAccion inherits ObjetoEnTablero{
	
	var property energiaQueSuma = null
	
	method impacto(){ 
		personaje.corazones(personaje.corazones() + energiaQueSuma)
	}
}

/*class Corazon inherits AyudaSinAccion {
	
	method impacto(){ 
		personaje.corazones(personaje.corazones() + energiaQueSuma)
	}
}


class Persona inherits AyudaSinAccion {
		
	method impacto(){ 
		personaje.corazones(personaje.corazones() + energiaQueSuma)
	}
	
}*/

object corazonesFactory {
		
   method construirObstaculo() {
   		return new AyudaSinAccion(position=randomizer.position(), energiaQueSuma = 1, image = "corazon1.png")
   }	
   
}

object personasFactory {
		
   method construirObstaculo() {
   		return new AyudaSinAccion(position=randomizer.position(), energiaQueSuma = 3, image = "nazi_malo.png")
   }	
   
}

class Nitro inherits ObjetoEnTablero{

	method impacto(){ 
		personaje.moverDeMas()
	}

}

object nitrosFactory {
		
   method construirObstaculo() {
   		return new Nitro(position=randomizer.position(), image = "nitro1.png")
   }	
   
}