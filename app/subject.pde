class Subject {
  String name;
  ArrayList<Test> testData;
  Button button;
  color col;
  
  Subject(String name, Button button) {
    this.name = name;
    this.button = button;
    this.testData = new ArrayList<Test>();
    
    // assign subject to random color
    colorMode(HSB);
    this.col = color(colorIdx++ * 69 % 256, 255, 200);
    colorMode(RGB);
  }
  
  void addTest(Test test) {
    testData.add(test);
  }
}
