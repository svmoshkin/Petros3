unit StDiagrams;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, OkCancl1, Hintctrl, ESBMaths, MoshChart, comctrls,
  TeCanvas, ADODb, Dialogs, Db, Variants;

type
  TStDiaForm = class(TOKBottomDlg)
    HelpBtn: TButton;
    GroupBox2: TGroupBox;
    HListBox2: THListBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    BitBtn5: TBitBtn;
    SaveDialog1: TSaveDialog;
    BitBtn6: TBitBtn;
    BitBtn2: TBitBtn;
    procedure HelpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HListBox1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure HListBox2DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TOPoint = class
  public
    Mark: boolean;
    X: real;
    Y: real;
   { Z : real;}
    Cod: integer;
          {Код поля, к которому принадлежит точка}
    TypCod: integer;
    ID: integer;
           {Код диаграммы, к которой принадлежит точка}
    constructor Create(AX, AY: real);
    constructor Copy(Source: TOPoint);
    constructor Load(var F: file); virtual;
    constructor LoadFromTable(T: tCustomADODataSet); virtual;
    procedure Save(var F: file); virtual;
    procedure SaveToTable(T: tCustomADODataSet); virtual;
    function GetR(Point: TOPoint): real;
    procedure Draw(Chart: TGeochart); virtual;
    procedure Cop(Source: TOPoint); virtual;
  end;

  TInterval = class(TOPOint)
  public
    Name: string[40];
    Node: TTreeNode;
    ClID: string[12];
    constructor Load(var F: file); override;
    procedure Save(var F: file); override;
    constructor LoadFromTable(T: tCustomADODataSet); override;
    procedure SaveToTable(T: tCustomADODataSet); override;
    procedure Draw(Chart: TGeochart); override;
    procedure Cop(Source: TOPoint); override;
  end;

  TLine = class
    P1, P2: TOPoint;
    a: real;
    B: real;
    C: real;

  public
    procedure Draw(Chart: TGeochart);
    constructor Create(A1, A2: TOPoint);
    function CrosPoint(L: TLine): TOPoint;
    function CrosPointIn(L: TLine; var CrP: TOPoint): boolean;
    function RToPoint(P: TOPoint): real;
    function ROtrToPoint(P: TOPoint): real;
    constructor Ort(L: TLine; P: TOPoint);
    procedure FreeWithPoints;
    function CrosInOTRs(L: TLine): boolean;
    function Len: real;
    function PointInOtr(P: TOPoint): boolean;
  end;

  TPointCollection = class(TList)
    Name1: string[40];
    Cod: Integer;
    TypCod: integer;
    Marked: Boolean;
    Id: Integer;
  public
    constructor Create(AName1: string; ACod: integer);
    constructor Copy(Source: TPointCollection);
    procedure Size(var MaxX, MaxY, MinX, MinY: real);
      {Максимальные и минимальные  координаты по осям}
    function Nearest(X, Y: real; var Point: TOPoint): real;
    function Add(Item: TOPoint): Integer;
    procedure UnMark;
    constructor Load(var F: file); virtual;
    constructor LoadFromTable(T, T1: tCustomADODataSet); virtual;
    procedure Save(var F: file); virtual;
    procedure SaveToTable(T, T1: tCustomADODataSet); virtual;
    destructor Destroy; override;
    procedure Draw(Chart: TGeochart); virtual;
    procedure SetCod(AKod: integer);
    procedure Rev; virtual;
    procedure DelPoint(P: TOPoint); virtual;
    procedure DeleteFromTable(t1, T: tCustomADODataSet); virtual;
    procedure Insert(Index: Integer; Item: Pointer);
  end;


  TVerCollection = class(TPointCollection)
  public
    NamePos: TOPoint;
    Node: TTreeNode;
    Bez: boolean;
    Width: integer;
    Style: TPenStyle;
    ClId: string[12];
    constructor Create(AName1: string; ACod: integer);
    constructor Load(var F: file); override;
    procedure Save(var F: file); override;
    function Add(Item: TOPoint): Integer;
    constructor LoadFromTable(T, T1: tCustomADODataSet); override;
    procedure SaveToTable(T, T1: tCustomADODataSet); override;
    function NearestLine(PP: TOPoint;
      var L: TLine): real;
    procedure Draw(Chart: TGeochart); override;
    function Perimetr: real;
    function PointIn(P: TOPoint): boolean;
    destructor Destroy; override;
    procedure Insert(Index: Integer; Item: Pointer);
  end;

  TIntervals = class(TPointCollection)
             {TypCod: 0 - X, 1 - Y;
             X - beg, Y - End}
    procedure Draw(Chart: TGeochart); override;
    constructor Load(var F: file); override;
    constructor LoadFromTable(T, T1: tCustomADODataSet); override;
    destructor Destroy; override;
    { procedure SaveToTable(T,T1 : TADOTable); override;}
  end;

  TCurve = class(TVerCollection)
     {TypCod: }
    procedure Draw(Chart: TGeochart); override;
  public
    constructor Create(AName1: string; ACod: integer);
    constructor CreateM(AX1,AY1,AX2,AY2 : Integer);
  end;

  TAx = class
  public
    Caption: string[60];
    Formula: string;
    Log: Boolean;
    min: real;
    max: real;
    logor: boolean;
    AW: boolean;
    proc100: Boolean;
    Mols: boolean;
    constructor Create;
    constructor Load(var F: file); virtual;
    procedure Save(var F: file); virtual;
  end;


  TDiagram = class(TList)
  public
    Name: string[80];
    Cod: integer;
    Xax: Tax;
    YAx: TAx;
    ZAx: TAx;
    Medians : array[0..2] of TCurve;
    Interv: TIntervals;
    ShowTitle: boolean;
    ShowNames: boolean;
    ShowGrid: boolean;
    Classification: Boolean;
    Lines: TList;
    Trio: boolean;
    Norma: Double;
    ID: integer;
    AlphaN: integer;
    destructor Destroy; override;
    constructor Create;
    constructor Load(var F: file); virtual;
    procedure Save(var F: file); virtual;
    constructor LoadFromTable; virtual;
    procedure SaveToTable(New: Boolean); virtual;
    procedure DeleteFromTable; virtual;
    procedure Draw(Chart: TGeochart);
  end;

var
  StDiaForm: TStDiaForm;
  Diagrams: TStringList;
 { NewFormat: Boolean;
  Bug: Boolean;}
  CurDiag: TDiagram;
  MustDiag: Boolean;


resourcestring
  stBeenDel = ': old classification results have been deleted.';
  stWillDel = ': all  classification results will be deleted!' + #10 + 'Continue?';



procedure SaveDiagr;
procedure LoadDiagr(Diagr: TStringList; Path: string);

implementation

uses StDiagprop, DMod1, Main, TrioGraph, RHAGlobs, Options, ADOUtilsS;

{$R *.DFM}

