unit ChangeClass;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TChangeClForm = class(TForm)
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChangeClForm: TChangeClForm;

implementation

uses RHAGlobs;

{$R *.DFM}

procedure TChangeClForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
