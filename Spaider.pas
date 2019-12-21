unit Spaider;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db,  ExtCtrls, RHAGlobs, MoshChart, Buttons, Menus, ActnList,
  ADODB;

type
  TSPForm = class(TForm)
    GeoChart1: TGeoChart;
    ActionList1: TActionList;
    SaveFile: TAction;
    Preview: TAction;
    Print: TAction;
    SaveClip: TAction;
    SaveDialog1: TSaveDialog;
    MainMenu1: TMainMenu;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    Savetoclippboard1: TMenuItem;
    N1: TMenuItem;
    Preview1: TMenuItem;
    Print1: TMenuItem;
    ASpProp: TAction;
    N2: TMenuItem;
    Chartproperties1: TMenuItem;
    AExcExp: TAction;
    ExporttoEXCEL1: TMenuItem;
    Query1: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SaveFileExecute(Sender: TObject);
    procedure PreviewExecute(Sender: TObject);
    procedure PrintExecute(Sender: TObject);
    procedure SaveClipExecute(Sender: TObject);
    procedure AExcExpExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    AnType : TDatType;
    HaveDev: Boolean;
    ElNums: array[0..MendCount-1] of integer;
    Devider: array[0..MendCount-1] of real;
    procedure RefreshSql;
    procedure MakeSeries;
    function MakeLabels: boolean;
  end;

var
  SPForm: TSPForm;

resourcestring
  stTit = 'Spider diagram ';

implementation

uses Chemist, Devid, DMod1, ExcelExp;

{$R *.DFM}

procedure TSPForm.FormCreate(Sender: TObject);
var i, j, k: integer;
  {s: string;}
  R : Double;
begin
  Query1.SQL.Assign(SelQuery.SQL);
  Application.ProcessMessages;
  AnType:=TDatType(DevForm.RadioGroup1.ItemIndex);
  Geochart1.LeftTitle.Title := '';
  GeoChart1.BottomTitle.Title :='For '+ GetCaptionStr(AnType);
  for i := 0 to MendCount-1 do
    Devider[i] := 1;
  if (DevForm.ListBox1.ItemIndex > 0) and  DM1.GetAnal(DevI[DevForm.ListBox1.ItemIndex - 1])
     then begin
     MendTab.AlfaN:=DM1.qAnal.FieldByName('Alfa').AsInteger;
    k := 0;
    GeoChart1.SPLabelsValues.Clear;
    GeoChart1.BeginUpdate;
    for i := 1 to MendCount do begin
      if (DevForm.ElLB.Items.Count > 0) then
        j := TElemSeq(DevForm.OrdLB.Items.Objects[DevForm.OrdLB.ItemIndex]).Order[i]
      else
           j := i;
      {s := 'A' + IntToStr(j);}
      if ((DevForm.ElLB.Items.Count = 0) or DevForm.ElLB.Checked[i - 1])
        and CanPresent(j,AnType,0) then  begin
          R:=GetDataValue(DM1.qAnal,j,AnType,0);
        if R<>0 then begin
        GeoChart1.SPLabelsValues.Add( GetDataTitle(j,AnType,0));
        ElNums[j - 1] := k;
        Inc(K);
        end;
        Devider[j - 1] := R;
      end else Devider[j - 1] := 0;
    end;
    HaveDev := True;
    Geochart1.Axises[1].Logarithmic := True;
    Caption := stTit + SelSQLName + ' : ' + DM1.qAnal['Descript'];
    GeoChart1.SPCount := GeoChart1.SPLabelsValues.Count;
    GeoChart1.Spaid := True;
    GeoChart1.EndUpdate;
  end else begin
    HaveDev := false;
    Geochart1.Axises[1].Logarithmic := false;
    Caption := stTit + SelSQLName;
  end;
  Application.ProcessMessages;
  RefreshSql;
end;

