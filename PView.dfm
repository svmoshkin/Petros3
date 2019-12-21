object fPView: TfPView
  Left = 96
  Top = 184
  Width = 983
  Height = 623
  Caption = 'fPView'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 562
    Width = 975
    Height = 34
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 740
      Top = 12
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object Button1: TButton
      Left = 48
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 975
    Height = 562
    Align = alClient
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Alfa'
        Title.Caption = 'Alfabet'
        Width = 37
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Sample'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Num'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ArrayName'
        Title.Caption = 'Array name'
        Width = 245
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descript'
        Width = 526
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 176
    Top = 68
  end
  object Query1: TADOQuery
    Connection = DM1.ADOConnection1
    Parameters = <>
    Left = 236
    Top = 36
  end
end