{##################### TOPoint #######################}

constructor TOPoint.Create(AX, AY: real);
begin
  inherited Create;
  X := AX;
  Y := AY;
  Mark := false;
  Cod := 0;
  TypCod := 0
end;

constructor TOPoint.Copy(Source: TOPoint);
begin
  inherited Create;
  Cop(Source);
end;


constructor TOPoint.Load(var F: file);
begin
  inherited Create;
  BlockRead(F, X, SizeOf(Real));
  BlockRead(F, Y, SizeOf(Real));
  BlockRead(F, Mark, SizeOf(boolean));
  BlockRead(F, Cod, SizeOf(integer));
  BlockRead(F, TypCod, SizeOf(integer));
end;

constructor TOPoint.LoadFromTable(T: tCustomADODataSet);
begin
  inherited Create;
  X := T['X'];
  Y := T['Y'];
  Cod := T['Cod'];
  TypCod := T['TypCod'];
  ID := T['ID'];
end;

procedure TOPoint.SaveToTable(T: tCustomADODataSet);
begin
  T['X'] := X;
  T['Y'] := Y;
  T['Cod'] := Cod;
  T['TypCod'] := TypCod;
end;

procedure TOPoint.Save(var F: file);
begin
  BlockWrite(F, X, SizeOf(Real));
  BlockWrite(F, Y, SizeOf(Real));
  BlockWrite(F, Mark, SizeOf(boolean));
  BlockWrite(F, Cod, SizeOf(integer));
  BlockWrite(F, TypCod, SizeOf(integer));
end;

function TOPoint.GetR(Point: TOPoint): real;
begin
  Result := Sqrt(Sqr(X - Point.X) + Sqr(Y - Point.Y));
end;



procedure TOPoint.Draw(Chart: TGeochart);
begin
  {kx := kzx;
  Can.Pen.Width := 3;
  Can.Pen.Color := clRed;
  Can.Rectangle(Round((X - DX) * KX) + 2,
    Heig - 2 - Round((Y - DY) * Kx),
    Round((X - DX) * KX) + 6,
    Heig - 6 - Round((Y - DY) * Kx));
  Can.Pen.Width := CurWidth;
  Can.Pen.Color := clBlack; }
end;

procedure TOPoint.Cop(Source: TOPoint);
begin
  X := Source.x;
  Y := Source.Y;
 { Z := Source.Z;}
  Cod := Source.Cod;
  TypCod := Source.TypCod;
end;

{################## TInterval ####################}

constructor TInterval.Load(var F: file);
begin
  inherited Load(F);
  BlockRead(F, Name, SizeOf(Name));
  BlockRead(F, ClId, SizeOf(ClId));
end;

constructor TInterval.LoadFromTable(T: tCustomADODataSet);
begin
  inherited LoadFromTable(T);
  if T['Name'] <> null then
    Name := T['Name'];
  if T['ClassID'] <> null then
    ClId := T['ClassId'];
end;

procedure TInterval.SaveToTable(T: tCustomADODataSet);
begin
  T['Name'] := Name;
  T['ClassId'] := ClId;
  inherited SaveToTable(T);
end;

procedure TInterval.Save(var F: file);
begin
  inherited Save(F);
  BlockWrite(F, Name, SizeOf(Name));
  BlockWrite(F, ClId, SizeOf(ClId));
end;


procedure TInterval.Draw(Chart: TGeochart);
var
  fnt: TLogFont;
  MFont, OldFont: HFont;
  OldMode, i: integer;
  rr: PCHAR;
  P1, P2, P3: TPoint;
  RP1, RP2: TRPoint;
  H: HWND;
  OldStyle: TBrushStyle;
begin
  if TypCod = 0 then begin
    with Chart do begin
      Rp1.X := X;
      RP1.Y := Axises[1].Minimum;
      RP1.Z := Norma - Rp1.X - RP1.Y;
      P1 := ChartToScreen(RP1);
      Rp2.X := X;
      RP2.Y := Axises[1].Maximum;
      RP2.Z := Norma - Rp2.X - RP2.Y;
      P2 := ChartToScreen(RP2);
      Canvas.MoveTo(P1.x, P1.y);
      Canvas.LineTo(P2.X, P2.Y);
      P3.X := P1.X;
      Rp1.X := Y;
      RP1.Y := Axises[1].Minimum;
      RP1.Z := Norma - Rp1.X - RP1.Y;
      P1 := ChartToScreen(RP1);
      Rp2.X := Y;
      RP2.Y := Axises[1].Maximum;
      RP2.Z := Norma - Rp2.X - RP2.Y;
      P2 := ChartToScreen(RP2);
      Canvas.MoveTo(P1.x, P1.y);
      Canvas.LineTo(P2.X, P2.Y);
      P3.Y := P1.X;
    end;
    if Name[1] <> '$' then begin
      Chart.Canvas.Font := Chart.Font;
      fnt.lfHeight := Chart.Canvas.Font.Height;
      fnt.lfEscapement := 900;
      fnt.lfOrientation := 900;
      for i := 0 to length(Chart.Canvas.Font.Name) - 1 do
        fnt.lfFaceName[i] := Chart.Canvas.Font.Name[i + 1];
     {PaintBox1.Canvas.Font.Name;}
      fnt.lfCharSet := Chart.Canvas.Font.Charset;
      if fsItalic in Chart.Canvas.Font.Style then
        fnt.lfItalic := 1
      else
        fnt.lfItalic := 0;
      if fsBold in Chart.Canvas.Font.Style then
        fnt.lfWeight := 700
      else
        fnt.lfWeight := 400;
      fnt.lfUnderline := 0;
      fnt.lfStrikeOut := 0;
      MFont := CreateFontIndirect(Fnt);
      OldFont := SelectObject(Chart.Canvas.Handle, MFont);
      OldMode := SetBkMode(Chart.Canvas.Handle, TRANSPARENT);
      rr := StrAlloc(Length(Name));
      StrPCopy(RR, Name);
      TextOut(Chart.Canvas.Handle, P3.X + (P3.Y - P3.X) div 2 - 7,
        P1.Y - 5, rr, Length(rr));

      SetBkMode(Chart.Canvas.Handle, OldMode);
      SelectObject(Chart.Canvas.Handle, OldFont);
      DeleteObject(MFont);
      StrDispose(rr);

    end;
  end else begin
    with Chart do begin
      Rp1.Y := X;
      RP1.X := Axises[0].Minimum;
      RP1.Z := Norma - Rp1.X - RP1.Y;
      P1 := ChartToScreen(RP1);
      Rp2.Y := X;
      RP2.X := Axises[0].Maximum;
      RP2.Z := Norma - Rp2.X - RP2.Y;
      P2 := ChartToScreen(RP2);
      Canvas.MoveTo(P1.x, P1.y);
      Canvas.LineTo(P2.X, P2.Y);
      P3.X := P1.Y;
      Rp1.Y := Y;
      RP1.X := Axises[0].Minimum;
      RP1.Z := Norma - Rp1.X - RP1.Y;
      P1 := ChartToScreen(RP1);
      Rp2.Y := Y;
      RP2.X := Axises[0].Maximum;
      RP2.Z := Norma - Rp2.X - RP2.Y;
      P2 := ChartToScreen(RP2);
      Canvas.MoveTo(P1.x, P1.y);
      Canvas.LineTo(P2.X, P2.Y);
      P3.Y := P1.Y;
    end;
    if Name[1] <> '$' then begin
      Chart.Canvas.Font := Chart.Font;
      OldStyle := Chart.Canvas.Brush.Style;
      Chart.Canvas.Brush.Style := bsClear;
      Chart.Canvas.TextOut(P1.X + 2, P3.X + (P3.Y - P3.X) div 2 - 7, Name);
      Chart.Canvas.Brush.Style := OldStyle;
    end;
  end;
end;

procedure TInterval.Cop(Source: TOPoint);
begin
  inherited Cop(Source);
  Name := TInterval(Source).Name;
end;


{################## TLine ####################}

constructor TLine.Create(A1, A2: TOPoint);
begin
  inherited Create;
  P1 := A1;
  P2 := A2;
  A := P2.Y - P1.y;
  B := P1.X - P2.X;
  C := P1.y * (P2.X - P1.X) - P1.X * (P2.Y - P1.Y);
end;

function TLine.CrosInOTRs(L: TLine): boolean;
var
  P: TOPoint;
begin
  result := false;
  P := CrosPoint(L);
  if P <> nil then begin
    Result := PointInOtr(P) and L.PointInOtr(P);
    P.Free;
  end;
end;

function TLine.CrosPoint(L: TLine): TOPoint;
begin
  Result := nil;
  if abs(A * L.b - B * L.a) > 1E-20 then
    Result := TOPoint.Create((B * L.C - L.B * C) / (A * L.B - L.A * B),
      (C * L.A - L.C * A) / (A * L.B - L.A * B));
end;

function TLine.CrosPointIn(L: TLine; var CrP: TOPOint): boolean;
{Не включая граничные точки}
var
  P: TOPoint;
begin
  result := false;
  P := CrosPoint(L);
  if P <> nil then begin
    Result := PointInOtr(P);
    if CrP = nil then P.Free
    else CRP := P;
  end;
end;

procedure TLine.Draw(Chart: TGeochart);
begin
 { kx := kzx;
  P1.Draw(Can);
  Can.MoveTo(Round((P1.X - DX) * KX) + 4,
    Heig - 4 - Round((P1.Y - DY) * Kx));
  Can.Pen.Width := 2;
  Can.Pen.Color := clRed;
  Can.LineTo(Round(4 + (P2.X - DX) * kx),
    Round(Heig - 4 - (P2.Y - DY) * KX));
  P2.Draw(Can); }
end;


procedure TLine.FreeWithPoints;
begin
  if Self <> nil then begin
    P1.Free;
    P2.Free;
    inherited Free;
  end;
end;

function TLine.Len: real;
begin
  Result := P1.GetR(P2);
end;

constructor TLine.Ort(L: TLine; P: TOPoint);
begin
  inherited Create;
  a := L.B;
  b := -L.A;
  C := (L.a * P.Y - L.B * P.X);
  P1 := TOPoint.Create(P.X, P.Y);
  P2 := CrosPoint(L);
end;

function TLine.PointInOtr(P: TOPoint): boolean;
begin
  Result := ((P.y - P1.y) * (P.y - P2.y) <= 1E-8) and ((P.x - P1.x) * (P.x - P2.x) <= 1E-8);
end;

function TLine.ROtrToPoint(P: TOPoint): real;
var
  L: TLine;
begin
  L := TLine.Ort(Self, P);
  if PointInOtr(L.P2) then
    Result := L.Len
  else Result := MinExt(P.GetR(P1), P.GetR(P2));
  L.FreeWithPoints;
end;

function TLine.RToPoint(P: TOPoint): real;
begin
  Result := Abs((A * P.X + B * P.Y + C) / Sqrt(A * A + B * B));
end;
{######################### TPointCollection ###################}

constructor TPointCollection.Create(AName1: string; ACod: integer);
begin
  inherited Create;
  Name1 := AName1;
  Cod := ACod;
end;

constructor TPointCollection.Copy(Source: TPointCollection);
var
  i: integer;
begin
  inherited Create;
  Name1 := Source.Name1;
  Cod := Source.Cod;
  TypCod := Source.TypCod;
  for i := 0 to Source.Count - 1 do
    Add(TOPoint.Copy(Source.Items[i]));
end;

procedure TPointCollection.Size(var MaxX, MaxY, MinX, MinY: real);
var
  i: integer;
  P: TOPoint;
begin
  if Count = 0 then begin
    MaxX := 0;
    MaxY := 0;
    MinX := 0;
    MinY := 0;
  end else begin
    P := Items[0];
    MaxX := P.X;
    MaxY := P.Y;
    MinX := P.X;
    MinY := P.Y;
    for i := 1 to Count - 1 do begin
      P := Items[i];
      if P.X > MaxX then MaxX := P.X;
      if P.Y > MaxY then MaxY := P.Y;
      if P.X < MinX then MinX := P.X;
      if P.Y < MinY then MinY := P.Y;
    end
  end
end;

function TPointCollection.Nearest(X, Y: real;
  var Point: TOPoint): real;
var
  R, R1: Real;
  P: TOPoint;
  i: Integer;
begin
  R := 1.0E20;
  if Count = 0 then Point := nil
  else begin
    for i := 0 to Count - 1 do begin
      P := Items[I];
      R1 := Sqrt(sqr(X - P.X) + Sqr(Y - P.Y));
      if R1 < R then begin
        Point := P;
        R := R1;
      end
    end;
  end;
  Result := R;
end;

function TPointCollection.Add(Item: TOPoint): Integer;
begin
  Result := inherited Add(Item);
  Item.Cod := Cod;
  {Item.TypCod := TypCod;}
end;



procedure TPointCollection.UnMark;
var
  i: integer;
begin
  Marked := False;
  for i := 0 to Count - 1 do
    TOPoint(Items[i]).Mark := false;
end;


constructor TPointCollection.Load(var F: file);
var
  i, n: integer;
begin
  inherited Create;
  BlockRead(F, n, SizeOf(Integer));
  BlockRead(F, Name1, SizeOf(Name1));
  BlockRead(F, Cod, SizeOf(Integer));
  BlockRead(F, TypCod, SizeOf(integer));
  for i := 1 to n do begin
    Add(TOPoint.Load(F));
    TOPoint(Items[Count - 1]).Cod := Cod;
    TOPoint(Items[Count - 1]).TypCod := Count;
  end;
end;

constructor TPointCollection.LoadFromTable(T, T1: tCustomADODataSet);
begin
  inherited Create;
  if T['Name1'] <> null then
    Name1 := T['Name1'];
  Cod := T['Cod'];
  TypCod := T['TypCod'];
  ID := T['ID'];
  T1.First;
  while not T1.EOF do begin
    Add(TOPoint.LoadFromTable(T1));
    if (TOPoint(Last).TypCod = 0) and (Self is TVerCollection) then
      TOPoint(Last).TypCod := Count;
    T1.Next;
  end;
end;

procedure TPointCollection.SaveToTable(T, T1: tCustomADODataSet);
var
  i: integer;
begin
  T['Name1'] := Name1;
  T['Cod'] := Cod;
  T['TypCod'] := TypCod;
  T.Post;
  ID := T['ID'];
  for i := 0 to Count - 1 do begin
    T1.Insert;
    T1.Fields.Fields[1].AsInteger := T['ID'];
    TOPoint(Items[i]).SaveToTable(T1);
    T1.Post;
    TOPoint(Items[i]).ID := T1['ID'];
  end;
end;

procedure TPointCollection.DeleteFromTable(T1, T: tCustomADODataSet);
begin
  T1.Refresh;
  T.Refresh;
  T.First;
  while not T.Eof do
    T.Delete;
  T1.Delete;
end;

procedure TPointCollection.Save(var F: file);
var
  i: integer;
begin
  BLockWrite(F, Count, SizeOf(Count));
  BlockWrite(F, Name1, SizeOf(Name1));
  BlockWrite(F, Cod, SizeOf(Integer));
  BlockWrite(F, TypCod, SizeOf(Integer));
  for i := 0 to Count - 1 do
    TOPoint(Items[i]).Save(F);
end;

destructor TPointCollection.Destroy;
var
  i: integer;
begin
  for i := Count - 1 downto 0 do
    TOPoint(Items[i]).Free;
  inherited Destroy;
end;

procedure TPointCollection.Draw(Chart: TGeochart);
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    TOPoint(Items[i]).Draw(Chart);
end;

procedure TPointCollection.SetCod(AKod: integer);
var
  i: integer;
begin
  Cod := AKod;
  for i := 0 to Count - 1 do
    TOPoint(Items[i]).Cod := Cod;
end;

procedure TPointCollection.DelPoint(P: TOPoint);
begin
  Remove(P);
   {  if SelectedPoint=P then SelectedPoint:=nil;
     If (SelLine<>nil)and((SelLine.P1=P)or(SelLine.P2=P)) then begin
        SelLine.Free;
        SelLine:=nil;
     end;  }
  P.Free;
end;

procedure TPointCollection.Rev;
begin
  Pack;
end;


{################# TVerCollection #################}


constructor TVerCollection.Create(AName1: string; ACod: integer);
begin
  inherited Create(AName1, ACod);
  NamePos := TOPoint.Create(-100, -1);
  Width := 1;
  Style := psSolid;
  Bez := false;
  ClId := '';
end;

constructor TVerCollection.Load(var F: file);
begin
  inherited Load(F);
  NamePos := TOPoint.Load(F);
  BlockRead(F, Bez, SizeOf(Bez));
  BlockRead(F, Width, SizeOf(Width));
  BlockRead(F, Style, SizeOf(Style));
  {if NewFormat then}
  BlockRead(F, ClId, SizeOf(ClId));
end;


constructor TVerCollection.LoadFromTable(T, T1: tCustomADODataSet);
begin
  inherited LoadFromTable(T, T1);
  NamePos := TOPoint.Create(-100, -1);
  Bez := T['Bez'];
  Width := T['Width'];
  Style := T['PenStyle'];
  if T['ClassID'] <> null then
    ClId := T['Classid'];
  NamePos.X := T['NameposX'];
  NamePos.Y := T['NameposY'];
end;

procedure TVerCollection.SaveToTable(T, T1: tCustomADODataSet);
begin
  T['Bez'] := Bez;
  T['Width'] := Width;
  T['PenStyle'] := Style;
  T['Classid'] := ClId;
  T['NameposX'] := NamePos.X;
  T['NameposY'] := NamePos.Y;
  inherited SaveToTable(T, T1);
end;

procedure TVerCollection.Save(var F: file);
begin
  inherited Save(F);
  NamePos.Save(F);
  BlockWrite(F, Bez, SizeOf(Bez));
  BlockWrite(F, Width, SizeOf(Width));
  BlockWrite(F, Style, SizeOf(Style));
  BlockWrite(F, ClId, SizeOf(ClId));
end;

function TVerCollection.NearestLine(PP: TOPoint;
  var L: TLine): real;
var
  i: integer;
  r, Min: real;
  P, P1: TOPoint;
  LT: TLine;
begin
  Min := 1E20;
  L := nil;
  if Count >= 2 then begin
    P := Items[0];
    L := nil;
    for i := 1 to Count - 1 do begin
      P1 := Items[i];
      LT := TLine.Create(P, P1);
      r := LT.ROtrToPoint(PP);
      if r < Min then begin
        Min := R;
        L.Free;
        L := LT
      end else LT.Free;
      P := P1;
    end;
  end;
  Result := Min;
end;


procedure TVerCollection.Draw(Chart: TGeochart);
var
  PBeg, PEnd: TOPoint;
  R: real;
  b: boolean;
  Arr: array[0..500] of TPoint;
  i, k, j, n, x, y: integer;
  s: string;
  P1: TPoint;
  PR1: TRPoint;
begin
  B := Bez and (Count > 2);
  if Count >= 1 then begin
    Chart.Canvas.Pen.Color := clBlack;
    if b then begin
      k := 0;
      for i := 0 to Count - 1 do begin
        PR1.X := TOPoint(Items[i]).X;
        PR1.Y := TOPoint(Items[i]).Y;
        PR1.Z := Chart.Norma - Pr1.X - PR1.Y;
        Arr[k] := Chart.ChartToScreen(PR1);
        X := Arr[k].X;
        Y := Arr[k].Y;
        if TOPoint(Items[i]).Mark then begin
          Chart.Canvas.Pen.Width := 4;
          Chart.Canvas.Pen.Color := clRed;
          Chart.Canvas.Rectangle(X + 3, Y + 3, X - 3, Y - 3);
          Chart.Canvas.Pen.Color := clBlack;
        end;
        inc(k);
        if i = 0 then n := 4
        else if i = Count - 2 then n := 2
        else if i = Count - 1 then break
        else n := 3;
        for j := 1 to n - 1 do begin
          PR1.X := TOPoint(Items[i + 1]).X;
          PR1.Y := TOPoint(Items[i + 1]).Y;
          PR1.Z := Chart.Norma - Pr1.X - PR1.Y;
          P1 := Chart.ChartToScreen(PR1);
          Arr[k].X := X + j * (P1.X - X) div N;
          Arr[k].Y := Y + j * (P1.Y - Y) div n;
          inc(k);
        end;
      end;
    end else
      for i := 0 to Count - 1 do begin
        PR1.X := TOPoint(Items[i]).X;
        PR1.Y := TOPoint(Items[i]).Y;
        PR1.Z := Chart.Norma - Pr1.X - PR1.Y;
        Arr[i] := Chart.ChartToScreen(PR1);
        if TOPoint(Items[i]).Mark then begin
          Chart.Canvas.Pen.Width := 4;
          Chart.Canvas.Pen.Color := clRed;
          Chart.Canvas.Rectangle(Arr[i].X + 3, Arr[i].Y + 3, Arr[i].X - 3,
            Arr[i].Y - 3);
          Chart.Canvas.Pen.Color := clBlack;
        end;
      end;
    Chart.Canvas.Pen.Width := Width;
    Chart.Canvas.Pen.Style := Style;
    if Marked then
      Chart.Canvas.Pen.Color := clRed
    else
      Chart.Canvas.Pen.Color := clBlack;
    if Count > 1 then begin
      if b then
        Chart.Canvas.PolyBezier(Slice(Arr, k))
      else
        Chart.Canvas.PolyLine(Slice(Arr, Count));
    end;
    Chart.Canvas.Pen.Style := psSolid;

    if (NamePos.X <> -100) and (Name1[1] <> '$') then begin
      S := name1;
      k := 0;
      Chart.Canvas.Brush.Style := bsClear;
      Chart.Canvas.Font := Chart.Font;
      repeat
        i := Pos('@', S);
        if i = 0 then i := Length(S) + 1;
        PR1.X := NamePos.X;
        PR1.Y := NamePos.Y;
        PR1.Z := Chart.Norma - Pr1.X - PR1.Y;
        P1 := Chart.ChartToScreen(PR1);
        Chart.Canvas.TextOut(P1.X, P1.Y + 16 * k, System.Copy(S, 1, i - 1));
        if i = Length(S) + 1 then break;
        Inc(K);
        System.Delete(S, 1, i);
      until false;
    end
  end;
  Chart.Canvas.Pen.Color := clBlack;
end;

function TVerCollection.Perimetr: real;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Count - 2 do
    Result := Result + TOPoint(Items[i]).GetR(Items[i + 1]);
end;

function TVerCollection.PointIn(P: TOPoint): boolean;
var
  j, k: integer;
  L, F: TLine;
  MidP: TOPOint;
begin
  Result := true;
  MidP := TOPoint.Create((TOPOint(Items[0]).x + TOPOint(Items[1]).X) / 2,
    (TOPOint(Items[0]).Y + TOPOint(Items[1]).Y) / 2);
  MidP.X := MidP.X + (MidP.X - P.X) * 1000;
  MidP.Y := MidP.Y + (MidP.Y - P.Y) * 1000;
  L := TLine.Create(P, MidP);
  k := 0;
  for j := 0 to Count - 2 do begin
    F := TLine.Create(TOPOint(Items[j]), TOPOint(Items[j + 1]));
    if l.CrosInOTRs(F) then inc(k);
  end;
  if k mod 2 = 0 then begin
    Result := false;
    exit;
  end;
  MidP.Free;
end;


{######################## TAX  ############################}

constructor TAX.Create;
begin
  inherited Create;
  Max := 100;
end;

constructor TAX.Load(var F: file);
var
  s1, S2: string[255];
begin
  inherited Create;
  BlockRead(F, Caption, SizeOf(Caption));
  {BlockRead(F, S1,SizeOf(Caption));
  Formula:=S1; }
  BlockRead(F, S1, 256);
  BlockRead(F, S2, 256);
  Formula := S1;
  Formula := Formula + S2;
  BlockRead(F, Max, SizeOf(Real));
  BlockRead(F, Min, SizeOf(Real));
  BlockRead(F, Logor, SizeOf(Boolean));
  BlockRead(F, AW, SizeOf(Boolean));
  BlockRead(F, Log, SizeOf(Boolean));
  BlockRead(F, Proc100, SizeOf(Boolean));
  BlockRead(F, Mols, SizeOf(Boolean));
end;


procedure TAX.Save(var F: file);
var
  S1, S2: string[255];
begin
  S1 := System.Copy(Formula, 1, 255);
  S2 := System.Copy(Formula, 256, Length(Formula) - 255);
  BlockWrite(F, Caption, SizeOf(Caption));
  BlockWrite(F, S1, 256);
  BlockWrite(F, S2, 256);
  BlockWrite(F, Max, SizeOf(Real));
  BlockWrite(F, Min, SizeOf(Real));
  BlockWrite(F, Logor, SizeOf(Boolean));
  BlockWrite(F, AW, SizeOf(Boolean));
  BlockWrite(F, Log, SizeOf(Boolean));
  BlockWrite(F, Proc100, SizeOf(Boolean));
  BlockWrite(F, Mols, SizeOf(Boolean));
end;

 {################# TDiagram ##########################}

constructor TDiagram.Create;
begin
  inherited Create;
  XAx := TAx.Create;
  YAx := TAx.Create;
  ZAx := TAx.Create;
  ShowGrid := true;
  ShowNames := true;
  Classification := False;
  Interv := TIntervals.Create('', 0);
  Lines := TList.Create;
  Norma := 100;
  aLPHAn := 0;
  Medians[0]:=TCurve.CreateM(0,50,100,0);
  Medians[1]:=TCurve.CreateM(50,50,0,0);
  Medians[2]:=TCurve.CreateM(0,100,50,0);
end;

constructor TDiagram.Load(var F: file);
var
  i, n: integer;
begin
  inherited Create;
  Medians[0]:=TCurve.CreateM(0,50,100,0);
  Medians[1]:=TCurve.CreateM(50,50,0,0);
  Medians[2]:=TCurve.CreateM(0,100,50,0);
  BlockRead(F, n, SizeOf(Count));
  BlockRead(F, Name, SizeOf(Name));
  BlockRead(F, Cod, SizeOf(Integer));
  if Cod >= 100 then Trio := true
  else Trio := false;
  BlockRead(F, ShowTitle, SizeOf(Boolean));
  BlockRead(F, ShowGrid, SizeOf(Boolean));
  BlockRead(F, ShowNames, SizeOf(Boolean));
 { if NewFormat and not Bug then}
  BlockRead(F, Classification, SizeOf(Boolean));
  Xax := TAx.Load(f);
  YAx := TAx.Load(F);
  if Trio then
    ZAx := TAx.Load(F)
  else ZAx := TAx.Create; ;
  for i := 1 to n do
    Add(TVerCollection.Load(F));
  Interv := TIntervals.Load(F);
  Lines := TList.Create;
  BlockRead(F, n, SizeOf(Integer));
  for i := 1 to n do
    Lines.Add(TCurve.Load(F));
  if Trio then
    BlockRead(F, Norma, SizeOf(Norma))
  else Norma := 100;
  try
    BlockRead(F, AlphaN, SizeOf(AlphaN))
  except
    AlphaN := 0;
  end;
end;

constructor TDiagram.LoadFromTable;
begin
  inherited Create;
  Medians[0]:=TCurve.CreateM(0,50,100,0);
  Medians[1]:=TCurve.CreateM(50,50,0,0);
  Medians[2]:=TCurve.CreateM(0,100,50,0);
  if DM1.TbDiagr['Name'] <> null then
    Name := DM1.TbDiagr['Name']
  else Name := '?';
  ID := DM1.TbDiagr['ID'];
  Cod := DM1.TbDiagr.FieldByName('Cod').AsInteger;
  Trio := DM1.TbDiagr['Trio'];
  ShowTitle := DM1.TbDiagr['ShowTitle'];
  ShowGrid := DM1.TbDiagr['ShowGrid'];
  ShowNames := DM1.TbDiagr['ShowNames'];
  AlphaN := DM1.TbDiagr['AlphaN'];
  Classification := DM1.TbDiagr['Classification'];
  Xax := TAx.Create;
  if DM1.TbDiagr['XCaption'] <> null then
    Xax.Caption := DM1.TbDiagr['XCaption'];
  if DM1.TbDiagr['XFormula'] <> null then
    Xax.Formula := DM1.TbDiagr['XFormula'];
  Xax.min := DM1.TbDiagr.FieldByName('XMin').AsFloat;
  XAx.max := DM1.TbDiagr.FieldByName('XMax').AsFloat;
  Xax.logor := DM1.TbDiagr['XLogor'];
  if DM1.TbDiagr['LogX'] <> Null then
    Xax.log := DM1.TbDiagr['LogX'];
  Xax.AW := DM1.TbDiagr['XAW'];
  XAx.proc100 := DM1.TbDiagr['Proc100X'];
  if DM1.TbDiagr['XMols'] <> Null then
    Xax.Mols := DM1.TbDiagr['XMols'];
  YAx := TAx.Create;
  if DM1.TbDiagr['YCaption'] <> null then
    Yax.Caption := DM1.TbDiagr['YCaption'];
  if DM1.TbDiagr['YFormula'] <> null then
    Yax.Formula := DM1.TbDiagr['YFormula'];
  Yax.min := DM1.TbDiagr.FieldByName('YMin').AsFloat;
  YAx.max := DM1.TbDiagr.FieldByName('YMax').AsFloat;
  Yax.logor := DM1.TbDiagr['YLogor'];
  if DM1.TbDiagr['LogY'] <> Null then
    Yax.log := DM1.TbDiagr['LogY'];
  Yax.AW := DM1.TbDiagr['YAW'];
  YAx.proc100 := DM1.TbDiagr['Proc100Y'];
  if DM1.TbDiagr['YMols'] <> Null then
    Yax.Mols := DM1.TbDiagr['YMols'];
  ZAx := TAx.Create;
  if DM1.TbDiagr['ZCaption'] <> null then
    Zax.Caption := DM1.TbDiagr['ZCaption'];
  if DM1.TbDiagr['ZFormula'] <> null then
    Zax.Formula := DM1.TbDiagr['ZFormula'];
  Zax.min := DM1.TbDiagr.FieldByName('ZMin').AsFloat;
  ZAx.max := DM1.TbDiagr.FieldByName('ZMax').AsFloat;
  Zax.logor := DM1.TbDiagr['ZLogor'];
  Zax.AW := DM1.TbDiagr['ZAW'];
  ZAx.proc100 := DM1.TbDiagr['Proc100Z'];
  if DM1.TbDiagr['ZMols'] <> Null then
    Zax.Mols := DM1.TbDiagr['ZMols'];

  with DM1.TbFields do begin
    First;
    while not Eof do begin
      try
        Add(TVerCollection.LoadFromTable(DM1.TbFields, DM1.TbFPoint));
      except
        ShowMessage('Error loading field for diagram ' + DM1.TbDiagr['Name'] + '. Recreate it, please');
      end;
      Next;
    end;
  end;
  try
    Interv := TIntervals.LoadFromTable(nil, DM1.TbInterv);
  except
    ShowMessage('Error loading intervals for diagram ' + DM1.TbDiagr['Name'] + '. Recreate them, please');
  end;
  Lines := TList.Create;
  with DM1.TbLines do begin
    First;
    while not Eof do begin
      try
        Lines.Add(TCurve.LoadFromTable(DM1.TbLines, DM1.TbLPoint));
      except
        ShowMessage('Error loading line for diagram ' + DM1.TbDiagr['Name'] + '. Recreate it, please');
      end;
      Next;
    end;
  end;
  Norma := DM1.TbDiagr.FieldByName('Norma').AsFloat;
end;

procedure TDiagram.SaveToTable(New: Boolean);
var i: integer;
begin
  if New then
    DM1.TbDiagr.Insert
  else if DM1.TbDiagr.State = dsBrowse then
    DM1.TbDiagr.Edit;
  DM1.TbDiagr['Name'] := Name;
  DM1.TbDiagr['Cod'] := Cod;
  DM1.TbDiagr['Trio'] := Trio;
  DM1.TbDiagr['ShowTitle'] := ShowTitle;
  DM1.TbDiagr['ShowGrid'] := ShowGrid;
  DM1.TbDiagr['ShowNames'] := ShowNames;
  DM1.TbDiagr['Classification'] := Classification;
  DM1.TbDiagr['XCaption'] := Xax.Caption;
  DM1.TbDiagr['XFormula'] := Xax.Formula;
  DM1.TbDiagr['XMin'] := Xax.min;
  DM1.TbDiagr['XMax'] := XAx.max;
  DM1.TbDiagr['XLogor'] := Xax.logor;
  DM1.TbDiagr['LogX'] := Xax.log;
  DM1.TbDiagr['XAW'] := Xax.AW;
  DM1.TbDiagr['Proc100X'] := Xax.proc100;
  DM1.TbDiagr['XMols'] := Xax.Mols;
  DM1.TbDiagr['YCaption'] := Yax.Caption;
  DM1.TbDiagr['YFormula'] := Yax.Formula;
  DM1.TbDiagr['YMin'] := Yax.min;
  DM1.TbDiagr['YMax'] := YAx.max;
  DM1.TbDiagr['YLogor'] := Yax.logor;
  DM1.TbDiagr['LogY'] := Yax.log;
  DM1.TbDiagr['YAW'] := Yax.AW;
  DM1.TbDiagr['Proc100Y'] := Yax.proc100;
  DM1.TbDiagr['YMols'] := Yax.Mols;
  DM1.TbDiagr['ZCaption'] := Zax.Caption;
  DM1.TbDiagr['ZFormula'] := Zax.Formula;
  DM1.TbDiagr['ZMin'] := Zax.min;
  DM1.TbDiagr['ZMax'] := ZAx.max;
  DM1.TbDiagr['ZLogor'] := Zax.logor;
  DM1.TbDiagr['ZAW'] := Zax.AW;
  DM1.TbDiagr['Proc100Z'] := Zax.proc100;
  DM1.TbDiagr['ZMols'] := Zax.Mols;
  DM1.TbDiagr['Norma'] := Norma;
  DM1.TbDiagr['AlphaN'] := AlphaN;
  DM1.TbDiagr.Post;
  Id := DM1.TbDiagr['ID'];
  with Dm1.TbFields do begin
    First;
    while not eof do
      Delete;
  end;
  for i := 0 to Count - 1 do begin
    try
      DM1.TbFields.Insert;
      TVerCollection(Items[i]).SaveToTable(DM1.TbFields, DM1.TbFPoint);
        {DM1.TbFields.Post;}
    except
      on Exception do
        DM1.TbFields.Cancel;
    end;
  end;
  with Dm1.TbInterv do begin
    First;
    while not eof do
      Delete;
  end;
  for i := 0 to Interv.Count - 1 do begin
    try
      DM1.TbInterv.Insert;
      TInterval(Interv.Items[i]).SaveToTable(DM1.TbInterv);
      DM1.TbInterv.Post;
    except
      on Exception do
        DM1.TbInterv.Cancel;
    end;
  end;
  with Dm1.TbLines do begin
    First;
    while not eof do
      Delete;
  end;
  for i := 0 to Lines.Count - 1 do begin
    try
      DM1.TbLines.Insert;
      TCurve(Lines.Items[i]).SaveToTable(DM1.TbLines, DM1.TbLPoint);
        {DM1.TbLines.Post;}
    except
      on Exception do
        DM1.TbLines.Cancel;
    end;
  end;
end;

procedure TDiagram.DeleteFromTable;
var i: integer;
begin
  if DM1.TbDiagr.Locate('ID', id, []) then begin
    DM1.TbInterv.Refresh;
    DM1.TbInterv.First;
    while not DM1.TbInterv.EOF do
      DM1.TbInterv.Delete;
    for i := 0 to Lines.Count - 1 do
      TCurve(Lines.Items[i]).DeleteFromTable(DM1.TbLines, DM1.TbLPoint);
    for i := 0 to Count - 1 do
      TVerCollection(Items[i]).DeleteFromTable(DM1.TbFields, DM1.TbFPoint);
    DM1.TbDiagr.Delete;
  end;
end;

procedure TDiagram.Save(var F: file);
var
  i: integer;
begin
  BLockWrite(F, Count, SizeOf(Count));
  BlockWrite(F, Name, SizeOf(Name));
  BlockWrite(F, Cod, SizeOf(Integer));
  BlockWrite(F, ShowTitle, SizeOf(Boolean));
  BlockWrite(F, ShowGrid, SizeOf(Boolean));
  BlockWrite(F, ShowNames, SizeOf(Boolean));
  BlockWrite(F, Classification, SizeOf(Boolean));
  XAx.Save(F);
  YAx.Save(F);
  if Trio then
    ZAx.Save(F);
  for i := 0 to Count - 1 do
    TVerCollection(Items[i]).Save(F);
  Interv.Save(F);
  BlockWrite(F, Lines.Count, SizeOf(Integer));
  for i := 0 to Lines.Count - 1 do
    TCurve(Lines[i]).Save(F);
  if Trio then
    BlockWrite(F, Norma, SizeOf(Norma));
  BlockWrite(F, AlphaN, SizeOf(AlphaN));
end;


procedure TDiagram.Draw(Chart: TGeochart);
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    TVerCollection(Items[i]).Draw(Chart);
  Interv.Draw(Chart);
  for i := 0 to Lines.Count - 1 do
    TCurve(Lines.Items[i]).Draw(Chart);
  if Trio and (Cod=100) then
    for i:=0 to 2 do
      Medians[i].Draw(Chart);
end;

{###########################################################}

procedure TStDiaForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TStDiaForm.FormCreate(Sender: TObject);
begin
  inherited;
  DM1.TbDiagr.Open;
  DM1.TbDiagrID.Open;
  DM1.TbFields.Open;
  DM1.TbLines.Open;
  DM1.TbInterv.Open;
  DM1.TbFPoint.Open;
  DM1.TbLPoint.Open;
  Diagrams := TStringList.Create;
  DM1.TbDiagr.First;
  while not DM1.TbDiagr.Eof do begin
    Diagrams.Add('?');
    try
      Diagrams.Objects[Diagrams.Count - 1] := TDiagram.LoadFromTable;
      Diagrams[Diagrams.Count - 1] := TDiagram(Diagrams.Objects[Diagrams.Count - 1]).Name;
    except
      Diagrams[Diagrams.Count - 1] := 'ERROR! Delete this row!'
    end;
    DM1.TbDiagr.Next;
  end;
  Diagrams.Sort;
  HListBox2.Items.Assign(Diagrams);
  if Diagrams.Count > 0 then HListBox2.ItemIndex := 0
  else begin
    BitBtn1.Enabled := false;
    BitBtn4.Enabled := false;
  end;
end;

procedure TStDiaForm.HListBox1Click(Sender: TObject);
begin
  inherited;
  BitBtn1.Enabled := true;
  BitBtn4.Enabled := true;
end;

procedure TStDiaForm.BitBtn4Click(Sender: TObject);
var
  i, j: integer;
begin
  inherited;
  if (HListbox2.ItemIndex >= 0) and (
    (not TDiagram(Diagrams.Objects[Diagrams.IndexOf
    (HListBox2.Items[HListbox2.ItemIndex])]).Classification) or
      (MessageDlg(TDiagram(Diagrams.Objects[Diagrams.IndexOf
    (HListBox2.Items[HListbox2.ItemIndex])]).Name + stWillDel, mtWarning, [
      mbYES, mbNO], 0) = ID_YES)) then begin
    i := Diagrams.IndexOf(HListBox2.Items[HListbox2.ItemIndex]);
    HlistBox2.Items.Delete(HListbox2.ItemIndex);
    TDiagram(Diagrams.Objects[i]).DeleteFromTable;
    if TDiagram(Diagrams.Objects[i]).Classification then begin
      ExecQr('Delete from Classif where Diagr=' + IntToStr(TDiagram(Diagrams.Objects[i]).ID),
        DM1.q1Time);
      MessageDlg(TDiagram(Diagrams.Objects[i]).Name + stBeenDel, mtInformation, [
        mbOK], 0);
    end;
    for j := 0 to MainForm.MDIChildCount - 1 do
      if (MainForm.MDIChildren[j] is TTrioForm) and
        (TTrioForm(MainForm.MDIChildren[j]).Diagr =
        Diagrams.Objects[i]) then
        TTrioForm(MainForm.MDIChildren[j]).Standart := false;
    TDiagram(Diagrams.Objects[i]).DeleteFromTable;
    Diagrams.Objects[i].Free;
    Diagrams.Delete(i);
    if Diagrams.Count > 0 then HListBox2.ItemIndex := 0
    else begin
      BitBtn1.Enabled := false;
      BitBtn4.Enabled := false;
    end;
  end;
  {SaveDiagr;}
end;

procedure TStDiaForm.BitBtn3Click(Sender: TObject);
begin
  inherited;
  NewDiagr.Diag := TDiagram.Create;
  DM1.TbDiagr.Insert;
  NewDiagr.Diag.Name := 'Diagram ' + IntToStr(Diagrams.Count + 1);
  DM1.TbDiagr['Name'] := NewDiagr.Diag.Name;
  NewDiagr.Diag.ShowGrid := True;
  DM1.TbDiagr['XCaption'] := 'X';
  DM1.TbDiagr['YCaption'] := 'Y';
  DM1.TbDiagr['ZCaption'] := 'Z';
  DM1.TBDiagr.Post;
  NewDiagr.Diag.ID := DM1.TbDiagr['ID'];
  DM1.TBDiagr.Edit;
  if NewDiagr.ShowModal = mrOK then begin
    if DM1.TBDiagr.State <> dsEdit then
      DM1.TbDiagr.Edit;
    DM1.TbDiagr['AlphaN'] := NewDiagr.Diag.AlphaN;
    DM1.TBDiagr.Post;
    Diagrams.Add(NewDiagr.Diag.Name);
    Diagrams.Objects[Diagrams.IndexOf(NewDiagr.Diag.Name)] := NewDiagr.Diag;
    NewDiagr.Diag.SaveToTable(False);
    Diagrams.Sort;
    HListBox2.Items.Clear;
    HListBox2.Items.Assign(Diagrams);
    NewDiagr.Diag := nil;
   { SaveDiagr;}
  end else begin
    DM1.TBDiagr.Cancel;
    NewDiagr.Diag.DeleteFromTable;
    FreeAndNil(NewDiagr.Diag);
  end;
  if Diagrams.Count > 0 then begin
    BitBtn1.Enabled := true;
    BitBtn4.Enabled := true;
  end;
  NewDiagr.Lin := nil;
  NewDiagr.F := nil;
end;

procedure TStDiaForm.BitBtn1Click(Sender: TObject);
var i: integer;
  OldDiagram: TDiagram;
begin
  inherited;
  if (HListbox2.ItemIndex >= 0) and (
    (not TDiagram(Diagrams.Objects[Diagrams.IndexOf
    (HListBox2.Items[HListbox2.ItemIndex])]).Classification) or
      (MessageDlg(TDiagram(Diagrams.Objects[Diagrams.IndexOf
    (HListBox2.Items[HListbox2.ItemIndex])]).Name + stWillDel, mtWarning, [
      mbYES, mbNO], 0) = ID_YES)) then begin
    NewDiagr.Diag := TDiagram(Diagrams.Objects[Diagrams.IndexOf
      (HListBox2.Items[HListbox2.ItemIndex])]);
    Dm1.TbDiagr.Locate('ID', NewDiagr.Diag.ID, []);

    OldDiagram := TDiagram.LoadFromTable;
    if NewDiagr.ShowModal = mrOK then begin
      if DM1.TBDiagr.State <> dsEdit then
        DM1.TbDiagr.Edit;
      DM1.TbDiagr['AlphaN'] := NewDiagr.Diag.AlphaN;
      DM1.TBDiagr.Post;
      NewDiagr.Diag.SaveToTable(False);
      {TDiagram(Diagrams.Objects[Diagrams.IndexOf
        (HListBox2.Items[HListbox2.ItemIndex])]).DeleteFromTable; }
      for i := MainForm.MDIChildCount - 1 downto 0 do
        if (MainForm.MDIChildren[i] is TTrioForm) and
          (TTrioForm(MainForm.MDIChildren[i]).Diagr =
          NewDiagr.Diag) then
          MainForm.MDIChildren[i].Close;
          {TTrioForm(MainForm.MDIChildren[i]).Diagr := NewDiagr.Diag;}
      if OldDiagram.Classification then begin
       // DM1.TbDiagrId.Locate('ID',NewDiagr.Diag.ID,[]);
        ExecQr('Delete from Classif where Diagr=' + IntToStr(NewDiagr.Diag.ID),
          DM1.q1Time);
        MessageDlg(NewDiagr.Diag.Name + stBeenDel, mtInformation, [mbOK], 0);
      end;
      Diagrams[Diagrams.IndexOf
        (HListBox2.Items[HListbox2.ItemIndex])] := NewDiagr.Diag.Name;
      Diagrams.Sort;
      HListBox2.Items.Clear;
      HListBox2.Items.Assign(Diagrams);
      OldDiagram.Free;
      {SaveDiagr;}
    end else begin
      Dm1.TbDiagr.Cancel;
      Diagrams.Objects[Diagrams.IndexOf
        (HListBox2.Items[HListbox2.ItemIndex])] := OldDiagram;
      OLdDiagram.SaveToTable(False);
      NewDiagr.Diag.Free;
    end;
    NewDiagr.Diag := nil;
    NewDiagr.F := nil;
    NewDiagr.Lin := nil;
    {HListBox2.ItemIndex := 0; }
  end;
end;

procedure SaveDiagr;
var
  i: integer;
  F: file;
begin
  if StDiaForm.SaveDialog1.Execute then begin
    Diagrams.SaveToFile(StDiaForm.SaveDialog1.FileName);
    AssignFile(F, ExtractFilePath(StDiaForm.SaveDialog1.FileName) + 'diagrams.rhd');
    Rewrite(F, 1);
    i := Diagrams.Count;
    BlockWrite(F, i, SizeOf(Integer));
    for i := 0 to Diagrams.Count - 1 do
      TDiagram(Diagrams.Objects[i]).Save(F);
    CloseFile(F);
  end;
end;

procedure LoadDiagr(Diagr: TStringList; Path: string);
var
  n, i: integer;
  f: file;
begin
  AssignFile(F, Path + 'diagrams.rhd');
  Reset(F, 1);
  BlockRead(F, n, SizeOf(Integer));
  for i := 0 to n - 1 do
    Diagr.Objects[i] := TDiagram.Load(F);
  CloseFile(F);
end;

{ TIntervals }

destructor TIntervals.Destroy;
var
  i: integer;
begin
  for i := Count - 1 downto 0 do begin
    TInterval(Items[i]).Free;
    Delete(i);
  end;
  inherited Destroy;
end;

procedure TIntervals.Draw(Chart: TGeochart);
var
  i: integer;
begin
  if Count > 0 then begin
    Chart.Canvas.Brush.Color := clWhite;
    Chart.Canvas.Pen.Width := 1;
    Chart.Canvas.Pen.Color := clBlack;
    Chart.Canvas.Pen.Style := psDash;
    for i := 0 to Count - 1 do
      TInterval(Items[i]).Draw(Chart);
    Chart.Canvas.Pen.Style := psSolid;
  end;
end;

constructor TIntervals.Load(var F: file);
var
  i, n: integer;
begin
  inherited Create('', 0);
  BlockRead(F, n, SizeOf(Integer));
  BlockRead(F, Name1, SizeOf(Name1));
  BlockRead(F, Cod, SizeOf(Integer));
  BlockRead(F, TypCod, SizeOf(integer));
  for i := 1 to n do begin
    Add(TInterval.Load(F));
  end;
end;

constructor TIntervals.LoadFromTable(T, T1: tCustomADODataSet);
begin
  inherited Create('', 0);
  T1.First;
  while not T1.EOF do begin
    Add(TInterval.LoadFromTable(T1));
    T1.Next;
  end;
end;

{ TCurve }

constructor TCurve.Create(AName1: string; ACod: integer);
begin
  inherited Create(AName1, ACod);
  NamePos.X := -100;
end;

constructor TCurve.CreateM(AX1, AY1, AX2, AY2: Integer);
begin
   inherited Create('', 0);
   Width:=2;
   Add(TOPoint.Create(AX1,AY1));
   Add(TOPoint.Create(AX2,AY2));
end;

procedure TCurve.Draw(Chart: TGeochart);
var
  b: boolean;
  Arr: array[0..200] of TPoint;
  i, k, j, n, x, y: integer;
  s: string;
  P1: TPoint;
  PR1: TRPoint;
begin
  B := Bez and (Count > 2);
  if Count > 1 then begin
    Chart.Canvas.Pen.Color := clBlack;
    if b then begin
      k := 0;
      for i := 0 to Count - 1 do begin
        PR1.X := TOPoint(Items[i]).X;
        PR1.Y := TOPoint(Items[i]).Y;
        PR1.Z := Chart.Norma - Pr1.X - PR1.Y;
        Arr[k] := Chart.ChartToScreen(PR1);
        X := Arr[k].X;
        Y := Arr[k].Y;
        if TOPoint(Items[i]).Mark then begin
          Chart.Canvas.Pen.Width := 4;
          Chart.Canvas.Pen.Color := clRed;
          Chart.Canvas.Rectangle(X + 3, Y + 3, X - 3, Y - 3);
          Chart.Canvas.Pen.Color := clBlack;
        end;
        inc(k);
        if i = 0 then n := 4
        else if i = Count - 2 then n := 2
        else if i = Count - 1 then break
        else n := 3;
        for j := 1 to n - 1 do begin
          PR1.X := TOPoint(Items[i + 1]).X;
          PR1.Y := TOPoint(Items[i + 1]).Y;
          PR1.Z := Chart.Norma - Pr1.X - PR1.Y;
          P1 := Chart.ChartToScreen(PR1);
          Arr[k].X := X + j * (P1.X - X) div N;
          Arr[k].Y := Y + j * (P1.Y - Y) div n;
          inc(k);
        end;
      end;
    end else
      for i := 0 to Count - 1 do begin
        PR1.X := TOPoint(Items[i]).X;
        PR1.Y := TOPoint(Items[i]).Y;
        PR1.Z := Chart.Norma - Pr1.X - PR1.Y;
        Arr[i] := Chart.ChartToScreen(PR1);
        if TOPoint(Items[i]).Mark then begin
          Chart.Canvas.Pen.Width := 4;
          Chart.Canvas.Pen.Color := clRed;
          Chart.Canvas.Rectangle(Arr[i].X + 3, Arr[i].Y + 3, Arr[i].X - 3,
            Arr[i].Y - 3);
          Chart.Canvas.Pen.Color := clBlack;
        end;
      end;
    Chart.Canvas.Pen.Width := Width;
    Chart.Canvas.Pen.Style := Style;
    if b then
      Chart.Canvas.PolyBezier(Slice(Arr, k))
    else
      Chart.Canvas.PolyLine(Slice(Arr, Count));
    Chart.Canvas.Pen.Style := psSolid;
  end else if Count = 1 then begin
    PR1.X := TOPoint(Items[0]).X;
    PR1.Y := TOPoint(Items[0]).Y;
    PR1.Z := Chart.Norma - Pr1.X - PR1.Y;
    Arr[0] := Chart.ChartToScreen(PR1);
    if TOPoint(Items[0]).Mark then
      Chart.Canvas.Pen.Color := clRed
    else
      Chart.Canvas.Pen.Color := clBlack;
    Chart.Canvas.Pen.Width := 5;
    Chart.Canvas.Rectangle(Arr[0].X + 3, Arr[0].Y + 3, Arr[0].X - 3,
      Arr[0].Y - 3);
  end;
  Chart.Canvas.Pen.Color := clBlack;
  Chart.Canvas.Pen.Width := 1;
  if ((NamePos.X <> -100) or (Count = 1)) and (Name1[1] <> '$') then begin
    Chart.Canvas.Font := Chart.Font;
    S := name1;
    k := 0;
    Chart.Canvas.Brush.Style := bsClear;
    if NamePos.X = -100 then begin
      X := Arr[0].X;
      Y := Arr[0].Y;
      if X > Chart.Width div 2 then
        X := X - 4 - Chart.Canvas.TextWidth(S)
      else X := X + 4;
      if Y > Chart.Height div 2 then
        Y := Y - 4 - Chart.Canvas.TextHeight(S)
      else Y := Y + 4;
    end else begin
      PR1.X := NamePos.X;
      PR1.Y := NamePos.Y;
      PR1.Z := Chart.Norma - Pr1.X - PR1.Y;
      P1 := Chart.ChartToScreen(PR1);
      X := P1.X;
      Y := P1.Y;
    end;

    repeat
      i := Pos('@', S);
      if i = 0 then i := Length(S) + 1;
      Chart.Canvas.TextOut(X, Y + 16 * k, System.Copy(S, 1, i - 1));
      if i = Length(S) + 1 then break;
      Inc(K);
      System.Delete(S, 1, i);
    until false;
  end;
end;

procedure TStDiaForm.HListBox2DblClick(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrOK;
end;

destructor TVerCollection.Destroy;
begin
  NamePos.Free;
  inherited Destroy;
end;


destructor TDiagram.Destroy;
var i: integer;
begin
  Interv.Free;
  for i := Count - 1 downto 0 do
    TVerCollection(Items[i]).Free;
  for i := Lines.Count - 1 downto 0 do
    TCurve(Lines[i]).Free;
  for i:=0 to 2 do
    Medians[i].Free;
  Lines.Free;
  XAx.Free;
  YAx.Free;
  ZAx.Free;
  inherited;
end;

procedure TStDiaForm.FormDestroy(Sender: TObject);
var i: integer;
begin
  inherited;
  for i := 0 to Diagrams.Count - 1 do
    TDiagram(Diagrams.Objects[i]).Free;
  Diagrams.Free;
  DM1.TbDiagr.Close;
  DM1.TbDiagrID.Close;
  DM1.TbFields.Close;
  DM1.TbLines.Close;
  DM1.TbInterv.Close;
  DM1.TbFPoint.Close;
  DM1.TbLPoint.Close;
end;

procedure TStDiaForm.BitBtn6Click(Sender: TObject);
var TempDiagr: TStringList;
  i, j: integer;
  Ex: Boolean;
begin
  inherited;
  if OpenDialog1.Execute then begin
      {NewFormat := True;
      Bug := MessageDlg('Try to correct new format bug?', mtConfirmation,
        [mbYES, mbNO], 0) = ID_YES; }
    TempDiagr := TStringList.Create;
    TempDiagr.LoadFromFile(OpenDialog1.FileName);
    if TempDiagr.Count - 1 > 0 then
      LoadDiagr(TempDiagr, ExtractFilePath(OpenDialog1.FileName));
    for i := 0 to TempDiagr.Count - 1 do begin
      ex := False;
      for j := 0 to Diagrams.Count - 1 do
        if Diagrams[j] = TempDiagr[i] then
        begin
          Ex := True;
          break;
        end;
      if not Ex then begin
        Diagrams.Add(TempDiagr[i]);
        Diagrams.Objects[Diagrams.Count - 1] := TempDiagr.Objects[i];
        TDiagram(Diagrams.Objects[Diagrams.Count - 1]).SaveToTable(True);
      end else
        TempDiagr.Objects[i].Free;
    end;
    Diagrams.Sort;
    HListBox2.Items.Clear;
    HListBox2.Items.Assign(Diagrams);
    if Diagrams.Count > 0 then begin
      HListBox2.ItemIndex := 0;
      BitBtn1.Enabled := true;
      BitBtn4.Enabled := true;
    end else begin
      BitBtn1.Enabled := false;
      BitBtn4.Enabled := false;
    end;
    TempDiagr.Free;
  end;
end;

procedure TStDiaForm.BitBtn5Click(Sender: TObject);
begin
  inherited;
  SaveDiagr;
end;

procedure TStDiaForm.FormActivate(Sender: TObject);
begin
  inherited;
  CurHelpContext := HelpContext;
end;

procedure TPointCollection.Insert(Index: Integer; Item: Pointer);
begin
  inherited;
  TOPoint(Items[index]).Cod := Cod;
end;

function TVerCollection.Add(Item: TOPoint): Integer;
begin
  inherited Add(Item);
  Item.TypCod := Count;
end;

procedure TVerCollection.Insert(Index: Integer; Item: Pointer);
var i: Integer;
begin
  inherited;
  TOPoint(Items[Index]).TypCod := Index + 1;
  for i := Index + 1 to Count - 1 do
    TOPoint(Items[i]).TypCod := i + 1;
end;

procedure TStDiaForm.BitBtn2Click(Sender: TObject);
begin
  inherited;
  if HListBox2.ItemIndex >= 0 then begin
    FavDiagram := TDiagram(Diagrams.Objects[Diagrams.IndexOf
      (HListBox2.Items[HListbox2.ItemIndex])]).ID;
    Reg.OpenKey('Software', true);
    Reg.OpenKey('PETROS', True);
    Reg.WriteInteger('FavDiagram', FavDiagram);
    Reg.CloseKey;
  end;
end;

procedure TStDiaForm.FormShow(Sender: TObject);
begin
  inherited;
  DM1.TbDiagr.Open;
  DM1.TbDiagrID.Open;
  DM1.TbFields.Open;
  DM1.TbLines.Open;
  DM1.TbInterv.Open;
  DM1.TbFPoint.Open;
  DM1.TbLPoint.Open;
end;

end.

