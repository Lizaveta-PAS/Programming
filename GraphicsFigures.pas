Program GraphFig;
Uses math,crt, dos, ptcGraph, sysutils;

Type TFunction=Function(a,b:Word;t:double):double;

Procedure InitGraph(gd, gm:integer; PathToDriver:string);
 begin
 InitGraph(gd, gm, PathToDriver);
 if GraphResult <> grok then halt;
 end;

{$F+}

Function PointsX(a,b:word,t:double):double;
begin
PointsX:=a*sqr(cos(t))+b*cos(t);
end;

Function PointsY(a,b:word,t:double):double;
begin
PointsY:=a*cos(t)*sin(t)+b*sin(t);
end;

{$F-}

Procedure PlotAxis(TopX,TopY,BottomX,BottomY : integer; dx,dy: double;ColorAxis : integer);
begin
SetColor(ColorAxis);
Line(BottomX+dx,(TopY-BottomY) div 2,TopX-dx,BottomY+(TopY-BottomY) div 2);
Line(BottomX + (TopX-BottomX) div 2, BottomY + dy,BottomX + (TopX-BottomX) div 2,TopY-dy);
end;

Procedure PlotGraph(TopX,TopY,BottomX,BottomY:integer;FX,FY:TFunction;TBegin,TEnd,dT:double;dx,dy:double;a,b:Word);
 type TMas= array of double;
 var Width, Height:integer;
 X,Y:TMas;
	 T:double;
   r1,r2,xf,yf:double;
   MaxX, MinX, MaxY, MinY:double;
   MashX, MashY, Mash:double;
   XG,YG:integer;
 begin
 Width:=BottomX-TopX-2*dx;
 Height:=BottomY-TopY-2*dy;
 N:=Round((TEnd-TBegin)/dT)+1;
 SetLength(X,N);
 SetLength(Y,N); 
  for i:=0 to N-1 do
   begin
    T:=TBegin+i*dT;
    r1:=FX(a,b,t);
    r2:=FY(a,b,t);
    X[i]:=FX(a,b,t);
    Y[i]:=FY(a,b,t);
   end;
 MaxX:=maxvalue(X);
 MinX:=minvalue(X);
 MaxY:=maxvalue(Y);
 MinY:=minvalue(Y);
 MashX:=Width/(MaxX-MinX);
 MashY:=Height/(MaxY-MinY);
 Mash:=Min(MashX,MashY);

 T:=TBegin;
  for i:=0 to N-1 do begin
   r1:=FX(a,b,t);
   r2:=FY(a,b,t);
   xf:=PointsX(a,b,t);
   yf:=PointsY(a,b,t);

   XG:=round(r1*Mash)+BottomX+ (TopX-BottomX) div 2;
   YG:=round(r2*Mash)+BottomY+ (TopY-BottomY) div 2;
   PutPixel(XG,YG,White);
   PutPixel(XG,YG);
   t:=t+dT;
   end;

end;

Const eps=1E-6;
Var x1,y1,x2,,ColorAxis:integer;
    gd,gm:smallint;
    Mash:double;
    TBegin,TEnd:double;

begin
  InitGraph(10,262,'');
  
  x1:=0;y1:=0;x2:=GetMaxX div 2;y2:=GetMaxY div 2;
  SetViewPort(x1,y1,x2,y2,ClipOn);
  ColorAxis:=white;
  PlotAxis(x1,y1,x2,y2,4,4,ColorAxis)
  x2:=x2-x1;y2=y2-y1;x1:=0,y1:=0;
  TBegin:=0;TEnd:=2*pi*eps;
  PlotGraph(x1,y1,x2,y2,@PointsX,@PointsY,TBegin,TEnd,0.001,8,8,5,11);

  x1:=0;y1:=getmaxy div 2; x2:=getmaxx div 2;y2:=getmaxy;
  setviewport(x1,y1,x2,y2,ClipOn);
  ColorAxis:=red;
  x2:=x2-x1;y2:=y2-y1;x1:=0;y1:=0;
  PlotAxis(x1,y1,x2,y2,8,8,ColorAxis);
  TBegin:=0;TEnd:=2*Pi;
  PlotGraph(x1,y1,x2,y2,@PointsX,@PointsY,TBegin,TEnd,0.001,8,8,3,4);

  x1:=getmaxx div 2;y1:=0; x2:=getmaxx;y2:=getmaxy div 2;
  setviewport(x1,y1,x2,y2,ClipOn);
  ColorAxis:=blue;
  PlotAxis(x1,y1,x2,y2,8,8,ColorAxis);
  x2:=x2-x1;y2:=y2-y1;x1:=0;y1:=0;;
  TBegin:=0;TEnd:=2*Pi;
  PlotGraph(x1,y1,x2,y2,@PointsX,@PointsY,TBegin,TEnd,0.001,8,8,9,4);
 
  x1:=getmaxx div 2;y1:=getmaxy div 2; x2:=getmaxx;y2:=getmaxy;
  setviewport(x1,y1,x2,y2,ClipOn);
  ColorAxis:=green;
  PlotAxis(x1,y1,x2,y2,8,8,ColorAxis);
  x2:=x2-x1;y2:=y2-y1;x1:=0;y1:=0;;
  TBegin:=0;TEnd:=50*Pi;
  PlotGraph(x1,y1,x2,y2,@PointsX,@PointsY,TBegin,TEnd,0.001,8,8,4,3);
readln;
end.    






