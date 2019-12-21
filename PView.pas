unit PView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, ExtCtrls;

type
  TfPView = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    DataSource1: TDataSource;
    Query1: TADOQuery;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPView: TfPView;

implementation

uses DMod1;

{$R *.dfm}

procedure TfPView.FormShow(Sender: TObject);
begin
     Label1.Caption:=IntToStr(Query1.RecordCount)+'  records in query';
end;

end.
