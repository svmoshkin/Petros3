unit Color;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, DBTables;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Chemist, DMod1;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var i : Integer;
begin
        DM1.tabElem.Open;
     for i:=1 to MendCount do begin
           DM1.tabElem.Insert;
           DM1.tabElem['Num']:=i;
           DM1.tabElem['Elem']:=MendSym[i];
           DM1.tabElem['Color']:=clBlack;
           DM1.tabElem.Post;
     end;
end;

end.
