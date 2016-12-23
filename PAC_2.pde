/* PAC2
Aitor Javier Santaeugenia Marí
Integració digital de continguts
Universitat Oberta de Catalunya */
import ddf.minim.*;

Minim minim;

//Variables imatges
PImage fons;
PImage perso_pos_1;
PImage santahi;
PImage renohi;

//Variables de frame i posició salt
int frame; 

//Variable posició snowball
int estat_snowball;                                  // Estat del snowball
PImage[] snowball;                                   // Posició de les pinçes del cranc (3 poses diferents)

PImage santastatic;
PImage santaHI;
PImage rend;
PImage dereeHi;
//Variable posició trineu
PImage trineu;
PImage christmass_tree;

//Variables textos
PFont text_explicacio;
PFont text_explicacio2;
PFont text_explicacio3;
PFont text_explicacio4;

//Fonts
PFont zigBlack;

//Variables so
AudioPlayer merryxmass;
AudioPlayer bells;
AudioPlayer wewishyou;

//TEST
//TESTING
int x = -200;                                      // Inici posició del trineu
int dx = 1;                                       // Index de incrementació o decrementació de la posició del trineu

//INICI SETUP
void setup(){
    //Mida de l'escenari i framerate
    size(1000,600);
    frameRate(8);
    //stroke(0);
    //smooth();
    
    //Carrega imatge del fons
    fons = loadImage("town2.png");
    perso_pos_1 = loadImage("snowball.png");
    santahi = loadImage("santa_hi_izquierda2.png");
    renohi = loadImage("reno_derecha2.png");
    christmass_tree = loadImage("christmass_tree.png");
    
    //Posició SNOWBALL
    snowball = new PImage[4];
    snowball[0] = loadImage ("snowball1.png");
    snowball[1] = loadImage ("snowball2.png");
    snowball[2] = loadImage ("snowball1.png");
    snowball[3] = loadImage ("snowball3.png");
    estat_snowball = 0;
    
    //Inicializació de la variable frame
    frame = 1;
    
    //TEXTOS
      //TEXTOS MENU
      text_explicacio = createFont("Arial",16,true);
      text_explicacio2 = createFont("Arial",16,true);
      text_explicacio3 = createFont("Arial",16,true);
      text_explicacio4 = createFont("Arial",16,true);
      zigBlack = loadFont("Ziggurat-Black-32.vlw");
      
    //SO
    // we pass this to Minim so that it can load files from the data directory
    minim = new Minim(this);
    
    // loadFile will look in all the same places as loadImage does.
    // this means you can find files that are in the data folder and the 
    // sketch folder. you can also pass an absolute path, or a URL.
    merryxmass = minim.loadFile("merryxmass.wav");
    wewishyou = minim.loadFile("wewishyou.wav");
    bells = minim.loadFile("bells.wav");
    bells.play();
}//FI SETUP

//Inici funció mousePressed
void mousePressed(){     // Clicam botó per modificar de frame
   if(frame == 1){
       frame = 2;
   }else{
    frame = 1; 
   }
}//Fi funció mousePressed

//INICI DRAW
void draw(){
  //PINTAM EL FONS
    image(fons, 0,0);
    //perso_pos_1.resize(50, 60);
    //image(perso_pos_1, 200,200);
    image(snowball[estat_snowball],-260,-250);
    
    //TEXTOS
    //TEXTOS EXPLICATIUS
    textFont(text_explicacio,16);
    textFont(text_explicacio2,16);
    textFont(text_explicacio3,16);
    textFont(text_explicacio4,16);
    fill(255);
    text("- Manté clicat 'Q' o 'q' per a crear neu",680,100);
    text("- Clica amb el ratolí per veure interaccions",680,120);
    text("- Clica W per veure l'arbre",680,140);
    text("- Clica E per veure l'arbre, neu'",680,160);
    text("i 'We wish you a merryXmass'",680,180);
    text("- Clica R per veure felicitació",680,200);
    
    switch(frame){
         case 1:  
            parat();
            //image(perso_pos_1,220,280);  
           // parat();
            break;
         case 2:
            moviment();                              // Cridem a la funció saltant, ja que ens demana fer-ho a un procés extern del draw
            break;
         
      }
}//FI DRAW

