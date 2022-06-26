import java.util.Map;

final color BLACK = #000000;
final color WHITE = #FFFFFF;

// Mode framework
enum Mode { MAIN, INPUT, OUTPUT, GRAPH };
Mode mode;

// Maps chosen subject to test data
HashMap<String, ArrayList<Test>> data;

Button saveButton, clearButton, randomButton;

void setup() {
  size(800, 600);
  
  loadData();
  
  // add arbitrary values (for testing purposes)
  ArrayList<Test> bio = new ArrayList<Test>();
  bio.add(new Test(90, 0.80));
  bio.add(new Test(80, 0.60));
  bio.add(new Test(76, 0.75));
  ArrayList<Test> math = new ArrayList<Test>();
  math.add(new Test(100, 0.90));
  math.add(new Test(80, 0.70));
  ArrayList<Test> eng = new ArrayList<Test>();
  eng.add(new Test(1, 0.50));
  data.put("Biology", bio);
  data.put("Math", math);
  data.put("English", eng);
  
  saveButton = new Button("Save", 200, 200, 100);
  clearButton = new Button("Clear", 350, 200, 100);
  randomButton = new Button("Random", 500, 200, 100);
  
  // *FOR DEBUGGING*
  dumpData();
  
  // start on the main screen
  mode = Mode.MAIN;
}

void draw() {
  background(255);
  textSize(30);
  
  switch (mode) {
  case MAIN: mainMode(); break;
  case INPUT: inputMode(); break;
  case OUTPUT: outputMode(); break;
  case GRAPH: graphMode(); break;
  }
}

void loadData() {
  data = new HashMap<String, ArrayList<Test>>();

  String[] subjectFiles = new File(dataPath("")).list();
  for(String subjectFile : subjectFiles) {
    if (!subjectFile.endsWith(".txt")) continue;
    // strip ".txt" extension
    String subject = subjectFile.substring(0, subjectFile.length() - 4);

    data.put(subject, new ArrayList<Test>());
    ArrayList<Test> subjectData = data.get(subject);
    
    String[] lines = loadStrings(dataPath(subjectFile));
    if (lines != null) { // Make sure data actually exists
      for (String line : lines) {
        String[] arr = line.split(" ");
        int studyTime = int(arr[0]);
        float mark = float(arr[1]);
        subjectData.add(new Test(studyTime, mark));
      }
    }
  }
}

void saveData() {
  for (Map.Entry<String, ArrayList<Test>> entry : data.entrySet()) {
    String subject = entry.getKey();
    ArrayList<Test> subjectData = entry.getValue();
    String[] output = new String[subjectData.size()];
    for (int i = 0; i < subjectData.size(); i++) {
      Test test = subjectData.get(i);
      output[i] = test.studyTime + " " + test.mark;
    }
    saveStrings(dataPath(subject + ".txt"), output);
  }

  dumpData();
}

void dumpData() {
  // just output the data to the screen (for testing purposes)
  for (Map.Entry<String, ArrayList<Test>> entry : data.entrySet()) {
    String subject = entry.getKey();
    ArrayList<Test> subjectData = entry.getValue();
    println("Subject: " + subject);
    for (Test test : subjectData)
      println("(studyTime,mark) = (" + test.studyTime + "," + test.mark + ")");
    println();
  }
}

void mouseClicked() {
  if (saveButton.isHover())
    saveData();
  if (clearButton.isHover()) {
    // also delete all files associated with data (so it implicitly does a "load")
    for (String subject : data.keySet()) {
      File file = new File(dataPath(subject + ".txt"));
      file.delete();
    }
    data.clear();
  }
  if (randomButton.isHover()) {
    // add a random piece of data
    int studyTime = int(random(300));
    float mark = random(1);
    if (!data.containsKey("English"))
      data.put("English", new ArrayList<Test>());
    data.get("English").add(new Test(studyTime, mark));
  }
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
