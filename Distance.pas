unit Distance;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, RHAGlobs, Chemist, Math, Grids, Menus, StdCtrls;

type
  TfDistance = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    FontDialog1: TFontDialog;
    MainMenu1: TMainMenu;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    ExporttoEXCEL1: TMenuItem;
    N1: TMenuItem;
    Preview1: TMenuItem;
    Font1: TMenuItem;
    Print1: TMenuItem;
    Correlations1: TMenuItem;
    Atomic2: TMenuItem;
    Molecular1: TMenuItem;
    Weight2: TMenuItem;
    Weightrecalcto1002: TMenuItem;
    AtomicwithoutH2O2: TMenuItem;
    MolecularAW: TMenuItem;
    WeightwithoutH2O2: TMenuItem;
    SG1: TStringGrid;
    N2: TMenuItem;
    Pifagor1: TMenuItem;
    Kholmogorov1: TMenuItem;
    Petrov1: TMenuItem;
    Minkov1: TMenuItem;
    Label1: TLabel;
    N3: TMenuItem;
    Nearestandfarest1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure SaveFileExecute(Sender: TObject);
    procedure ExcExpExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Pifagor1Click(Sender: TObject);
    procedure Atomic2Click(Sender: TObject);
    procedure SG1DblClick(Sender: TObject);
    procedure Nearestandfarest1Click(Sender: TObject);
  private
    { Private declarations }
    DistType: Integer;
    Cod: TDatType;
    DistTyp: integer;
    Sample: string;
    AnID: integer;
    procedure CalcDist;

  public
    { Public declarations }
    Quer: TAdoQuery;
    procedure ExFormat(Col, Row: integer; Val: Variant; var FontColor: TColor;
    var FontBol: Boolean; var NumFormat: string; var FontName : String; var Sep : Boolean);
  end;

var
  fDistance: TfDistance;

resourcestring
  stDist = 'Distances between analyzes';
  stPifagor = ' (Euclid''s); ';
  stKolmogor = ' (entropy); ';
  stPetrov = ' (anentropy); ';
  stMinkov = ' (according to Minkowski); ';

implementation
uses DMod1, ExcelExp, RollQuery,
  TxtImpExp, AtProc, wait, AnData, Main, ListBrows, Nearest, DistType;

{$R *.DFM}

procedure TfDistance.FormCreate(Sender: TObject);
begin
  Quer := SelQuery;
  Application.ProcessMessages;
  OpenSq(Quer);
end;

procedure TfDistance.SaveFileExecute(Sender: TObject);
begin
  if ExpToTextForm.DefExport(nil, Sg1, False) then
    ExpToTextForm.ExpStringGrid(SG1);
end;

procedure TfDistance.ExcExpExecute(Sender: TObject);
begin
  if (Quer.RecNo > 0) then
    ExcF.ExportSGToExc(SG1, Caption + '. ' + Label1.Caption,ExFormat);
end;

procedure TfDistance.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
end;

procedure TfDistance.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  CloseSq(Quer);
end;

procedure TfDistance.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
  if Quer.RecordCount = 0 then begin
    ShowMessage(stEmptyQuer);
    Close;
    Exit;
  end;
  fDistType := TfDistType.Create(Application);
  fDistType.ShowModal;
  DistTyp := fDistType.RadioGroup1.ItemIndex;
  if DistTyp = 1 then begin
    AnID := Quer['AnID'];
    Sample := Quer['Sample'];
    Width:=400;
  end;
  Caption := SelSQLName;
  if SID in UsedFields then
    SG1.DefaultColWidth := 45
  else
    SG1.DefaultColWidth := 55;
  if Disttyp = 0 then
    SG1.ColCount := Quer.RecordCount + 2
  else begin
    SG1.ColCount := 3;
     SG1.Cells[1, 0] :='Distance'
  end;
  SG1.ColWidths[SG1.ColCount - 1] := 240;
  if SID in UsedFields then 
        SG1.Cells[0, 0] :='Sample';
  SG1.Cells[SG1.ColCount - 1, 0] := 'Description';
  SG1.RowCount := Quer.RecordCount + 4;
  SG1.Cells[0, Quer.RecordCount + 1] := 'Min';
  SG1.Cells[0, Quer.RecordCount + 2] := 'Max';
  SG1.Cells[0, Quer.RecordCount + 3] := 'Average';
  CalcDist;
end;

procedure TfDistance.Pifagor1Click(Sender: TObject);
begin
  if Sender = Pifagor1 then
    DistType := 0
  else if Sender = Kholmogorov1 then
    DistType := 1
  else if Sender = Petrov1 then
    DistType := 2
  else if Sender = Minkov1 then
    DistType := 3;
  CalcDist;
end;

