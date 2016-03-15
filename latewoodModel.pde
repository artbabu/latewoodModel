// Press 'w' to start wiggling, space to restore
// original positions.

PShape cube;
PShape subCube1;
PShape subCube2;
float cubeSize = 25;
float circleRad = 8;
int circleRes = 8;
float noiseMag = 1;

boolean wiggling = false;

void setup() {
  size(1024, 768, P3D);    

  createCube();
}

void draw() {
  background(180);
  lights(); 
  translate(width/2, height/2);
  rotateX(frameCount * 0.01f);
 rotateY(frameCount * 0.01f);
  //rotateX(PI/3);
 //rotateY(PI/3);

  shape(cube);

  if (wiggling) {
    PVector pos = null;
    for (int i = 0; i < cube.getChildCount(); i++) {
      PShape face = cube.getChild(i);
      for (int j = 0; j < face.getVertexCount(); j++) {
        pos = face.getVertex(j, pos);
        pos.x += random(-noiseMag/2, +noiseMag/2);
        pos.y += random(-noiseMag/2, +noiseMag/2);
        pos.z += random(-noiseMag/2, +noiseMag/2);
        face.setVertex(j, pos.x, pos.y, pos.z);
      }
    }
  }

 // if (frameCount % 60 == 0) println(frameRate);
}

public void keyPressed() {
  if (key == 'w') {
    wiggling = !wiggling;
  } else if (key == ' ') {
    restoreCube();
  } else if (key == '1') {
    cube.setStrokeWeight(1);
  } else if (key == '2') {
    cube.setStrokeWeight(5);
  } else if (key == '3') {
    cube.setStrokeWeight(10);
  }
}

