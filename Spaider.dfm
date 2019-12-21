object SPForm: TSPForm
  Left = 67
  Top = 83
  Width = 648
  Height = 463
  HelpContext = 89
  Caption = 'Spider diagram'
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
    Height = 417
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
        Maximum = 82.958381068569290000
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
    Band = False
    Legend.Top = 191
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
      Caption = 'Chart properties'
      Hint = 'Chart customisation'
      ImageIndex = 26
      OnExecute = SpeedButton1Click
    end
    object AExcExp: TAction
      Caption = 'Export to EXCEL'
      ImageIndex = 29
      OnExecute = AExcExpExecute
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
    object Action1: TMenuItem
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
      object Chartproperties1: TMenuItem
        Action = ASpProp
        Caption = 'Diagram properties'
      end
    end
  end
  object Query1: TADOQuery
    Connection = DM1.ADOConnection1
    Parameters = <>
    Left = 309
    Top = 218
  end
end
