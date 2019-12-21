unit Stat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, Menus, Grids, Db, ADODB, RHAGlobs, Chemist, Math, Series,
  TeEngine, ExtCtrls, TeeProcs, Chart, ESBRtns, Variants;

type
  TStatForm = class(TForm)
    SG1: TStringGrid;
    MainMenu1: TMainMenu;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    ExporttoEXCEL1: TMenuItem;
    N1: TMenuItem;
    Preview1: TMenuItem;
    Font1: TMenuItem;
    Print1: TMenuItem;
    ActionList1: TActionList;
    SaveFile: TAction;
    Preview: TAction;
    Print: TAction;
    Font: TAction;
    ExcExp: TAction;
    PrinterSetupDialog1: TPrinterSetupDialog;
    FontDialog1: TFontDialog;
    Characteristics1: TMenuItem;
    Atomic1: TMenuItem;
    Weight1: TMenuItem;
    Weightrecalcto1001: TMenuItem;
    AtomicwithoutH2O1: TMenuItem;
    WeightwithoutH2O1: TMenuItem;
    Chart1: TChart;
    Series1: TBarSeries;
    Series2: TLineSeries;
    Molecular1: TMenuItem;
    MolecularAW: TMenuItem;
    Print2: TMenuItem;
    procedure ExcExpExecute(Sender: TObject);
    procedure SaveFileExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Atomic1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SG1Click(Sender: TObject);
    procedure SG1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure Print2Click(Sender: TObject);
  private
    { Private declarations }
    Pres: TPresents;
    Elements: array[1..ShowCount] of integer;
    Av: array[1..ShowCount] of Double;
    Mn: array[1..ShowCount] of Single;
    Mx: array[1..ShowCount] of Single;
    Sigm: array[1..ShowCount] of Double;
    NOpr: array[1..ShowCount] of integer;
    AnType: TDatType;
    Col: integer;
  public
    { Public declarations }
    Quer: TAdoQuery;
    procedure PrepareChart(ind: integer);
  end;

var
  StatForm: TStatForm;

resourcestring
  stChar = 'Statistical characteristics of ';
  stDisp = 'Dispersion';
  stMin = 'Minimum';
  stMax = 'Maximum';
  StAv = 'Average';
  stSigm = 'St.deviation';
  stAss = 'Asymmetry';
  StExc = 'Excess';
  stNotEnData = 'Not enough data to build frequency histogram for ';
{  stMod = 'Mode';
  stMed = 'Mediane';}

implementation

uses DMod1, ExcelExp, RollQuery,
  TxtImpExp, AtProc, wait;

{$R *.DFM}

procedure TStatForm.ExcExpExecute(Sender: TObject);
begin
  if (Quer.RecNo > 0) then
    ExcF.ExportSGToExc(SG1, Caption);
end;

procedure TStatForm.SaveFileExecute(Sender: TObject);
begin
  if ExpToTextForm.DefExport(nil, Sg1, False) then
    ExpToTextForm.ExpStringGrid(SG1);
end;

procedure TStatForm.FormCreate(Sender: TObject);
begin
  Quer := SelQuery;
  Application.ProcessMessages;
  OpenSq(Quer);
  MendTab.AlfaN:=Quer.FieldByName('Alfa').AsInteger;
end;

procedure TStatForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  CloseSq(Quer);
end;



procedure TStatForm.Atomic1Click(Sender: TObject);
var i, j, t: integer;
  {S: string;}
  Val, Val1, R, R1: double;
  Ass: array[1..ShowCount] of Double;
  Exc: array[1..ShowCount] of Double;
