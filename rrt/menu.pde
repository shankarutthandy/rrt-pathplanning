class menu
{
  boolean start;
 boolean end;
 boolean run;
 boolean addObs;
 boolean clearObs;
 boolean rrtSTAR;
 float bias;
 float renderl;
 float rewireR;
 float Dist;
 menu()
 {
  start=false;
  end=false;
  run=false;
  rrtSTAR=false;
  bias=0.2;
  renderl=map(bias,0,1,0,100);
  rewireR=30;
  Dist=10;
 }
 void biasRender()
 {
   if(mousePressed && mouseX>=100 && mouseX<=200 && mouseY<60 && mouseY>50)
      { 
        this.start=false;
        this.end=false;
        this.addObs=false;
        this.bias=map(mouseX-100,0,100,0,1);
        this.renderl=mouseX-100;
      
      }
   stroke(0);
   noFill();
   rect(150,55,100,10);
   fill(0);
    text("goal-bias  :",20,60);
   text(str(this.bias),210,60);
   rectMode(CORNER);
   fill(color(0,255,0));
   rect(100,50,this.renderl,10);
 }
 void distRender()
 {
  if(mousePressed && mouseX>=315 && mouseX<=365 && mouseY<60 && mouseY>50)
      { 
        this.start=false;
        this.end=false;
        this.addObs=false;
        this.Dist=mouseX-315;
     }
   stroke(0);
   noFill();
   rectMode(CENTER);
   rect(340,55,50,10);
   fill(0);
   text("jump  :",260,60);
   text(str(this.Dist),370,60);
   rectMode(CORNER);
   fill(color(0,255,0));
   rect(315,50,this.Dist,10);
 }
 void rewireRender()
 {
   if(mousePressed && mouseX>=520 && mouseX<=620 && mouseY<60 && mouseY>50)
      { 
        this.start=false;
        this.end=false;
        this.addObs=false;
        this.rewireR=mouseX-520;
     }
   stroke(0);
   noFill();
   rectMode(CENTER);
   rect(570,55,100,10);
   fill(0);
   text("rewire-radius  :",420,60);
   text(str(this.rewireR),630,60);
   rectMode(CORNER);
   fill(color(0,255,0));
   rect(520,50,this.rewireR,10);
 }
 void render()
 {
 if(!(m.run || m.rrtSTAR))  
   {
     this.biasRender();
   this.rewireRender();
   this.distRender();
   }
 this.mousePressed();
 fill(color(240,220,220));
 strokeWeight(2);
 stroke(0);
 rectMode(CENTER);
 rect(50,20,100,40);
 rect(150,20,100,40);
 rect(250,20,100,40);
 rect(350,20,100,40);
 rect(450,20,100,40);
 fill(color(200,240,220));
 rect(550,20,100,40);
 fill(0);
 text("START",30,25);
 text("END",140,25);
 text("RUN",240,25);
 text("add obstacles",310,25);
 text("clear obstacles",410,25);
 text("RUN RRT*",520,25);
  stroke(120);
  strokeWeight(3);
  line(0,68,width,68);
if(this.run || this.rrtSTAR)
   {
     
     if(path==null)
     {  
     path=new RRT(MaxIterations,this.Dist,strt,endPoint,obs,this.rrtSTAR,this.bias,this.rewireR);
     //this.biasRender();
     }
     else
     {
       path.show();
     }
   }
   else
   {
     noStroke();
     //this.biasRender();
     if(strt!=null)
     {
    fill(color(0,255,0));
    ellipse(strt.x,strt.y,20,20);
    }
    if(endPoint!=null)
     {
    fill(color(255,0,0));
    ellipse(endPoint.x,endPoint.y,20,20);
    }
     
     for(obstacle o:obs)
     {
       o.show();
     }
   }

 }
 void mousePressed()
 {
   if(mousePressed)
   {
   if(mouseX>0 && mouseX<100 && mouseY<40 && mouseY>0)
   {
     this.start=true;
     this.end=false;
     this.clearObs=false;    
      this.addObs=false;
   }
   else if (mouseX>100 && mouseX<200 && mouseY<40 && mouseY>0)
   {
     this.start=false;
     this.end=true;
     this.clearObs=false;
      this.addObs=false;
   }
  else if (mouseX>200 && mouseX<300 && mouseY<40 && mouseY>0)
   {
     if(strt!=null && endPoint!=null)
     {
      this.start=false;
      this.end=false;
      this.run=true;
      this.addObs=false;
      this.clearObs=false;
     }
   }
   else if (mouseX>300 && mouseX<400 && mouseY<40 && mouseY>0)
   {
     this.start=false;
     this.end=false;
      this.addObs=true;
      this.clearObs=false;
   }
   else if (mouseX>400 && mouseX<500 && mouseY<40 && mouseY>0)
   {
     this.start=false;
     this.end=false;
      this.addObs=false;
      this.clearObs=true;
   }
  else if (mouseX>500 && mouseX<600 && mouseY<40 && mouseY>0)
   {
     if(strt!=null && endPoint!=null)
     {
     this.start=false;
     this.end=false;
      this.addObs=false;
      this.clearObs=false;
      this.rrtSTAR=true;
     }
   }
   if(this.start)
   {
     if(mouseY>70)
     strt=new PVector(mouseX,mouseY);
   }
   else if(this.end)
   {
     if(mouseY>70)
     endPoint=new PVector(mouseX,mouseY);
   }
   else if(this.clearObs)
   {
     obs=new ArrayList<obstacle>();
   }
   }
 }
 void mouseDragged()
 { 
  if(this.addObs)
  {
    if(mouseY>70)
      obs.add(new obstacle(new PVector(mouseX,mouseY),10));
  }
 
 }
}
