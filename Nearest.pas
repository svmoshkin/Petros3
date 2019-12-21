unit Nearest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, JvgStringGrid, StdCtrls, ExtCtrls, Distance, Menus,
  ADOUtilsS, RHAGlobs;

type
  TfNearest = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    SG1: TStringGrid;
    MainMenu1: TMainMenu;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    ExporttoEXCEL1: TMenuItem;

    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SaveToFile1Click(Sender: TObject);
    procedure ExporttoEXCEL1Click(Sender: TObject);
    procedure SG1DblClick(Sender: TObject);
    procedure SG1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    Acl, Arw: integer;
  public
    { Public declarations }
    fDist: TfDistance;
    NAnal: integer;
    procedure Calc;
  end;



var
  fNearest: TfNearest;

implementation

uses TxtImpExp, ExcelExp, Main, ListBrows, DMod1, AnData;



{$R *.dfm}

procedure TfNearest.Calc;
var i, j, k: integer;
  Mins, Maxs: array[0..4] of integer;
  procedure Shift(var m: array of integer; St: integer);
  var i: integer;
  begin
    for i := 4 downto St + 1 do
      m[i] := M[i - 1];
  end;
begin
  SG1.RowCount := NAnal + 1;
  for i := 1 to NAnal do begin
    for k := 0 to 4 do begin
      Mins[k] := -1;
      Maxs[k] := -1;
    end;
    for j := 1 to NAnal do
      if i <> j then begin
        for k := 0 to 4 do
          if (Maxs[k] < 0) or (StrToFloat(fDist.SG1.Cells[i, j]) >
            StrToFloat(fDist.SG1.Cells[i, Maxs[k]])) then begin
            Shift(Maxs, k);
            Maxs[k] := j;
            break;
          end;
        for k := 0 to 4 do
          if (Mins[k] < 0) or (StrToFloat(fDist.SG1.Cells[i, j]) <
            StrToFloat(fDist.SG1.Cells[i, Mins[k]])) then begin
            Shift(Mins, k);
            Mins[k] := j;
            break;
          end;
      end;
    SG1.Cells[0, i] := fDist.SG1.Cells[0, i];
    SG1.Cols[0].Objects[i] := fDist.SG1.Rows[i].Objects[0];
    for k := 0 to 4 do begin
      if Maxs[k] >= 0 then begin
        SG1.Cells[K + 1, i] := fDist.SG1.Cells[0, Mins[k]] + ' (' + fDist.SG1.Cells[i, Mins[k]] + ')';
        SG1.Cols[K + 1].Objects[i] := fDist.SG1.Rows[Mins[k]].Objects[0];
      end else
        SG1.Cols[K + 1].Objects[i] := Pointer(0);
      if Mins[k] >= 0 then begin
        SG1.Cells[K + 6, i] := fDist.SG1.Cells[0, Maxs[k]] + ' (' + fDist.SG1.Cells[i, Maxs[k]] + ')';
        SG1.Cols[K + 6].Objects[i] := fDist.SG1.Rows[Maxs[k]].Objects[0];
      end else
        SG1.Cols[K + 6].Objects[i] := Pointer(0);
    end;
  end;
end;

procedure TfNearest.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfNearest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfNearest.FormShow(Sender: TObject);
begin
  SG1.ColWidths[0] := 64;
  SG1.Cells[0, 0] := 'Sample';
  Sg1.Cells[1, 0] := 'Near.1';
  Sg1.Cells[2, 0] := 'Near.2';
  Sg1.Cells[3, 0] := 'Near.3';
  Sg1.Cells[4, 0] := 'Near.4';
  Sg1.Cells[5, 0] := 'Near.5';
  Sg1.Cells[6, 0] := 'Far.1';
  Sg1.Cells[7, 0] := 'Far.2';
  Sg1.Cells[8, 0] := 'Far.3';
  Sg1.Cells[9, 0] := 'Far.4';
  Sg1.Cells[10, 0] := 'Far.5';
end;

procedure TfNearest.SaveToFile1Click(Sender: TObject);
begin
  if ExpToTextForm.DefExport(nil, Sg1, False) then
    ExpToTextForm.ExpStringGrid(SG1);
end;

procedure TfNearest.ExporttoEXCEL1Click(Sender: TObject);
begin
  ExcF.ExportSGToExc(SG1, Caption);
end;

procedure TfNearest.SG1DblClick(Sender: TObject);
var i: integer;
begin
  if Arw > 0 then begin
    i := Integer(SG1.Cols[Acl].Objects[Arw]);
    if I > 0 then begin
      if MainForm.Cadd.Checked then begin
        if OpenQr('Select Sample from RHADATA where AnID=' + IntToStr(I), DM1.q1Time) then
          AddToList(DM1.q1Time['Sample']);
      end else begin
        CurID := i;
        TAnalForm.Create(MainForm);
      end;
    end;
  end;
end;

procedure TfNearest.SG1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    SG1.MouseToCell(X, Y, Acl, Arw);
end;

end.

