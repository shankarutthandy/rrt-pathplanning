int MaxIterations=10000000;
RRT path=null;
ArrayList<obstacle> obs=new ArrayList<obstacle>();
PVector strt=null;
PVector endPoint=null;
menu m=new menu();
void setup()
{
  size(800,800);
  background(255);
 
}

void mouseDragged()
{
  m.mouseDragged();
}
void draw()
{
 if(m.run || m.rrtSTAR)
 {
 m.render();
 }
 else
 {
   background(255);
   m.render();
 }
}
class vertx
{
  PVector pose;
  float weight;
  vertx previous;
  vertx(PVector pose_,float wgt,vertx prev)
  {
    pose=pose_;
    weight=wgt; 
    previous=prev;
  }
}
