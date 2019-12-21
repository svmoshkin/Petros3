unit Koeff;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DMod1, Db, ADODB, StdCtrls, Buttons, Grids, DBGrids, QuickRpt, ExtCtrls,
  Chemist, EdCoefs, ESBRtns, Qrctrls, Math, AnData, RXDBCtrl, ActnList,
  OleServer, Excel97, Menus, Variants;

type
  TKoefForm = class(TForm)
    QR: TQuickRep;
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    SaveDialog1: TSaveDialog;
    SG1: TStringGrid;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    MainMenu1: TMainMenu;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    N1: TMenuItem;
    Preview1: TMenuItem;
    Print1: TMenuItem;
    ActionList1: TActionList;
    SaveFile: TAction;
    Preview: TAction;
    Print: TAction;
    EditCoeff: TAction;
    EditCoeff1: TMenuItem;
    ExcExp: TAction;
    ExporttoEXCEL1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SG1DblClick(Sender: TObject);
    procedure QRDBText1Print(sender: TObject; var Value: string);
    procedure QRLabel5Print(sender: TObject; var Value: string);
    procedure ExcExpExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Quer: TAdoQuery;
  end;


function Interprete(F: string; Tabl: TDataset): double;
function Parse(FF: string; Tabl: TDataset; PredR: Double): double;

var
  KoefForm: TKoefForm;
  KoefName: TStringList;
  AnW: boolean;

resourcestring
  stStKoef = 'Standard coefficients';
  stNotO= 'Oxygen is not valid component for weight concentration';
  {'Для весовых концентраций указание в формуле кислорода недопустимо!'}
  stNotH= 'Hydrogen is not available for calculations without water';
  {'Для безводного состава указание в формуле водорода недопустимо!'}
  stFormErr = 'Error in formula for ';

implementation

uses RhaGlobs, Main, ExcelExp, wait, ListBrows, RollQuery, TxtImpExp;
{$R *.DFM}

procedure TKoefForm.FormCreate(Sender: TObject);
begin
  Quer := SelQuery;
  Qr.Visible := false;
 { QrLabel1.Caption := stStKoef + ': ' + SelSQLName;}
  Caption := stStKoef + ': ' + SelSQLName;
  Application.ProcessMessages;
  OpenSq(Quer);
end;

procedure TKoefForm.FormShow(Sender: TObject);
var
  i, j, k, W: integer;
  Cap: string;
begin
  Cap := '       ID       ';
  try
    Quer.DisableControls;
    with Sg1 do begin
      RowCount := Quer.RecordCount + 1;
      ColCount := Coefs.Count + 2;
      Cells[0, 0] := ' No ';
      ColWidths[0] := 24;
      Cells[1, 0] := ' ID ';
      ColWidths[1] := 16 * Sg1.Canvas.TextWidth('s');
      j := 2;
      for i := 0 to Coefs.Count - 1 do
        if TStKoef(Coefs.Items[i]).Ident[Length(TStKoef(Coefs.Items[i]).Ident)]
          <> '_' then begin
          W := Max(Length(TStKoef(Coefs.Items[i]).DFormat) + 1,
            Length(TStKoef(Coefs.Items[i]).Title) + 1);
          Cap := Cap + CentreStr(' ' + TStKoef(Coefs.Items[i]).Title, W);
          ColWidths[j] := W * Sg1.Canvas.TextWidth('s');
          Cells[j, 0] := TStKoef(Coefs.Items[i]).Title;
          inc(J);
        end;
      ColCount := j + 5;
      for i := j to j + 3 do
        ColWidths[i] := 16 * Sg1.Canvas.TextWidth('s');
      SG1.Cells[j, 0] := GeolIdTit;
      Cap := Cap + CentreStr(' ' + GeolIdTit, 16);
      SG1.Cells[j + 1, 0] := RockTit;
      Cap := Cap + CentreStr(' ' + RockTit, 16);
      SG1.Cells[j + 2, 0] := Regiontit;
      Cap := Cap + CentreStr(' ' + RegionTit, 16);
      SG1.Cells[j + 3, 0] := GBodyTit;
      Cap := Cap + CentreStr(' ' + GBodyTit, 16);
      Cells[j + 4, 0] := stAnDes;
      ColWidths[j + 4] := 100 * Sg1.Canvas.TextWidth('s');
      Quer.First;
      k := 1;
      while not Quer.Eof do begin
        Application.ProcessMessages;
        Cells[0, k] := IntToStr(Quer.RecNo);
        if Quer['Sample'] <> Null then
          Cells[1, k] := Quer['Sample']
        else Cells[1, k] := '';
        j := 2;
        for i := 0 to Coefs.Count - 1 do
          if TStKoef(Coefs.Items[i]).Ident[Length(TStKoef(Coefs.Items[i]).Ident)]
            <> '_' then begin
            try
              AnW := TStKoef(Coefs.Items[i]).AnW;
              Cells[j, k] := FormatFloat(TStKoef(Coefs.Items[i]).DFormat,
                Interprete(TStKoef(Coefs.Items[i]).Formula, Quer));
            except
              on Exception do begin
                ShowMessage(stFormerr
                  + TStKoef(Coefs.Items[i]).Name);
                Cells[j, k] := '****';
              end;
            end;
            Inc(j);
          end;
        SG1.Cells[j, k] := DM1.GeolIds.LookUp('ID', Quer['GeolId'], 'GeolId');
        SG1.Cells[j + 1, k] := DM1.Rocks.LookUp('ID', Quer['Rock'], 'Rock');
        SG1.Cells[j + 2, k] := DM1.Regions.LookUp('ID', Quer['Region'], 'Region');
        SG1.Cells[j + 3, k] := DM1.GBodies.LookUp('ID', Quer['GBody'], 'GBody');
        if Quer['Descript'] <> Null then
          Cells[j + 4, k] := Quer['Descript']
        else Cells[j + 4, k] := '';
        Inc(K);
        Quer.Next;
      end;
    end;
  finally
    Sg1.FixedCols := 2;
    Sg1.Visible := true;
    Quer.EnableControls;
    Sg1.SetFocus;
  end;
  QR.DataSet := Quer;
  QRLabel3.Caption := Cap + '   ' + stAnDes;
  QRLabel1.Caption := Caption;
