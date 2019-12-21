unit Correlat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, Menus, Grids, Db, ADODB, RHAGlobs, Chemist, Math, Variants;

type
  TCorrForm = class(TForm)
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
    Correlations1: TMenuItem;
    Atomic2: TMenuItem;
    Weight2: TMenuItem;
    Weightrecalcto1002: TMenuItem;
    AtomicwithoutH2O2: TMenuItem;
    WeightwithoutH2O2: TMenuItem;
    Molecular1: TMenuItem;
    MolecularAW: TMenuItem;
    procedure ExcExpExecute(Sender: TObject);
    procedure SaveFileExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Atomic1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SG1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    Pres: array[1..ShowCount] of boolean;
    Atomn: Boolean;
    AW: Boolean;
    Mols: boolean;
    procedure ExFrm(Col, Row: integer; Val: Variant; var FontColor: TColor;
      var FontBol: Boolean; var NumFormat: string; var FontName: string; var Sep: Boolean);
  public
    { Public declarations }
    Quer: TAdoQuery;
  end;

var
  CorrForm: TCorrForm;


resourcestring
  stCorr = 'Correlation coefficients of ';

implementation

uses DMod1, ExcelExp, RollQuery,
  TxtImpExp, AtProc, wait;

{$R *.DFM}

procedure TCorrForm.ExcExpExecute(Sender: TObject);
begin
  if (Quer.RecNo > 0) then
    ExcF.ExportSGToExc(SG1, Caption, ExFrm);
end;

procedure TCorrForm.SaveFileExecute(Sender: TObject);
begin
  if ExpToTextForm.DefExport(nil, Sg1, False) then
    ExpToTextForm.ExpStringGrid(SG1);
end;

procedure TCorrForm.FormCreate(Sender: TObject);
begin
  Quer := SelQuery;
  Application.ProcessMessages;
  OpenSq(Quer);
  try
  MendTab.AlfaN := Quer.FieldByName('Alfa').AsInteger;
  except
     ShowMessage('Запрос в устаревшем формате. Удалите запрос и создайте его заново');
  end;
end;

procedure TCorrForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  CloseSq(Quer);
end;



procedure TCorrForm.Atomic1Click(Sender: TObject);
var i, j, k, l, m, t: integer;
  S: string;
  Val, Val1, R, R1: double;
  Corr: array[1..ShowCount, 1..ShowCount] of Single;
  Av: array[1..ShowCount, 1..ShowCount] of Double;
  Sigm: array[1..ShowCount, 1..ShowCount] of Double;
  NOpr: array[1..ShowCount, 1..ShowCount] of integer;
