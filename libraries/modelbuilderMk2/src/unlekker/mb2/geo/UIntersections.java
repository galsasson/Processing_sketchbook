package unlekker.mb2.geo;

import unlekker.mb2.util.UMB;

public class UIntersections extends UMB {
  private static UFace planeY;
  
  public static UVertex[] faceYPlane(UFace f,float Y) {

    if(planeY==null) {
      float BIG=Float.MAX_VALUE*0.1f;
      planeY=new UFace().set(
          new UVertex(BIG,0),
          new UVertex(BIG,0).rotY(120*DEG_TO_RAD),
          new UVertex(BIG,0).rotY(240*DEG_TO_RAD));
      log(planeY.normal().str()+" "+
          UVertex.delta(planeY.v[1],planeY.v[0]).str()+" "+
          UVertex.delta(planeY.v[2],planeY.v[0]).str());
    }
    float yD=Y-planeY.getV()[0].y;
    for(UVertex vv:planeY.getV()) vv.add(0,yD,0);
    
    UVertex[] fv=f.getV();
    if(fv[0].y>Y && fv[1].y>Y && fv[2].y>Y) return null;
    if(fv[0].y<Y && fv[1].y<Y && fv[2].y<Y) return null;

    log("planeY "+str(planeY.getV())+" | "+str(fv));
    
    int id=0;
    UVertex[] vv=new UVertex[] {
        linePlane(fv[0], fv[1], planeY),
        linePlane(fv[1], fv[2], planeY),
        linePlane(fv[2], fv[0], planeY)
//        lineYPlane(fv[0], fv[1], Y),
//        lineYPlane(fv[1], fv[2], Y),
//        lineYPlane(fv[2], fv[0], Y)
    };
    
    return vv;
  }

  public static UVertex linePlane(UVertex a,UVertex b,UFace plane) {
    UVertex D1,D2,v[],n,origin;
    
    v=plane.getV();
    n=plane.normal();
    log(str(v)+" "+n.str());
    D1=v[0].delta(v[1]);
    D2=v[0].delta(v[2]);
    n=D1.cross(D2).norm();

    origin=v[0];
    
    // distance plane -> a/b
    float dist=origin.mag();
    dist=0;
    float da = a.dot(n) - dist;
    float db = b.dot(n) - dist;

    log(n.str()+" da "+da+" db "+db);
  //The distance is < zero if the point is on the backside of the plane. It's zero if the point is on the plane, and positive otherwise. If both points have a negative distance we can remove them. The line will be entirely on the backside of the plane. If both are positive we don't have to do anything (the line is completely visible). But if the signs are different we have to calculate the intersection point of the plane and the line:
    if(da>0 && db>0) return null;
    if(da<0 && db<0) return null;
    if(da==0 || db==0)  return null;
    
    UVertex i=new UVertex();
    float s = da/(da-db);   // intersection factor (between 0 and 1)
  
    i.set(b).sub(a).mult(s).add(a);
    i.set(a.x + s*(b.x-a.x),
        a.y + s*(b.y-a.y),
        a.z + s*(b.z-a.z));
    i.log("Intersection: "+ i.str()+" "+s);
    return i;
  
  }

  /**
   * Simplified line-plane intersection between 3D line and XZ plane at a 
   * given Y position.
   * @param a line - start position
   * @param b line - end position
   * @param Y Y position of plane 
   * @return
   */
  public static UVertex lineYPlane(UVertex a,UVertex b,float Y) {
    UVertex D1,D2,v[],n,origin;
    
    n=new UVertex(0,1,0);

    float dist=0;
    float da = a.dot(n) - dist;
    float db = b.dot(n) - dist;

  //The distance is < zero if the point is on the backside of the plane. It's zero if the point is on the plane, and positive otherwise. If both points have a negative distance we can remove them. The line will be entirely on the backside of the plane. If both are positive we don't have to do anything (the line is completely visible). But if the signs are different we have to calculate the intersection point of the plane and the line:
    if(da>0 && db>0) return null;
    if(da<0 && db<0) return null;
    if(da==0 || db==0)  return null;
    
    UVertex i=new UVertex();
    float s = da/(da-db);   // intersection factor (between 0 and 1)
  
    i.set(b).sub(a).mult(s).add(a);
    i.set(a.x + s*(b.x-a.x),
        a.y + s*(b.y-a.y),
        a.z + s*(b.z-a.z));
//    i.set(a.x + s*(b.x-a.x),
//        a.y + s*(b.y-a.y),
//        a.z + s*(b.z-a.z));
    i.log(i.str()+" "+s);
    return i;
  
  }

}
