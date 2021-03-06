///////////////////////CONTROLES TECLADO
//--- flechas izquierda y derecha: para navegacion
//--- enter:  ingresar en un submenu o activar un modificador
//--- barra espaciadora: desplagar ipManager
//--- 'a' o 'A' : agregarModificador
//--- 's' o 'S' : quitarModificador
//--- 'd' o 'D' : cancelar

/*---- mi favorita hasta ahora---- ir a opciones para quitar 
 ------ el fondo agregar movimiento, y cohesion(2), esperar 
 ------ unos segundos, agregar fuerzaPorSemejanza y alfa 
 ------ segun velocidad, agregar dibujar lineas, quitar los 
 ------ dos cohesion y agregar un sepracion inmediatamente xD*/

import controlP5.*; 
import oscP5.*;
import netP5.*;

int contadorCapturas = 0;

OscP5 oscP5;
NetAddress sistema;

ControlP5 cp5;
IpManager ipManager;

String ip = "127.0.0.1";
String puertoEnvio = "12100";
String puertoRecivo = "12000";


Consola consola;
Controlador controlador;
ArrayList<String> nombresBotones;
ArrayList<String> nombresBotonesExistentes;
ArrayList<String> nombresCategorias;
/*ArrayList<Boolean> estado;
 ArrayList<Boolean> estadoExistentes;*/
int cantidad;
int cantidadExistentes;





color[] paleta = new color[5]; 

color colorBoton;
color lineaBoton;
color letras;
color letrasActivas;
color fondo;


PFont fuente;

boolean abajo = false;// variables de control para los niveles
boolean medio = false;// variables de control para los niveles
boolean alto = false;// variables de control para los niveles

boolean abierto = false;// variables de control para los abierto/cerrado
boolean cerrado = false;// variables de control para los abirto/cerrado



int cerradoValor = 0;
int desequilibrioValor = 0;
int nivelValor = 0;

boolean totales;
boolean existentes;
//boolean renovarConsola;

