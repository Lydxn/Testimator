// - Adding info to existing subjects (i.e. mark on last test)
void inputMode() {
  toolBar();
  
}

void inputClick() {
  if (mouseX >= width-20) mode = Mode.MAIN; //returns to the main mode
}
