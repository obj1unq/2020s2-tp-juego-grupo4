import wollok.game.*
import indicadores.*
import jugador.*
import obstaculosTest.*

class Ayuda inherits ObjetoEnTablero{
	
	var property energiaQueSuma = null

}

class Corazon inherits Ayuda {
	
	method impacto(personajePpal){ personajePpal.impactoA(self) }

}


class Persona inherits Ayuda {
		
	method impacto(personajePpal){ personajePpal.impactoA(self) }
	
}

object corazonesFactory {
		
   method construirObstaculo() {
   		return new Corazon(position=randomizer.position(), energiaQueSuma = 1, image = "")
   }	
   
}

object personasFactory {
		
   method construirObstaculo() {
   		return new Persona(position=randomizer.position(), energiaQueSuma = 3, image = "")
   }	
   
}
