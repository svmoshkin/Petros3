program Petros;

uses
  Forms,
  SysUtils,
  Graphics,
  Splash in 'Splash.pas' {SForm},
  DMod1 in 'DMod1.pas' {DM1: TDataModule},
  Main in 'MAIN.PAS' {MainForm},
  Options in 'Options.pas' {ConfigDlg},
  About in 'About.pas' {About1},
  Chemist in 'chemist.pas',
  Tasks in 'Tasks.pas' {NewProject},
  TaskSQL in 'TaskSQL.pas' {TaskSQLForm},
  TabMend in 'TabMend.pas' {MendForm},
  MyUtils in '..\Utils\MyUtils.pas',
  PetDBUtils in 'PetDBUtils.pas' {DbUtil},
  LoadPr in 'LoadPr.pas' {LoadPrForm},
  AnalInput in 'AnalInput.pas' {AnDlg},
  MRollUp in '..\OBJREPOS\MROLLUP.pas' {RollsUp},
  RollQuery in 'RollQuery.pas' {QueryRolls},
  AtProc in 'AtProc.pas' {AtForm},
  Koeff in 'Koeff.pas' {KoefForm},
  EdCoefs in 'EdCoefs.pas' {EdKoefForm},
  AnData in 'AnData.pas' {AnalForm},
  wait in 'wait.pas' {WForm},
  TrioGraph in 'TrioGraph.pas' {TrioForm},
  explor in 'explor.pas' {ClassForm},
  StDiagrams in 'StDiagrams.pas' {StDiaForm},
  OkCancl1 in 'okcancl1.pas' {OKBottomDlg},
  RHABrows in 'RHABrows.pas' {FBrows},
  ORF in 'ORF.pas' {ORFForm},
  DebuS in 'DebuS.pas' {DebugSQL},
  BSQL in 'BSQL.pas' {BiblSQL},
  Biblio in 'Biblio.pas' {Books},
  BBrowse in 'BBrowse.pas' {BiblBrouse},
  NewArr in 'NewArr.pas' {DlNew},
  ArrayRolls in 'ArrayRolls.pas' {ArrayRollsUp},
  ImportAn in 'ImportAn.pas' {ImportDialog},
  SelPoint in 'SelPoint.pas' {SelForm},
  Spaider in 'Spaider.pas' {SPForm},
  Devid in 'Devid.pas' {DevForm},
  StDiagProp in 'StDiagProp.pas' {NewDiagr},
  Classif in 'Classif.pas' {FClass},
  ExcelExp in 'ExcelExp.pas' {ExcF},
  ImpWiz in 'ImpWiz.pas' {WizForm},
  ViewSQ in 'ViewSQ.pas' {SQView},
  Lists in 'Lists.pas' {ListsRoll},
  LookUps in 'LookUps.pas' {LookUpForm},
  EdBook in 'EdBook.pas' {EdBookForm},
  ImpLookUps in 'ImpLookUps.pas' {ImpLookUpForm},
  TxtImpExp in 'TxtImpExp.pas' {ExptoTextForm},
  ChangeClass in 'ChangeClass.pas' {ChangeClForm},
  Correlat in 'Correlat.pas' {CorrForm},
  Stat in 'Stat.pas' {StatForm},
  BandGr in 'BandGr.pas' {BandForm},
  DeletDescr in 'DeletDescr.pas' {DeletDial},
  Dictionar in 'Dictionar.pas' {SinonimForm},
  Grouping in 'Grouping.pas' {GroupForm},
  Storage in 'Storage.pas' {StorageForm},
  StRecalc in 'StRecalc.pas' {RecForm},
  Recalc in 'Recalc.pas' {AlgoForm},
  RecResult in 'RecResult.pas' {RecResForm},
  ListBrows in 'ListBrows.pas' {LBrowseForm},
  Mend_C in '..\Mend\Mend_C.pas' {MendTabl: TControlGroupBox},
  preview in '..\Trio\Preview.pas' {PrevForm},
  ChartProp in '..\Trio\ChartProp.pas' {ChartPropertyForm},
  RHAGlobs in 'RHAGlobs.pas',
  Analise in 'Analise.pas',
  Registrat in 'Registrat.pas' {RegistrForm},
  Regres in 'Regres.pas' {RegrForm},
  RHAColor in 'RHAColor.pas' {fRHAColor},
  SGridPrint in 'SGridPrint.pas' {fQRep},
  RepLstViewUnit in 'RepLstViewUnit.pas' {RepLstViewFrm},
  Distance in 'Distance.pas' {fDistance};

