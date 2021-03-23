class obstacle
{
  PVector pose;
  float radius;
  
  obstacle(PVector pose_,float r)
  {
    pose=pose_;
    radius=r;
  }
  boolean collides(vertx v)
  {
    if(PVector.dist(v.pose,this.pose)<this.radius)
    {
      return true;
    }
    return false;
  }
  void show()
  {
    fill(0);
    ellipse(this.pose.x,this.pose.y,(this.radius-2)*2,(this.radius-2)*2);
  }
}
