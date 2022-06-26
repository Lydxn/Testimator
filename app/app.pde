final color BLACK = #000000;
final color WHITE = #FFFFFF;

// Stores the data for previous tests (studyTime, mark)
ArrayList<Test> tests;

Button saveButton, clearButton, randomButton;

void setup() {
  size(800, 600);
  
  tests = new ArrayList<Test>();

  String[] data = loadStrings("data/data.txt");
  if (data != null) { // Make sure data actually exists
    for (String d : data) {
      String[] s = d.split(" ");
      int studyTime = int(s[0]);
      float mark = float(s[0]);
      tests.add(new Test(studyTime, mark));
    }
  }
  
  // add arbitrary values
  tests.add(new Test(90, 0.80));
  tests.add(new Test(60, 0.60));
  tests.add(new Test(0, 0.20));
  
  saveButton = new Button("Save", 200, 200, 100);
  clearButton = new Button("Clear", 350, 200, 100);
  randomButton = new Button("Random", 500, 200, 100);
}

void draw() {
  background(255);
  textSize(30);
  
  fill(0);
  
  // output the data to the screen (for testing)
  for (int i = 0; i < tests.size(); i++) {
    Test test = tests.get(i);
    text(test.studyTime + " " + test.mark, 100, (i + 1) * 50);
  }
  
  // render the buttons
  saveButton.render();
  clearButton.render();
  randomButton.render();
  
  if (saveButton.isPressed()) {
    saveTests();
  }
  if (clearButton.isPressed()) {
    tests.clear();
  }
  if (randomButton.isPressed()) {
    // add a random piece of data
    int studyTime = int(random(300));
    float mark = random(1);
    tests.add(new Test(studyTime, mark));
  }
}

void saveTests() {
  String[] output = new String[tests.size()];
  for (int i = 0; i < tests.size(); i++) {
    Test test = tests.get(i);
    output[i] = test.studyTime + " " + test.mark;
  }
  println(1);
  saveStrings("data/data.txt", output);
}

double getMean(double[] arr) {
  double sum = 0;
  for (double num: arr) { //get sum of the values
    sum += num;
  } 
  
  return sum/arr.length; //divide to get mean
}


double getSD(double[] arr, double mean) {
  float s = 0;
  for (double num: arr) {
    s += (num-mean)*(num-mean);
  }
  
  return sqrt(s/arr.length);
}

double getR(double[] arrX, double[] arrY, double meanX, double meanY, double SDX, double SDY) {
  double s = 0;
  for (int i = 0; i < arrX.length; i++) {
    double zx, zy;
    zx = (arrX[i]-meanX)/SDX;
    zy = (arrY[i]-meanY)/SDY;
    s += zx*zy;
  }
  
  return s/(arrX.length-1);
}

double getSlope(double[] arrX, double[] arrY) {
  double mx = getMean(arrX);
  double my = getMean(arrY);
  double sx = getSD(arrX, mx);
  double sy = getSD(arrY, my);
  double r = getR(arrX, arrY, mx, my, sx, sy);
  return r*sy/sx;
}

double findB(double[] xArray, double[] yArray) { //find the B of the line
  double xMean = getMean(xArray);
  double yMean = getMean(yArray);
  double functSlope = getSlope(xArray, yArray);
  return yMean - xMean*functSlope;
}
