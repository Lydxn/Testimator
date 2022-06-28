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
PShape target, plus, pencil, home, eraser, floppy, trashcan, trashcanRed;
PFont andalemoFont, rubikFont, ubuntuFont, ubuntuBoldFont, ubuntuMonoFont;

// Mode framework ========================
enum Mode { MAIN, INPUT, OUTPUT, NEW };
Mode mode;

ArrayList<Subject> subjects;
int subjectIdx, colorIdx;

//all the buttons :(
Button inputB, outputB, homeB, subjectB; //toolBar
Button saveButton, clearButton, addSubjectButton;

// keypress variables
int curKey = -1, curKeyCode = -1; // -1 = no key pressed
boolean isKeyHeld = false;

// textboxes
TextBox inputStudyTime, inputMark, inputTarget, inputSubject;

final int MAX_SUBJECTS = 9;

// list of available colours to choose from
// *ONLY IMPLEMENT IF TIME IS AVAILABLE*
color[] AVAILABLE_COLOURS = new color[] {
  #ff0000,
  #ff9d00,
  #f6ff00,
  #00ffa2,
  #00ff3c,
  #00ffe1,
  #0080ff,
  #aa00ff,
  #ff00a2
};

void setup() {
  frameRate(60);
  size(1200, 800);
  textAlign(CORNER, CENTER);
  
  //load images / font   ==================
  // https://www.onlinewebfonts.com/icon
  plus = loadShape("data/images/plus.svg");
  target = loadShape("data/images/target.svg");
  pencil = loadShape("data/images/pencil.svg");
  home = loadShape("data/images/home.svg");
  eraser = loadShape("data/images/eraser.svg"); //https://www.onlinewebfonts.com/icon/468470
  floppy = loadShape("data/images/floppy.svg");
  trashcan = loadShape("data/images/trashcan.svg");
  trashcanRed = loadShape("data/images/trashcan_red.svg");
  
  rubikFont = createFont("data/fonts/rubik.ttf", 1);
  andalemoFont = createFont("data/fonts/andalemo.ttf", 1);
  ubuntuFont = createFont("data/fonts/ubuntu.ttf", 1);
  ubuntuBoldFont = createFont("data/fonts/ubuntu_bold.ttf", 1);
  ubuntuMonoFont = createFont("data/fonts/ubuntu_monobold.ttf", 30);
  
  //intialize the textboxes
  inputStudyTime = new TextBox(100, 350, 500, 50, ubuntuMonoFont, true);
  inputMark = new TextBox(100, 500, 500, 50, ubuntuMonoFont, true);
  inputTarget = new TextBox(100,350,500,50,ubuntuMonoFont, true);
  inputSubject = new TextBox(100, 350, 500, 50, ubuntuMonoFont, false);

  //=======================================
  loadData();
  
  // add arbitrary values (for testing purposes)
  /*Subject bio = new Subject("Biology", new Button("Biology", width-210, -1, 200, 40, -1, white, 20, null));
  bio.addTest(new Test(80, 90));
  bio.addTest(new Test(65, 80));
  bio.addTest(new Test(50, 65));
  Subject math = new Subject("Math", new Button("Math", width-210, -1, 200, 40, -1, white, 20, null));
  math.addTest(new Test(90, 100));
  math.addTest(new Test(70, 80));
  Subject eng = new Subject("English", new Button("English", width-210, -1, 200, 40, -1, white, 20, null));
  eng.addTest(new Test(50, 1));
  eng.addTest(new Test(50, 2));
  eng.addTest(new Test(60, 3));
  
  subjects.add(bio);
  subjects.add(math);
  subjects.add(eng);
  */
  
  // start on the main screen
  mode = Mode.MAIN;
  
  //initalize buttons for all modes
  initalizeButtons();
  
  // set subject to first one in map
  subjectIdx = 0;
  
}

void draw() {
  background(255);
  
  switch (mode) {
  case MAIN: mainMode(); break;
  case INPUT: inputMode(); break;
  case OUTPUT: outputMode(); break;
  case NEW: newMode(); break; //this is the draw function of Mode.NEW, don't think otherwise
  }

  toolBar();

}

void mouseClicked() {
  toolbarClick();
  if (mode == Mode.MAIN) mainClick();
  else if (mode == Mode.INPUT) inputClick(); 
  else if (mode == Mode.OUTPUT) outputClick(); 
  else if (mode == Mode.NEW) newClick(); 
}

//========================================================================

final int toolbarW = 200;

void toolBar() {
  //render the tool bar ============
    fill(lightCyan);
    noStroke();
    rect(width-toolbarW, 0, toolbarW, height);
    
    //render the buttons
    inputB.render();
    outputB.render();
    homeB.render();
    subjectB.render();
    
    // render the subject buttons
    float buttonPos = 230;
    for (Subject subject : subjects) {
      // set new button y-position since it can change
      subject.button.y = buttonPos;
      buttonPos += 50;
      subject.render();
    }
}

void toolbarClick() {
  if (inputB.isHover() && inputB.isActive()) mode = Mode.INPUT;
  else if (outputB.isHover() && outputB.isActive()) mode = Mode.OUTPUT;
  else if (homeB.isHover()) mode = Mode.MAIN;
  else if (subjectB.isHover()) mode = Mode.NEW; 
  
  int deleteIdx = -1;
  for (int i = 0; i < subjects.size(); i++) {
    Button b = subjects.get(i).button;
    float trashX = b.x-b.w*0.2, trashY = b.y+b.h*1/6, trashSz = b.h*2/3;
    if (trashX <= mouseX && mouseX < trashX + trashSz && trashY <= mouseY && mouseY < trashY + trashSz)
      deleteIdx = i;
  }
  if (deleteIdx != -1) {
    subjects.remove(deleteIdx);
    saveData();
  }
  
  for (int i = 0; i < subjects.size(); i++) {
    Subject subject = subjects.get(i);
    if (subject.button.isHover())
      subjectIdx = i;
  }
}

void initalizeButtons() {
  //used for initalizing the buttons, the rendering occurs in their respective modes
  //mode - MAIN
  
  
  saveButton = new Button("Save", 100, 600, 200, 50, white, black, 30, floppy, false); 
  clearButton = new Button("Clear", 350, 600, 200, 50, white, black, 30, eraser, false);
  addSubjectButton = new Button("Add", 100, 450, 200, 50, white, black, 30, plus, false);
  inputB = new Button("New Test", width-210, 30, 200, 50, lightGray, black, 20, pencil, false);
  outputB = new Button("Set Target", width-210, 90, 200, 50, lightGray, black, 20, target, false);
  homeB = new Button("Homepage", width-210, 150, 200, 50, lightGray, black, 20, home, false);
  subjectB = new Button("New Subject", width-210, height-100, 200, 50, lightGray, blue, 20, plus, false);
  
  //mode - INPUT
  
  //mode - OUTPUT
  
  //mode - GRAPH
  
  //mode - NEW
  
}
