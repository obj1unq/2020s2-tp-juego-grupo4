import wollok.game.*
import indicadores.*
import jugador.*
import obstaculos.*

object corazonesFactory {
	method construirObstaculo() {
           const posicion = randomizer.position()

           if (game.getObjectsIn(posicion).isEmpty()){
   				return new ObjetoEnPista(position=posicion, energia = 1, image = "corazon_f.png")			
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
   				return new ObjetoEnPista(position=posicion, energia = 3, image = "nazi_malo.png")			
   		   }
           else{
               return self.construirObstaculo()
           }
   }		   
}

class Nitro inherits ObjetoEnPista{

	override method impacto(){ 
		personaje.moverDeMas()
	}

}

object nitrosFactory {
	
	method construirObstaculo() {
           const posicion = randomizer.position()

           if (game.getObjectsIn(posicion).isEmpty()){
   				return new Nitro(position=posicion, image = "nitro_f.png",energia = 0)			
   		   }
           else{
               return self.construirObstaculo()
           }
   }		 
}