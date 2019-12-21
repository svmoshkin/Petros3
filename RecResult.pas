unit RecResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ActnList, Menus, ADODB, QuickRpt, Qrctrls, ExtCtrls, ESBRtns,
  Math, AnData, ListBrows, Variants;

type
  TRecResForm = class(TForm)
    SG1: TStringGrid;
    MainMenu1: TMainMenu;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    ExporttoEXCEL1: TMenuItem;
    N1: TMenuItem;
    Preview1: TMenuItem;
    Print1: TMenuItem;
    ActionList1: TActionList;
    SaveFile: TAction;
    Preview: TAction;
    Print: TAction;
    ExcAct: TAction;
    QR: TQuickRep;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    DetailBand1: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveFileExecute(Sender: TObject);
    procedure PreviewExecute(Sender: TObject);
    procedure PrintExecute(Sender: TObject);
    procedure ExcActExecute(Sender: TObject);
    procedure QRLabel5Print(sender: TObject; var Value: string);
    procedure QRLabel4Print(sender: TObject; var Value: string);
    procedure SG1DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Quer: TAdoQuery;
  end;

var
  RecResForm: TRecResForm;

implementation

uses Recalc, DMod1, wait, RHAGlobs, RollQuery, TxtImpExp, ExcelExp, Main;

{$R *.DFM}

procedure TRecResForm.FormShow(Sender: TObject);
var i, n, j, W, k, l: integer;
  Cap, S: string;
  Ex: Boolean;
begin
  if Quer.RecordCount = 0 then begin
    ShowMessage(stEmptyQuer);
    Close;
    Exit;
  end;
  Caption := DM1.TabRec['Name'] + ': ' + SelSQLName;
  Qr.Visible := false;
  QrLabel1.Caption := Caption;
  AlgoForm.VE1.DataSet := Quer;
  AlgoForm.RAProgr.Source := AlgoForm.RAHLEditor1.Lines.Text;
  //AlgoForm.RAProgr.Compile;
  N := DM1.TabVars.RecordCount;

  with Sg1 do begin
    RowCount := Quer.RecordCount + 1;
    Cells[0, 0] := ' No ';
    ColWidths[0] := 24;
    ColCount := N;
    l := 0;
    if SID in UsedFields then begin
      Cells[1, 0] := ' ID ';
      ColWidths[1] := 16 * Sg1.Canvas.TextWidth('s');
      ColCount := ColCount + 1;
      l := 1;
    end;
    ColCount := ColCount + 6;
    with DM1.TabVars do begin
      First;
      i := L+1;
      while not Eof do begin
        W := Max(Length(DM1.TabVars['DFormat']) + 2,
          Length(DM1.TabVars['FldName']) + 1);
        ColWidths[i] := W * Sg1.Canvas.TextWidth('s');
        Cells[i, 0] := DM1.TabVars['FldName'];
        Next;
        Inc(i);
      end;
    end;
    if GID in UsedFields then begin
      ColWidths[i] := 16 * Sg1.Canvas.TextWidth('s');
      SG1.Cells[i, 0] := GeolIdTit;
      Cap := CentreStr(' ' + GeolIdTit, 16);
      inc(I);
    end else
      SG1.ColCount := SG1.ColCount - 1;
    if ROC in UsedFields then begin
      ColWidths[i] := 16 * Sg1.Canvas.TextWidth('s');
      SG1.Cells[i , 0] := RockTit;
      Cap := Cap + CentreStr(' ' + RockTit, 16);
      inc(I);
    end else
      SG1.ColCount := SG1.ColCount - 1;
    if RGN in UsedFields then begin
      ColWidths[i ] := 16 * Sg1.Canvas.TextWidth('s');
      SG1.Cells[i, 0] := RegionTit;
      Cap := Cap + CentreStr(' ' + RegionTit, 16);
      inc(I);
    end else
      SG1.ColCount := SG1.ColCount - 1;
    if GBD in UsedFields then begin
      ColWidths[i ] := 16 * Sg1.Canvas.TextWidth('s');
      SG1.Cells[i, 0] := GBodyTit;
      Cap := Cap + CentreStr(' ' + GBodyTit, 16);
      inc(I);
    end else
      SG1.ColCount := SG1.ColCount - 1;
    Cells[i , 0] := stAnDes;
    ColWidths[i ] := 100 * Sg1.Canvas.TextWidth('s');
  end;
  I := 1;
  try
    Quer.DisableControls;
    AlgoForm.VE1.First;
    while not AlgoForm.VE1.Eof do begin
      AlgoForm.RaProgr.Run;
      SG1.Cells[0, i] := IntToStr(i);
      Application.ProcessMessages;
      if SID in UsedFields then begin
        if Quer['Sample'] <> Null then
          SG1.Cells[1, i] := Quer['Sample']
        else
          SG1.Cells[1, i] := '';
      end;
      for j := 1 to N do
        if AlgoForm.VE1.Data[j] <> Null then
          SG1.Cells[j + l, i] := FormatFloat(DM1.TabVars['DFormat'], AlgoForm.VE1.Data[j]);

      
      j := N + 1 + l;
      if GID in UsedFields then begin
        SG1.Cells[j, i] := DM1.GeolIds.LookUp('ID', Quer['GeolId'], 'GeolId');
        inc(J);
      end;
      if ROC in UsedFields then begin
      SG1.Cells[j, i] := DM1.Rocks.LookUp('ID', Quer['Rock'], 'Rock');
      inc(J);
      end;
      if RGN in UsedFields then begin
      SG1.Cells[j, i] := DM1.Regions.LookUp('ID', Quer['Region'], 'Region');
      inc(J);
      end;
      if GBD in UsedFields then begin
      SG1.Cells[j, i] := DM1.GBodies.LookUp('ID', Quer['GBody'], 'GBody');
      inc(J);
      end;
      if Quer['Descript'] <> Null then
        SG1.Cells[j, i] := Quer['Descript']
      else SG1.Cells[j, i] := '';
      Inc(i);
      AlgoForm.VE1.Next;
    end;
  finally
    Sg1.FixedCols := 2;
    Sg1.Visible := true;
    Quer.EnableControls;
    Sg1.SetFocus;
  end;
  for i := n + 1 downto 2 do begin
    ex := False;
    for j := 1 to SG1.RowCount - 1 do
      if SG1.Cells[i, j] <> '' then begin
        Ex := True;
        break;
      end;
    if not Ex then begin
      for k := i to SG1.ColCount - 2 do begin
        for j := 0 to SG1.RowCount - 1 do
          Sg1.Cells[k, j] := Sg1.Cells[k + 1, j];
        SG1.ColWidths[k] := SG1.ColWidths[k + 1];
      end;
      Sg1.ColCount := Sg1.ColCount - 1;
      Dec(n);
    end;
  end;
  QR.DataSet := Quer;
  S := '       ID       ';
  for i := 2 to n + 1 do
    S := S + CentreStr(' ' + SG1.Cells[i, 0], Sg1.ColWidths[i]
      div Sg1.Canvas.TextWidth('s'));
  QRLabel3.Caption := S + Cap + '   ' + stAnDes;
