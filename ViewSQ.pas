unit ViewSQ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,ADODB;

type
  TSQView = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    BitBtn3: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Sq : TAdoQuery;
  end;

var
  SQView: TSQView;


implementation

uses RHAGlobs;

{$R *.DFM}

procedure TSQView.FormShow(Sender: TObject);
begin
     Memo1.ReadOnly:=True;
     Memo1.Clear;
     Memo1.Lines.Assign(SQ.SQL);
     Memo1.Modified:=False;
end;

procedure TSQView.BitBtn2Click(Sender: TObject);
begin
     Memo1.ReadOnly:=False;
     Memo1.Modified:=True;
end;

procedure TSQView.BitBtn3Click(Sender: TObject);
begin
     if Memo1.Modified then begin
        SQ.Close;
        Sq.SQL.Clear;
        SQ.SQL.Assign(Memo1.Lines);
        SQ.Open;
        Memo1.Modified:=False;
     end;
end;

procedure TSQView.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