{$R *.res}
var
  Sp: TSForm;
begin
  AppPath := ExtractFilePath(ParamStr(0));
  ChDir(AppPath);
  Application.Initialize;

  SP := TSForm.Create(Application);
  Sp.show;
  Sp.Update;
  Sp.PB.Progress := 5;

  Application.Title := 'Petros 3';

  

  Application.HelpFile := 'Petros.hlp';
  Application.CreateForm(TDM1, DM1);
 
  Sp.PB.Progress := Sp.PB.Progress + 10;
  Application.ProcessMessages;
   Application.CreateForm(TMainForm, MainForm);

  Application.CreateForm(TConfigDlg, ConfigDlg);

  Sp.PB.Progress := Sp.PB.Progress + 10;
  Application.ProcessMessages;
 Application.CreateForm(TSQView, SQView);
  Application.CreateForm(TListsRoll, ListsRoll);
  Application.CreateForm(TLBrowseForm, LBrowseForm);
  Application.CreateForm(TGroupForm, GroupForm);

  Sp.PB.Progress := Sp.PB.Progress + 10;
  Application.ProcessMessages;
   Application.CreateForm(TEdBookForm, EdBookForm);
  Application.CreateForm(TQueryRolls, QueryRolls);

  Application.CreateForm(TDebugSQL, DebugSQL);
  Sp.PB.Progress := Sp.PB.Progress + 10;
  Application.ProcessMessages;


  Application.CreateForm(TAnDlg, AnDlg);
  Application.CreateForm(TDlNew, DlNew);
  Application.CreateForm(TExcF, ExcF);
  Sp.PB.Progress := Sp.PB.Progress + 10;
  Application.ProcessMessages;
  Application.CreateForm(TStDiaForm, StDiaForm);
  Application.CreateForm(TEdKoefForm, EdKoefForm);
  Application.CreateForm(TWForm, WForm);
  Sp.PB.Progress := Sp.PB.Progress + 10;
  Application.ProcessMessages;
  Application.CreateForm(TTaskSQLForm, TaskSQLForm);
  Application.CreateForm(TMendForm, MendForm);

  Sp.PB.Progress := Sp.PB.Progress + 10;
  Application.ProcessMessages;

  Sp.PB.Progress := Sp.PB.Progress + 10;
  Application.ProcessMessages;
  Application.CreateForm(TImportDialog, ImportDialog);
  Application.CreateForm(TArrayRollsUp, ArrayRollsUp);
  Application.CreateForm(TSelForm, SelForm);

  Application.CreateForm(TExptoTextForm, ExptoTextForm);
  Application.CreateForm(TChangeClForm, ChangeClForm);
  Sp.PB.Progress := Sp.PB.Progress + 5;
  Application.ProcessMessages;
  Application.CreateForm(TDevForm, DevForm);
  Application.CreateForm(TNewDiagr, NewDiagr);

  Sp.PB.Progress := Sp.PB.Progress + 5;
  Application.ProcessMessages;
  ReadIni;
  Sp.PB.Progress := Sp.PB.Progress + 5;
  Application.ProcessMessages;
  Application.CreateForm(TDeletDial, DeletDial);
   Application.CreateForm(TRecForm, RecForm);
  Application.CreateForm(TAlgoForm, AlgoForm); 
  Sp.PB.Progress := Sp.PB.Progress + 10;
  Application.ProcessMessages; 

  SP.Hide;
  Sp.Free;
  Application.Run;
end.
