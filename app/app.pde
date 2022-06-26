import java.util.Map;

//========================================
final color black      = #000000;
final color white      = #FFFFFF;
final color red        = #FF0000;
final color pink       = #FF6ABC;
final color lightBlue  = #00FCEE;
final color brown      = #9F642C;
final color blue       = #324BE3;
final color gray       = #818183;
final color lightGreen = #00FF00;
final color cyan       = #94BBC1;
final color yellow     = #F6FF05;
final color orange     = #FF7E05;
final color lightCyan  = #E8F9FC;  
final color lightGray  = #BDCBCE;
final color silver     = #D1D1D1;
final color gold       = #E5C982;
//images/fonts ===========================
PImage hidden, plus;
PFont font;

// Mode framework ========================
enum Mode { MAIN, INPUT, OUTPUT, GRAPH, NEW };
Mode mode;

// Maps chosen subject to test data
HashMap<String, ArrayList<Test>> data;

//all the buttons :(
Button inputB, outputB, graphB, subjectB; //mode - MAIN
Button saveButton, clearButton, randomButton; //not used at the moment

void setup() {
  size(900,600);
  textAlign(CORNER, CENTER);
  //load images / font   ==================
  hidden = loadImage("images/hidden.png");
  plus = loadImage("images/plus.png");
  font = createFont("images/font.ttf", 200);
  textFont(font);
  
  //=======================================
  loadData();
  
  // add arbitrary values (for testing purposes)
  ArrayList<Test> bio = new ArrayList<Test>();
  bio.add(new Test(80, 90));
  bio.add(new Test(65, 80));
  bio.add(new Test(75, 76));
  ArrayList<Test> math = new ArrayList<Test>();
  math.add(new Test(90, 100));
  math.add(new Test(70, 80));
  ArrayList<Test> eng = new ArrayList<Test>();
  eng.add(new Test(50, 1));
  data.put("Biology", bio);
  data.put("Math", math);
  data.put("English", eng);
  
  LogGraph graph = logRegression(data.get("Biology"));
  println(graph.a, graph.b);
  
  // *FOR DEBUGGING*
  dumpData();
  
  // start on the main screen
  mode = Mode.MAIN;
  
  //initalize buttons for all modes
  initalizeButtons();
}

void draw() {
  background(255);
  
  switch (mode) {
  case MAIN: mainMode(); break;
  case INPUT: inputMode(); break;
  case OUTPUT: outputMode(); break;
  case GRAPH: graphMode(); break;
  case NEW: newMode(); break; //this is the draw function of Mode.NEW, don't think otherwise
  }
}

void mouseClicked() {
  if (mode == Mode.MAIN) mainClick(); 
  else if (mode == Mode.INPUT) inputClick(); 
  else if (mode == Mode.OUTPUT) outputClick(); 
  else if (mode == Mode.GRAPH) graphClick(); 
  else if (mode == Mode.NEW) newClick(); 
}

//========================================================================

void toolBar() {
  
  if (mode == Mode.OUTPUT || mode == Mode.INPUT || mode == Mode.GRAPH || mode == Mode.NEW) {
    fill(lightCyan);
    noStroke();
    rect(width-20, 0, 20, height);
        
    fill(cyan);
    rect(width-20,height/2-10,20,20,5);
    image(hidden, width-20, height/2-10, 20, 20);
  }
  else { //Mode.MAIN
    //render the tool bar ============
    fill(lightCyan);
    noStroke();
    rect(width-200, 0, 200, height);
    
    //renter the buttons
    inputB.render();
    outputB.render();
    graphB.render();
    subjectB.render();
  }
}

void initalizeButtons() {
  //used for initalizing the buttons, the rendering occurs in their respective modes
  //mode - MAIN
  
  /*
  saveButton = new Button("Save", 200, 200, 100,50);
  clearButton = new Button("Clear", 350, 200, 100,50);
  randomButton = new Button("Random", 500, 200, 100,50);
  */
  inputB = new Button("Input new test information", width-210,30,200,50,lightGray,white,18,plus);
  outputB = new Button("Set a Target", width-210,90,200,50,lightGray,white,18, plus);
  graphB = new Button("To see graphs", width-210,150,200,50,lightGray,white,18, plus);
  subjectB = new Button("New Subject", width-120, height-50, 115, 30, lightCyan, blue, 14, plus);
  
  //mode - INPUT
  
  //mode - OUTPUT
  
  //mode - GRAPH
  
  //mode - NEW
  
}
