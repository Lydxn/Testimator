// Receive output (time needed to study) by giving a targeted grade
void outputMode() {
  //title
   int xAlign = 100;
  
   textSize(70);
   fill(black);
   text("Set a target grade", xAlign, 200);
   
   //instructions for textboxes
   textSize(40);
   text("Target Mark%", xAlign, 300);
   //annotation for where we will generate the estimated needed study time
   text("Estimated studytime (min)", xAlign, 450);
   
   //textboxes
   inputTarget.render();

   //place where we will display the estimated study time
   stroke(0);
   fill(255);
   rect(xAlign, 500, 500, 50);
   fill(0);
   if ((int(inputTarget.text) == 0 && inputTarget.text.length() > 0) || int(inputTarget.text) > 100) text("dumbo " + inputTarget.text + ", NUMBERS",xAlign+textWidth("a")/2+10,500 + 50/2 + 30/2); //if the bad boy dont type numbers
   else if (inputTarget.text != "") text(str(int(inputTarget.text)*2+5),xAlign+textWidth("a")/2+10,500 + 50/2 + 30/2);
}

void outputClick() {

}
