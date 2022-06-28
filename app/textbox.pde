class TextBox {
  float x, y, wdt, hgt;
  color normalFill, hoverFill, normalStroke, hoverStroke;
  String text = "";
  PFont font;
  int textSize, textLength;
  boolean isSelected;

  TextBox(float x, float y, float wdt, float hgt, PFont font) {
    this.x = x;
    this.y = y;
    this.wdt = wdt;
    this.hgt = hgt;
    this.font = font;

    normalFill = 255;
    normalStroke = 0;
    hoverFill = 0;
    hoverStroke = 255;
    textSize = 30;
    isSelected = false;
  }

  void render() {
    textFont(font, textSize);
    textAlign(LEFT, LEFT);

    //box-----------------------------------
    if (isHovering()) {
      //box
      fill(hoverFill);
      strokeWeight(3);
      stroke(hoverStroke);
      rect(x, y, wdt, hgt, 20);
      //text
      fill(hoverStroke);
      textFont(font);
      textSize(textSize);
      text(text+(frameCount / 25 % 2 == 0 && isSelected ? "_" : ""), x+textWidth("a")/2+10, y + hgt/2 + textSize/2);
    } else {
      //box
      fill(normalFill);
      strokeWeight(3);
      stroke(normalStroke);
      rect(x, y, wdt, hgt, 20);
      //text
      fill(normalStroke);
      textFont(font);
      textSize(textSize);
      text(text+(frameCount / 25 % 2 == 0 && isSelected ? "_" : ""), x+textWidth("a")/2+10, y + hgt/2 + textSize/2);
    }

    //check if text box is selected
    if (mousePressed && isHovering()) {
      isSelected = true;
    } else if (mousePressed) {
      isSelected = false;
    }
  }

  boolean isHovering() {
    return x <= mouseX && mouseX < x+wdt && y <= mouseY && mouseY < y+hgt;
  }

  void act() {
    if (curKeyCode == BACKSPACE && curKeyCode != -1) {// deleting text
      backspace();
    } else if (curKey != -1 && curKey != 65535 && !isKeyHeld && keyCode != ENTER) {// entering text
      addText(char(curKey));
    }
  }

  void addText(char ch) {
    if (textLength <= 15 && isSelected) { //check if within textbox
      text += ch;
      textLength++;
    }
  }

  void backspace() {
    if (!text.isEmpty() && isSelected) //check if text is not empty
      text = text.substring(0, text.length() - 1);
      textLength--;
  }

  // Add extra visual effect inspired by "Insert Mode"
  String getTextInsert() {
    if (isSelected) return text + (frameCount / 25 % 2 == 0 ? "_" : "");
    else return text;
  }
}

void keyPressed() {
  if (curKeyCode != -1) isKeyHeld = curKeyCode == keyCode;
  curKey = key;
  curKeyCode = keyCode;
  if (mode == Mode.INPUT) {
    inputStudyTime.act();
    inputMark.act();
  }
  if (mode == Mode.OUTPUT) {
    inputTarget.act();
  }
  if (mode == Mode.NEW) {
    inputSubject.act();
  }
}

void keyReleased() {
  curKey = curKeyCode = -1;
  isKeyHeld = false;
}
