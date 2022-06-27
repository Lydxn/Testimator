class LogCurve {
  float a, b;
  
  LogCurve(float a, float b) {
    this.a = a;
    this.b = b;
  }
  
  float eval(float x) {
    return a + b * log(x);
  }
}

// Source: https://keisan.casio.com/exec/system/14059930226691
// (x, y) = (study time, mark)
// Returns the best-fit graph in the form a+b*ln(x)
LogCurve logRegression(ArrayList<Test> subjectData) {
  if (subjectData == null)
    return null;
  // add 1 to "fix" the graph such that root isn't positive
  int n = subjectData.size();

  float lnMean = 0;
  for (Test test : subjectData) lnMean += log(test.studyTime);
  lnMean /= n;

  float yMean = 0; 
  for (Test test : subjectData) yMean += test.mark;
  yMean /= n;
  
  float Sxx = 0;
  for (Test test : subjectData) Sxx += sq(log(test.studyTime));
  Sxx -= n * sq(lnMean);
  
  float Sxy = 0;
  for (Test test : subjectData) Sxy += log(test.studyTime) * test.mark;
  Sxy -= n * lnMean * yMean;
  
  float b = Sxy / Sxx;
  float a = yMean - b * lnMean;

  return new LogCurve(a, b);
}
