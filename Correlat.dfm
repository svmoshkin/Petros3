object CorrForm: TCorrForm
  Left = 95
  Top = 41
  Width = 777
  Height = 514
  HelpContext = 71
  Caption = 'Correlation coefficients'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SG1: TStringGrid
    Left = 0
    Top = 0
    Width = 769
    Height = 468
    Align = alClient
    ColCount = 2
    DefaultColWidth = 40
    DefaultRowHeight = 18
    RowCount = 2
    TabOrder = 0
    OnDrawCell = SG1DrawCell
    ColWidths = (
      40
      40)
  end
  object MainMenu1: TMainMenu
    Images = MainForm.ImageList1
    Left = 560
    Top = 24
    object Action1: TMenuItem
      Caption = 'Action'
      GroupIndex = 3
      object SaveToFile1: TMenuItem
        Action = SaveFile
      end
      object ExporttoEXCEL1: TMenuItem
        Action = ExcExp
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Preview1: TMenuItem
        Action = Preview
        Enabled = False
      end
      object Font1: TMenuItem
        Action = Font
        Enabled = False
      end
      object Print1: TMenuItem
        Action = Print
        Enabled = False
      end
    end
    object Correlations1: TMenuItem
      Caption = 'Correlations'
      GroupIndex = 3
      object Atomic2: TMenuItem
        Caption = 'Atomic %'
        OnClick = Atomic1Click
      end
      object Molecular1: TMenuItem
        Caption = 'Molecular %'
        OnClick = Atomic1Click
      end
      object Weight2: TMenuItem
        Caption = 'Weight%'
        OnClick = Atomic1Click
      end
      object Weightrecalcto1002: TMenuItem
        Caption = 'Weight % recalc to 100'
        OnClick = Atomic1Click
      end
      object AtomicwithoutH2O2: TMenuItem
        Caption = 'Atomic % without H2O'
        OnClick = Atomic1Click
      end
      object MolecularAW: TMenuItem
        Caption = 'Molecular % without H2O'
        OnClick = Atomic1Click
      end
      object WeightwithoutH2O2: TMenuItem
        Caption = 'Weight % without H2O'
        OnClick = Atomic1Click
      end
    end
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList1
    Left = 588
    Top = 20
    object SaveFile: TAction
      Caption = 'Save To File'
      Hint = 'Save to file '#13#10'contens of the'#13#10'current window'
      ImageIndex = 14
      OnExecute = SaveFileExecute
    end
    object Preview: TAction
      Caption = 'Preview'
      Hint = 'Print preview for'#13#10'current window'
      ImageIndex = 13
    end
    object Print: TAction
      Caption = 'Print'
      Hint = 'Print contens of'#13#10'current window'
      ImageIndex = 15
    end
    object Font: TAction
      Caption = 'Font'
      Hint = 'Change font properties'#13#10'for printing'
      ImageIndex = 16
    end
    object ExcExp: TAction
      Caption = 'Export to EXCEL'
      ImageIndex = 29
      OnExecute = ExcExpExecute
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 464
    Top = 172
  end
  object FontDialog1: TFontDialog
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Options = [fdAnsiOnly, fdForceFontExist]
    Left = 496
    Top = 172
  end
end
