// - Adding info to existing subjects (i.e. mark on last test)
void inputMode() {
  //title
   int xAlign = 100;

   textSize(70);
   fill(black);
   text("Input New Test Data", xAlign, 200);
   
   //instructions for textboxes
   textSize(40);
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
   if ((int(inputStudyTime.text) == 0 && inputStudyTime.text != "") || int(inputStudyTime.textLength) > 5) {
     fill(red);
     text("This textbox calmly asked for numbers (not too large, either).", xAlign, 330);
   }
   if ((int(inputMark.text) == 0 && inputMark.text != "") || int(inputMark.text) < 0 || int(inputMark.text) > 100) {
     fill(red);
     text("This textbox politely asks for a number between 0 and 100, please.", xAlign, 480);
   }
}

void inputClick() {
  if (clearButton.isHover()) {
    inputStudyTime.text = "";
    inputMark.text = "";
  }
  if (int(inputStudyTime.text) != 0 && int(inputMark.text) != 0 && saveButton.isHover()) {
    saveData();
    println("saved");
  }
}
