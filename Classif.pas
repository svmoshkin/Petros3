unit Classif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, ImgList, ActnList, Menus, Db, Grids, ESBRtns,  Wait, Variants;

type
  TFClass = class(TForm)
    SG1: TStringGrid;
    MainMenu1: TMainMenu;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    N1: TMenuItem;
    Preview1: TMenuItem;
    Font1: TMenuItem;
    Print1: TMenuItem;
    ActionList1: TActionList;
    SaveFile: TAction;
    Preview: TAction;
    Print: TAction;
    Font: TAction;
    PrinterSetupDialog1: TPrinterSetupDialog;
    FontDialog1: TFontDialog;
    DSQ: TDataSource;
    ExcExp: TAction;
    ExporttoEXCEL1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SaveFileExecute(Sender: TObject);
    procedure SG1DblClick(Sender: TObject);
    procedure ExcExpExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    DIDs: array[0..256] of integer;
    DidsCount: integer;
    function findDiagr(ID: integer): integer;
  public
    { Public declarations }
    Quer: TAdoQuery;
  end;

var
  FClass: TFClass;

resourcestring
  stNotRes = 'There are no classification results for this query.';
  stCapt = 'Classification results for ';

implementation

uses RHAGlobs, DMod1, Main, AnData, ExcelExp, ListBrows, RollQuery,
  TxtImpExp, ADOUtilsS;

{$R *.DFM}

procedure TFClass.FormCreate(Sender: TObject);
begin
  Quer := SelQuery;
  Application.ProcessMessages;
  OpenSq(Quer);
end;

procedure TFClass.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  CloseSq(Quer);
end;

procedure TFClass.FormShow(Sender: TObject);
var i,j, DCol: integer;
begin
  Application.ProcessMessages;
  DSQ.DataSet := Quer;
  Caption := stCapt + SelSQLName;
  SG1.Cells[0, 0] := 'Num';
  SG1.ColWidths[0] := 32;
  if SID in UsedFields then begin
  SG1.Cells[1, 0] := 'ID';
  SG1.ColWidths[1] := 96;
  end else
   SG1.ColCount:=1;
  try
   DM1.TbDiagr.DisableControls;
  try
    with Quer do begin
      {DisableControls;}
      first;
      i := 1;
      while not EOF do begin
        Application.ProcessMessages;
        SG1.RowCount := SG1.RowCount + 1;
        SG1.Cells[0, i] := IntToStr(i);
        if SID in UsedFields then begin
        if QUer['Sample'] <> Null then
          SG1.Cells[1, i] := QUer['Sample'];
        end;

      OpenQr('Select * From Classif where Anal='+IntToStr(QUer['AnId']),DM1.q1Time);

        while not DM1.q1Time.EOF do begin
          DCol := FindDiagr(DM1.q1Time['Diagr']);
          if Dcol = 0 then begin
            DIDs[DidsCount] := DM1.q1Time['Diagr'];
            Inc(DIDsCount);
            SG1.ColCount := SG1.ColCount + 1;
            SG1.ColWidths[SG1.ColCount-1] := 80;
            if DM1.TbDiagrId.Locate('Id',DIDs[DidsCount - 1],[]) then
              SG1.Cells[SG1.ColCount - 1, 0] := DM1.TbDiagrId['Name'];
            DCol := DIDsCount + 1;
          end;
          SG1.Cells[DCol, i] := DM1.q1Time['Class'];
          DM1.q1Time.Next;
        end;
        Inc(i);
        Next;
      end;
    end;
  finally
        if Sg1.ColCount>1 then
    Sg1.FixedCols := 1;
    SG1.FixedRows := 1;
    Sg1.Visible := true;
    {Quer.EnableControls;}
    Sg1.SetFocus;
  end;
  finally
    DM1.TbDiagr.EnableControls;
    end;
  if DIDsCount = 0 then begin
    ShowMessage(stNotRes);
    Close;
    Exit;
  end;
  if GID in UsedFields then begin
  Sg1.ColCount := Sg1.ColCount + 1;
  SG1.ColWidths[Sg1.ColCount - 1] := 80;
  SG1.Cells[Sg1.ColCount - 1, 0] := GeolIdTit;
  end;
  if ROC in UsedFields then begin
   Sg1.ColCount := Sg1.ColCount + 1;
  SG1.ColWidths[Sg1.ColCount - 1] := 80;
  SG1.Cells[Sg1.ColCount - 1, 0] := RockTit;
  end;
  if RGN in UsedFields then begin
   Sg1.ColCount := Sg1.ColCount + 1;
  SG1.ColWidths[Sg1.ColCount - 1] := 80;
  SG1.Cells[Sg1.ColCount - 1, 0] := RegionTit;
   end;
   if GBD in UsedFields then begin
   Sg1.ColCount := Sg1.ColCount + 1;
  SG1.ColWidths[Sg1.ColCount - 1] := 80;
  SG1.Cells[Sg1.ColCount - 1, 0] := GBodytit;
   end;
   Sg1.ColCount := Sg1.ColCount + 1;
  SG1.Cells[Sg1.ColCount - 1, 0] := stAnDes;
  SG1.ColWidths[Sg1.ColCount - 1] := 360;
  with Quer do begin
    try
      DisableControls;
      first;
      i := 1;
      while not EOF do begin
      j:=Sg1.ColCount - 1;
        SG1.Cells[j, i] := Quer['Descript'];
        if GBD in UsedFields then begin
        Dec(j);
        SG1.Cells[j, i] := DM1.GBodies.LookUp('ID', Quer['GBody'], 'GBody');
        end;
        if RGN in UsedFields then begin
        Dec(j);
        SG1.Cells[j, i] := DM1.Regions.LookUp('ID', Quer['Region'], 'Region');
        end;
        if ROC in UsedFields then begin
        Dec(j);
        SG1.Cells[j, i] := DM1.Rocks.LookUp('ID', Quer['Rock'], 'Rock');
        end;
        if GID in UsedFields then begin
        Dec(j);
        SG1.Cells[j, i] := DM1.GeolIds.LookUp('ID', Quer['GeolId'], 'GeolId');
        end;

        Inc(I);
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
end;

function TFClass.findDiagr(ID: integer): integer;
var i: integer;
begin
  Result := 0;
  for i := 0 to DidsCount - 1 do
         {if DIDs[i]=0 then break
         else } if DIDs[i] = ID then begin
    Result := i +1;
    if SID in UsedFields then
      Result := Result+1;
      break;
    end;
end;

procedure TFClass.SaveFileExecute(Sender: TObject);
begin
  if ExpToTextForm.DefExport(nil,Sg1,False) then
        ExpToTextForm.ExpStringGrid(SG1);
end;

procedure TFClass.SG1DblClick(Sender: TObject);
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

procedure TFClass.ExcExpExecute(Sender: TObject);
begin
  if (Quer.RecNo > 0) then 
   ExcF.ExportSGToExc(SG1, Caption);
end;

procedure TFClass.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.

