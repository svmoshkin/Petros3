unit LookUps;

interface

uses
  Windows, Messages, Classes, SysUtils, Graphics, Controls, StdCtrls, Forms,
  Dialogs, DBCtrls, DB, DBGrids, Grids, ExtCtrls, Buttons;

type
  TLookUpForm = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator: TDBNavigator;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }

  end;

var
  LookUpForm: TLookUpForm;

implementation

uses DMod1, RHAGlobs;
       {#ToDo1 Удаление проверка на использование}
{$R *.DFM}

procedure TLookUpForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
