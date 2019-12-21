unit DeletDescr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TDeletDial = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LRock : TStringList;
    LGeolId : TStringList;
    LRegion : TStringList;
    LGBody : TStringList;
  end;

var
  DeletDial: TDeletDial;

implementation

uses DMod1, RHAGlobs;

{$R *.DFM}

procedure TDeletDial.FormDestroy(Sender: TObject);
var i : integer;
begin
     for i:=0 to LRock.Count-1 do
         LRock.Objects[i].Free;
     LRock.Free;
     for i:=0 to LGeolId.Count-1 do
         LGeolId.Objects[i].Free;
    LGeolId.Free;
    for i:=0 to LRegion.Count-1 do
         LRegion.Objects[i].Free;
    LRegion.Free;
    for i:=0 to LGBody.Count-1 do
         LGBody.Objects[i].Free;
    LGBody.Free;
end;

procedure TDeletDial.FormCreate(Sender: TObject);
begin
      LRock:=TStringList.Create;
    LGeolId:=TStringList.Create;
    LRegion:=TStringList.Create;
    LGBody:=TStringList.Create;
    with DM1 do begin
    Rocks.Active:=True;
       with Rocks do begin
            First;
            while not Eof do begin
                LRock.Add(Rocks['Rock']);
                LRock.Objects[LRock.Count-1]:=TInt.Create(Rocks['Id']);
                Next;
            end;
       end;
       with Regions do begin
       Active:=True;
            First;
            while not Eof do begin
                LRegion.Add(Regions['Region']);
                LRegion.Objects[LRegion.Count-1]:=TInt.Create(Regions['Id']);
                Next;
            end;
       end;
       with GBodies do begin
       Active:=True;
            First;
            while not Eof do begin
                LGBody.Add(GBodies['GBody']);
                LGBody.Objects[LGBody.Count-1]:=TInt.Create(GBodies['Id']);
                Next;
            end;
       end;
       with GeolIds do begin
       Active:=True;
            First;
            while not Eof do begin
                LGeolId.Add(GeolIds['GeolId']);
                LGeolId.Objects[LGeolId.Count-1]:=TInt.Create(GeolIds['Id']);
                Next;
            end;
       end;
    end;
end;

procedure TDeletDial.FormShow(Sender: TObject);
begin
     ListBox1.ItemIndex:=0;
     BitBtn1.Enabled:=True;
end;

procedure TDeletDial.ListBox1Click(Sender: TObject);
begin
     BitBtn1.Enabled:=ListBox1.Items[ListBox1.ItemIndex]<>Label2.Caption;
end;

procedure TDeletDial.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
