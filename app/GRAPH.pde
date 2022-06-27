class Graph {
  ArrayList<Test> subjectData;
  float xStart, yStart, sz;
  
  Graph(ArrayList<Test> subjectData, float xStart, float yStart, float sz) {
    this.subjectData = subjectData;
    this.xStart = xStart;
    this.yStart = yStart;
    this.sz = sz;
  }
  
  void render() {
    // graph has exactly 10 lines; manually calculate best unit metric
    float maxX = 0;
    for (Test test : this.subjectData)
      maxX = max(maxX, test.studyTime);
    int unitSz = -1; float bestDiff = Float.MAX_VALUE;
    for (int log = 1; log < 1e9; log *= 10) {
      for (int x : new int[] {1, 2, 5}) {
        int val = log * x;
        float diff = abs(maxX / 10 - val);
        if (diff < bestDiff) {
          bestDiff = diff;
          unitSz = val;
        }
      }
    }
    int xSz = unitSz * 10;
    
    // trace lines and number labels
    stroke(gray, 50);
    strokeWeight(1.5);

    fill(black);
    textFont(ubuntuFont, this.sz * 0.03);
    
    for (int i = 0; i <= 10; i++) {
      float x = this.xStart + i / 10.0 * this.sz;
      float y = this.yStart + this.sz - i / 10.0 * this.sz; 

      line(x, this.yStart - this.sz / 10, x, this.yStart + this.sz);
      line(xStart, y, this.xStart + this.sz + this.sz / 10, y);
      
      textAlign(RIGHT);
      text(i * 10 + "%", this.xStart - this.sz * 0.015, y);
      
      textAlign(CENTER, TOP);
      text(i * unitSz + "", x, this.yStart + this.sz + this.sz * 0.015);
    }
    text("(min)", this.xStart + this.sz * 1.15, this.yStart + this.sz + this.sz * 0.015);
    
    // text labels
    fill(black);
    textFont(ubuntuBoldFont, this.sz * 0.05);
    textAlign(CENTER, TOP);
    text("Study Time", this.xStart + this.sz / 2, this.yStart + this.sz + 0.08 * this.sz);
    // my god this one is rotated
    pushMatrix();
    translate(this.xStart - this.sz * 0.15, this.yStart + this.sz / 2);
    rotate(3 * PI / 2);
    textAlign(LEFT, CENTER);
    text("Mark", 0, 0);
    popMatrix();
    
    // x/y-axis arrows
    stroke(black);
    strokeWeight(2);
    
    float xAxisXPos = xStart + this.sz + this.sz / 10, xAxisYPos = yStart + this.sz;
    line(xStart, yStart + this.sz, xAxisXPos, xAxisYPos);
    float yAxisXPos = xStart, yAxisYPos = yStart - this.sz / 10;
    line(xStart, yStart + this.sz, yAxisXPos, yAxisYPos);
    
    // x-axis arrow tip
    beginShape();
    vertex(xAxisXPos, xAxisYPos);
    vertex(xAxisXPos - this.sz / 30, xAxisYPos - this.sz / 80);
    vertex(xAxisXPos - this.sz / 50, xAxisYPos);
    vertex(xAxisXPos - this.sz / 30, xAxisYPos + this.sz / 80);
    endShape(CLOSE);
    
    // y-axis arrow tip
    beginShape();
    vertex(yAxisXPos, yAxisYPos);
    vertex(yAxisXPos - this.sz / 80, yAxisYPos + this.sz / 30);
    vertex(yAxisXPos, yAxisYPos + this.sz / 50);
    vertex(yAxisXPos + this.sz / 80, yAxisYPos + this.sz / 30);
    endShape(CLOSE);
  
    // draw line of best fit
    LogCurve curve = logRegression(this.subjectData);
    noFill();
    stroke(blue, 150);
    strokeWeight(this.sz * 0.004);

    beginShape();
    int samples = 1000; // should be fast enough...
    for (int i = 0; i < samples; i++) {
      float x = 1.0 * xSz * i / samples, y = curve.eval(x);
      if (0 <= y && y <= 100) {
        float realX = this.xStart + x * this.sz / xSz;
        float realY = this.yStart + this.sz - y / 100.0 * this.sz;
        vertex(realX, realY);
      }
    }
    endShape();
    
    // plot data points
    stroke(red);
    strokeWeight(this.sz * 0.01);
    for (Test test : subjectData) {
      float realX = this.xStart + this.sz * test.studyTime / xSz;
      float realY = this.yStart + this.sz - this.sz * test.mark / 100.0;
      point(realX, realY);
    }
  }
}

// See each subjects' graphs (the study/grade trend)
void graphMode() {
  toolBar();
  
}

void graphClick() {
  if (mouseX >= width-20) mode = Mode.MAIN; //returns to the main mode  
}
