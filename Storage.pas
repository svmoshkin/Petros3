unit Storage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, ComObj, ComCtrls, ExtCtrls, Buttons, StdCtrls;

type
  TStorageForm = class(TForm)
    Tree: TTreeView;
    pnlHeader: TPanel;
    FileOpen1: TButton;
    Compress1: TButton;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    procedure FileOpen1Click(Sender: TObject);
    procedure Compress1Click(Sender: TObject);
  private
    { Private declarations }
    procedure DisplayFileStructure;
    procedure RecurseStorage(ParentNode: TTreeNode; stg: IStorage);
  public
    { Public declarations }
    
  end;

var
  StorageForm: TStorageForm;
  FRootStorage : IStorage;
   FFileName: WideString;
    

const
  DocFileName = 'Petros.rcl';

procedure OpenDocFile;
procedure ComressDoc;

implementation

uses RHAGlobs;

{$R *.DFM}

procedure OpenDocFile;
var FN: Widestring;
begin
  FN := MainPath + DocFileName;
  FFileName := Fn;
  if not Succeeded(StgOpenStorage(PWideChar(FN),nil,STGM_ReadWrite or STGM_SHARE_EXCLUSIVE,
    nil,0,FRootStorage)) then
   OleCheck(StgCreateDocFile(PWideChar(FN),STGM_Create or STGM_ReadWrite or STGM_SHARE_EXCLUSIVE
     ,0,FRootStorage));
end;

procedure TStorageForm.RecurseStorage(ParentNode: TTreeNode; stg: IStorage);
var
  EnumStatStg: IEnumStatStg;
  StatStg: TStatStg;
  NodeName: string;
  ChildNode: TTreeNode;
  stgChild: IStorage;
begin
  OleCheck(stg.EnumElements(0, nil, 0, EnumStatStg));
  while EnumStatStg.Next(1, StatStg, nil) = S_OK do begin
    NodeName := StatStg.pwcsName;
    if Ord(NodeName[1]) < 32 then
      NodeName := '#' + IntToStr(Ord(NodeName[1])) +
        Copy(NodeName, 2, Length(NodeName) - 1);
    ChildNode := tree.Items.AddChild(ParentNode, NodeName +
      ' (' + IntToStr(StatStg.cbSize) + ' bytes)');
    if StatStg.dwType = STGTY_STORAGE then begin
// Проверить, нельзя ли открыть вложенное хранилище.
      OleCheck(stg.OpenStorage(StatStg.pwcsName, nil, STGM_READ or
        STGM_SHARE_EXCLUSIVE, nil, 0, stgChild));
// Обработка вложенного хранилища.
      RecurseStorage(ChildNode, stgChild);
    end;
  end;
end;

procedure TStorageForm.DisplayFileStructure;
var
  stgRoot: IStorage;
  Node: TTreeNode;
begin
// Сначала проверить, действительно ли это докфайл.
  if StgIsStorageFile(PWideChar(FFileName)) <> S_OK then begin
    ShowMessage(FFileName + ' is not a structured storage file.');
    exit;
  end;
  pnlHeader.Caption := FFileName;
// Открыть файл.
  OleCheck(StgOpenStorage(PWideChar(FFileName), nil, STGM_READ or
    STGM_SHARE_EXCLUSIVE, nil, 0, StgRoot));
  tree.Items.BeginUpdate;
  try
    tree.Items.Clear;
    Node := tree.Items.Add(nil, '<Root>');
    RecurseStorage(Node, stgRoot);
    Node.Expand(True);
  finally
    tree.Items.EndUpdate;
  end;
  Compress1.Enabled := True;
end;


procedure TStorageForm.FileOpen1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := MainPath;
  OpenDialog1.FileName := DocFileName;
  if OpenDialog1.Execute then begin
    FFileName := OpenDialog1.FileName;
    DisplayFileStructure;
  end;
end;

procedure ComressDoc;
var
  stgOriginal: IStorage;
  stgTemp: IStorage;
  TempFileName: WideString;
begin
// Шаг 1 - Открыть исходный докфайл.
  OleCheck(StgOpenStorage(PWideChar(FFileName), nil,
    STGM_READ or STGM_SHARE_EXCLUSIVE, nil, 0, stgOriginal));
// Шаг 2 - Создать новый временный докфайл.
  TempFileName := ChangeFileExt(FFilename, '.$$$');
  OleCheck(StgCreateDocFile(PWideChar(TempFileName),
    STGM_WRITE or STGM_SHARE_EXCLUSIVE, 0, stgTemp));
// шаг 3 - Скопировать все хранилища и потоки
//из исходного файла во временный.
  stgOriginal.CopyTo(0, nil, nil, stgTemp);
// Bar 4 - Закрыть временный файл.
  stgTemp := nil;
// Шаг 5 - Закрыть исходный файл.
  stgOriginal := nil;
// Шаг б - Удалить исходный файл.
  DeleteFile(FFileName);
// Oar 7 - Переименовать временный файл.
  RenameFile(TempFileName, FFileName);
end;

procedure TStorageForm.Compress1Click(Sender: TObject);
begin
  ComressDoc;
end;

end.

