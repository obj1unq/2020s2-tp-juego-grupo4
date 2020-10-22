import wollok.game.*
import indicadores.*
import jugador.*
import obstaculosTest.*

object inicioDeJuego {

	method iniciar() {
		//Declaracion de Objetos
		var obstaculoAuto = new Obstaculo(energiaQueQuita=4 , image="auto_rojo.png", position=game.at(1,0))
		
		//Visuales
		game.addVisual(tablero)
		game.addVisual(personaje)
		game.addVisual(reloj)
		game.addVisual(unidad)
		game.addVisual(decena)
		//game.addVisual(unidadVida)
		//game.addVisual(decenaVida)
		game.addVisual(obstaculoAuto)
		config.configurarTeclas()
		//config.configurarColisiones()
		game.onTick(1000,"tiempo",{unidad.tiempo()})
		game.onCollideDo(personaje, { obstaculo => obstaculo.impactoA(personaje)})
		//game.onCollideDo(personaje, { obs => personaje.impactoA(obs)})
		//ANDA//game.onCollideDo(obstaculoAuto,{personajePpal => personajePpal.impactoA(obstaculoAuto)})
		//game.whenCollideDo(personaje, { obstaculo => personaje.impactoA(obstaculo)})
		//game.whenCollideDo(obstaculoAuto, { per => per.impactoA(obstaculoAuto)})	
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




