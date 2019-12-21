unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ArtLabel, xRegistr;

type
  TAbout1 = class(TForm)
    OKBtn: TButton;
    Bevel1: TBevel;
    Image1: TImage;
    ArtLabel1: TArtLabel;
    Label2: TLabel;
    RegName: TxRegistry;
    RegCom: TxRegistry;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ArtLabel2: TArtLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About1: TAbout1;
  Cap1,Cap2 : string;

implementation

uses RHAGlobs, Registrat;

{$R *.DFM}

procedure TAbout1.FormCreate(Sender: TObject);
begin
    { if registered then begin
     Button1.Visible:=False;
     Label2.Caption:=Label2.Caption+' '+RegName.ReadString;
     Label3.Caption:=Label3.Caption+' '+RegCom.ReadString;
     end else begin
         Cap1:=Label2.Caption;
         Cap2:=Label3.Caption;
        Label2.Caption:='  Unregistered';
        Label3.Caption:='  Trial';
        Button1.Visible:=True;
     end; }
end;

procedure TAbout1.Button1Click(Sender: TObject);
begin
    { RegistrForm:=TRegistrForm.Create(Self);
     RegistrForm.ShowModal;
     RegistrForm.Free;
     if registered then begin
     Button1.Visible:=False;
     Label2.Caption:=Cap1+' '+RegName.ReadString;
     Label3.Caption:=Cap2+' '+RegCom.ReadString;
     end;  }
end;

end.