//INICIO NIEVE
void nieve(){  
  //bells.play();
  // Snow
  stroke(255, 255, 255);
  strokeWeight(3);

  for (int i = 0; i < 10; i = i+1) {
    for (int j=0; j<10; j=j+1){
      point(random(i*100, (i+1)*100), random(height));
    }
  }
}//FIN NIEVE

//Inici funció keyPressed
void keyPressed() {
  if(key=='q' || key=='Q'){
    nieve();
  }else if(key=='r' || key=='R'){
    felicitacio();
  }else if(key=='w' || key=='W'){
    santaTree();
  }else if(key=='e' || key=='E'){
    allin();
  }
}//FI funció keyPressed

//Inici funció quan cliquem el botó (per tant, estat = saltant)
void moviment(){  // Funció per saltant
  estat_snowball = estat_snowball+1;
    if (estat_snowball >= 4){
        estat_snowball = 0;
  }
   x = x+dx;
   //Moviment del trineu
   if(x>=-200){                                          // Comença a -200 i va cap ¡
       trineu = loadImage("santareindeer2.png");         // Imatge 1 del trineu
       image(trineu,x,-100);
       dx = +4; 
   }
}

//Inici funció quan no cliquem res (es a dir, estat = 0, posició de repos de tot el programa)
void parat(){                                      //Funció per aturat
  //fill(255,0,0);
  estat_snowball = 0;
}

void felicitacio(){
     //FONS SENSE ALTRES PARAMETRES
     image(fons, 0,0);
     //TEXT
     textFont(zigBlack);
     color c = color(255, 204, 0);  // Define color 'c'
     fill(c);
     text("BON NADAL",290,200);
     text("A TOTHOM,",310,250);
     text("I PROPER",330,300);
     text("2017",438,350);
     //DIBUIXOS SANTA I RENO
     image(santahi,0,-830);
     image(renohi,10,-830); 
     merryxmass.play();
}

void santaTree(){ 
  noStroke();
  christmass_tree.resize(200,450);
  image(christmass_tree,496,100);
  // Lights
  fill(random(200, 255), random(255), random(255));
  ellipse(random(500, 700), random(440, 460), 10, 10);

  fill(random(0, 255), random(200, 255), random(255));
  ellipse(random(505, 695), random(415, 435), 10, 10);

  fill(random(0, 255), random(255), random(200, 255));
  ellipse(random(510, 690), random(390, 410), 10, 10);

  fill(random(200, 255), random(255), random(255));
  ellipse(random(515, 685), random(365, 385), 10, 10);

  fill(random(200, 255), random(200, 255), random(255));
  ellipse(random(520, 680), random(340, 360), 10, 10);

  fill(random(200, 255), random(255), random(200, 255));
  ellipse(random(530, 670), random(315, 335), 10, 10);

  fill(random(200, 255), random(255), random(255));
  ellipse(random(540, 660), random(290, 310), 10, 10);

  fill(random(0, 255), random(200, 255), random(255));
  ellipse(random(545, 655), random(265, 285), 10, 10);

  fill(random(0, 255), random(255), random(200, 255));
  ellipse(random(560, 640), random(240, 260), 10, 10);

  fill(random(200, 255), random(255), random(255));
  ellipse(random(575, 625), random(215, 235), 10, 10);

  fill(random(0, 255), random(255), random(200, 255));
  ellipse(random(580, 620), random(175, 200), 10, 10);

  fill(random(0, 255), random(255), random(200, 255));
  ellipse(random(590, 610), random(150, 160), 10, 10);
}

void allin(){
  santaTree();
  nieve();
  bells.close();
  wewishyou.play();
}