end;

procedure TRecResForm.FormCreate(Sender: TObject);
begin
  Quer := SelQuery;
  Application.ProcessMessages;
  OpenSq(Quer);
end;

procedure TRecResForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  CloseSq(Quer);
end;

procedure TRecResForm.SaveFileExecute(Sender: TObject);
begin
  if ExpToTextForm.DefExport(nil, Sg1, False) then
    ExpToTextForm.ExpStringGrid(SG1);
end;

procedure TRecResForm.PreviewExecute(Sender: TObject);
begin
  QR.Preview;
end;

procedure TRecResForm.PrintExecute(Sender: TObject);
begin
  QR.Print;
end;

procedure TRecResForm.ExcActExecute(Sender: TObject);
begin
  if (Quer.RecNo > 0) then
    ExcF.ExportSGToExc(SG1, Caption);
end;

procedure TRecResForm.QRLabel5Print(sender: TObject; var Value: string);
var i: integer;
begin
  if Quer['Sample'] <> null then
    Value := CentreStr(Quer['Sample'], 16)
  else Value := '                ';
  for i := 2 to SG1.ColCount - 2 do
    Value := Value + CentreStr(Sg1.Cells[i, Quer.RecNo] + ' ',
      SG1.ColWidths[i] div Sg1.Canvas.TextWidth('s'));
  if Quer['Descript'] <> null then
    Value := Value + Quer['Descript'];
end;

procedure TRecResForm.QRLabel4Print(sender: TObject; var Value: string);
begin
  if Quer.RecNo > 0 then
    Value := IntToStr(Quer.RecNo);
end;

procedure TRecResForm.SG1DblClick(Sender: TObject);
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

procedure TRecResForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
end;

end.