begin
  try
    WForm.Show;
    Application.ProcessMessages;
    if (Sender = Atomic1) then
      AnType := dtAtomn
    else if (Sender = AtomicwithoutH2O1) then
      AnType := dtAtomnAw
    else if (Sender = Molecular1) then
      AnType := dtMol
    else if (Sender = MolecularAW) then
      AnType := dtMolAW
    else if (Sender = Weight1) then
      AnType := dtWeight
    else if (Sender = Weightrecalcto1001) then
      AnType := dtWeight100
    else if (Sender = WeightwithoutH2O1) then
      AnType := dtWeightAW;
    Caption := stChar + SelSQLName + GetCaptionStr(AnType);
    with SG1 do begin
      RowCount := 9;
      Cells[0, 1] := StMin;
      Cells[0, 2] := StMax;
      Cells[0, 3] := StAv;
      Cells[0, 4] := StDisp;
      Cells[0, 5] := StSigm;
      Cells[0, 6] := StAss;
      Cells[0, 7] := StExc;
    {Cells[0, 8] := StMod;
    Cells[0, 9] := StMed;}
      Cells[0, 8] := 'N';
      ColCount := 1;

      for i := 1 to ShowCount do begin
        Nopr[i] := 0;
        Ass[i] := 0;
        Av[i] := 0;
      {Disp[i] := 0;}
        Exc[i] := 0;
      {Med[i] := 0;
      Mode[i] := 0;}
        Mx[i] := 0;
        Mn[i] := 200;
        Sigm[i] := 0;
      end;
      with Quer do begin
        try
          DisableControls;
          first;
          while not EOF do begin
            Application.ProcessMessages;
            for i := 1 to ShowCount do begin
             if i <= MendCount then
        j := MendTab.Order[i]
      else
        j := i;
              if PresentInData(Pres, j, AnType, 0) and (Quer[GetFieldName(j)] <> null) then begin
                Inc(NOpr[j]);
                Val1 := GetDataValue(Quer, j, AnType, 0);
                if Mn[j] > Val1 then
                  Mn[j] := Val1;
                if Mx[j] < Val1 then
                  Mx[j] := Val1;
                Av[j] := Av[j] + Val1;
                R := Val1 * Val1;
                Sigm[j] := Sigm[j] + R;
                R := R * Val1;
                Ass[j] := Ass[j] + R;
                R := R * Val1;
                Exc[j] := Exc[j] + R;
              end;
            end;
            next;
          end;
          first;
        finally
          EnableControls;
        end;
      end;
      for i := 1 to ShowCount do begin
        if i <= MendCount then
        j := MendTab.Order[i]
      else
        j := i;
        if PresentInData(Pres, j, AnType, 0) then begin
          Av[j] := Av[j] / NOpr[j];
          R := Sigm[j] / NOpr[j];
          Sigm[j] := R - Av[j] * Av[j];
          if (Nopr[j] > 1) and (Sigm[j] > 1E-24) then begin
            R1 := Ass[j] / NOpr[j];
            Ass[j] := (R1 - 3 * Av[j] * R + 2 * Av[j] * Av[j] * Av[j])
              / Power(Sigm[j], 1.5);
            Exc[J] := (Exc[j] / NOpr[j] - 4 * R1 * Av[j] + 6 * R * Av[j] * Av[j] -
              3 * Av[j] * Av[j] * Av[j] * Av[j]) / (Sigm[j] * Sigm[j]) - 3;
          end else begin
            Ass[j] := 0;
            Exc[J] := 0;
            Sigm[j] := 0;
          end;
        end;
      end;

      t := 1;
      for j := 1 to ShowCount do begin
      if j <= MendCount then
        i := MendTab.Order[j]
      else
        i := j;
        if PresentInData(Pres, i, AnType, 0) then begin
          ColCount := ColCount + 1;
          Cells[ColCount - 1, 0] := CentreStr(GetDataTitle(i, AnType, 0), 10);
          Elements[t] := i;
          Inc(t);
          Cells[ColCount - 1, 1] := FormatAnData(Mn[i]);
          Cells[ColCount - 1, 2] := FormatAnData(Mx[i]);
          Cells[ColCount - 1, 3] := FormatAnData(Av[i]);
          Cells[ColCount - 1, 4] := FormatAnData(Sigm[i]);
          Cells[ColCount - 1, 5] := FormatAnData(Sqrt(Sigm[i]));
          Cells[ColCount - 1, 6] := FormatAnData(Ass[i]);
          Cells[ColCount - 1, 7] := FormatAnData(Exc[i]);
        {Cells[ColCount - 1, 8] := FormatAnData( Mode[ i]);
        Cells[ColCount - 1, 9] := FormatAnData( Med[i]);}
          Cells[ColCount - 1, 8] := IntToStr(NOpr[i]);
        end;
      end;
      ColWidths[0] := 80;
      FixedCols := 1;
    end;
     if NOpr[1] > 10 then
    PrepareChart(1)
  else
    ShowMessage(stNotEnData +
      Sg1.Cells[1, 0]);
  finally
    WForm.Close;
  end;
