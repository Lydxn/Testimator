// loadData() - loads data from data/ folder into `data` object
// saveData() - writes data from `data` object into data/ folder
// dumpData() - output data to screen (debugging)

void loadData() {
  data = new HashMap<String, ArrayList<Test>>();

  String[] subjectFiles = new File(dataPath("")).list();
  for(String subjectFile : subjectFiles) {
    if (!subjectFile.endsWith(".txt")) continue;
    // strip ".txt" extension
    String subject = subjectFile.substring(0, subjectFile.length() - 4);

    data.put(subject, new ArrayList<Test>());
    ArrayList<Test> subjectData = data.get(subject);
    
    String[] lines = loadStrings(dataPath(subjectFile));
    if (lines != null) { // Make sure data actually exists
      for (String line : lines) {
        String[] arr = line.split(" ");
        float mark = float(arr[0]);
        int studyTime = int(arr[1]);
        subjectData.add(new Test(mark, studyTime));
      }
    }
  }
}

void saveData() {
  for (Map.Entry<String, ArrayList<Test>> entry : data.entrySet()) {
    String subject = entry.getKey();
    ArrayList<Test> subjectData = entry.getValue();
    String[] output = new String[subjectData.size()];
    for (int i = 0; i < subjectData.size(); i++) {
      Test test = subjectData.get(i);
      output[i] = test.mark + " " + test.studyTime;
    }
    saveStrings(dataPath(subject + ".txt"), output);
  }

  dumpData();
}

void dumpData() {
  for (Map.Entry<String, ArrayList<Test>> entry : data.entrySet()) {
    String subject = entry.getKey();
    ArrayList<Test> subjectData = entry.getValue();
    println("Subject: " + subject);
    for (Test test : subjectData)
      println("(mark,studyTime) = (" + test.mark + "," + test.studyTime + ")");
    println();
  }
}
