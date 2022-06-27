void newMode() {
  toolBar();  
}

void newClick() {
  if (mouseX >= width-20) mode = Mode.MAIN; //returns to the main mode  
}
