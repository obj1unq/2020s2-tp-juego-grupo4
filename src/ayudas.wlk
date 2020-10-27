import wollok.game.*
import indicadores.*
import jugador.*
import obstaculos.*

class AyudaSinAccion inherits ObjetoEnTablero{
	
	var property energiaQueSuma = null
	
	override method impacto(){ 
		personaje.corazones(personaje.corazones() + energiaQueSuma)
	}
}

object corazonesFactory {
	method construirObstaculo() {
           const posicion = randomizer.position()

           if (game.getObjectsIn(posicion).isEmpty()){
   				return new AyudaSinAccion(position=posicion, energiaQueSuma = 1, image = "corazon1.png")			
   		   }
           else{
               return self.construirObstaculo()
           }
   }	
}

object personasFactory {
   method construirObstaculo() {
           const posicion = randomizer.position()

           if (game.getObjectsIn(posicion).isEmpty()){
   				return new AyudaSinAccion(position=posicion, energiaQueSuma = 3, image = "nazi_malo.png")			
   		   }
           else{
               return self.construirObstaculo()
           }
   }		   
}

class Nitro inherits ObjetoEnTablero{

	override method impacto(){ 
		personaje.moverDeMas()
	}

}

object nitrosFactory {
	
	method construirObstaculo() {
           const posicion = randomizer.position()

           if (game.getObjectsIn(posicion).isEmpty()){
   				return new Nitro(position=posicion, image = "nitro1.png")			
   		   }
           else{
               return self.construirObstaculo()
           }
   }		 
}