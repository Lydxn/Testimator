class Subject {
  String name;
  ArrayList<Test> testData;
  Button button;
  
  Subject(String name, Button button) {
    this.name = name;
    this.button = button;
    this.testData = new ArrayList<Test>();
    
    // assign subject to random color
    if (this.button.col == -1) {
      colorMode(HSB);
      this.button.col = color(colorIdx++ * 69 % 256, 255, 200);
      colorMode(RGB);
    }
  }
  
  void addTest(Test test) {
    testData.add(test);
  }
  
  int predict(float y) {
    return int(logRegression(testData).getTime(y));
  }
  
  void render() {
    Button b = this.button;
    b.render();
    
    float trashX = b.x-b.w*0.2, trashY = b.y+b.h*1/6, trashSz = b.h*2/3;
    boolean trashHover = trashX <= mouseX && mouseX < trashX + trashSz && trashY <= mouseY && mouseY < trashY + trashSz;
    shape(trashHover ? trashcanRed : trashcan, trashX, trashY, trashSz, trashSz);
  }
}
