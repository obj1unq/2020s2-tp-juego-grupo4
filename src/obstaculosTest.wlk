import indicadores.*
import jugador.* 
import wollok.game.*

class Obstaculo{
	
	var property energiaQueQuita = null
	
	var property image =  null
	
	var property position = null //referencia : game.at(1,0)
		
	method borrarObstaculo(){ game.removeVisual(self)}
	
	//(game.at(self.position().x(), self.position().y().down(1))	
	
}

class Autos inherits Obstaculo{
	
	method impacto(personajePpal){ personajePpal.impactoA(self) }
	
}

class Barriles inherits Obstaculo{
	
	method impacto(personajePpal){ personajePpal.impactoA(self) }
	
}

object autosFactory {
	
   var property position = null
	
   method construirObstaculo() {
   		return new Autos(position=randomizer.position())
   }	
   
}

object barrilesFactory {
	
   var property position = null
	
   method construirObstaculo() {
   		return new Barriles(position=randomizer.position())
   }	
   
}

object generadorObstaculos{ 
	const obstaculosGenerados = #{}
    const factoriesObstaculos = [ autosFactory , barrilesFactory] 
    
    method nuevoObstaculo() {
		const factoryElegida = factoriesObstaculos.get((0..factoriesObstaculos.size() - 1).anyOne() ) 
		const nuevoObstaculo = factoryElegida.construirObstaculo()
		
		game.addVisual(nuevoObstaculo)
		obstaculosGenerados.add(nuevoObstaculo)	
	}
	
	
	method avanzar(){
		obstaculosGenerados.forEach( {objetocreado => objetocreado.position(objetocreado.position().down(1)) })
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