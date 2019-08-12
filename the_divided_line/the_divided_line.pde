void setup() {
  
  size(500, 500);
} 

void draw(){
  //set the background of the canvas to white
  background(255);
  
  //set the diameter and radius of the circle
  float diameter = 500;
  float radius = diameter / 2;
  //draw the circle to the canvas setting the color to yellow
  noStroke();
  fill(255,255,0);
  ellipse(radius, radius, diameter, diameter);
  
  //pick an arbitrary y value for a point with a x value of the circles radius
  float arbitrary_y = diameter/3;
  
  float horizontal_bisector_x = findHorizontalBisectorX(radius, arbitrary_y);
  
  //draw triangle ABD
  fill(0,0,255);
  triangle(radius, diameter, radius, 0, horizontal_bisector_x, arbitrary_y);
  
  //find the closest point on line segment BD through point C (Point F)
  float[] closestPointOn_BD = findClosestPoint(radius, 0, horizontal_bisector_x, arbitrary_y, arbitrary_y, radius);
  
  //find the closest point on line segment AD through point C (Point E)
  float[] closestPointOn_AD = findClosestPoint(radius, diameter, horizontal_bisector_x, arbitrary_y, arbitrary_y, radius);
  
  //draw triangle BCF
  fill(255,0,0);
  triangle(radius, 0, radius, arbitrary_y, closestPointOn_BD[0], closestPointOn_BD[1]);
  
  //draw triangle ACE
  fill(0,255,0);
  triangle(radius, diameter, radius, arbitrary_y, closestPointOn_AD[0], closestPointOn_AD[1]);

}

float findHorizontalBisectorX(float radius, float arbitrary_y){
  //find the distance from the midpoint of the circle to the arbitrary_y
  //if the arbitrary_y is less than the radius (above midpoint)
  float segment_length = -1;
  if(radius > arbitrary_y){
    segment_length = radius - arbitrary_y;
  //if the arbitrary_y is greater than the radius (below midpoint)
  }else if(radius < arbitrary_y){
    segment_length = arbitrary_y - radius;
  } 
  //calculate the distance to bisect the circle horizontally from the (radius, arbitrary_y)
  float bisecting_distance = sqrt( pow(radius,2) - pow(segment_length, 2) );
  //convert the bisecting_distance to a x value
  float bisecting_x = radius - bisecting_distance;
  return bisecting_x;
}

//
float[] findClosestPoint(float x1, float y1, float x2, float y2, float arbitrary_y, float radius) {
  
  float delta_y = -1;
  float delta_x = -1;
  
  //determine which set of co-ordinates are set 1 and set 2
  if(y1 > y2){
    //(x1, y1) are set 2
    delta_y = y1 - y2;
    delta_x = x1 - x2;
    
  }else if(y1 < y2){
    //(x2, y2) are set 2
    delta_y = y2 - y1;
    delta_x = x2 - x1;
  }  
  //find the slope of the line
  float slope = delta_y / delta_x;
  
  //find the b value of the line
  float b = y2 - slope * x2;
  
  //find the reciprocal slope
  float reciprocal_slope = 1 / slope * -1;
  
  //find the reciprocal b value
  float reciprocal_b = arbitrary_y - reciprocal_slope * radius;
  
  //find the intersection value of x
  float intersection_x = (b + (reciprocal_b * -1) ) / (reciprocal_slope + (slope * -1));
  
  //find the intersection value of y
  float intersection_y = slope * intersection_x + b;
  
  float[] closestPoint = {intersection_x, intersection_y};
  return closestPoint;
  
}
