void newMode() {
  //title
  int xAlign = 100;

  textSize(70);
  fill(black);
  text("Create New Subject", xAlign, 200);

  //instructions for textboxes
  textSize(40);
  text("Subject Name", xAlign, 300);

  //textboxes
  inputSubject.render();

  //buttons
  stroke(black);
  addSubjectButton.render();
}

void newClick() {
}
