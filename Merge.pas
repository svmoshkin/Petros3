unit Merge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, DB;

type
  TfMerge = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DataSource1: TDataSource;
    Label1: TLabel;
    DBG: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id : integer;
  end;

var
  fMerge: TfMerge;

implementation

uses ADOUtilsS, Analise, ArrayRolls, DMod1;

{$R *.dfm}

procedure TfMerge.FormShow(Sender: TObject);
begin
    Label1.Caption:='Destination dataset: '+DM1.TabM1['ArrayName'];
    Label3.Caption:='Alphabet Num: '+IntToStr(DM1.TabM1['Alfa']);
    Label4.Caption :='Components sequence: '+ DM1.TabM1['Title1'];
    ID:=DM1.TabM1['ID'];
end;

procedure TfMerge.Button2Click(Sender: TObject);
var i,N : integer;
begin
  if   DBG.SelectedRows.Count>0 then begin
    for i:=0 to DBG.SelectedRows.Count-1 do begin
       DM1.qLongTime1.GotoBookmark(TBookMark(DBG.SelectedRows.Items[i]));
       //ShowMessage(DM1.qLongTime1['ArrayName']);
       openQr('select max(Num) as n from RHAData where ArrID='+InttoStr(ID),DM1.q1Time);
       N:= DM1.q1Time['n'];
       ExecQr('Update RHADAta set ArrID='+ InttoStr(ID) + ', Num=Num+'+IntToStr(N)+
       ' where ArrID='+IntToStr(DM1.qLongTime1['ID']),DM1.q1Time);
       ExecQr('Delete from mainRHA where id='+IntToStr(DM1.qLongTime1['ID']),DM1.q1Time);
    end;
      ExecQr('update MainRHA set MaxNum=(select max(Num) from RHAData where ArrID='
      +InttoStr(ID)+'),NAnal=(select Count(*) from RHAData where ArrID='
      +InttoStr(ID)+') where ID='+InttoStr(ID),DM1.q1Time);
      DM1.TabM1.Requery();
    end;
      ModalResult:=mrOK;
end;

end.
