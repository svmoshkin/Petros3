object BandForm: TBandForm
  Left = 99
  Top = 55
  Width = 648
  Height = 466
  HelpContext = 85
  Caption = 'Maximum, minimum and average concentration'
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
  PixelsPerInch = 96
  TextHeight = 13
  object GeoChart1: TGeoChart
    Left = 0
    Top = 0
    Width = 640
    Height = 420
    Align = alClient
    Color = clWhite
    ParentColor = False
    SPLabelsValues.Strings = (
      'A'
      'B'
      'C'
      'D'
      'E'
      'F'
      'G'
      'H'
      'I'
      'J'
      'K'
      'L'
      'M'
      'N'
      'O'
      'P')
    Title.Direction = 0
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clWindowText
    Title.Font.Height = -19
    Title.Font.Name = 'MS Sans Serif'
    Title.Font.Style = [fsBold]
    Title.Text = 'Graph'
    Title.Visible = False
    BottomTitle.Direction = 0
    BottomTitle.Font.Charset = DEFAULT_CHARSET
    BottomTitle.Font.Color = clWindowText
    BottomTitle.Font.Height = -16
    BottomTitle.Font.Name = 'MS Sans Serif'
    BottomTitle.Font.Style = [fsBold]
    BottomTitle.Title = 'X'
    LeftTitle.Direction = 90
    LeftTitle.Font.Charset = DEFAULT_CHARSET
    LeftTitle.Font.Color = clWindowText
    LeftTitle.Font.Height = -16
    LeftTitle.Font.Name = 'MS Sans Serif'
    LeftTitle.Font.Style = [fsBold]
    LeftTitle.Title = 'Y'
    RightTitle.Direction = 0
    RightTitle.Font.Charset = DEFAULT_CHARSET
    RightTitle.Font.Color = clWindowText
    RightTitle.Font.Height = -16
    RightTitle.Font.Name = 'MS Sans Serif'
    RightTitle.Font.Style = [fsBold]
    RightTitle.Title = 'B'
    AvaibleMoveByMouse = True
    AvailableMouseZooming = True
    Trio = False
    Norma = 100.000000000000000000
    Axises = <
      item
        Maximum = 15.100000000000000000
        Minimum = -0.100000000000000000
        Automatic = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GridVisible = True
        LabelCount = 16
        LabelDirection = 0
        LabelInterval = 1.000000000000000000
        LabelsVisible = True
        Logarithmic = False
        MinorGridVisible = False
        TicksCount = 0
        TickLength = 3
        Title = 'X'
        Thickness = 1
        GridThickness = 1
        LeftTicks = True
        RightTicks = False
      end
      item
        Maximum = 82.958381068569300000
        Minimum = 0.000001000000000000
        Automatic = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GridVisible = True
        LabelCount = 0
        LabelDirection = 0
        LabelInterval = 5.000000000000000000
        LabelsVisible = True
        Logarithmic = False
        MinorGridVisible = False
        TicksCount = 4
        TickLength = 3
        Title = 'Y'
        Thickness = 1
        GridThickness = 1
        LeftTicks = True
        RightTicks = False
      end
      item
        Maximum = 100.000000000000000000
        Automatic = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GridVisible = True
        LabelCount = 0
        LabelDirection = 0
        LabelInterval = 10.000000000000000000
        LabelsVisible = True
        Logarithmic = False
        MinorGridVisible = False
        TicksCount = 4
        TickLength = 3
        Title = 'B'
        Thickness = 1
        GridThickness = 1
        LeftTicks = True
        RightTicks = False
      end>
    Spaid = True
    SPCount = 16
    Band = True
    Legend.Top = 193
    Legend.Left = 610
    Legend.Font.Charset = DEFAULT_CHARSET
    Legend.Font.Color = clWindowText
    Legend.Font.Height = -12
    Legend.Font.Name = 'MS Sans Serif'
    Legend.Font.Style = [fsBold]
    Legend.Visible = True
    Legend.Frame = True
    Legend.Transparent = False
    Legend.InChart = True
    Legend.PosDefault = True
    Series = <>
  end
  object Panel1: TPanel
    Left = 268
    Top = 4
    Width = 121
    Height = 413
    TabOrder = 0
    Visible = False
    object Label1: TLabel
      Left = 12
      Top = 0
      Width = 101
      Height = 29
      Alignment = taCenter
      AutoSize = False
      Caption = 'Visible components'
      WordWrap = True
    end
    object BitBtn1: TBitBtn
      Left = 4
      Top = 384
      Width = 49
      Height = 25
      TabOrder = 1
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 56
      Top = 384
      Width = 61
      Height = 25
      TabOrder = 2
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
    object Button1: TButton
      Left = 20
      Top = 320
      Width = 81
      Height = 17
      Caption = 'Select all'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 20
      Top = 340
      Width = 81
      Height = 17
      Caption = 'Unselect all'
      TabOrder = 4
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 20
      Top = 360
      Width = 81
      Height = 17
      Caption = 'Invert'
      TabOrder = 5
      OnClick = Button3Click
    end
    object CheckListBox1: TCheckListBox
      Left = 8
      Top = 28
      Width = 105
      Height = 289
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList1
    Left = 4
    Top = 60
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
      OnExecute = PreviewExecute
    end
    object Print: TAction
      Caption = 'Print'
      Hint = 'Print contens of'#13#10'current window'
      ImageIndex = 15
      OnExecute = PrintExecute
    end
    object SaveClip: TAction
      Caption = 'Save to clippboard'
      Hint = 'Save graph to'#13#10'clippboard'
      OnExecute = SaveClipExecute
    end
    object ASpProp: TAction
      Caption = 'Chart properties...'
      Hint = 'Diagram customisation'
      ImageIndex = 26
      OnExecute = SpeedButton1Click
    end
    object AExcExp: TAction
      Caption = 'Export to EXCEL...'
      ImageIndex = 29
      OnExecute = AExcExpExecute
    end
    object AGroup: TAction
      Caption = 'Grouping...'
      OnExecute = AGroupExecute
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'wmf'
    FileName = 'New'
    Filter = 'Windows metafiles|*.wmf'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 18
    Top = 92
  end
  object MainMenu1: TMainMenu
    Images = MainForm.ImageList1
    Left = 36
    Top = 60
    object Chart1: TMenuItem
      Caption = 'Diagram'
      GroupIndex = 3
      object SaveToFile1: TMenuItem
        Action = SaveFile
      end
      object Savetoclippboard1: TMenuItem
        Action = SaveClip
      end
      object ExporttoEXCEL1: TMenuItem
        Action = AExcExp
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Preview1: TMenuItem
        Action = Preview
      end
      object Print1: TMenuItem
        Action = Print
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Grouping1: TMenuItem
        Action = AGroup
      end
      object LogMItem: TMenuItem
        Caption = 'Log of concentrations'
        OnClick = LogMItemClick
      end
      object ShowMinandMax1: TMenuItem
        Caption = 'Show Min and Max'
        Checked = True
        OnClick = ShowMinandMax1Click
      end
      object Chartproperties1: TMenuItem
        Action = ASpProp
        Caption = 'Diagram properties...'
      end
    end
    object Concentrations1: TMenuItem
      Caption = 'Concentrations'
      GroupIndex = 3
      object Visiblecomponents1: TMenuItem
        Caption = 'Visible components...'
        OnClick = Visiblecomponents1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Atomic1: TMenuItem
        Caption = 'Atomic %'
        OnClick = Atomic1Click
      end
      object Moleculars1: TMenuItem
        Caption = 'Molecular %'
        OnClick = Moleculars1Click
      end
      object Weight1: TMenuItem
        Caption = 'Weight %'
        OnClick = Weight1Click
      end
      object Weightrecalcto1001: TMenuItem
        Caption = 'Weight % recalc to 100'
        OnClick = Weightrecalcto1001Click
      end
      object AtomicwithoutH2O1: TMenuItem
        Caption = 'Atomic% without H2O'
        OnClick = AtomicwithoutH2O1Click
      end
      object MolecularwithoutH2O1: TMenuItem
        Caption = 'Molecular % without H2O'
        OnClick = MolecularwithoutH2O1Click
      end
      object WeightwithoutH2O1: TMenuItem
        Caption = 'Weight % without H2O'
        OnClick = WeightwithoutH2O1Click
      end
    end
  end
end
