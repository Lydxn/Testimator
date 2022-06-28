// Receive output (time needed to study) by giving a targeted grade
void outputMode() {
  //title
  int xAlign = 100;

  textSize(70);
  fill(black);
  text("Set a target grade", xAlign, 150);

  //instructions for textboxes
  textSize(40);
  text("Target Mark (%)", xAlign, 300);
  //annotation for where we will generate the estimated needed study time
  text("Estimated Study Time", xAlign, 450);
  
   Subject subject = subjects.get(subjectIdx);
   fill(subject.button.col);
   textFont(ubuntuFont, 30);
   text("Selected Subject: ", xAlign, 230);
   textFont(ubuntuBoldFont, 30);
   text(subject.name, xAlign + 240, 230);

  //textboxes
  inputTarget.render();

  //place where we will display the estimated study time
  stroke(black);
  fill(255);
  rect(xAlign, 500, 500, 50, 20);
  fill(black);
  if ((int(inputTarget.text) == 0 && inputTarget.text.length() > 0) || int(inputTarget.text) > 100) {
    fill(red);
    text("1 <= mark <= 100", xAlign+textWidth("a")/2+10, 500 + 50/2 + 30/2); //if the bad boy dont type numbers
  } else {
    int studyTime = subject.predict(float(inputTarget.text));
    text(prettifyTime(studyTime), xAlign+textWidth("a")/2+10, 500 + 50/2 + 30/2);
  }
}

void outputClick() {
}

String prettifyTime(int time) {
  if (time < 60) return time + "m";
  if (time < 60 * 24) return time / 60 + "h" + time % 60 + "m";
  return time / (60 * 24) + "d " + time % (60 * 24) / 60 + "h " + time % 60 + "m";
}
