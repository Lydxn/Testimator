class Button {
  String name;
  float x, y, sz;
  boolean isClicked;
  
  Button(String name, float x, float y, float sz) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.sz = sz;
  }
  
  void render() {
    fill(this.isHover() ? BLACK : WHITE);
    rect(this.x, this.y, this.sz, this.sz);
    
    fill(this.isHover() ? WHITE : BLACK);
    text(name, this.x, this.y, this.sz, this.sz);
  }
  
  boolean isHover() {
    return this.x <= mouseX && mouseX < this.x + this.sz &&
           this.y <= mouseY && mouseY < this.y + this.sz;
  }
}
