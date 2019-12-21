unit wait;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TWForm = class(TForm)
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WForm: TWForm;

implementation

{$R *.DFM}

procedure TWForm.FormShow(Sender: TObject);
begin
     Label1.Visible:=True;
     Screen.Cursor:=crHourGlass;
end;

procedure TWForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Screen.Cursor:=crDefault;
end;

end.
