unit DistType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, Grids, DBGrids;

type
  TfDistType = class(TForm)
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    Button1: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDistType: TfDistType;

implementation

uses Distance, RHAGlobs;

{$R *.dfm}

procedure TfDistType.RadioGroup1Click(Sender: TObject);
begin
    DBGrid1.Enabled:=RadioGroup1.ItemIndex=1;
end;

procedure TfDistType.FormCreate(Sender: TObject);
begin
     DataSource1.DataSet:=SelQuery;
end;

end.
