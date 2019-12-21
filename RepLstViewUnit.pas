unit RepLstViewUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, QuickRpt, SGridPrint, MButton, FormStylist;

type
  TRepLstViewFrm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ListBox1: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TMButton;
    BitBtn2: TMButton;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RepLstViewFrm: TRepLstViewFrm;

  resourcestring
                stTit='Report title';

implementation

//uses {SimpGrid, PreviewUnit} SGridPrint;
{$R *.DFM}

procedure TRepLstViewFrm.FormShow(Sender: TObject);
var i: integer;
begin
  label1.Caption := label1.Caption + ':    '+fQRep.HEdit1.Text;
  with ListBox1 do begin
    Clear;
    for i := 0 to fQRep.RepList.Count-1 do
     ListBox1.Items.Add(fQRep.RepList.Strings[i]);
     ItemIndex := 0;
  end;
end;

procedure TRepLstViewFrm.BitBtn1Click(Sender: TObject);
begin
 Screen.Cursor := crHourglass;
  if ListBox1.ItemIndex = -1 then exit
  else begin
    with TQuickRep(fQRep.RepList.Objects[ListBox1.ItemIndex]) do
      begin
        Top := 0;
        Left := 0;
        ReportTitle := fQRep.RepList.Strings[ListBox1.ItemIndex];
        Screen.Cursor := crDefault;
       { fPreview.QRPreview1.PageNumber := 1;}
        Preview;
        {PreviewModal;
        fPreview.ShowModal; }
      end;
  end;
end;

procedure TRepLstViewFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  label1.Caption := stTit;
end;

end.
