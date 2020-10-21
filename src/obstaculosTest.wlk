import indicadores.*
import jugador.* 
import wollok.game.*

class Obstaculo{
	var property energiaQueQuita = null
	
	var property image = "auto_rojo.png"
	var property position = null //referencia : game.at(1,0)
	
	method impacto(personajePpal){ personajePpal.impactoA(self) }
	
	method borrarObstaculo(){ game.removeVisual(self)}
	
	
	
}

class Barriles{
	var property energiaQueQuita = null
	
	var property image = "barril3.png"
	var property position = null //referencia : game.at(1,0)
	
	method impacto(personajePpal){ personajePpal.impactoA(self) }
	
	method borrarObstaculo(){ game.removeVisual(self)}
	
	
	
}

object obstaculoFactory {
	var property position = null
	
   method construirObstaculo() {
   		return new Obstaculo(position=randomizer.position())
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
    const factoriesObstaculos = [ obstaculoFactory , barrilesFactory] 
    
	method nuevoObstaculo() {
		const factoryElegida = factoriesObstaculos.get((0..factoriesObstaculos.size() - 1).anyOne() ) 
		const nuevoObstaculo = factoryElegida.construirObstaculo()
		
		game.addVisual(nuevoObstaculo)
		obstaculosGenerados.add(nuevoObstaculo)	
	}
	method avanzar(){
		obstaculosGenerados.forEach( {objetoCreado => objetoCreado.position().down(1)})
	}
	
	
}

object randomizer {
		
	method position() {
		return 	game.at( 
					(1 .. game.width() - 4 ).anyOne(),
					(9..  game.height() - 1).anyOne()
		) 
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	
}