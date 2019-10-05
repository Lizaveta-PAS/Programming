Uses math;

Type TFunction=Function(a:Word;t:double;Var y:Word);


{$F+}

Function PointsX(a,b:word,t:double):double;
begin
PointsX:=a*sqr(cos(t))+b*cos(t);
end;

Function PointsY(a,b:word,t:double):double;
begin
PointsY:=a*sqr(cos(t))+b*cos(t);
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
 Const eps=1E-6;
 var Width, Height:integer;
 X,Y:TMas;
	 i, N:longword;
	 r1,r2:double;
	 MaxX, MinX, MaxY, MinY:double;
	 MashX, MashY, Mash:double;
     XG,YG,xf,yf:TMas;
 begin
 TEnd:=TEnd*eps;
 Width:=BottomX-TopX-2*dx;
 Height:=BottomY-TopY-2*dy;
 N:=Round((TEnd-TBegin)/dT)+1;
 SetLength(X,N);
 SetLength(Y,N); 
  for i:=0 to N-1 do
   begin
    T:=TBegin+i*dT;
    {r1:=FX(a,b,t);
    r2:=FY(a,b,t);}
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

   XG:=round(xf*Mash)+BottomX+ (TopX-BottomX) div 2;
   YG:=round(yf*Mash)+BottomY+ (TopY-BottomY) div 2;
   PutPixel(XG,YG);
   t:=t+dT;
   end;
  end;

end;



