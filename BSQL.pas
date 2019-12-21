unit BSQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,  checklst, Analise, DMod1, Grids, DBGrids,
  RXDBCtrl, Db, ADODB, StrHlder,BBrowse, NumInp;

type
  TBiblSQL = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    EAuthor: TEdit;
    ETitle: TEdit;
    EBibl: TEdit;
    GroupBox4: TGroupBox;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BOr: TButton;
    BAnd: TButton;
    Memo1: TMemo;
    Add1: TButton;
    Add2: TButton;
    Add3: TButton;
    Add4: TButton;
    SQL0: TStrHolder;
    Button1: TButton;
    EN1: TNumInp;
    EN2: TNumInp;
    NameGrid: TDBGrid;
    BitBtn3: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure Add2Click(Sender: TObject);
    procedure Add3Click(Sender: TObject);
    procedure BOrClick(Sender: TObject);
    procedure BAndClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Add4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure DisButtons;
    Procedure EnabButtons;
  public
    { Public declarations }
  end;

var
  BiblSQL: TBiblSQL;

implementation

uses Main, RHAGlobs,Biblio, ADOUtilsS;

{$R *.DFM}

procedure TBiblSQL.FormShow(Sender: TObject);
var i: integer;
begin
     Memo1.Lines.Assign(SQL0.Strings);
     EnabButtons;
     DM1.TabM1.First;
end;

procedure TBiblSQL.BitBtn1Click(Sender: TObject);
begin
     If Memo1.Lines.Count>7 then begin
     if books.Table1.IndexFieldNames<>'Author' then
        Memo1.Lines[Memo1.Lines.Count-1]:=' SOURCE.Num';
       BiblBrouse.Query1.Close;
       BiblBrouse.Query1.SQL.Assign(Memo1.Lines);
       BiblBrouse.Query1.Open;
     end else
      OpenQr('SELECT Id , Num ,Author, Title , Bibl FROM SOURCE ORDER BY Author',BiblBrouse.Query1);
     BiblBrouse.ShowModal;
end;

procedure TBiblSQL.Add1Click(Sender: TObject);
begin
     if EAuthor.Text<>'' then begin
     Memo1.Lines.Insert(Memo1.Lines.Count-3,'(Source.Author LIKE ''%'+
            EAuthor.Text+'%'')');
     EAuthor.Text:='';
     DisButtons;
     end
end;

procedure TBiblSQL.Add2Click(Sender: TObject);
begin
     if ETitle.Text<>'' then begin
     Memo1.Lines.Insert(Memo1.Lines.Count-3,'(Source.Title LIKE ''%'+
            ETitle.Text+'%'')');
     ETitle.Text:='';
     DisButtons;
     end;
end;

procedure TBiblSQL.DisButtons;
begin
     Add1.Enabled:=false;
     Add2.Enabled:=false;
     Add3.Enabled:=false;
     Add4.Enabled:=false;
     BOr.Enabled:=true;
     BAnd.Enabled:=true;
end;


Procedure TBiblSQL.EnabButtons;
begin
     Add1.Enabled:=True;
     Add2.Enabled:=True;
     Add3.Enabled:=True;
     Add4.Enabled:=True;
     BOr.Enabled:=false;
     BAnd.Enabled:=false;
end;


procedure TBiblSQL.Add3Click(Sender: TObject);
begin
     if EBibl.Text<>'' then begin
     Memo1.Lines.Insert(Memo1.Lines.Count-3,'(Source.Bibl LIKE ''%'+
            EBibl.Text+'%'')');
     EBibl.Text:='';
     DisButtons;
     end;
end;

procedure TBiblSQL.BOrClick(Sender: TObject);
begin
     Memo1.Lines.Insert(Memo1.Lines.Count-3,')OR(');
     EnabButtons;
end;

procedure TBiblSQL.BAndClick(Sender: TObject);
begin
     Memo1.Lines.Insert(Memo1.Lines.Count-3,')AND(');
     EnabButtons;
end;

procedure TBiblSQL.Button1Click(Sender: TObject);
Var S : String[255];
begin
      if Memo1.Lines.Count>7 then begin
         S:=Memo1.Lines[Memo1.Lines.Count-4];
         if s[1]='(' then EnabButtons
         else  DisButtons;
         Memo1.Lines.Delete(Memo1.Lines.Count-4);
     end;
end;

procedure TBiblSQL.Button7Click(Sender: TObject);
begin
     Memo1.Lines.Insert(Memo1.Lines.Count-3,'(Source.Num >= '+
            EN1.Text+')');
     EN1.Text:='0';
     DisButtons;
end;

procedure TBiblSQL.Button8Click(Sender: TObject);
begin
          Memo1.Lines.Insert(Memo1.Lines.Count-3,'(Source.Num <= '+
            EN1.Text+')');
     EN1.Text:='0';
     DisButtons;
end;

procedure TBiblSQL.Button9Click(Sender: TObject);
begin
          Memo1.Lines.Insert(Memo1.Lines.Count-3,'(Source.Num = '+
            EN1.Text+')');
     EN1.Text:='0';
     DisButtons;
end;

procedure TBiblSQL.Button10Click(Sender: TObject);
begin
     Memo1.Lines.Insert(Memo1.Lines.Count-3,'(Source.Num >= '+
            EN1.Text+')AND(Source.Num <= '+ EN2.Text+')');
     EN1.Text:='0';
      EN2.Text:='0';
     DisButtons;
end;

procedure TBiblSQL.Add4Click(Sender: TObject);
var S : string;
    i : integer;
begin
     s:= '(Source.Id IN (';
     if NameGrid.SelectedRows.Count>0 then begin
     try
     DM1.TabM1.DisableControls;
        { DataModule1.TabM2.First;
         While notDataModule1.TabM2.Eof do
               if }
        for i:=0 to NameGrid.SelectedRows.Count-1 do begin
            DM1.TabM1.Bookmark:=NameGrid.SelectedRows[i];
            s:=S+IntToStr(DM1.TabM1['Source'])+', ';
        end;
        System.Delete(S,Length(S)-1,2);
        Memo1.Lines.Insert(Memo1.Lines.Count-3,S+'))');
        NameGrid.SelectedRows.Clear;
        DisButtons;
     finally
            DM1.TabM1.First;
            DM1.TabM1.EnableControls;
     end;
     end;
end;

procedure TBiblSQL.BitBtn3Click(Sender: TObject);
begin
     Application.HelpFile := 'PETROS.HLP';
     Application.HelpCommand(HELP_CONTEXT ,150);
end;

procedure TBiblSQL.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