end;

procedure TStatForm.FormShow(Sender: TObject);
var j, i: integer;
begin
  Application.ProcessMessages;
  if Quer.RecordCount = 0 then begin
    ShowMessage(stEmptyQuer);
    Close;
    Exit;
  end;
  GetPresents(Quer, Pres);
  Atomic1Click(Atomic1);
  if NOpr[Elements[1]] > 10 then
    PrepareChart(1);
end;

procedure TStatForm.PrepareChart(ind: integer);
var int: array[0..20] of Single;
  N, i, j: integer;
  Step, val, x, Y, r: Single;
begin
  Chart1.BottomAxis.Title.Caption := Sg1.Cells[ind, 0];
  j := Elements[ind];
  if StBarAuto then begin
    if NOpr[j] < 16 then
      n := 5
    else
      if NOpr[j] < 25 then
        n := 7
      else
        if NOpr[j] < 60 then
          n := NOpr[j] div 3
        else
          n := 20;
  end else
    n := StatChartBars;
  Step := (Mx[j] - Mn[j]) / n;
  if Step=0 then
    Exit;
  for i := 0 to 20 do
    int[i] := 0;
  with Quer do begin
    try
      DisableControls;
      First;
      while not Eof do begin
        if Quer[GetFieldName(j)] <> null then begin
          Val := Quer[GetFieldName(j)];
          if (MendTab.AlfaN>0)or(j>100) then
              i := round((Val - Mn[j]) / Step)
          else begin
          case AnType of
            dtAtomn: i := round((Val - Mn[j]) / Step);
            dtAtomnAW: begin
                Val := Val * (Quer['AWA']);
                if (J = 8) and (Quer['A1'] <> null) then
                  Val := Val - 0.5 * Quer['A1'] * Quer['AWA'];
                i := round((Val - Mn[j]) / Step);
              end;
            dtMol: i := Round((Val * Quer['MolFact'] / MendTab.GetKatSteh(j) - Mn[j]) / Step);
            dtMolAw: i := Round((Val * Quer['MolFactAW'] / MendTab.GetKatSteh(j) - Mn[j]) / Step);
            dtWeight: i := round((Val * Quer['Summa'] * MendTab.GetPetroVes(j)
                / (Quer['Ox'] * 100) - Mn[j]) / Step);
            dtWeight100: i := round((Val * MendTab.GetPetroVes(j) / Quer['Ox']
                - Mn[j]) / Step);
            dtWeightAW: i := round((Val * MendTab.GetPetroVes(j) / Quer['AW'] - Mn[j]) / Step);
          end;
          end;
          Int[i] := Int[i] + 1;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
    end;
  end;
  Chart1.Series[0].Clear;
  Chart1.Series[1].Clear;
  for i := 0 to n do begin
    Chart1.Series[0].AddXY(Mn[j] + i * Step, Int[i]);
  end;
  R := NOpr[j] * Step * (n + 1) / (N * 2.506628 * Sqrt(Sigm[j]));
  Step := Step * n / 50;
  for i := -1 to 52 do begin
    X := Mn[j] + i * Step;
    Val := (X - Av[j]);
    Val := Val * Val / (2 * Sigm[j]);
    Y := R * Exp(-Val);
    Chart1.Series[1].AddXY(X, Y);
  end;
end;

procedure TStatForm.SG1Click(Sender: TObject);
begin
  if Col < 1 then Exit;
  if NOpr[Elements[Col]] > 10 then
    PrepareChart(Col)
  else
    ShowMessage(stNotEnData +
      Sg1.Cells[Col, 0]);
end;

procedure TStatForm.SG1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i: integer;
begin
  SG1.MouseToCell(X, Y, Col, I);
  if i = 0 then
    SG1Click(Sender);
end;

procedure TStatForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
  MendTab.AlfaN:=Quer.FieldByName('Alfa').AsInteger;
end;

procedure TStatForm.Print2Click(Sender: TObject);
begin
  Chart1.Print;
end;

end.

