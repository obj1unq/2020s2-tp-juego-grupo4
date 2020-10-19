import indicadores.*
import jugador.* 
import wollok.game.*

class Obstaculo{
	var property energiaQueQuita = null
	
	var property image = null
	var property position = null //referencia : game.at(1,0)
	
	method impacto(personajePpal){ personajePpal.impactoA(self) }
	
	method borrarObstaculo(){ game.removeVisual(self)}
	
}
