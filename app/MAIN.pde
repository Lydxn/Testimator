final int rectW = 700, rectH = 600;
final int graphSz = 350;

void mainMode() {
  Subject subject = subjects.get(subjectIdx);
  
  // rectangular background for subject
  fill(subject.button.col, 50);
  strokeWeight(8); stroke(subject.button.col);
  rect((width - toolbarW - rectW) / 2, (height - rectH) / 2, rectW, rectH, 30);
  
  // title
  fill(black);
  textFont(ubuntuBoldFont, 50);
  textAlign(CENTER, TOP);
  text(subject.name, (width - toolbarW) / 2, height / 2 - rectH * 0.45);
  
  // graph
  Graph graph = new Graph(subject.testData, (width - toolbarW - graphSz) / 2, (height - graphSz + rectH * 0.15) / 2, graphSz);
  graph.render();
}

void mainClick() {
  
  /*
  if (saveButton.isHover()) saveData();
  
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
  */
}
