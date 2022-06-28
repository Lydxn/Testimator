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

    Subject subject = new Subject(name, new Button("X", 0,0,0,0,0,0,0,null));
    String[] lines = loadStrings(dataPath(subjectFile));
    if (lines != null) { // Make sure data actually exists
      for (String line : lines) {
        String[] arr = line.split(" ");
        float mark = float(arr[0]);
        int studyTime = int(arr[1]);
        subject.addTest(new Test(mark, studyTime));
      }
    }
    // dummy values in button for now
    subjects.add(new Subject(name, new Button("X", 1,1,1,1,1,1,1,null)));
  }
}

void saveData() {
  for (Subject subject : subjects) {
    ArrayList<Test> subjectData = subject.testData;
    String[] output = new String[subjectData.size()];
    for (int i = 0; i < subjectData.size(); i++) {
      Test test = subjectData.get(i);
      output[i] = test.mark + " " + test.studyTime;
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
