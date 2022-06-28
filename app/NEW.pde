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

final int MAX_SUBJECTS = 9;

void newClick() {
  if (addSubjectButton.isHover() && subjects.size() <= MAX_SUBJECTS && inputSubject.text != "") {
    Subject subject = new Subject(inputSubject.text,
      new Button(inputSubject.text, width-210, -1, 200, 40, -1, white, 20, null));
    subjects.add(subject);
  }
}
