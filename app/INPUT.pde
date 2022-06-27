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
   text("Mark%", xAlign, 450);
   
   //textboxes
   inputStudyTime.render();
   inputMark.render();
   
   //buttons
   stroke(black);
   saveButton.render();
   clearButton.render();
}

void inputClick() {
  
}
