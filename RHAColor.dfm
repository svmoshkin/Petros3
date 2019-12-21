object fRHAColor: TfRHAColor
  Left = 50
  Top = 200
  Width = 1136
  Height = 473
  Caption = 'Color view of rank formulas'
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
  PixelsPerInch = 96
  TextHeight = 13
  object RE1: TJvRichEdit
    Left = 0
    Top = 0
    Width = 1128
    Height = 427
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 276
    Top = 120
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'rtf'
    Filter = 'Rich Text Format files|*.rtf'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofNoReadOnlyReturn, ofNoNetworkButton]
    Left = 188
    Top = 24
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
      Enabled = False
      Hint = 'Print preview for'#13#10'current window'
      ImageIndex = 13
    end
    object Print: TAction
      Caption = 'Print'
      Hint = 'Print contens of'#13#10'current window'
      ImageIndex = 15
      OnExecute = PrintExecute
    end
  end
  object MainMenu1: TMainMenu
    Images = MainForm.ImageList1
    Left = 248
    Top = 100
    object Action1: TMenuItem
      Caption = 'Action'
      GroupIndex = 3
      object SaveToFile1: TMenuItem
        Action = SaveFile
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
    end
  end
end
