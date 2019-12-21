unit StRecalc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Grids, DBGrids, Hintctrl, StdCtrls, ActiveX, ComObj, axctrls,
  EdvShape, Variants;

type
  TRecForm = class(TForm)
    Button1: TButton;
    HDBGrid2: THDBGrid;
    Button2: TButton;
    Button3: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure HDBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure HDBGrid2DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function LoadAlgo(Id: integer;Exc : boolean): boolean;
    function SaveAlgo(Id: integer;Exc : boolean): boolean;
  end;

var
  RecForm: TRecForm;
resourcestring
              stNotValid='This algorithm was not validated!';

implementation

uses DMod1, Recalc, Storage, RecResult,  Main, wait, RHAGlobs, ADOUtilsS;

{$R *.DFM}

procedure TRecForm.FormActivate(Sender: TObject);
begin
  if DM1.TabRec.RecordCount = 0 then begin
    Button2.Enabled := False;
    Button3.Enabled := False;
  end else begin
    Button2.Enabled := Button1.Enabled;
    Button3.Enabled := Button1.Enabled;
  end;
  CurHelpContext := HelpContext;
end;

procedure TRecForm.Button1Click(Sender: TObject);
var //StMain: IStorage;
  MainName: WideString;
  Writer: TWriter;
  Ostr: TOleStream;
  stm: IStream;
begin
  AlgoForm.NewRecord := True;
  OpenQr('Select IsNull(Max(ID)+1,1) as IDNew from Recalcs',DM1.q1Time);
  DM1.TabRec.Insert;
  DM1.TabRec['Id']:=DM1.q1Time['IDNew'];
  DM1.TabRec['Name'] := stNewRec;
  DM1.TabRec.Post;
  AlgoForm.RecordID := DM1.TabRec['Id'];
  AlgoForm.PaintBox1.DestroyComponents;
  AlgoForm.PaintBox1.Blocks.Clear;
  AlgoForm.RAHLEditor1.Lines.Clear;
  if (AlgoForm.ShowModal = mrOK) or (AlgoForm.ModalResult = mrOk) then begin
    SaveAlgo(AlgoForm.RecordID,False);
  end else begin
    DM1.TabRec.Locate('Id',AlgoForm.RecordID,[]);
    DM1.TabRec.Delete;
  end;
  FormActivate(Sender);
end;

procedure TRecForm.Button2Click(Sender: TObject);
begin
  AlgoForm.NewRecord := False;
  AlgoForm.RecordID := DM1.TabRec['Id'];
  if not LoadAlgo(AlgoForm.RecordID,False) then exit;
  if (AlgoForm.ShowModal = mrOK) or (AlgoForm.ModalResult = mrOk) then
    SaveAlgo(AlgoForm.RecordID,False);
end;

procedure TRecForm.Button3Click(Sender: TObject);
var StMain: IStorage;
  MainName: WideString;
begin
  MainName := 'Algorithm' + IntToStr(DM1.TabRec['ID']);
  OleCheck(FRootStorage.DestroyElement(PWideChar(MainName)));
  DM1.TabRec.Delete;
  FormActivate(Sender);
end;

procedure TRecForm.HDBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (DM1.TabRec['Validated'] <> Null) and (DM1.TabRec['Validated'] = False) then
    HDBGrid2.Canvas.Font.Color := clRed;
  HDBGrid2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TRecForm.FormShow(Sender: TObject);
begin
  DM1.TabRec.Active:=True;
   DM1.TabVars.Active:=True;
  OpenDocFile;
end;

procedure TRecForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FRootStorage := nil;
  FFileName:=MainPath + DocFileName;
  ComressDoc;
end;

procedure TRecForm.FormCreate(Sender: TObject);
begin
  RegisterClass(TAlgoPanel);
  RegisterClass(TAdvShape);
  RegisterClass(TAlgoShape);
  RegisterClass(TAlgoLine);
end;

function TRecForm.LoadAlgo(Id: integer;Exc : boolean): boolean;
var StMain: IStorage;
  MainName: WideString;
  Reader: TReader;
  Ostr: TOleStream;
  stm: IStream;
  i: integer;
