unit crysmath;

interface
uses
  Windows, Messages, SysUtils, Classes;

const
     MaxFaceCount=150; {����������� ���������� ���������� �p����}


Type
    CoordMat=array[1..3,1..3]of real;
    matsys = array [0..10,0..11] of real;
     vectsys = array [0..10] of real;
     Goniom =  array [1..MaxFaceCount,1..2] of real;
       {������� ������ � p���������� ��� �p����}
     coord=array[1..600] of real;


var  anglunit : word;

function tg(A : double) : double;

function Ctg(A : double) : double;

procedure  MakeCoord(var T : CoordMat);
{����p����� ��������� ���p���}

procedure rotx(d : real; var T1 : CoordMat);
procedure roty(d : real; var T1 : CoordMat);
procedure rotz(d : real; var T1 : CoordMat);
{�p������ ���p�� ���p�������� ����}

procedure rotation(var x,y,z : real;var t : coordmat); {����p�� ���p�����
��� ����� �����}
procedure matrotation(var t1,t : coordmat); {�p������ ������� ���p�����}

function stepen(a : real; n : integer) : real;
{���������� � � ������� n}

function angltrans(a:real) : real;
{��p���� ����� �� p����� � ������� �������� ������ "����"}

function gradmin(var x : real) : real; {��p���� �p������
  � ����� � p������}

function transAngl(x : real) : real;
{��p���� ����� �� ������ �������� ������ "����" � p������}

procedure polinom(var a: vectsys; m:integer; n : integer;
px,py : array of double; var bool:boolean);
{���p��������� ���������; �[i]- ���������� �p� ����� i �������;
m - ������� �������� (<=10);n - ���������� �����
px,py - ��������� �� TList, ����p����� �������� X � Y ��������������
bool=false ���� ��p��������� � ����� m ����������}

procedure gauss( b : matsys; var a : vectsys; m : integer;
          var bool : boolean);
{P������ ������� �p������� ������� ������. B-���p��� �������,
�-�����p p������,m-����� �p�������,bool=false ���� ��� p������;}

procedure dek(var fi,ro,x,y,z : real);
{��p���� �� ����p��� ���p����� � ����p����� ��� ����� �����}

procedure dekart(var firo : goniom; var x,y,z : coord; n : integer);
{��p���� �� ��������p������� ���p����� � ����p�����}

procedure pol(var fi,ro,x,y,z : real);
{��p���� �� ����p����� ���p����� � ����p��� ��� ����� �����}

procedure polarn(var firo : goniom; x,y,z : coord; n : integer);
{��p���� �� ����p������ ���p����� � ��������p�������}

implementation

function tg(A : double) : double;
var b:double;
begin
	b:=Cos(A);
	if B<1E-35 then tg:=1E35 else
	Tg:=Sin(A)/B;
end;

function Ctg(A : double) : double;
var b:double;
begin
	b:=Sin(A);
	if B<1E-35 then Ctg:=1E35 else
	CTg:=Cos(A)/B;
end;



procedure  MakeCoord(var T : CoordMat);
var    i,j : integer;
begin
    for i:=1 to 3 do begin
             for j:=1 to 3 do
                 t[i,j]:=0;
                 t[i,i]:=1;
    end;
end;

procedure rotx(d : real; var T1 : CoordMat);
            begin
                 t1[1,1]:=1; t1[2,1]:=0; t1[3,1]:=0;
                 t1[1,2]:=0; t1[2,2]:=cos(d); t1[3,2]:=sin(d);
                 t1[1,3]:=0; t1[2,3]:=-sin(d); t1[3,3]:=cos(d);
	    end;

procedure roty(d : real; var T1 : CoordMat);
	    begin
		 t1[1,1]:=cos(d); t1[2,1]:=0; t1[3,1]:=-sin(d);
		 t1[1,2]:=0; t1[2,2]:=1; t1[3,2]:=0;
		 t1[1,3]:=sin(d); t1[2,3]:=0; t1[3,3]:=cos(d);
	    end;
procedure rotz(d : real; var T1 : CoordMat);
            begin
		 t1[1,1]:=cos(d); t1[2,1]:=sin(d); t1[3,1]:=0;
                 t1[1,2]:=-sin(d); t1[2,2]:=cos(d); t1[3,2]:=0;
                 t1[1,3]:=0; t1[2,3]:=0; t1[3,3]:=1;
	    end;

procedure rotation(var x,y,z : real; var t : coordmat);
var x1 : array [1..3] of real;
    i : 1..3;
begin
     for i:=1 to 3 do x1[i]:=0;
     for i:=1 to 3 do
             x1[i]:=x1[i]+x*t[1,i]+y*t[2,i]+z*t[3,i];
     x:=x1[1]; y:=x1[2]; z:=x1[3];
end;

