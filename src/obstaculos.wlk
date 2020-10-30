import indicadores.*
import jugador.* 
import wollok.game.*

class ObjetoEnPista {
	
	var property position = null //referencia : game.at(1,0)
	var property image = null
	
	method efectoUnico() {
		return false
	}
	
	method impacto(alguien)
	
	method avanzar() {
		position = position.down(1)
		if(position.y() < 0) {
			calle.limpiar(self)
			game.removeVisual(self)
		}
	}
	
}


class ObjetoEnergia inherits ObjetoEnPista {
	
	var property energiaEfectuada = null
	
	override method impacto(alguien) {
		alguien.impactaEnergia(self)
	}
	
}


class ObjetoMovimiento inherits ObjetoEnPista {
	
	override method efectoUnico() {
		return true
	}
	
	override method impacto(alguien) {
		alguien.moverDeMas()
	}
	
}


object calle {
	
const property barril = new ObjetoEnergia(image="barril.png", energiaEfectuada = -4)
const property auto = new ObjetoEnergia(image="auto_rojo.png", energiaEfectuada = -2)
const property bache = new ObjetoEnergia(image="bache.png", energiaEfectuada = -1)
const property persona = new ObjetoEnergia(image="nazi_malo.png", energiaEfectuada = 3)
const property corazon = new ObjetoEnergia(image="corazon_f.png", energiaEfectuada = 1)	
const property nitro = new ObjetoMovimiento(image="nitro_f.png")
const property aceite = new ObjetoMovimiento(image="aceite.png")
	
const property obtaculosAGenerar = [barril, auto, bache, aceite ] //ANYONE SIRVE SOLO CON LISTA
const property ayudasAGenerar = [persona, corazon, nitro]
const property obtaculosGenerados = []
const property ayudasGeneradas = []
	
	method generarNuevoObjeto(lista) {
		
		const posicion = randomizer.emptyPosition()
        const objetoAGenerar = lista.anyOne()
        					   //randomizer.anyObject(objetosAGenerar)
        const objetoGenerado = factory.generate(objetoAGenerar, posicion)
        
        if(lista == obtaculosAGenerar ) {
        	obtaculosGenerados.add(objetoGenerado)
       		game.addVisual(objetoGenerado)
        }
        else{
        	ayudasGeneradas.add(objetoGenerado)
       		game.addVisual(objetoGenerado)
        }
        
	}
	
	
	method avanzar(){
		
		obtaculosGenerados.forEach( {objeto => objeto.avanzar() })
		ayudasGeneradas.forEach( {objeto => objeto.avanzar() })
	}
	
	
	method limpiar(obj) {
		
		obtaculosGenerados.remove(obj)
		ayudasGeneradas.remove(obj)
	}
	
}


object factory {
	
	method generate(struct, pos) {
		return
		if(struct.efectoUnico()) {
			new ObjetoMovimiento(position=pos, image=struct.image())
		}
		else {
			new ObjetoEnergia(position=pos, image=struct.image(), energiaEfectuada=struct.energiaEfectuada())
		}
	}
	
}



object randomizer {	
	
	method emptyPosition() {
		const position = game.at((1 .. game.width() - 4).anyOne(), game.height() - 1)
		return
		if(game.getObjectsIn(position).isEmpty()) {
			position
		}
		else { 
			self.emptyPosition()
		}
	}
	
	method anyObject(ls) {
		return ls.anyOne()
	}
	
}