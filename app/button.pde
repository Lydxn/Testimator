class Button {
  String name;
  float x, y, w, h, txtSz;
  color col, col2; 
  PShape icon;
  //col is always button base color, col2 is text color
  boolean isClicked;
  
  Button(String name, float x, float y, float w, float h, color col, color col2, float txtSz, PShape icon) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.col = col;
    this.col2 = col2;
    this.txtSz = txtSz;
    this.icon = icon;
  }
  
  void render() {
    fill(this.isHover() ? col2 : col);
    rect(this.x, this.y, this.w, this.h, 5);
    fill(this.isHover() ? col : col2);
    
    textAlign(LEFT, CENTER);
    textFont(rubikFont, this.txtSz);
    text(this.name, this.x+this.w/this.txtSz, this.y, this.w, this.h);
    shape(this.icon, this.x+this.w*0.8,this.y+this.h*1/6, this.h*2/3,this.h*2/3);
  }
  
  boolean isHover() {
    return this.x <= mouseX && mouseX < this.x + this.w &&
           this.y <= mouseY && mouseY < this.y + this.h;
  }
}
