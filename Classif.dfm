object FClass: TFClass
  Left = 139
  Top = 119
  Width = 649
  Height = 468
  HelpContext = 90
  Caption = 'Classification results'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefaultPosOnly
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
    Width = 641
    Height = 422
    Align = alClient
    ColCount = 2
    DefaultColWidth = 80
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving]
    TabOrder = 0
    Visible = False
    OnDblClick = SG1DblClick
  end
  object MainMenu1: TMainMenu
    Images = MainForm.ImageList1
    Left = 244
    Top = 100
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
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList1
    Left = 312
    Top = 104
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
    Left = 308
    Top = 204
  end
  object FontDialog1: TFontDialog
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Options = [fdAnsiOnly, fdForceFontExist]
    Left = 492
    Top = 172
  end
  object DSQ: TDataSource
    Left = 144
    Top = 376
  end
end
