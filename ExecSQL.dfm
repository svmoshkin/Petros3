object fExecSQL: TfExecSQL
  Left = 206
  Top = 215
  Width = 761
  Height = 526
  Caption = 'Execute SQL query to DateBase'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 753
    Height = 458
    Align = alClient
    TabOrder = 0
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 751
      Height = 456
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 458
    Width = 753
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 80
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Execute'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 608
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