boolean conectadoConSistema = false;
void setup() {
  size(600, 600);
  //frameRate(25);
  smooth();



  paleta[0] = color(#1E2327);
  paleta[1] = color(#AFC22B);
  paleta[2] = color(#101215);//
  paleta[3] = color(#25282D);
  paleta[4] = color( #BE4041);

  colorBoton = paleta[0];
  lineaBoton = paleta[0];
  letras = paleta[2];
  letrasActivas = color(255);
  fondo = paleta[3];
  initOSC();

  cp5 = new ControlP5(this);
  ipManager = new IpManager(cp5);

  //fuente = loadFont("28DaysLater-48.vlw");
  //fuente = loadFont("Castellar-30.vlw");
  fuente = loadFont("Consolas-48.vlw");



  textFont(fuente);



  consola = new Consola(paleta);
  controlador = new Controlador(consola);
}


void draw() {

  background( fondo);
  if (consola != null) {
    consola.ejecutar();
  }

  ipManager.fondo();

  if (totales && existentes) {
    botonesListo();
    println("..........listo botones.........");
  }

  if (!conectadoConSistema) {
    if (frameCount%60==0) {
      println("pido");
      consola.mandarMensaje("/pedir/modificadores/total");
    }

    pushStyle();
    fill(255);
    textSize(30);
    text("desconectado", width/2, height/2);
    popStyle();
  }
}

void keyPressed() {

  if (key == ' ') {
    ipManager.hide();
  }

  if (keyCode==RIGHT) {
    controlador.derecha();
  }

  if (keyCode==LEFT) {
    controlador.izquierda();
  }

  if (keyCode==ENTER) {
    controlador.aceptar();
  }

  if (key == 'A' || key == 'a') {

    controlador.anadir();
  }

  if (key == 's' || key == 'S') {
    controlador.quitar();
  }

  if (key == 'q' || key == 'Q') {
    controlador.opciones();
  }

  if (key == 'w' || key == 'W') {
    controlador.estimulos();
  }

  if (key == 'd' || key == 'D') {
    controlador.cancelar();
  }

  if (key == 'i' || key == 'I') {
    //consola.imprimirLista();
  }

  if (key == 'g' || key == 'G') {
    saveFrame("capturas/captura_####.tff");
    contadorCapturas++;
  }
}

void actualizarMovimiento() {
  controlador.actualizarIconos(cerradoValor, nivelValor, desequilibrioValor);
}

void cantidadBotones(int cantidad_) {
  conectadoConSistema = true;
  cantidad=cantidad_;
  nombresBotones = new ArrayList<String>();
  nombresCategorias = new ArrayList<String>();
  // estado = new ArrayList<Boolean>();
}

void cantidadBotonesExistentes(int cantidad_) {
  cantidadExistentes=cantidad_;
  nombresBotonesExistentes = new ArrayList<String>();
  // estadoExistentes = new ArrayList<Boolean>();
}

void modificadores(String nombre_, String categoria_, int estado_) {
  nombresBotones.add(nombre_); 
  nombresCategorias.add(categoria_); 

  /* if (estado_ == 0) {
   estado.add(false);
   } else {
   estado.add(true);
   }*/
}

void modificadoresExistentes(String nombre, int estado_) {
  nombresBotonesExistentes.add(nombre); 

  /*if (estado_ == 0) {
   estado.add(true);
   } else {
   estado.add(false);
   }*/
}

void opciones(String nombre_, int estado_) {

  nombresBotones.add(nombre_); 

  /* if (estado_ == 0) {
   estado.add(true);
   } else {
   estado.add(false);
   }*/
}

void estimulos(String nombre_, int estado_) {

  nombresBotones.add(nombre_); 
  println("me estan llegando los estimulos");
  /* if (estado_ == 0) {
   estado.add(true);
   } else {
   estado.add(false);
   }*/
}


void totalesListo() {

  totales =true;
  if (!existentes) {
    consola.mandarMensaje("/pedir/modificadores/existentes");
  }
}

void  existentesListo() {

  existentes =true;
}

void  estimulosListo() {
  consola.renovarDatosEstimulos(nombresBotones);
   println("estimulos listos");
  consola.mandarMensaje("/pedir/opciones");
}

void botonesListo() {
  
  consola.renovarDatosCategorias(nombresBotones, nombresCategorias, nombresBotonesExistentes);
  println("mods listos");
  //  renovarConsola = false;
  totales = false;
  existentes = false;
  consola.mandarMensaje("/pedir/estimulos");
 
}
void opcionesListo() {
  consola.renovarDatosOpciones(nombresBotones);
 println("opciones listos");
  // consola.renovarDatos(cantidad, estado, nombresBotones);
}

void agregarMod(String cual) {
  consola.agregarMod(cual);
  
}
void quitarMod(String cual) {
 
  consola.quitarMod(cual);

  // consola.renovarDatos(cantidad, estado, nombresBotones);
}

//-----------------------------------------------------------------------------------CAPTURA--------------------------

void menuQuitarModificador() {
 // if (!consola.nivelAgregar && !consola.nivelQuitar)
    controlador.quitar();
}
void menuAgregarModificador() {
//  if (!consola.nivelAgregar && !consola.nivelQuitar)
    controlador.anadir();
}
void menuNavegarIzquierda() {
  controlador.izquierda();
}
void menuNavegarDerecha() {
  controlador.derecha();
}
void cancelar() {
  controlador.cancelar();
}
void aceptar() {
  controlador.aceptar();
}

void cerrado(int valor) {
  cerradoValor = valor;

  println( "cerradoValor: " +  cerradoValor);
}
void desequilibrio(int valor) {
  desequilibrioValor = valor;
  println( "desequilibrioValor: " +  desequilibrioValor);
}
void nivel(int valor) {
  nivelValor = valor;
  println( "nivelValor: " +  nivelValor);
}
void cursorMoCap(float x, float y) {
  consola.setCursor(x*width, y*height);
}

