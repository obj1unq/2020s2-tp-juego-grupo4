import contadores.*
import jugador.* 
import wollok.game.*
import config.*

class ObjetoEnPista {
	
	var property position = null 
	var property image = null
	
	var property sonido = null

	method impacto(alguien){ calle.limpiar(self)}
	
	method avanzar() {
		position = position.down(1)
		if(position.y() < 0) {
			calle.limpiar(self)
		}
	}
	method init(posicion)
}

class ObjetoAcumulador inherits ObjetoEnPista {
	
	override method impacto(alguien){
		alguien.impactaPasajero()
		sonidos.reproducir("pasajero.mp3")
		if(!config.testeo())
			super(self)
	}
	override method init(posicion){
		return new ObjetoAcumulador(position=posicion, image=self.image())
	}
	
	
}

class ObjetoEnergia inherits ObjetoEnPista {

	var property energiaEfectuada = 0
	
	override method impacto(alguien) {

		alguien.modificaEnergia(energiaEfectuada)
			
		if(energiaEfectuada<0){
			sonidos.reproducir("choque.mp3")
		}else{
			self.corazonesFull()
		}
		super(self)
	}
	method corazonesFull(){
		if(personaje.energia()<12)
			sonidos.reproducir("corazon.mp3")
	
	}
	
	override method init(posicion){
		return new ObjetoEnergia(position=posicion, image=self.image(),energiaEfectuada=self.energiaEfectuada())
	}
	
}



class ObjetoMovimiento inherits ObjetoEnPista {
	
	
	override method impacto(alguien) {
		alguien.moverDeMas()
			
		sonidos.reproducir("aceite.mp3")
		super(self)
	}
	
	override method init(posicion){
		return new ObjetoMovimiento(position=posicion, image=self.image())
	}
	
}

class ObjetoTiempo inherits ObjetoEnPista {
	
	override method impacto(alguien){
		

		alguien.agregarTiempo()	
			
		sonidos.reproducir("tiempo.mp3")
		if(!config.testeo()){
			super(self)

		}
	}
	override method init(posicion){
		return new ObjetoTiempo(position=posicion, image=self.image())
	}
	
}



class EnergiaObstaculo{
	method energia()
	method imagen()
}
object o_auto inherits EnergiaObstaculo{
	override method energia(){
		return -4
	}
	override method imagen(){
		return "auto_rojo.png"
	}
}
object o_barril inherits EnergiaObstaculo{
	override method energia(){
		return -2
	}
	override method imagen(){
		return "barril.png"
	}
}
object o_bache inherits EnergiaObstaculo{
	override method energia(){
		return -1
	}
	override method imagen(){
		return "bache.png"
	}
}
object o_corazon inherits EnergiaObstaculo{
	override method energia(){
		return 1
	}
	override method imagen(){
		return "corazon.png"
	}
}

class ImagenObstaculo{
	method imagen()
}

object o_persona inherits ImagenObstaculo{
	override method imagen(){
		return "pasajero.png"
	}
}
	

object o_tiempo inherits ImagenObstaculo{
	override method imagen(){
		return "reloj5.png"
	}
}
object o_aceite inherits ImagenObstaculo{
	override method imagen(){
		return "aceite.png"
	}
}




object calle {
	
const property barril = new ObjetoEnergia(image=o_barril.imagen(), energiaEfectuada = o_barril.energia())
const property auto = new ObjetoEnergia(image=o_auto.imagen(), energiaEfectuada = o_auto.energia())
const property bache = new ObjetoEnergia(image=o_bache.imagen(), energiaEfectuada = o_bache.energia())
const property corazon = new ObjetoEnergia(image=o_corazon.imagen(), energiaEfectuada = o_corazon.energia())
const property persona = new ObjetoAcumulador(image=o_persona.imagen())	
const property tiempo = new ObjetoTiempo(image=o_tiempo.imagen())
const property aceite = new ObjetoMovimiento(image=o_aceite.imagen())
	
const property obtaculosAGenerar = [barril, auto, bache, aceite,persona, corazon, tiempo] 
const property obtaculosGenerados = []
	
	
	method generarNuevoObjeto(lista) {
		
		const posicion = randomizer.emptyPosition()
        const objetoAGenerar = lista.anyOne()
        					   
        const objetoGenerado = objetoAGenerar.init(posicion)
        
        obtaculosGenerados.add(objetoGenerado)
		game.addVisual(objetoGenerado)
        
	}
	
	///////////////////
	method avanzar(){
		
		obtaculosGenerados.forEach( {objeto => objeto.avanzar() })
	}
	
	
	method limpiar(obj) {
		
		obtaculosGenerados.remove(obj)
		game.removeVisual(obj)
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
	
	method anyObject(obj) {
		return obj.anyOne()
	}
	
}