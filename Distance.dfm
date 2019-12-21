object fDistance: TfDistance
  Left = 133
  Top = 204
  Width = 989
  Height = 609
  HelpContext = 110
  Caption = 'Distances between analyzes'
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
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 981
    Height = 13
    Align = alTop
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SG1: TStringGrid
    Left = 0
    Top = 13
    Width = 981
    Height = 550
    Align = alClient
    ColCount = 2
    DefaultColWidth = 40
    DefaultRowHeight = 18
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSelect]
    TabOrder = 0
    OnDblClick = SG1DblClick
    ColWidths = (
      40
      40)
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
  object MainMenu1: TMainMenu
    Images = MainForm.ImageList1
    Left = 498
    Top = 24
    object Action1: TMenuItem
      Caption = 'Action'
      GroupIndex = 3
      object SaveToFile1: TMenuItem
        Caption = 'Save To File'
        Hint = 'Save to file '#13#10'contens of the'#13#10'current window'
        ImageIndex = 14
        OnClick = SaveFileExecute
      end
      object ExporttoEXCEL1: TMenuItem
        Caption = 'Export to EXCEL'
        ImageIndex = 29
        OnClick = ExcExpExecute
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Preview1: TMenuItem
        Caption = 'Preview'
        Enabled = False
        Hint = 'Print preview for'#13#10'current window'
        ImageIndex = 13
      end
      object Font1: TMenuItem
        Caption = 'Font'
        Enabled = False
        Hint = 'Change font properties'#13#10'for printing'
        ImageIndex = 16
      end
      object Print1: TMenuItem
        Caption = 'Print'
        Enabled = False
        Hint = 'Print contens of'#13#10'current window'
        ImageIndex = 15
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Nearestandfarest1: TMenuItem
        Caption = 'Nearest and distant'
        OnClick = Nearestandfarest1Click
      end
    end
    object Correlations1: TMenuItem
      Caption = 'Distances'
      GroupIndex = 3
      object Atomic2: TMenuItem
        Caption = 'Atomic %'
        Checked = True
        GroupIndex = 2
        RadioItem = True
        OnClick = Atomic2Click
      end
      object Molecular1: TMenuItem
        Caption = 'Molecular %'
        GroupIndex = 2
        RadioItem = True
        OnClick = Atomic2Click
      end
      object Weight2: TMenuItem
        Caption = 'Weight%'
        GroupIndex = 2
        RadioItem = True
        OnClick = Atomic2Click
      end
      object Weightrecalcto1002: TMenuItem
        Caption = 'Weight % recalc to 100'
        GroupIndex = 2
        RadioItem = True
        OnClick = Atomic2Click
      end
      object AtomicwithoutH2O2: TMenuItem
        Caption = 'Atomic % without H2O'
        GroupIndex = 2
        RadioItem = True
        OnClick = Atomic2Click
      end
      object MolecularAW: TMenuItem
        Caption = 'Molecular % without H2O'
        GroupIndex = 2
        RadioItem = True
        OnClick = Atomic2Click
      end
      object WeightwithoutH2O2: TMenuItem
        Caption = 'Weight % without H2O'
        GroupIndex = 2
        RadioItem = True
        OnClick = Atomic2Click
      end
      object N2: TMenuItem
        Caption = '-'
        GroupIndex = 2
      end
      object Pifagor1: TMenuItem
        Caption = 'Euclid'
        GroupIndex = 2
        OnClick = Pifagor1Click
      end
      object Kholmogorov1: TMenuItem
        Caption = 'Entropy'
        GroupIndex = 2
        OnClick = Pifagor1Click
      end
      object Petrov1: TMenuItem
        Caption = 'Anentropy'
        GroupIndex = 2
        OnClick = Pifagor1Click
      end
      object Minkov1: TMenuItem
        Caption = 'Minkowski'
        GroupIndex = 2
        OnClick = Pifagor1Click
      end
    end
  end
end
