final int rectW = 600, rectH = 500;
final int graphSz = 300;

void mainMode() {
  int curIdx = 0;
  for (Map.Entry<String, ArrayList<Test>> entry : data.entrySet()) {
    // dumb way to get nth entry in map, but ehh... whatever
    if (curIdx++ != subjectIdx) continue;
    
    String subject = entry.getKey();
    ArrayList<Test> subjectData = entry.getValue();
    
    // rectangular background for subject
    fill(cyan, 150);
    strokeWeight(8); stroke(cyan);
    rect((width - toolbarW - rectW) / 2, (height - rectH) / 2, rectW, rectH, 30);
    
    // title
    fill(black);
    textFont(ubuntuBoldFont, 50);
    textAlign(CENTER, TOP);
    text(subject, (width - toolbarW) / 2, height / 2 - rectH * 0.45);
    
    // graph
    Graph graph = new Graph(subjectData, (width - toolbarW - graphSz) / 2, (height - graphSz + rectH * 0.15) / 2, graphSz);
    graph.render();
    break;
  }
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