begin
  try
    WForm.Show;
    S := stCorr + SelSQLName;
    if (Sender = Atomic2) or (Sender = AtomicwithoutH2O2) then begin
      S := S + stAtomn;
      Atomn := True;
      Mols := False;
      if (Sender = Atomic2) then
        k := 0
      else
        k := 1;
    end
    else if (Sender = Molecular1) or (Sender = MolecularAW) then begin
      S := S + stMols;
      Atomn := False;
      Mols := true;
      if (Sender = Molecular1) then
        k := 2
      else
        k := 3;
    end
    else if (Sender = Weight2) or (Sender = Weightrecalcto1002) or
      (Sender = WeightwithoutH2O2) then begin
      S := S + stWeight;
      Atomn := False;
      Mols := False;
      if (Sender = Weight2) then
        k := 4
      else
        K := 6;
    end;
    if (Sender = Weightrecalcto1002) then begin
      S := S + st100;
      k := 5;
    end;
    if (Sender = AtomicwithoutH2O2) or (Sender = WeightwithoutH2O2)
      or (Sender = MolecularAW) then begin
      AW := True;
      S := S + stAnW
    end else begin
      AW := False;
      s := S + '.';
    end;
    Caption := S;
    with SG1 do begin
      RowCount := 1;

      ColCount := 1;
      Cells[0, 0] := 'n \ r';
      for i := 1 to ShowCount do
        for j := 1 to ShowCount do begin
          Nopr[i, j] := 0;
          Av[i, j] := 0;
          Sigm[i, j] := 0;
          Corr[i, j] := 0;
        end;
      with Quer do begin
        first;
        while not EOF do begin
          Application.ProcessMessages;
          for i := 1 to ShowCount do begin
            if i <= MendCount then
              j := MendTab.Order[i]
            else
              j := i;
           { if J=0 then
              ShowMessage('Order=0; i='+InttoStr(i));}
            if Pres[j] and (Quer[GetFieldName(j)] <> null) and
            ((not Mols) or (MendTab.MustMol(j))) then begin
              R := GetConcentration(Quer, j, TDatType(k));
              for l := i + 1 to ShowCount do begin
                if l <= MendCount then
                  m := MendTab.Order[l]
                else
                  m := l;
             {   if m=0 then
              ShowMessage('Order=0; l='+InttoStr(l));  }
                if Pres[m] and (Quer[GetFieldName(m)] <> null) and
                ((not Mols) or (MendTab.MustMol(m))) then begin
                  Inc(NOpr[j, m]);
                  Inc(NOpr[m, j]);
                  R1 := GetConcentration(Quer, M, TDatType(k));
                  Av[j, m] := Av[j, m] + R;
                  Sigm[j, m] := Sigm[j, m] + R * R;
                  Av[m, j] := Av[m, j] + R1;
                  Sigm[m, j] := Sigm[m, j] + R1 * R1;
                  Corr[j, m] := Corr[j, m] + R * R1;
                end;
              end;
            end;
          end;
          next;
        end;
        first;
      end;
      for i := 1 to ShowCount do begin
        if i <= MendCount then
          j := MendTab.Order[i]
        else
          j := i;
        if Pres[j] then begin
          for l := i + 1 to ShowCount do begin
            if l <= MendCount then
              m := MendTab.Order[l]
            else
              m := l;

            if (NOpr[j, m] > 0) then begin
              Av[j, m] := Av[j, m] / NOpr[j, m];
              Av[m, j] := Av[m, j] / NOpr[j, m];
              Sigm[j, m] := Sigm[j, m] / NOpr[j, m] - Av[j, m] * Av[j, m];
              Sigm[m, j] := Sigm[m, j] / NOpr[j, m] - Av[m, j] * Av[m, j];
            end;
          end;
        end;
      end;
      for i := 1 to ShowCount do begin
        if i <= MendCount then
          j := MendTab.Order[i]
        else
          j := i;
        if Pres[j] then begin
          for l := i + 1 to ShowCount do begin
            if l <= MendCount then
              m := MendTab.Order[l]
            else
              m := l;
            if (NOpr[j, m] > 0) and (Sigm[j, m] > 1E-15) and (Sigm[m, j] > 1E-15) then
              Corr[j, m] := (Corr[j, m] / NOpr[j, m] - Av[j, m] * Av[m, j]) / Sqrt(Sigm[j, m] * Sigm[m, j])
          end;
        end;
      end;


      for j := 1 to ShowCount do begin
        if j <= MendCount then
          i := MendTab.Order[j]
        else
          i := j;
        if (MendTab.AlfaN = 0) and (((i = 8) and not Atomn) or ((i = 1) and AW)
          or (Mols and not MendTab.MustMol(i))) then continue;
        if (Pres[i]) then begin
          ColCount := ColCount + 1;
          RowCount := RowCount + 1;
        {Elements[ColCount - 1] := i;}
          if atomn then begin
            Cells[ColCount - 1, 0] := ' ' + MendTab.GetFieldTitle(i);
            Cells[0, RowCount - 1] := ' ' + MendTab.GetFieldTitle(i);
          end else begin
            Cells[ColCount - 1, 0] := ' ' + MendTab.GetPetroSym(i);
            Cells[0, RowCount - 1] := ' ' + MendTab.GetPetroSym(i);
          end;
          Cells[ColCount - 1, RowCount - 1] := '     1';
          t := 1;
          for l := 1 to j - 1 do begin
            if l <= MendCount then
              m := MendTab.Order[l]
            else
              m := l;
            if ((m = 8) and not Atomn) or ((m = 1) and AW) then continue;
            if (Pres[m]) then begin
              if (NOpr[i, m] >= minCorrCount) and (abs(corr[m, i]) <= 1.0001) then
                Cells[ColCount - 1, t] := FormatFloat('0.##', Corr[m, i])
              else
                Cells[ColCount - 1, t] := '   -';
              Cells[t, ColCount - 1] := IntToStr(NOpr[i, m]);
              Inc(t);
            end;
          end;
        end;
      end;
      RowCount := RowCount + 1;
      Cells[0, RowCount - 1] := ' r(mid)';
      k := 1;
      for j := 1 to MendCount {+ 2 } do begin
        if j <= MendCount then
          i := MendTab.Order[j]
        else
          i := j;
        if (MendTab.AlfaN = 0) and (((i = 8) and not Atomn) or ((i = 1) and AW)
          or (Mols and not MendTab.MustMol(i))) then continue;
        if (Pres[i]) then begin
          R := 0;
          t := 0;
          for l := 1 to MendCount { + 2} do begin
            if l <= MendCount then
              m := MendTab.Order[l]
            else
              m := l;
            if (m = i) or ((m = 8) and not Atomn) or ((m = 1) and AW) then continue;
            if (NOpr[i, m] >= minCorrCount) and ((abs(corr[m, i]) <= 1.0001) or (abs(corr[i, m]) <= 1.0001)) then begin
              inc(t);
              if (abs(corr[m, i]) <= 1.0001) then
                R := R + Abs(Corr[m, i]);
              if (abs(corr[i, m]) <= 1.0001) then
                R := R + Abs(Corr[i, m]);
            end;
          end;
          if t > 0 then
            Cells[k, RowCount - 1] := FormatFloat('0.##', r / t);
          inc(k);
        end;
      end;
      FixedCols := 1;
      FixedRows := 1;
    end;
  finally
    WForm.Close;
  end;