begin
  Result := False;
  MainName := 'Algorithm' + IntToStr(ID);
  OleCheck(FRootStorage.OpenStorage(PWideChar(MainName), nil,
    STGM_READ or STGM_SHARE_EXCLUSIVE, nil, 0, StMain));
  try
    OleCheck(StMain.OpenStream('Algorithm', nil,
      STGM_READ or STGM_SHARE_EXCLUSIVE, 0, stm));
    Ostr := TOleStream.Create(stm);
    try
      Reader := TReader.Create(Ostr, 1024);
      try
        AlgoForm.PaintBox1.DestroyComponents;
           {AlgoForm.PaintBox1.Free;
           AlgoForm.PaintBox1:=TAlgoPanel(Ostr.ReadComponent(nil));}
        Reader.ReadRootComponent(AlgoForm.PaintBox1);
        AlgoForm.PaintBox1.Top:=0;
        AlgoForm.PaintBox1.Left:=0;
        AlgoForm.PaintBox1.Blocks.Clear;
        for i := 0 to AlgoForm.PaintBox1.ComponentCount - 1 do
          if AlgoForm.PaintBox1.Components[i] is TAlgoShape then begin
            AlgoForm.PaintBox1.Blocks.Add(AlgoForm.PaintBox1.Components[i]);
            TAdvShape(AlgoForm.PaintBox1.Components[i]).OnMouseUp := AlgoForm.AdvShape3MouseUp;
            TAdvShape(AlgoForm.PaintBox1.Components[i]).OnMouseDown := AlgoForm.AdvShape3MouseDown;
            TAdvShape(AlgoForm.PaintBox1.Components[i]).OnMouseMove := AlgoForm.AdvShape3MouseMove;
            TAdvShape(AlgoForm.PaintBox1.Components[i]).OnDblClick := AlgoForm.AdvShape2Click;
          end else
              if AlgoForm.PaintBox1.Components[i] is TAlgoLine then begin
            AlgoForm.PaintBox1.Blocks.Add(AlgoForm.PaintBox1.Components[i]);
            TALgoLine(AlgoForm.PaintBox1.Components[i]).OnClick:=AlgoForm.AlgoLineClick;
            end;
        AlgoForm.PaintBox1.ReadShema(Reader);
      finally
        Reader.Free;
      end;
    finally
      Ostr.Free;
      stm := nil;
    end;
    OleCheck(StMain.OpenStream('Programm_Text', nil,
      STGM_READ or STGM_SHARE_EXCLUSIVE, 0, stm));
    Ostr := TOleStream.Create(stm);
    try
      Reader := TReader.Create(Ostr, 1024);
      try
        AlgoForm.RAHLEditor1.Lines.Text := Reader.ReadString;
        Result := True;
      finally
        Reader.Free;
      end;
    finally
      Ostr.Free;
      stm := nil;
    end;
  finally
    stMain := nil;
  end;
end;

function TRecForm.SaveAlgo(Id: integer; Exc : boolean): boolean;
var StMain: IStorage;
  MainName: WideString;
  Writer: TWriter;
  Ostr: TOleStream;
  stm: IStream;
begin
  Result := False;
  MainName := 'Algorithm' + IntToStr(AlgoForm.RecordID);
  if not SUCCEEDED(FRootStorage.OpenStorage(PWideChar(MainName), nil,
    STGM_READWRITE or STGM_SHARE_EXCLUSIVE, nil, 0, StMain)) then
    OleCheck(FRootStorage.CreateStorage(PWideChar(MainName),
      STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, 0, StMain));
  try

    if not SUCCEEDED(StMain.OpenStream('Algorithm', nil,
      STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, stm)) then
      OleCheck(StMain.CreateStream('Algorithm',
        STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, 0, stm));
    Ostr := TOleStream.Create(stm);
    try
      Writer := TWriter.Create(Ostr, 1024);
      try
        AlgoForm.PaintBox1.SetTags;
        Writer.WriteRootComponent(AlgoForm.PaintBox1);
        AlgoForm.PaintBox1.WriteShema(Writer);
      finally
        Writer.Free;
      end;
    finally
      Ostr.Free;
      stm := nil;
    end;
    if not SUCCEEDED(StMain.OpenStream('Programm_Text', nil,
      STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, stm)) then
      OleCheck(StMain.CreateStream('Programm_Text',
        STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, 0, stm));
    Ostr := TOleStream.Create(stm);
    try
      Writer := TWriter.Create(Ostr, 1024);
      try
        Writer.WriteString(AlgoForm.RAHLEditor1.Lines.Text);
        Result := True;
      finally
        Writer.Free;
      end;
    finally
      Ostr.Free;
      stm := nil;
    end;
  finally
    stMain := nil;
  end;
end;

procedure TRecForm.FormDestroy(Sender: TObject);
begin
  FRootStorage := nil;
end;

procedure TRecForm.BitBtn1Click(Sender: TObject);
begin
     if DM1.TabRec['Validated'] then begin
     AlgoForm.NewRecord := False;
  AlgoForm.RecordID := DM1.TabRec['Id'];
  if  LoadAlgo(AlgoForm.RecordID,False) then begin
  AlgoForm.VE1.Atomn :=not DM1.TabRec['W'];
  AlgoForm.VE1.AW := DM1.TabRec['AW'];
  AlgoForm.VE1.C100 := DM1.TabRec['C100'];
  AlgoForm.VE1.Mols := DM1.TabRec['Mols'];
        ModalResult:=mrOK;
         WForm.Show;
         Try
       TRecResForm.Create(MainForm);
        finally
      WForm.Close;
      end;
      end;
  end else
      ShowMessage(stNotValid);
end;

procedure TRecForm.HDBGrid2DblClick(Sender: TObject);
begin
     BitBtn1Click(Sender);
end;

end.

