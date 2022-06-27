class TextBox {
  float x, y, wdt, hgt;
  color normalFill, hoverFill, normalStroke, hoverStroke;
  String text = "";
  PFont font;
  int textSize, textLength;
  boolean isDown;

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
    isDown = false;
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
      //textFont(font);
      textSize(textSize);
      text(getTextInsert(), x+textWidth("a")/2+10, y + hgt/2 + textSize/2);
    } else {
      //box
      fill(normalFill);
      strokeWeight(3);
      stroke(normalStroke);
      rect(x, y, wdt, hgt, 20);
      //text
      fill(normalStroke);
      //textFont(font);
      textSize(textSize);
      text(getTextInsert(), x+textWidth("a")/2+10, y + hgt/2 + textSize/2);
    }
  }

  boolean isHovering() {
    return x <= mouseX && mouseX < x+wdt && y <= mouseY && mouseY < y+hgt;
  }

  void act() {
    if (curKeyCode == BACKSPACE && curKeyCode != -1) // deleting text
      backspace();
    else if (curKey != -1 && curKey != 65535 && !isKeyHeld) // entering text
      addText(char(curKey));
  }

  void addText(char ch) {
    if (textWidth(getTextInsert() + ch) + textSize < wdt) { //check if within textbox
      text += ch;
      textLength++;
    }
  }

  void backspace() {
    if (!text.isEmpty()) //check if text is not empty
      text = text.substring(0, text.length() - 1);
  }
  
  // Add extra visual effect inspired by "Insert Mode"
  String getTextInsert() {
    return text + (frameCount / 25 % 2 == 0 ? "_" : "");
  }
}

void keyPressed() {
  if (curKeyCode != -1) isKeyHeld = curKeyCode == keyCode;
  curKey = key;
  curKeyCode = keyCode;
  tb.act();
}

void keyReleased() {
  curKey = curKeyCode = -1;
  isKeyHeld = false;
}
