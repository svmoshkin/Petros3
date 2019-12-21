unit ImpAlphabet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, Buttons, OleServer, Excel2000;

type
  TfImpAlpha = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    Label2: TLabel;
    ExcApp: TExcelApplication;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    LCID: integer;
  end;

var
  fImpAlpha: TfImpAlpha;

implementation

uses ADOUtilsS, DMod1;

{$R *.dfm}

procedure TfImpAlpha.BitBtn1Click(Sender: TObject);
var i, j, Num: integer;
  S: string;
  Sl, Sell: ExcelRange;
begin
  Sl := ExcelRange(ExcApp.Selection[0]);
  Sell := ExcApp.Range[Sl.Cells.Item[1, 1], Sl.Cells.Item[Sl.Rows.Count, Sl.Columns.Count]];
  if Sell.Rows.Count * Sell.Columns.Count = 0 then begin
    ShowMessage('Select data in excel table!');
    exit;
  end;
  if Radiogroup1.ItemIndex = 0 then begin
    if Sell.Rows.Count > 1 then begin
      ShowMessage('You must select only 1 row!');
      exit;
    end;
    j := Sell.Columns.Count;
  end else begin
    if Sell.Columns.Count > 1 then begin
      ShowMessage('You must select only 1 column!');
      exit;
    end;
    j := Sell.Rows.Count;
  end;
  for i := 1 to j do begin
    if Radiogroup1.ItemIndex = 0 then
      S := Sell.Cells.Item[1, i]
    else
      S := Sell.Cells.Item[i, 1];
    if (S <> '') and
      not OpenQr('Select * from Elements where Elem=''' + S + ''' and Num>100*' +
      IntToStr(SpinEdit1.Value) + ' and Num<=100*' + IntToStr(SpinEdit1.Value+1), DM1.q1Time) then begin
      if not OpenQr('Select * from Elements  where  Num=' + IntToStr(100*SpinEdit1.Value+1) , DM1.q1Time) then begin
          DM1.tabElem.Insert;
        DM1.tabElem['Elem'] := S;
        DM1.tabElem['Num'] := 100*SpinEdit1.Value+1;
        DM1.tabElem.Post;
      end else
      if OpenQr('Select top 1 Num+1 as N from Elements e1 where  Num>=100*' +
        IntToStr(SpinEdit1.Value) + ' and Num<100*' + IntToStr(SpinEdit1.Value+1) +
        ' and not exists (Select * from Elements e2 where e2.Num= e1.Num+1)', DM1.q1Time) then begin
        DM1.tabElem.Insert;
        DM1.tabElem['Elem'] := S;
        DM1.tabElem['Num'] := DM1.q1Time['N'];
        DM1.tabElem.Post;
      end else begin
        ShowMessage('Where are not empty positions in alphabet #' + IntToStr(SpinEdit1.Value));
        ModalResult := MrOK;
        exit;
      end;
    end;
  end;
  ModalResult := mrOK;
end;

procedure TfImpAlpha.FormShow(Sender: TObject);
begin
  LCID := 0;
  ExcApp.Connect;
  ExcApp.Visible[LCID] := True;
end;

procedure TfImpAlpha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ExcApp.Disconnect;
end;

end.

