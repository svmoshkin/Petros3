unit EdCoefs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Boxes, Mend_C, Hintctrl, Buttons,ADODB;

type
  TEdKoefForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    HListBox1: THListBox;
    MendTabl1: TMendTabl;
    Bevel1: TBevel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    CheckBox1: TCheckBox;
    ListBox1: TListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn6: TBitBtn;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure HListBox1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Quer : TAdoQuery;
  end;


  TStKoef =class
      formula : string[255];
      Name : string[40];
      Ident : string[10];
      Title : string[10];
      DFormat : String[20];
      AnW : boolean;
      Visible : boolean;
      procedure Save(var F : file);
      constructor Load(var f : file);
  public
    constructor Create;
  end;

  TCoefs = class(TList)
      Names : TStringList;
      Ids : TStringList;
      Constructor Create;
      destructor Destroy; override;
      procedure Save(var F : file);
      procedure Load(var f : file);
      function GetFormula(Name : string) : string;
  published
    function GetIndFromTitle(Title: String): integer;
  end;

var
  EdKoefForm: TEdKoefForm;
  Coefs: TCoefs;

function ExpandSym(S : string) : string;

implementation

uses Koeff, RHAGlobs;

{$R *.DFM}



{ TStKoef }

constructor TStKoef.Create;
begin
     Inherited Create;
     DFormat:='###0.###';
end;

constructor TStKoef.Load(var f: file);
begin
     Inherited Create;
     BlockRead(F,Formula,SizeOf(Formula));
     BlockRead(F,Name,SizeOf(Name));
     BlockRead(F,Ident,SizeOf(Ident));
     BlockRead(F,Title,SizeOf(Title));
     BlockRead(F,AnW,SizeOf(AnW));
     BlockRead(F,Visible,SizeOf(Visible));
     BlockRead(F,DFormat,SizeOf(DFormat));
end;

procedure TStKoef.Save(var F: file);
begin
     BlockWrite(F,Formula,SizeOf(Formula));
     BlockWrite(F,Name,SizeOf(Name));
     BlockWrite(F,Ident,SizeOf(Ident));
     BlockWrite(F,Title,SizeOf(Title));
     BlockWrite(F,AnW,SizeOf(AnW));
     BlockWrite(F,Visible,SizeOf(Visible));
     BlockWrite(F,DFormat,SizeOf(DFormat));
end;

{ TCoefs }

constructor TCoefs.Create;
begin
     Inherited Create;
     IDs:=TStringList.Create;
     Names:=TStringList.Create;
end;

destructor TCoefs.Destroy;
var i : integer;
begin
     IDS.Free;
     Names.Free;
     for i:=Count-1 downto 0 do
         TStKoef(Items[i]).Free;
     Inherited Destroy;
end;

function TCoefs.GetFormula(Name: string): string;
begin
     Result:=TStKoef(Items[IDs.IndexOf(Name)]).Formula;
end;

function TCoefs.GetIndFromTitle(Title: String): integer;
var i : integer;
begin
     Result := -1;
     for i:=0 to Count-1 do 
         if TStKoef(Items[i]).Title=Title then begin
             Result:=i;
             Exit;
         end;
end;

procedure TCoefs.Load(var f: file);
var i, n : integer;
begin
     BlockRead(F,n,SizeOf(Count));
     for i:=0 to n-1 do begin
         Add(TStKoef.Load(F));
         Names.Add(TStKoef(Last).Name);
         IDs.Add(TStKoef(Last).Ident);
     end;
end;

procedure TCoefs.Save(var F: file);
var i : integer;
begin
     BlockWrite(F,Count,SizeOf(Count));
     for i:=0 to Count-1 do
         TStKoef(Items[i]).Save(F);
end;

procedure TEdKoefForm.FormCreate(Sender: TObject);
var F : file;
begin
     if FileExists('Koef.rhi') then begin
        AssignFile(F,'Koef.rhi');
        Reset(F,1);
        Coefs.Load(F);
        CloseFile(F);
        HListBox1.Items.Assign(Coefs.Names);
        ListBox1.Items.Assign(Coefs.IDs);
     end;
     SpeedButton1.Enabled:=false;
     SpeedButton2.Enabled:=false;
