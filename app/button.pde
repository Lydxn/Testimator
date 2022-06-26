class Button {
  String name;
  float x, y, sz;
  
  Button(String name, float x, float y, float sz) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.sz = sz;
  }
  
  void render() {
    fill(this.isActive() ? BLACK : WHITE);
    rect(this.x, this.y, this.sz, this.sz);
    
    fill(this.isActive() ? WHITE : BLACK);
    text(name, this.x, this.y, this.sz, this.sz);
  }
  
  boolean isActive() {
    return this.x <= mouseX && mouseX < this.x + this.sz &&
           this.y <= mouseY && mouseY < this.y + this.sz;
  }
  
  boolean isPressed() {
    return this.isActive() && mousePressed;
  }
}
