class Test {
  int studyTime;
  float mark, slope;
  
  Test(int studyTime, float mark) {
    this.studyTime = studyTime;
    this.mark = mark;
  }
  
  void getSlope() {
    slope = studyTime/mark;
  }
}