procedure matrotation(var t1,t : coordmat);
var i : 1..3;
begin
     for i:=1 to 3 do
     rotation(t1[i,1],t1[i,2],t1[i,3],t);
end;


function angltrans(a:real) : real;
begin
     case anglunit of
     1 : angltrans:=a*180/pi;
     2 : if abs(a)<0.00001 then angltrans:=0 else
	 angltrans:=a*(int((abs(a)+1E-11)*180/pi)+
		frac((abs(a)+1E-11)*180/pi)*0.6)/abs(a);
     0 : angltrans:=a;
     end;
end;

function transAngl(x : real) : real;
begin
     case anglunit of
     1 : TransAngl:=x*pi/180;
     2 : TransAngl:=(int(x)+frac(x)/0.6)*pi/180;
     0 : TransAngl:=x;
     end;
end;

function gradmin(var x : real) : real;
begin
     gradmin:=(int(x)+frac(x)*1.666667)*pi/180;
end;

procedure gauss(b : matsys; var a : vectsys; m : integer;
          var bool : boolean);
var  i,im,j,k : integer;
     c,dmax : real;
begin
     bool:=true;
     m:=m-1;
     for i:=0 to m do begin
        dmax:=1E-20;
        im:=-1;
        for j:=i to m do
               if abs(b[j,i])>dmax then begin im:=j; dmax:=abs(b[j,i]) end;
        if im=-1 then begin bool:=false; exit end;
                for j:=i to m+1 do begin
                c:=b[i,j]; b[i,j]:=b[im,j]; b[im,j]:=c;
        end;
        for j:=i+1 to m do begin
            c:=b[j,i]/b[i,i];
            for k:=i+1 to m+1 do
                b[j,k]:=b[j,k]-b[i,k]*c;
        end;
     end;
     a[m]:=b[m,m+1]/b[m,m];
     for i:=1 to m do begin
         c:=b[m-i,m+1];
         for j:=0 to i-1 do
          c:=c-b[m-i,m-j]*a[m-j];
         a[m-i]:=c/b[m-i,m-i];
     end;
end;

function stepen(a : real; n : integer) : real;
var s : real;
    i : integer;
begin
     s:=1;
     if n<>0 then begin
	for i:=1 to abs(n) do
              s:=s*a;
        if n<0 then s:=1/s;
     end;
     stepen:=s;
end;

procedure polinom(var a: vectsys; m: integer; n : integer;
px,py : array of double; var bool:boolean);
var b : matsys;
    c,x,y : real;
    i,k,j : integer;

{���p��������� ���������; �[i]- ���������� �p� ����� i �������;
m - ������� �������� (<=10);n - ���������� �����
px,py - ��������� �� TList, ����p����� �������� X � Y ��������������
bool=false ���� ��p��������� � ����� m ����������}

begin
     if (m>10)or(m>n)or(m<1)or(n<1) then begin
        bool:=false;
        exit;
     end;
     bool:=true;
    for i:=0 to m do begin
        c:=0;
        for k:=1 to n do
                c:=c+py[k]*stepen(px[k],i);
        b[i,m+1]:=c;
        for j:=i to m do begin
                c:=0;
                for k:=1 to n do
                        c:=c+stepen(px[k],(i+j));
                b[i,j]:=c;
                b[j,i]:=c;
        end;
    end;
    gauss(b,a,m+1,bool);
end;

procedure dek(var fi,ro,x,y,z : real);
var r : real;
begin
         r:=sin(abs(ro));
	 Y:=r*cos(fi);
	 X:=-r*sin(fi);
         z:=cos(ro);
         if ro<0 then z:=-z;
end;


procedure dekart(var firo : goniom; var x,y,z : coord; n : integer);
var i : integer;
begin
     for i:=1 to n do
       dek(fiRo[i,1],Firo[i,2],x[i],y[i],z[i]);
end;

procedure pol(var fi,ro,x,y,z : real);
var p2 : real;
begin
     p2:=pi/2;
       if Y=0 then begin
		if X=0 then fi:=0
		else begin
			if X<0 then fi:=p2
			else fi:=pi*1.5;
		end
       end else begin
		if Y<0 then fi:=arctan(-X/Y)+pi
		else fi:=arctan(-X/Y);
       end;
	if Fi<0 then fi:=Fi+2*pi;
	if z=1 then  ro:=0 else
	if abs(z+1)<1E-8 then  ro:=pi else
	if abs(z)<1E-8 then ro:=p2 else
	ro:=arctan(sqrt(x*x+y*y)/z);
	if ro<0 then ro:=ro+pi;
end;

procedure polarn(var firo : goniom; x,y,z : coord; n : integer);
var i : integer;
begin
     for i:=1 to n do
     pol(fiRo[i,1],Firo[i,2],x[i],y[i],z[i]);
end;

end.
