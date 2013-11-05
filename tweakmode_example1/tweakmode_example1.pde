/* example 1 for tweak mode for Processing
 *
 * press play
 */
 
void setup()
{
  size(400, 450); // will not do any realtime change
  smooth();
}

void draw()
{
  /* tweak the background grayness */
  background(112);
  
  /* tweak the stroke */
  stroke(117, 226, 64);
  strokeWeight(15);
  
  /* tweak the fill */
  fill(242, 250, 14);
  
  /* control the ellipse */
  ellipse(189, 155, 116, 117);
}
