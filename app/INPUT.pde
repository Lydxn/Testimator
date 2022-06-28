// - Adding info to existing subjects (i.e. mark on last test)
void inputMode() {
  //title
   int xAlign = 100;
  
   textAlign(LEFT, CENTER);
  
   textFont(rubikFont, 70);
   fill(black);
   text("Input New Test Data", xAlign, 150);
   
   Subject subject = subjects.get(subjectIdx);
   fill(subject.button.col);
   textFont(ubuntuFont, 30);
   text("Selected Subject: ", xAlign, 230);
   textFont(ubuntuBoldFont, 30);
   text(subject.name, xAlign + 240, 230);
   
   //instructions for textboxes
   fill(black);
   textFont(rubikFont, 40);
   text("Study Time (min)", xAlign, 300);
   text("Mark (%)", xAlign, 450);
   
   //textboxes
   inputStudyTime.render();
   inputMark.render();
   
   //buttons
   stroke(black);
   saveButton.render();
   clearButton.render();
   
   
   //warnings
   textSize(16);
   if ((int(inputStudyTime.text) == 0 && inputStudyTime.text != "") || int(inputStudyTime.textLength) > 4) {
     fill(red);
     text("Invalid number (must be between 0 and 9999).", xAlign, 335);
   }
   if ((int(inputMark.text) == 0 && inputMark.text != "") || int(inputMark.text) < 0 || int(inputMark.text) > 100) {
     fill(red);
     text("This textbox politely asks for a number between 0 and 100, please.", xAlign, 485);
   }
}

void inputClick() {
  if (clearButton.isHover()) {
    inputStudyTime.text = "";
    inputMark.text = "";
  }
  if (saveButton.isHover()) {
    if (!((int(inputStudyTime.text) == 0 && inputStudyTime.text != "") || int(inputStudyTime.textLength) > 4)
     && !((int(inputMark.text) == 0 && inputMark.text != "") || int(inputMark.text) < 0 || int(inputMark.text) > 100)) {
      Subject subject = subjects.get(subjectIdx);
      int studyTime = int(inputStudyTime.text);
      float mark = float(inputMark.text);
      subject.addTest(new Test(mark, studyTime));
     
      saveData();
      println("saved");
    }
  }
}