end;

procedure TEdKoefForm.BitBtn2Click(Sender: TObject);
var     i : integer;
begin
     if (MendTabl1.Text<>'')and(Edit1.Text<>'')and(Edit2.Text<>'')
     and(Edit3.Text<>'')and(Edit4.Text<>'') then begin
        for i:=0 to Coefs.Count-1 do
            if (TSTKoef(Coefs.Items[i]).Name=Edit1.Text)or
            (TSTKoef(Coefs.Items[i]).Ident=Edit2.Text) then begin
            ShowMessage('Название или идентификатор добавляемого коэффициента '+
            'совпадает с уже существующими. Для редактирования используйте'+
            ' кнопку "Replace".');
            exit;
            end;
            try
               Interprete(MendTabl1.Text,Quer);
            except
        on Exception do begin
          ShowMessage(stFormErr);
            exit;
        end;
        end;
        Coefs.Add(TStkoef.Create);
        TSTKoef(Coefs.Last).ANw:=CheckBox1.Checked;
        TSTKoef(Coefs.Last).Formula:=MendTabl1.Text;
        TSTKoef(Coefs.Last).Ident:=Edit2.Text;
        TSTKoef(Coefs.Last).Name:=Edit1.Text;
        TSTKoef(Coefs.Last).Title:=Edit3.Text;
        TSTKoef(Coefs.Last).DFormat:=Edit4.Text;
        HListBox1.Items.Add(TStKoef(Coefs.Last).Name);
        ListBox1.Items.Add(Edit2.Text);
        Coefs.Names.Add(TStKoef(Coefs.Last).Name);
        Coefs.IDs.Add(TStKoef(Coefs.Last).Ident);
        HListBox1.ItemIndex:=HListBox1.Items.Count-1;
     end else
         ShowMessage('Все поля должны быть заполнены!');
end;

procedure TEdKoefForm.BitBtn1Click(Sender: TObject);
var f: file;
begin
      AssignFile(F,'Koef.rhi');
        Rewrite(F,1);
        Coefs.Save(F);
      CloseFile(F);
end;

procedure TEdKoefForm.BitBtn3Click(Sender: TObject);
var i : integer;
begin
     if (MendTabl1.Text<>'')and(Edit1.Text<>'')and(Edit2.Text<>'')
     and(Edit3.Text<>'')and(Edit4.Text<>'') then begin
          try
               Interprete(MendTabl1.Text,Quer);
            except
        on Exception do begin
          ShowMessage('Ошибка в записи формулы');
            exit;
        end;
        end;
     i:=HListBox1.ItemIndex;
        TSTKoef(Coefs.Items[i]).ANw:=CheckBox1.Checked;
        TSTKoef(Coefs.Items[i]).Formula:=MendTabl1.Text;
        TSTKoef(Coefs.Items[i]).Ident:=Edit2.Text;
        TSTKoef(Coefs.Items[i]).Name:=Edit1.Text;
        TSTKoef(Coefs.Items[i]).Title:=Edit3.Text;
        TSTKoef(Coefs.Items[i]).DFormat:=Edit4.Text;
        HListBox1.Items[i]:=TStKoef(Coefs.Items[i]).Name;
        ListBox1.Items[i]:=Edit2.Text;
        Coefs.Names[i]:=(TStKoef(Coefs.Items[i]).Name);
        Coefs.IDs[i]:=(TStKoef(Coefs.Items[i]).Ident);
         end else
         ShowMessage('Все поля должны быть заполнены!');

end;

