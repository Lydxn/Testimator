void mainMode() {
 
  /*
  saveButton.render();
  clearButton.render();
  randomButton.render();
  */
  toolBar();
}

void mainClick() {
  if (inputB.isHover()) mode = Mode.INPUT;
  else if (outputB.isHover()) mode = Mode.OUTPUT;
  else if (graphB.isHover()) mode = Mode.GRAPH;
  else if (subjectB.isHover()) mode = Mode.NEW;
  
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
