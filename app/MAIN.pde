final int rectW = 700, rectH = 600;
final int graphSz = 350;

void mainMode() {
  if (!subjects.isEmpty()) {
    Subject subject = subjects.get(subjectIdx);
    // rectangular background for subject
    fill(subject.button.col, 50);
    strokeWeight(8); stroke(subject.button.col);
    rect((width - toolbarW - rectW) / 2, (height - rectH) / 2, rectW, rectH, 30);
    
    // title
    textFont(ubuntuBoldFont, 50);
    textAlign(CENTER, TOP);
    fill(black);
    text(subject.name, (width - toolbarW) / 2, height / 2 - rectH * 0.45);
    
    // graph
    Graph graph = new Graph(subject.testData, (width - toolbarW - graphSz) / 2, (height - graphSz + rectH * 0.15) / 2, graphSz);
    graph.render();
  } else {
    fill(black);
    textSize(50);
    textAlign(CENTER);
    text("Create a new subject by clicking", (width-toolbarW)/2, height/2-30);
    text("the button on the bottom right", (width-toolbarW)/2, height/2+30);
  }
}

void mainClick() {
}