procedure TSPForm.RefreshSql;
begin
  Query1.Close;
  Query1.Open;
  MendTab.AlfaN:=Query1.FieldByName('Alfa').AsInteger;
  MakeLabels;
  GeoChart1.Series.Clear;
  Query1.First;
  while not Query1.Eof do begin
    GeoChart1.Series.Add;
    MakeSeries;
    Query1.Next;
    Application.ProcessMessages;
  end;
end;

procedure TSPForm.MakeSeries;
var i: integer;
  {A: string;}
  R: TRPoint;
begin
  GeoChart1.Series[GeoChart1.Series.Count - 1].Name := Query1['Descript'];
  GeoChart1.BeginUpdate;
  for i := 1 to MendCount do begin
    {A := 'A' + IntToStr(I);}
    if (Devider[i - 1] > 0) and NotNullValue(Query1,i,AnType,0)
      then begin
      R.X := ElNums[i - 1];
      R.Y := GetDataValue(Query1,I,AnType,0) / Devider[i - 1];
      R.Z := 0;
      GeoChart1.Series[GeoChart1.Series.Count - 1].Add(TCPoint.Create(R, '', ''));
    end;
  end;
  GeoChart1.Series[GeoChart1.Series.Count - 1].Kind := stPointLine;
  GeoChart1.Series[GeoChart1.Series.Count - 1].Active := True;
  GeoChart1.EndUpdate;
end;

function TSPForm.MakeLabels: boolean;
var i, j, K: integer;
  A: string;
  exist: array[0..MendCount-1] of Boolean;
begin
  if HaveDev then Exit;
  for i := 0 to MendCount-1 do
    exist[i] := False;
  Query1.First;
  GeoChart1.SPLabelsValues.Clear;
  GeoChart1.BeginUpdate;
  K := 0;
  if DevForm.ElLB.Items.Count > 0 then
    for i := 1 to MendCount do begin
       j := TElemSeq(DevForm.OrdLB.Items.Objects[DevForm.OrdLB.ItemIndex]).Order[i];
      if TElemSeq(DevForm.OrdLB.Items.Objects[DevForm.OrdLB.ItemIndex]).Check[i]
        and CanPresent(j,AnType,0) then begin
        GeoChart1.SPLabelsValues.Add( GetDataTitle(j,AnType,0));
        ElNums[j - 1] := k;
        Inc(K);
      end else Devider[j - 1] := 0;
    end else begin
    while not Query1.Eof do begin
      for i := 1 to MendCount do
      if CanPresent(i,AnType,0) then begin
        if NotNullValue(Query1,i,AnType,0) then
          Exist[i - 1] := True;
      end;
      Query1.Next;
    end;

    for i := 1 to MendCount do
      if Exist[i - 1] then begin
        GeoChart1.SPLabelsValues.Add( GetDataTitle(i,AnType,0));
        ElNums[i - 1] := k;
        Inc(K);
      end;
  end;
  GeoChart1.SPCount := GeoChart1.SPLabelsValues.Count;
  GeoChart1.Spaid := True;
  GeoChart1.EndUpdate;
end;


procedure TSPForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Query1.Close;
end;

procedure TSPForm.SpeedButton1Click(Sender: TObject);
begin
  CurHelpContext := 77;
  GeoChart1.EditProperties;
  CurHelpContext := HelpContext;
end;

procedure TSPForm.SaveFileExecute(Sender: TObject);
begin
  if SaveDialog1.Execute then
    GeoChart1.SaveToEMF(SaveDialog1.FileName);
end;

procedure TSPForm.PreviewExecute(Sender: TObject);
begin
  CurHelpContext := 87;
  Geochart1.PreView;
  CurHelpContext := HelpContext;
end;

procedure TSPForm.PrintExecute(Sender: TObject);
begin
  GeoChart1.Print;
end;

procedure TSPForm.SaveClipExecute(Sender: TObject);
begin
  GeoChart1.CopyToClipboard;
end;

procedure TSPForm.AExcExpExecute(Sender: TObject);
begin
  ExcF.ExportChartToExc(GeoChart1, Caption, False, nil);
end;

procedure TSPForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
  MendTab.AlfaN:=Query1.FieldByName('Alfa').AsInteger;
end;

end.