procedure TfDistance.CalcDist;
var j, i, k: integer;
  r, Mn, Mx, Sum: Double;
  C, DS: array[1..100] of Double;
  S: string;
  BMr: TBookMark;
  function CalcNDist: Double;
  var i, k: Integer;
    t: Double;
  begin
    Result := 0;
    for I := 1 to 99 do
      for K := 1 to 100 - I do
        if Ds[K] < Ds[K + 1] then begin
          T := DS[K];
          DS[K] := DS[K + 1];
          DS[K + 1] := T;
        end;
    for i := 1 to NDist do
      Result := Result + DS[i];
  end;
  function Pifagor: Double;
  var i: Integer;
    R: Double;
  begin
    Result := 0;
    if UseNDist then begin
      for i := 1 to 100 do
        if C[i] > 0 then begin
          R := GetConcentration(Quer, i, Cod);
          if R > 0 then
            DS[i] := SQR(C[i] - R)
          else
            DS[i] := 0;
        end else
          DS[i] := 0;
      Result := CalcNDist;
    end else
      for i := 1 to 100 do
        if C[i] > 0 then begin
          R := GetConcentration(Quer, i, Cod);
          if R > 0 then
            Result := Result + SQR(C[i] - R);
        end;
    Result := SQRT(Result);
  end;
  function Kolmog: Double;
  var i: Integer;
    R: Double;
  begin
    Result := 0;
    if UseNDist then begin
      for i := 1 to 100 do
        if C[i] > 0 then begin
          R := GetConcentration(Quer, i, Cod);
          if R > 0 then
            DS[i] := (C[i] - R) * Ln(C[i] / R)
          else
            DS[i] := 0;
        end else
          DS[i] := 0;
      Result := CalcNDist;
    end else
      for i := 1 to 100 do
        if C[i] > 0 then begin
          R := GetConcentration(Quer, i, Cod);
          if R > 0 then
            Result := Result + (C[i] - R) * Ln(C[i] / R);
        end;
  end;
  function Petrov: Double;
  var i: Integer;
    R: Double;
  begin
    Result := 0;
    if UseNDist then begin
      for i := 1 to 100 do
        if C[i] > 0 then begin
          R := GetConcentration(Quer, i, Cod);
          if R > 0 then
            DS[i] := Abs(Ln(C[i] / R))
          else
            DS[i] := 0;
        end else
          DS[i] := 0;
      Result := CalcNDist;
    end else
      for i := 1 to 100 do
        if C[i] > 0 then begin
          R := GetConcentration(Quer, i, Cod);
          if R > 0 then
            Result := Result + Abs(Ln(C[i] / R));
        end;
  end;
  function Minkov: Double;
  var i: Integer;
    R: Double;
  begin
    Result := 0;
    if UseNDist then begin
      for i := 1 to 100 do
        if C[i] > 0 then begin
          R := GetConcentration(Quer, i, Cod);
          if R > 0 then
            DS[i] := Abs(C[i] - R)
          else
            DS[i] := 0;
        end else
          DS[i] := 0;
      Result := CalcNDist;
    end else
      for i := 1 to 100 do
        if C[i] > 0 then begin
          R := GetConcentration(Quer, i, Cod);
          if R > 0 then
            Result := Result + Abs(C[i] - R);
        end;
  end;
