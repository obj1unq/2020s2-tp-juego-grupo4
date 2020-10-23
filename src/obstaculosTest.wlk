import indicadores.*
import jugador.* 
import wollok.game.*
import ayuda.*

class ObjetoEnTablero{
	
	var property position = null //referencia : game.at(1,0)
		
	var property image = null
	
	method borrarObstaculo(){ game.removeVisual(self)}
	
}


class Obstaculo inherits ObjetoEnTablero{
	
	var property energiaQueQuita = null	
	
}


class Auto inherits Obstaculo {
	
	method impacto(personajePpal){ personajePpal.impactoA(self) }

}


class Barril inherits Obstaculo {
		
	method impacto(personajePpal){ personajePpal.impactoA(self) }
	
}

object autosFactory {
		
   method construirObstaculo() {
   		return new Auto(position=randomizer.position(), energiaQueQuita = 2, image = "auto_rojo.png")
   }	
   
}

object barrilesFactory {
		
   method construirObstaculo() {
   		return new Barril(position=randomizer.position(), energiaQueQuita = 1, image = "barril.png")
   }	
   
}

object generadorObstaculos{ 
	const property obstaculosGenerados = []
	const property ayudasGeneradas = []
	const property factoriesObstaculos = [ autosFactory , barrilesFactory] 
    const property factoriesAyudas = [corazonesFactory,personasFactory]
    
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
	
	method avanzar(lista){
		lista.forEach( {objetocreado => objetocreado.position(objetocreado.position().down(1)) })
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