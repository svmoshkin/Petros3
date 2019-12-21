object fNearest: TfNearest
  Left = 206
  Top = 128
  Width = 1015
  Height = 658
  Caption = 'Nearest and distant'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 574
    Width = 1007
    Height = 38
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 60
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1007
    Height = 574
    Align = alClient
    TabOrder = 1
    object SG1: TStringGrid
      Left = 1
      Top = 1
      Width = 1005
      Height = 572
      Align = alClient
      ColCount = 11
      DefaultColWidth = 90
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      TabOrder = 0
      OnDblClick = SG1DblClick
      OnMouseDown = SG1MouseDown
    end
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
        OnClick = SaveToFile1Click
      end
      object ExporttoEXCEL1: TMenuItem
        Caption = 'Export to EXCEL'
        ImageIndex = 29
        OnClick = ExporttoEXCEL1Click
      end
    end
  end
end
