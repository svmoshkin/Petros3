object RepLstViewFrm: TRepLstViewFrm
  Left = 400
  Top = 185
  Width = 328
  Height = 378
  Caption = 'Reports list'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 310
    Width = 320
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TMButton
      Left = 40
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Preview'
      TabOrder = 0
      OnClick = BitBtn1Click
      NumGlyphs = 2
      SimpleView = True
    end
    object BitBtn2: TMButton
      Left = 192
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      NumGlyphs = 2
      SimpleView = True
      Kind = bkCancel
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 310
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 305
      Height = 49
      AutoSize = False
      Caption = 'Report title'
      WordWrap = True
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 64
      Width = 318
      Height = 245
      Align = alBottom
      Caption = 'Parts of report'
      TabOrder = 0
      object ListBox1: TListBox
        Left = 2
        Top = 15
        Width = 314
        Height = 228
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = BitBtn1Click
      end
    end
  end
end