end;

procedure TKoefForm.BitBtn6Click(Sender: TObject);
begin
  EdKoefForm.Quer:=Quer;
  EdKoefForm.ShowModal;
  FormShow(Sender);
end;


function Interprete(F: string; Tabl: TDataset): double;
begin
  Result := Parse('+' + F, Tabl, 0);
end;


function Parse(FF: string; Tabl: TDataset; PredR: Double): double;
var SS: string;
  RR: Double;
  function FindTerm(F: string; var SS1: string): double;
  var s, s1: string;
    R: real;
    FirstIsNum: boolean;
    Znak, Zn: Char;
    function Sim: real;
    var
      i: integer;
    begin
      S := '';
      for i := 1 to Length(S1) do
        if S1[i] in ['A'..'Z', 'a'..'z', '@', '$', '0'..'9', '_', #134, #135] then
          S := S + S1[i]
        else begin
          Znak := S1[i];
          break;
        end;
      if i > Length(S1) then Znak := '`';
      S1 := Copy(S1, i + 1, Length(S1));
      if S[Length(S)] = '@' then
      try
        System.Delete(S, Length(S), 1);
        Result := Parse('+' + Coefs.GetFormula(S), Tabl, 0);
      except
        on Exception do Abort;
      end
      else if S[Length(S)] = '$' then begin
        System.Delete(S, Length(S), 1);
        i := MendTab.GetNumber(S);
        if i = 8 then begin
          ShowMessage(stNotO);
          Abort;
        end;
        if i > 0 then begin
          if AnW then begin
            if i = 1 then begin
              ShowMessage(stNotH);
              Abort;
            end;
            if Tabl['A' + IntToStr(i)] <> null then
              Result := MendTab.GetPetroVes(i) *
                Tabl['A' + IntToStr(i)] / Tabl['AW']
            else
              Result := 0;
          end else
            if Tabl['A' + IntToStr(i)] <> null then
              Result := MendTab.GetPetroVes(i) *
                Tabl['A' + IntToStr(i)] / Tabl['OX']
            else
              Result := 0;
        end else
          Abort
      end else begin
        i := MendTab.GetNumber(S);
        if i > 0 then begin
          if AnW then begin
            if i = 1 then begin
              ShowMessage(stHforAw);
              Abort;
            end;
            if i = 8 then begin
              if Tabl['A1'] <> null then
                Result := (Tabl['A8'] - 0.5 * Tabl['A1']) * Tabl['AWA']
              else
                Result := Tabl['A8'] * Tabl['AWA']
            end else
              if Tabl['A' + IntToStr(i)] <> null then
                Result := Tabl['A' + IntToStr(i)] * Tabl['AWA']
              else Result := 0;
          end else
            if Tabl['A' + IntToStr(i)] <> null then
              Result := Tabl['A' + IntToStr(i)]
            else Result := 0;
        end else
          Abort;
      end;
      FirstIsNum := true;
    end;

    function Num: real;
    var
      i: integer;
    begin
      S := '';
      for i := 1 to Length(S1) do
        if S1[i] in ['0'..'9', '.'] then S := S + S1[i]
        else begin
          Znak := S1[i];
          break;
        end;
      if i > Length(S1) then Znak := '`';
      S1 := Copy(S1, i + 1, Length(S1));
      try
        Result := StrToFloat(S);
      except
        on Exception do Abort
      end;
      FirstIsNum := true;
    end;

    procedure FindFactor;
    var
      i, j: integer;
    begin
      J := 1;
      i := 1;
      s := '';
      repeat
        Inc(I);
        if i > Length(S1) then Abort;
        if S1[i] = '(' then inc(J);
        if S1[i] = ')' then dec(J);
        S := S + S1[i];
      until j = 0;
      if i = Length(S1) then begin
        Znak := '`';
        S1 := '';
      end else begin
        Znak := S1[i + 1];
        S1 := Copy(S1, i + 2, Length(S1));
      end;
      System.Delete(S, Length(S), 1);
      FirstIsNum := false;
    end;

    function FindFunction: Double;
    var FName: string;
    begin
    end;
  begin
    S1 := F;
    case S1[1] of
      'A'..'Z', 'a'..'z': R := Sim;
      '0'..'9', '.': R := Num;
      '(': FindFactor;
      '!': R := FindFunction;
    else
      Abort;
    end;
    if FirstIsNum then
      Result := R
    else Result := Parse('+' + S, Tabl, 0);
    Zn := Znak;
    if not (Znak in ['+', '-', '`']) then
      repeat
        if S1 = '' then Abort;
        case S1[1] of
          'A'..'Z', 'a'..'z': R := Sim;
          '0'..'9', '.': R := Num;
          '(': FindFactor;
          '!': R := FindFunction;
        else
          Abort;
        end;
        case Zn of
          '*': if FirstIsNum then
              Result := Result * R
            else Result := Result * Parse('+' + S, Tabl, 0);
          '/': begin
              if not FirstIsNum then
                R := Parse('+' + S, Tabl, 0);
              if R = 0 then
                R := 1E-28;
              Result := Result / R
            end;
        else
          Abort;
        end;
        zn := Znak;
      until Znak in ['+', '-', '`'];
    SS1 := S1;
    if Znak in ['+', '-'] then ss1 := Znak + SS1
  end;
begin
  Result := PredR;
  if FF = '' then exit;
  case FF[1] of
    '+': begin
        RR := FindTerm(Copy(FF, 2, Length(FF)), SS);
      end;
    '-': begin
        RR := -FindTerm(Copy(FF, 2, Length(FF)), SS);
      end;
  else Abort;
  end;
  Result := PredR + Parse(SS, Tabl, RR);
end;

procedure TKoefForm.BitBtn2Click(Sender: TObject);
begin
     if ExpToTextForm.DefExport(nil,Sg1,False) then
        ExpToTextForm.ExpStringGrid(SG1);
end;

procedure TKoefForm.BitBtn3Click(Sender: TObject);
begin
  QR.Preview;
end;

procedure TKoefForm.BitBtn5Click(Sender: TObject);
begin
  QR.Print;
end;

procedure TKoefForm.DBGrid1DblClick(Sender: TObject);
begin
  try
    quer.DisableControls;
    Quer.First;
    Quer.MoveBy(SG1.Row - 1);
    CurID := Quer['AnID'];
  finally
    quer.EnableControls;
  end;
  if MainForm.Cadd.Checked then
    AddToList(Quer['Sample'])
  else
    TAnalForm.Create(MainForm);
end;

{procedure TKoefForm.SG1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  i, a, b: integer;
  S: string;
begin
  if (Quer.RecNo > 0) then begin
    if (DataCol = 0) then begin
      s := IntToStr(Quer.RecNo);
      Sg1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
      Sg1.Canvas.TextOut(Rect.Right - Sg1.Canvas.TextWidth(s) - 2, Rect.Top + 1, S);
      Exit;
    end;
    if (DataCol > 1) and (DataCol <= DColCount) then begin
      try
        i := Coefs.GetIndFromTitle(Column.Title.Caption);
        AnW := TStKoef(Coefs.Items[i]).AnW;
        S := FormatFloat(TStKoef(Coefs.Items[i]).DFormat,
          Interprete(TStKoef(Coefs.Items[i]).Formula, Quer));
        Sg1.Canvas.TextOut(Rect.Right - Sg1.Canvas.TextWidth(s) - 1, Rect.Top + 1, S);
      except
        on Exception do
          ShowMessage('Ошибка в формуле для расчета '
            + TStKoef(Coefs.Items[i]).Name);
      end;
    end
    else Sg1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;  }

procedure TKoefForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  CloseSq(Quer);
end;

procedure TKoefForm.SG1DblClick(Sender: TObject);
begin
  CurID := Quer['AnID'];
  TAnalForm.Create(MainForm);
end;

procedure TKoefForm.QRDBText1Print(sender: TObject; var Value: string);
begin
  if Quer.RecNo > 0 then
    Value := IntToStr(Quer.RecNo);
end;

procedure TKoefForm.QRLabel5Print(sender: TObject; var Value: string);
var i: integer;
begin
  if Quer['Sample'] <> null then
    Value := CentreStr(Quer['Sample'],16)
  else Value := '                ';
  for i := 2 to SG1.ColCount - 2 do
    Value := Value + CentreStr(Sg1.Cells[i, Quer.RecNo] + ' ',
      SG1.ColWidths[i] div Sg1.Canvas.TextWidth('s'));
  if Quer['Descript'] <> null then
    Value := Value + Quer['Descript'];
end;

procedure TKoefForm.ExcExpExecute(Sender: TObject);
begin
     if (Quer.RecNo > 0) then 
     ExcF.ExportSGToExc(SG1, Caption);
end;

procedure TKoefForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.

