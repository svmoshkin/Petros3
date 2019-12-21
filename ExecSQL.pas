unit ExecSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfExecSQL = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fExecSQL: TfExecSQL;

implementation

uses ADOUtilsS, DMod1;

{$R *.dfm}

procedure TfExecSQL.Button1Click(Sender: TObject);
begin
  try
    screen.Cursor:=crHourGlass;
     ExecQr(Memo1.Text,DM1.q1Time);
     ShowMessage('Executed');
  finally
      Screen.Cursor:=crDefault;
  end;
end;

end.
