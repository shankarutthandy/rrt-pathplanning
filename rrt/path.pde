class RRT
{
  ArrayList<vertx> vertices;
  float dist;
  int iterations;
  boolean reached;
  PVector end;
  PVector start;
  ArrayList<obstacle> obstacles;
  boolean star;
 float goalBias;
 float rewireRadius;
  RRT(int iterations_,float dist_,PVector start_,PVector end_,ArrayList<obstacle> obs,boolean star_,float goalBias_,float rr)
  {
    vertices=new ArrayList<vertx>();
    start=start_;
    dist=dist_;
    iterations=iterations_;
    vertices.add(new vertx(start_,0,null));
    reached=false;
    end=end_;
    obstacles=obs;
    star=star_;
    goalBias=goalBias_;
    rewireRadius=rr;
  }
  void update()
  {
    if(this.iterations>0 && !this.reached)
    {
      PVector ran=new PVector(floor(random(width)),floor(random(height)));
    if(random(1)<this.goalBias)
    {
      float radius=50;
      ran=PVector.random2D();
      ran.mult(random(0,radius));
      ran.add(end);
    }
    vertx winner=this.vertices.get(this.vertices.size()-1);
    float dmin=PVector.dist(winner.pose,ran);
    for(vertx v:this.vertices)
    {
      float d=PVector.dist(v.pose,ran);
      if(d<dmin)
      {
        dmin=d;
        winner=v;
      }
    }
    ran.sub(winner.pose);
    ran.normalize();
    ran.mult(this.dist);
    ran.add(winner.pose);
    vertx v=new vertx(ran,winner.weight+this.dist,winner);
    if(!this.colliding(v))
    {
      if(this.star)
      {
      this.rewire(v);
      }
      if(PVector.dist(ran,this.end)<10)
    {
      this.reached=true;
    }
    
    this.vertices.add(v);
    }
    this.iterations--;
  }
  }
  void show()
  {
    noStroke();
    fill(color(0,255,0));
    ellipse(this.start.x,this.start.y,20,20);
    fill(color(255,0,0));
    ellipse(this.end.x,this.end.y,20,20);
    for(obstacle o:this.obstacles)
    {
      o.show();
    }
    this.update();
    vertx latest=this.vertices.get(this.vertices.size()-1);
    while(latest.previous!=null)
    {
      stroke(color(0,0,255));
      strokeWeight(1);
      line(latest.pose.x,latest.pose.y,latest.previous.pose.x,latest.previous.pose.y);
      latest=latest.previous;
    }
    if(this.reached)
    {
      vertx e=this.vertices.get(this.vertices.size()-1);
      stroke(color(0,240,0));
      while(e.previous!=null)
      {
        strokeWeight(4);
        line(e.pose.x,e.pose.y,e.previous.pose.x,e.previous.pose.y);
        e=e.previous;
      }
      noLoop();
      saveFrame("rrt-star2.png");
    }
  }
  void rewire(vertx curr)
  {
    vertx min=curr.previous;
    for(vertx v:this.vertices)
    {
      if(PVector.dist(v.pose,curr.pose)<this.rewireRadius)
      {
      if(min.weight+PVector.dist(curr.pose,min.pose)>v.weight+PVector.dist(v.pose,curr.pose))
      {
        min=v;
      }
    }
    }
    curr.previous=min;
    curr.weight=min.weight+PVector.dist(curr.pose,min.pose);
  }
  boolean colliding(vertx v)
  {
    for(obstacle o:this.obstacles)
    {
      if(o.collides(v))
      {
       return true; 
      }
    }
    return false;
  }
}