begin
  WForm.Show;
  Application.ProcessMessages;
  if DistTyp = 0 then
    S := S + stDist
  else
    S := 'Distances from all analyzes to ' + Sample + '. ';
  case DistType of
    0: S := S + stPifagor;
    1: S := S + stKolmogor;
    2: S := S + stPetrov;
    3: S := S + stMinkov;
  end;
  case Cod of
    dtAtomn: S := S + stAtomn;
    dtMol: s := S + stMols;
    dtWeight: S := S + stWeight;
    dtWeight100: s := S + stWeight + st100;
    dtAtomnAW: s := S + stAtomn + stAnW;
    dtMolAw: s := S + stMols + stAnW;
    dtWeightAw: S := S + stWeight + stAnW;
  end;
  if UseNDist then S := S + '. Use only ' + IntToStr(NDist) + ' max contributions';
  Label1.Caption := S;
  try
    i := 1;
    Quer.DisableControls;
      Quer.First;
    if DistTyp = 1 then begin
      Quer.Locate('AnID',AnID,[]);
      for j := 1 to 92 do
        C[j] := GetConcentration(Quer, j, Cod);
    end;
    Quer.First;
    while not Quer.Eof do begin
      if SID in UsedFields then begin
        SG1.Cells[0, i] := Quer['Sample'];
        if DistTyp = 0 then
          SG1.Cells[i, 0] := Quer['Sample'];
      end else begin
        S := Trim(Quer['Descript']);
        K := Pos(',', S) - 1;
        if (K < 1) or (K > 8) then
          K := 8;
        SG1.Cells[0, i] := Copy(S, 1, k);
        if DistTyp = 0 then
          SG1.Cells[i, 0] := Copy(S, 1, k);
      end;
      SG1.Cells[SG1.ColCount - 1, i] := Quer['Descript'];
      if DistTyp = 0 then begin
        K := Quer['AnID'];
        SG1.Rows[i].Objects[0] := Pointer(K);
        SG1.Cols[i].Objects[0] := Pointer(K);
        for j := 1 to 92 do
          C[j] := GetConcentration(Quer, j, Cod);
        K := i;
        Bmr := Quer.GetBookmark;
        while not Quer.Eof do begin
          if i = k then
            SG1.Cells[i, k] := '    0'
          else begin
            case DistType of
              0: SG1.Cells[i, k] := FloatToStrF(Pifagor, ffFixed, 5, 2);
              1: SG1.Cells[i, k] := FloatToStrF(Kolmog, ffFixed, 5, 2);
              2: SG1.Cells[i, k] := FloatToStrF(Petrov, ffFixed, 6, 2);
              3: SG1.Cells[i, k] := FloatToStrF(Minkov, ffFixed, 6, 2);
            end;
            SG1.Cells[k, i] := SG1.Cells[i, k];
          end;
          inc(K);

          Quer.Next;
        end;
        Quer.GotoBookmark(Bmr);
        Quer.FreeBookmark(Bmr);
      end else begin
          if Quer['AnID']=AnID then
            SG1.Cells[1, i] := '    0'
          else begin
            case DistType of
              0: SG1.Cells[1, i] := FloatToStrF(Pifagor, ffFixed, 5, 2);
              1: SG1.Cells[1, i] := FloatToStrF(Kolmog, ffFixed, 5, 2);
              2: SG1.Cells[1, i] := FloatToStrF(Petrov, ffFixed, 6, 2);
              3: SG1.Cells[1, i] := FloatToStrF(Minkov, ffFixed, 6, 2);
            end;
          end;
      end;
      Quer.Next;
      inc(i);
    end;
    if Disttyp=0 then
    for i := 1 to Quer.RecordCount do begin
      Mn := 10E9;
      Mx := 0;
      Sum := 0;
      for j := 1 to Quer.RecordCount do
        if j <> i then begin
          R := StrToFloat(SG1.Cells[i, j]);
          Sum := Sum + R;
          if R > Mx then
            Mx := R;
          if R < Mn then
            Mn := R;
        end;
      SG1.Cells[i, Quer.RecordCount + 1] := FloatToStrF(Mn, ffFixed, 6, 2);
      SG1.Cells[i, Quer.RecordCount + 2] := FloatToStrF(Mx, ffFixed, 6, 2);
      SG1.Cells[i, Quer.RecordCount + 3] := FloatToStrF(Sum / (Quer.RecordCount - 1), ffFixed, 6, 2);
    end else begin
      Mn := 10E9;
      Mx := 0;
      Sum := 0;
      for j := 1 to Quer.RecordCount do
        if SG1.Cells[1, j]<>'    0' then begin
          R := StrToFloat(SG1.Cells[1, j]);
          Sum := Sum + R;
          if R > Mx then
            Mx := R;
          if R < Mn then
            Mn := R;
        end;
      SG1.Cells[1, Quer.RecordCount + 1] := FloatToStrF(Mn, ffFixed, 6, 2);
      SG1.Cells[1, Quer.RecordCount + 2] := FloatToStrF(Mx, ffFixed, 6, 2);
      SG1.Cells[1, Quer.RecordCount + 3] := FloatToStrF(Sum / (Quer.RecordCount - 1), ffFixed, 6, 2);
    end;
  finally
    WForm.Close;
    Quer.EnableControls;
  end;
end;

procedure TfDistance.Atomic2Click(Sender: TObject);
begin
  TMenuItem(Sender).Checked := True;
  if Atomic2.Checked then
    Cod := dtAtomn
  else if Molecular1.Checked then
    Cod := dtMol
  else if Weight2.Checked then
    Cod := dtWeight
  else if Weightrecalcto1002.Checked then
    Cod := dtWeight100
  else if AtomicwithoutH2O2.Checked then
    Cod := dtAtomnAW
  else if MolecularAW.Checked then
    Cod := dtMolAw
  else if WeightwithoutH2O2.Checked then
    Cod := dtWeightAw;
  CalcDist;
end;

procedure TfDistance.SG1DblClick(Sender: TObject);
begin
  if SG1.Row > 0 then begin
    Quer.First;
    Quer.MoveBy(SG1.Row - 1);
    if MainForm.Cadd.Checked then
      AddToList(Quer['Sample'])
    else begin
      CurID := Quer['AnID'];
      TAnalForm.Create(MainForm);
    end;
  end;
end;

procedure TfDistance.Nearestandfarest1Click(Sender: TObject);
var fnr: TfNearest;
begin
  fnr := TfNearest.Create(MainForm);
  fnr.fDist := Self;
  fnr.NAnal := Quer.RecordCount;
  fnr.Calc;
  fnr.Caption := Caption + '. ' + Label1.Caption + '. 5 Max and 5 min.';
end;

procedure TfDistance.ExFormat(Col, Row: integer; Val: Variant;
  var FontColor: TColor; var FontBol: Boolean; var NumFormat,
  FontName: String; var Sep: Boolean);
begin
  if row=0 then
    Exit;
   if DistTyp=0 then begin
     if (Col>0)and (Col<SG1.ColCount - 1)then
        NumFormat:='#####0.##';
   end else begin
      if Col=1 then
        NumFormat:='#####0.##';
   end;
end;

end.

