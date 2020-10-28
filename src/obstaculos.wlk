import indicadores.*
import jugador.* 
import wollok.game.*
import ayudas.*

class ObjetoEnTablero{
	
	var property position = null //referencia : game.at(1,0)
		
	var property image = null
	
	method borrarObstaculo(){ game.removeVisual(self) }
	
	method impacto(){}
}


class Obstaculo inherits ObjetoEnTablero{
	
	var property energiaQueQuita = null	
	 
	 override method impacto(){ 
		personaje.corazones(personaje.corazones() - energiaQueQuita)
	}	
}

object autosFactory {
		
   method construirObstaculo() {
           const posicion = randomizer.position()

           if (game.getObjectsIn(posicion).isEmpty()){
   				return new Obstaculo(position=posicion, energiaQueQuita = 2, image = "auto_rojo.png")
           }
           else{
               return self.construirObstaculo()
           }
   }
   
}

object barrilesFactory {
	
   method construirObstaculo() {
           const posicion = randomizer.position()

           if (game.getObjectsIn(posicion).isEmpty()){
   				return new Obstaculo(position=posicion, energiaQueQuita = 2, image = "barril_f.png")
           }
           else{
               return self.construirObstaculo()
           }
   }	
   
}

object generadorObstaculos{ 
	const property obstaculosGenerados = []
	const property ayudasGeneradas = []
	const property factoriesObstaculos = [ autosFactory , barrilesFactory] 
    const property factoriesAyudas = [corazonesFactory,personasFactory,nitrosFactory]
    
    method nuevoObstaculo(lista) {
		const factoryElegida = lista.get((0..lista.size() - 1).anyOne() ) 
		const nuevoObstaculo = factoryElegida.construirObstaculo()
		
		
		game.addVisual(nuevoObstaculo)
		
		if (lista == factoriesObstaculos){
			obstaculosGenerados.add(nuevoObstaculo)	
		} else {
			ayudasGeneradas.add(nuevoObstaculo)	
		}
		
	}	
	
	method avanzar(){
		obstaculosGenerados.forEach( {objetocreado => objetocreado.position(objetocreado.position().down(1)) })
		ayudasGeneradas.forEach( {objetocreado => objetocreado.position(objetocreado.position().down(1)) })
	}
}

object randomizer {
		
	method position() {
		return 	game.at( 
					(1 .. game.width() - 4 ).anyOne(), game.height() - 1)
					//(9..  game.height() - 1).anyOne()
		//) 
	}
	
	method emptyPosition() {
		//para implementar, buscar celda libre para ubicar objeto
	}
	
}