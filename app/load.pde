// loadData() - loads data from data/ folder into `data` object
// saveData() - writes data from `data` object into data/ folder
// dumpData() - output data to screen (debugging)

void loadData() {
  subjects = new ArrayList<Subject>();

  String[] subjectFiles = new File(dataPath("")).list();
  for(String subjectFile : subjectFiles) {
    if (!subjectFile.endsWith(".txt")) continue;
    // strip ".txt" extension
    String name = subjectFile.substring(0, subjectFile.length() - 4);
    
    Subject subject = new Subject(name, new Button(name, width-210, -1, 200, 40, -1, white, 20, null, true));
    String[] lines = loadStrings(dataPath(subjectFile));
    if (lines != null) { // Make sure data actually exists
      for (String line : lines) {
        String[] arr = line.split(" ");
        if (arr.length == 1) // saved colour of subject
          subject.button.col = int(arr[0]);
        else {
          float mark = float(arr[0]);
          int studyTime = int(arr[1]);
          subject.addTest(new Test(mark, studyTime));
        }
      }
    }
    // dummy values in button for now
    subjects.add(subject);
  }
}

void saveData() {
  for (Subject subject : subjects) {
    ArrayList<Test> subjectData = subject.testData;
    String[] output = new String[subjectData.size() + 1];
    output[0] = subject.button.col + "";
    for (int i = 0; i < subjectData.size(); i++) {
      Test test = subjectData.get(i);
      output[i + 1] = test.mark + " " + test.studyTime;
    }
    saveStrings(dataPath(subject.name + ".txt"), output);
  }
  dumpData();
}

void dumpData() {
  for (Subject subject : subjects) {
    println("Subject: " + subject.name);
    for (Test test : subject.testData)
      println("(mark,studyTime) = (" + test.mark + "," + test.studyTime + ")");
    println();
  }
}
