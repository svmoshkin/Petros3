unit SelPoint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ComCtrls, StdCtrls, Buttons,  Explor, ExtCtrls, Variants,
  ADODB;

type
  TSelForm = class(TForm)
    ListView1: TListView;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Query1: TADOQuery;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    {ANList: TList;}
    { Public declarations }
  end;

var
  SelForm: TSelForm;

implementation

uses TaskSQL, DMod1, RHAGlobs;

{$R *.DFM}

procedure TSelForm.BitBtn2Click(Sender: TObject);
begin
     Close;
end;

procedure TSelForm.FormShow(Sender: TObject);
var T : TListItem;
    {I : integer;
    P : TClassPoint;}
begin
     
      try
      ListView1.Items.BeginUpdate;
      ListView1.Items.Clear;
        {Query1.DisableControls;}
        Query1.First;
        while not Query1.Eof do begin
            T:=ListView1.Items.Add;
            T.Caption:=Query1['Descript'];
            if Query1['Sample']<>Null then
            T.SubItems.Add(Query1['Sample'])
            else T.SubItems.Add('');
            T.SubItems.Add(IntToStr(Query1['AnId']));
            Query1.Next;
        end;
     
      finally
        ListView1.Items.EndUpdate;
      end;
end;

procedure TSelForm.FormCreate(Sender: TObject);
begin
    { ANList:=TList.Create;}
end;

procedure TSelForm.FormDestroy(Sender: TObject);
begin
     {ANList.Free;}
end;

procedure TSelForm.FormClose(Sender: TObject; var Action: TCloseAction);
{var i : integer;}
begin
     {for i:=AnList.Count-1 downto 0 do
         TClassPoint(ANList.Items[i]).Free;
     ANList.Clear;}
end;

procedure TSelForm.BitBtn1Click(Sender: TObject);
var i,Fir : integer;
    S:String;
begin
     if ListView1.SelCount>0 then begin
        Fir:=ListView1.Selected.Index;
        S:='(AnId in ('+ListView1.Items[fir].Subitems[1];
        if ListView1.SelCount>1 then
        for i:=Fir+1 to ListView1.Items.Count-1 do
            if ListView1.Items[i].Selected then
               S:=S+','+ListView1.Items[i].Subitems[1];
        S:=S+'))';
        TaskSQLForm.FormShow(TaskSQLForm.Button8);
        TaskSQLForm.Memo1.Lines.Insert(TaskSQLForm.Memo1.Lines.Count-1,S);
     end;
     Close;
end;

procedure TSelForm.BitBtn3Click(Sender: TObject);
var i : integer;
begin
     For i:=0 to ListView1.Items.Count-1 do
         ListView1.Items[i].Selected:=true;
     ListView1.SetFocus;
end;

procedure TSelForm.Button1Click(Sender: TObject);
var i : integer;
begin
     For i:=0 to ListView1.Items.Count-1 do
         ListView1.Items[i].Selected:=false;
     ListView1.SetFocus;
end;

procedure TSelForm.Button2Click(Sender: TObject);
var i : integer;
begin
     For i:=0 to ListView1.Items.Count-1 do
         ListView1.Items[i].Selected:=not ListView1.Items[i].Selected;
     ListView1.SetFocus;
end;

procedure TSelForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
