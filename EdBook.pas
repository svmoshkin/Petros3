unit EdBook;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Hintctrl, Buttons, ExtCtrls,Db, Variants;

type
  TEdBookForm = class(TForm)
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBNavigator1: TDBNavigator;
    BitBtn4: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ESourceN: THDBEdit;
    ESourceA: THDBEdit;
    DBEdit4: THDBEdit;
    DBEdit5: THDBEdit;
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   procedure TabEdBookAfterCancel(DataSet: TDataSet);
   procedure TabEdBookBeforePost(DataSet: TDataSet);
  end;

var
  EdBookForm: TEdBookForm;

implementation

uses DMod1, RHAGlobs;

{$R *.DFM}

procedure TEdBookForm.BitBtn4Click(Sender: TObject);
begin
      DM1.TabEdBook.Insert;
      ESourceN.SetFocus;
      ESourceN.ReadOnly := false;
      ESourceA.ReadOnly := false;
      DBEdit4.ReadOnly := false;
      DBEdit5.ReadOnly := false;
end;

procedure TEdBookForm.TabEdBookAfterCancel(DataSet: TDataSet);
begin
     ESourceN.ReadOnly := true;
  ESourceA.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  DBEdit5.ReadOnly := true;
end;

procedure TEdBookForm.FormShow(Sender: TObject);
begin
     BookEdits:=Self;
end;

procedure TEdBookForm.TabEdBookBeforePost(DataSet: TDataSet);
begin
     if (DataSet.State = dsInsert) and (DataSet.Lookup('Num',DataSet['Num'],'Id')<>Null)
    then begin
    ShowMessage(stDoubleSourceNumber);
    ESourceN.SetFocus;
    Abort;
  end;
  ESourceN.ReadOnly := true;
  ESourceA.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  DBEdit5.ReadOnly := true;
end;

procedure TEdBookForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