procedure TEdKoefForm.HListBox1Click(Sender: TObject);
var i : integer;
begin
     i:=HListBox1.ItemIndex;
        CheckBox1.Checked:=TSTKoef(Coefs.Items[i]).ANw;
        MendTabl1.Text:=TSTKoef(Coefs.Items[i]).Formula;
        Edit2.Text:=TSTKoef(Coefs.Items[i]).Ident;
        Edit1.Text:=TSTKoef(Coefs.Items[i]).Name;
        Edit3.Text:=TSTKoef(Coefs.Items[i]).Title;
        Edit4.Text:=TSTKoef(Coefs.Items[i]).DFormat;
        if i=0 then SpeedButton1.Enabled:=false
        else  SpeedButton1.Enabled:=true;
        if i=HListBox1.Items.Count-1 then SpeedButton2.Enabled:=false
        else  SpeedButton2.Enabled:=true;
end;

procedure TEdKoefForm.ListBox1Click(Sender: TObject);
begin
     MendTabl1.InsertText(ListBox1.Items[ListBox1.ItemIndex]+'@');
end;

procedure TEdKoefForm.BitBtn5Click(Sender: TObject);
var i : integer;
begin
     i:=HListBox1.ItemIndex;
     TSTKoef(Coefs.Items[i]).Free;
     Coefs.Delete(i);
        HListBox1.Items.Delete(i);
        ListBox1.Items.Delete(i);
        Coefs.Names.Delete(i);
        Coefs.IDs.Delete(i);
        MendTabl1.Text:='';
        Edit1.Text:='';
        Edit2.Text:='';
        Edit3.Text:='';
        Edit4.Text:='###0.###';
end;

procedure TEdKoefForm.BitBtn6Click(Sender: TObject);
begin
     Coefs.Free;
     HlistBox1.Items.Clear;
     ListBox1.Items.Clear;
     Coefs:=TCoefs.Create;
     FormCreate(Sender);
end;

procedure TEdKoefForm.SpeedButton1Click(Sender: TObject);
begin
     Coefs.Exchange(HlistBox1.ItemIndex,HlistBox1.ItemIndex-1);
     Coefs.Names.Exchange(HlistBox1.ItemIndex,HlistBox1.ItemIndex-1);
     Coefs.Ids.Exchange(HlistBox1.ItemIndex,HlistBox1.ItemIndex-1);
     HListbox1.Items.Exchange(HlistBox1.ItemIndex,HlistBox1.ItemIndex-1);
     HlistBox1.ItemIndex:=HlistBox1.ItemIndex-1;
end;

procedure TEdKoefForm.SpeedButton2Click(Sender: TObject);
begin
     Coefs.Exchange(HlistBox1.ItemIndex,HlistBox1.ItemIndex+1);
     Coefs.Names.Exchange(HlistBox1.ItemIndex,HlistBox1.ItemIndex+1);
     Coefs.Ids.Exchange(HlistBox1.ItemIndex,HlistBox1.ItemIndex+1);
     HListbox1.Items.Exchange(HlistBox1.ItemIndex,HlistBox1.ItemIndex+1);
     HlistBox1.ItemIndex:=HlistBox1.ItemIndex+1;
end;

procedure TEdKoefForm.FormShow(Sender: TObject);
begin
     if HListBox1.ItemIndex>=0 then
     HlistBox1Click(Sender);
end;


function ExpandSym(S : string) : string;
var R,Sym : String;
    i,P,j : integer;
begin
     R:=s;
     P:=Pos('@',R);
     while p>0 do
     begin
          Sym:='';
          for i:=p-1 downto 0 do
              if (i=0)or(R[i]in['-','+','/','*','(']) then break
              else Sym:=R[i]+Sym;
          System.Delete(R,I+1,p-i);
          for j:=0 to Coefs.Count-1 do
              if Coefs.Ids[j]=Sym then begin
                 System.Insert(TStKoef(Coefs.Items[j]).Formula,R,i+1);
                 break;
              end;
          P:=Pos('@',R);
     end;
     Result:=R
end;

procedure TEdKoefForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

procedure TEdKoefForm.BitBtn4Click(Sender: TObject);
begin
     Application.HelpContext(CurHelpContext);
end;

initialization

              Coefs:=TCoefs.Create;

finalization

            Coefs.Free;
end.