end;

procedure TCorrForm.FormShow(Sender: TObject);
var j, i: integer;
begin
  Application.ProcessMessages;
  if Quer.RecordCount = 0 then begin
    ShowMessage(stEmptyQuer);
    Close;
    Exit;
  end;
  for j := 1 to ShowCount do
    Pres[j] := false;
  try
    Quer.DisableControls;
    with Quer do begin
      first;
      while not EOF do begin
        for i := 1 to ShowCount do begin
          if i <= MendCount then begin
            j := MendTab.Order[i];
          end else
            j := i;
          if (J>0)and(Quer[GetFieldName(j)] <> null) and (Quer[GetFieldName(j)] >= 0)
          then
            Pres[j] := True;
        end;
        Next;
      end;
      Atomic1Click(Atomic2);
    end;
  finally
    Quer.EnableControls;
  end;
end;

procedure TCorrForm.SG1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (ACol > 0) and (ARow > 0) and (ACol > ARow) and (SG1.Cells[ACol, ARow] <> '   -') and
    (abs(StrToFloat(SG1.Cells[ACol, ARow])) > rBold) then begin
    SG1.Canvas.Font.Style := [fsBold];
    if (abs(StrToFloat(SG1.Cells[ACol, ARow])) > rRed) then
      SG1.Canvas.Font.Color := clRed;
  end else begin
    SG1.Canvas.Font.Style := [];
    SG1.Canvas.Font.Color := clBlack;
  end;
  SG1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, SG1.Cells[ACol, ARow]);
end;

procedure TCorrForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
  MendTab.AlfaN := Quer.FieldByName('Alfa').AsInteger;
end;

procedure TCorrForm.ExFrm(Col, Row: integer; Val: Variant;
  var FontColor: TColor; var FontBol: Boolean; var NumFormat: string; var FontName: string; var Sep: Boolean);
begin
  if (Col > 0) and (Row > 0) then begin
    if ((Col > Row) or (Row = Sg1.RowCount - 1)) and (Val <> '   -') and (Trim(Val) <> '') then begin
      NumFormat := '0.##';
      if (abs(StrToFloat(Val)) > rBold) then begin
        FontBol := True;
        if (abs(StrToFloat(Val)) > rRed) then
          FontColor := clRed;
      end
    end else
      NumFormat := '#####0';
  end;
end;

end.