void createCube() {
  cube = createShape(GROUP);
  cube.noStroke();
 cube. fill(255, 255, 255);
  int i =0 ;
  float tranX = 25 ;
  float tranZ = 25 ;
  
  
  while( i<4){
    
   PShape cubeRow = createShape(GROUP);
   //pushMatrix();
   
  pushMatrix();
  subCube1 = createShape(GROUP);
  subCube1 = createSubCube(subCube1);
  cubeRow.addChild(subCube1);
   
  println("subcube 1 ===>"+subCube1.getChildCount()); 
   
  subCube2 = createShape(GROUP);
  subCube2.translate(50, 0); 
  subCube2 = createSubCube(subCube2);
  cubeRow.addChild(subCube2);
  
  println("subcube 2 ===>"+subCube2.getChildCount());
  popMatrix();
  cubeRow.translate(tranX,0,tranZ);
  tranX += tranX;
  tranZ += tranZ;
  cube.addChild(cubeRow);
 // popMatrix();
  i++;
  println("cubeRow ===>"+cubeRow.getChildCount());
  }
  
  println("cube ===>"+cube.getChildCount());
  
}
PShape createSubCube(PShape scube)
{
   PShape face;

 
  // Rotate all the faces to their positions

    face = createShape();
    createFaceWithHole(face,+cubeSize/2,+(10*cubeSize));
    scube.addChild(face);
  
  //// Front face - already correct
  //face = cube.getChild(0);
 
    
    face = createShape();
    face.rotateY(radians(180));
    createFaceWithHole(face,+cubeSize/2,+(10*cubeSize));
    scube.addChild(face);
   

  //// Back face
  //face = cube.getChild(1);
  

   face = createShape();
   face.rotateY(radians(90));
   createFaceWithHole(face,+cubeSize/2,+(10*cubeSize));
   scube.addChild(face);
// //// Right face
//// face = cube.getChild(2);


// //// Left face
 face = createShape();
 face.rotateY(radians(-90));
 createFaceWithHole(face,+cubeSize/2,+(10*cubeSize));
 scube.addChild(face);
  
 

    // Top face
    face = createShape();
    face.rotateX(radians(90));
    createTopFaceWithHole(face,+cubeSize/2,+cubeSize/2);
    scube.addChild(face);
// face = cube.getChild(4);

// //// Bottom face
  face = createShape();
    face.rotateX(radians(-90));
    createTopFaceWithHole(face,+cubeSize/2,+cubeSize/2);
    scube.addChild(face);
    
    
    return scube;
}
void createFaceWithHole(PShape face,float l,float b) {
  face.beginShape(POLYGON);
  face.noStroke();

  // Draw main shape Clockwise
  face.vertex(-(l), -b, +l);
  face.vertex(+(l), -b, +l);
  face.vertex(+(l), +b, +l);
  face.vertex(-(l), +b, +l);

  //println(-(l)+"//"+ -b +"//"+ +l);
  //println(+(l)+"//"+ -b+"//"+ +l);
  //println(+(l)+"//"+ +b+"//"+ +l);
  //println(-(l)+"//"+ +b+"//"+ +l);
  //println("******************************************");
 float angle = 0;
  float angleIncrement = TWO_PI / circleRes;
  
//face.beginContour();
//  for (int i = 0; i < circleRes; ++i) {
//    face.vertex(circleRad*cos(angle), circleRad*sin(angle),0);
//    face.vertex(circleRad*cos(angle), circleRad*sin(angle),20*l);
//    angle += angleIncrement;
//  }
//  face.endContour();
  // Draw contour (hole) Counter-Clockwise
  //face.beginContour();
  // println("********************Circle**********************");
  //for (int i = 0; i < circleRes; i++) {
  //  float angle = TWO_PI * i / circleRes;
  //  float x = sin(  angle ) * circleRad;
  //  float y = cos(  angle  ) * (circleRad);
  //  face.vertex( x, y, l );     
  //    println("angle"+angle);
  //    println(x+"//"+y+"//"+l);
   
  // // println(" coor ==>"+x+" "+y+" "+cubeSize );
  // /* float x = circleRad * sin(angle);
  //   float y = circleRad * cos(angle);
  //   float z = +cubeSize/2;
  //   face.vertex(x, y, z);*/
  //}
  // println("********************End Of Circle****************");
  //face.endContour();
  face.endShape(CLOSE);
}
void createTopFaceWithHole(PShape face,float l,float b) {
  
  PShape pore = createShape();
  face.beginShape(POLYGON);
  face.fill(255, 255, 255);
 // face.noStroke();

  // Draw main shape Clockwise
  face.vertex(-l, -b, +(20*l));
  face.vertex(+l, -b, +(20*l));
  face.vertex(+l, +b, +(20*l));
  face.vertex(-l, +b, +(20*l));

//println(-(l)+"//"+ -b +"//"+ +(20*l));
//  println(+(l)+"//"+ -b+"//"+ +(20*l));
//  println(+(l)+"//"+ +b+"//"+ +(20*l));
//  println(-(l)+"//"+ +b+"//"+ +(20*l));
//  println("******************************************");
  // Draw contour (hole) Counter-Clockwise
  
  //float angle = 0;
  //float angleIncrement = TWO_PI / circleRes;
  
  //float prevY = circleRad*sin(0) ;
  //float prevX = circleRad*cos(0) ;
  
  //face.beginContour();
 //for (int i = 1; i <= circleRes; ++i) {
  //  angle += angleIncrement;
  //  face.vertex(prevX,prevY,0);
  // face.vertex( circleRad*cos(angle),(circleRad*2)*sin(angle),0);
   
  // face.vertex(prevX,prevY,20*l);
   
  // face.vertex( circleRad*cos(angle),(circleRad*2)*sin(angle),20*l);
   
   
   
  // prevY =  circleRad*sin(angle) ;
  // prevX = circleRad*cos(angle) ;
   
  
 //}
   
  //face.endContour();
  
  face.beginContour();
  //println("********************Circle**********************");
  for (int i = 0; i < circleRes; i++) {
   float angle = TWO_PI * i / circleRes;
   float x = sin(  angle ) * (circleRad);
   float y = cos(  angle  ) * (2*circleRad);
   face.vertex( x, y,(20*l));     
 
    // println(x+"//"+y+"//"+(20*l));
   
  // println(" coor ==>"+x+" "+y+" "+cubeSize/2 );
   /*float x = circleRad * sin(angle);
    float y = circleRad * cos(angle);
    float z = +cubeSize/2;
    face.vertex(x, y, z);*/
  }
  //println("********************End Of Circle****************");
  face.endContour();

  face.endShape(CLOSE);
}


void restoreCube() {
  // Rotation of faces is preserved, so we just reset them
  // the same way as the "front" face and they will stay
  // rotated correctly
  for (int i = 0; i < 6; i++) {
    PShape face = cube.getChild(i);
    restoreFaceWithHole(face);
  }
}

void restoreFaceWithHole(PShape face) {
  face.setVertex(0, -cubeSize/2, -cubeSize/2, +cubeSize/2);
  face.setVertex(1, +cubeSize/2, -cubeSize/2, +cubeSize/2);
  face.setVertex(2, +cubeSize/2, +cubeSize/2, +cubeSize/2);
  face.setVertex(3, -cubeSize/2, +cubeSize/2, +cubeSize/2);
  for (int i = 0; i < circleRes; i++) {
    float angle = TWO_PI * i / circleRes;
    float x = circleRad * sin(angle);
    float y = circleRad * cos(angle);
    float z = +cubeSize/2;
    face.setVertex(4 + i, x, y, z);
  }
}