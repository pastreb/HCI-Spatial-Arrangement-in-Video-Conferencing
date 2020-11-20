/*
  A rect is used to describe the shape of a rectangle. 
 The first two values are the coordinates of the top-left corner. The last two values are the coordinates of the bottom-right corner.
 Consider the following rectangle:
 
 1  2  3  4  5  6  7  8  9
 1
 2   ----------------------
 3   |                    |
 4   |                    |
 5   |                    |
 6   |                    |
 7   ----------------------
 8
 9
 
 This would translate to the following rectangle:
 Rect r {
 top = 2
 bot = 7
 left = 1
 right = 8
 }
 
 The rectangle is meant to be used for describing the position of UIElements
 
 */

class Rect {
  public float top;
  public float bot;
  public float left;
  public float right;

  Rect(float left, float top, float right, float bot) {
    this.top = top;
    this.bot = bot;
    this.left = left;
    this.right = right;
  }

  String toString() {
    return "[" + left + ", " + top + ", " + right + ", " + bot + "]";
  }

  public void Set(float left, float top, float right, float bot) {
    this.top = top;
    this.bot = bot;
    this.left = left;
    this.right = right;
  }


  public void Translate(PVector x) {
    top += x.y;
    bot += x.y;
    left += x.x;
    right += x.x;
  }

  public void Scale(float x) {
    float mx = (left + right) / 2;
    float my = (top + bot) / 2;

    top = (top - my) * x + my;
    bot = (bot - my) * x + my;
    left = (left - mx) * x + mx;
    right = (right - mx) * x + mx;
  }

  public void ClampRect(Rect r) {
    top = min(max(top, r.top), r.bot);
    bot = min(max(bot, r.top), r.bot);
    left = min(max(left, r.left), r.right);
    right = min(max(right, r.left), r.right);
  }

  public void Clamp(float minimum, float maximum) {
    top = min(max(top, minimum), maximum);
    bot = min(max(bot, minimum), maximum);
    left = min(max(left, minimum), maximum);
    right = min(max(right, minimum), maximum);
  }

  public void Clamp01() {
    Clamp(0, 1);
  }
}