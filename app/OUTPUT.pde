// Receive output (time needed to study) by giving a targeted grade
void outputMode() {
  toolBar();
  
}

void outputClick() {
  if (mouseX >= width-20) mode = Mode.MAIN; //returns to the main mode
}
