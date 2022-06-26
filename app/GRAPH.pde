// See each subjects' graphs (the study/grade trend)
void graphMode() {
  toolBar();
  
}

void graphClick() {
  if (mouseX >= width-20) mode = Mode.MAIN; //returns to the main mode  
}
