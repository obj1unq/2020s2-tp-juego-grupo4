import wollok.game.*
import indicadores.*
import jugador.*
import obstaculosTest.*

object inicioDeJuego {

	method iniciar() {
		//Declaracion de Objetos
		var obstaculoAuto = new Obstaculo(energiaQueQuita=4 , image="auto_rojo.png", position=game.at(1,0))
		
		//Visuales
		game.addVisualIn(tablero, tablero.position())
		game.addVisualIn(personaje, personaje.position())
		game.addVisualIn(reloj, reloj.position())
		game.addVisualIn(unidad, unidad.position())
		game.addVisualIn(decena, decena.position())
		game.addVisualIn(unidadVida,unidadVida.position())
		game.addVisualIn(decenaVida,decenaVida.position())
		game.addVisualIn(obstaculoAuto,obstaculoAuto.position())
		config.configurarTeclas()
		//config.configurarColisiones()
		//game.schedule(1000,{})
		game.onTick(1000,"tiempoLSD",{unidad.tiempo()})
		game.onCollideDo(personaje, { obstaculo => personaje.impactoA(obstaculo)})
		//game.colliders(personaje).first().impacto(obstaculo)
	}

}


object config {

	method configurarTeclas() {
		//movimientos
		keyboard.left().onPressDo({personaje.mover(-1)})
    	keyboard.right().onPressDo({personaje.mover(1)})
	}
	
//	method configurarColisiones() {
//		game.onCollideDo(personaje, { obstaculo => personaje.impactoA(obstaculo)})
//		
//	}

	
}




