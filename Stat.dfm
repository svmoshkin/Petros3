object StatForm: TStatForm
  Left = 71
  Top = 104
  Width = 763
  Height = 547
  HelpContext = 70
  Caption = 'Statistics'
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
    Width = 755
    Height = 193
    Align = alTop
    ColCount = 2
    DefaultColWidth = 56
    DefaultRowHeight = 18
    RowCount = 9
    TabOrder = 0
    OnClick = SG1Click
    OnMouseDown = SG1MouseDown
    ColWidths = (
      56
      58)
  end
  object Chart1: TChart
    Left = 0
    Top = 196
    Width = 755
    Height = 305
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      '')
    Title.Visible = False
    BottomAxis.AxisValuesFormat = '#,#0.#####'
    BottomAxis.LabelsSeparation = 20
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -11
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = [fsBold]
    LeftAxis.AxisValuesFormat = '#,###0.'
    LeftAxis.Title.Caption = 'f'
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -11
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsBold]
    View3D = False
    Align = alBottom
    Color = clWhite
    TabOrder = 1
    Anchors = [akLeft, akTop, akRight, akBottom]
    object Series1: TBarSeries
      Marks.ArrowLength = 20
      Marks.Style = smsValue
      Marks.Visible = False
      SeriesColor = 4227327
      Title = 'Histogram of frequencies'
      BarWidthPercent = 95
      Dark3D = False
      MultiBar = mbNone
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Normal distribution with same parameters'
      Dark3D = False
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
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
      object Print2: TMenuItem
        Caption = 'Print chart'
        OnClick = Print2Click
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
    object Characteristics1: TMenuItem
      Caption = 'Concentrations'
      GroupIndex = 3
      object Atomic1: TMenuItem
        Caption = 'Atomic %'
        OnClick = Atomic1Click
      end
      object Molecular1: TMenuItem
        Caption = 'Molecular %'
        OnClick = Atomic1Click
      end
      object Weight1: TMenuItem
        Caption = 'Weight%'
        OnClick = Atomic1Click
      end
      object Weightrecalcto1001: TMenuItem
        Caption = 'Weight % recalc to 100'
        OnClick = Atomic1Click
      end
      object AtomicwithoutH2O1: TMenuItem
        Caption = 'Atomic % without H2O'
        OnClick = Atomic1Click
      end
      object MolecularAW: TMenuItem
        Caption = 'Molecular % without H2O'
        OnClick = Atomic1Click
      end
      object WeightwithoutH2O1: TMenuItem
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
