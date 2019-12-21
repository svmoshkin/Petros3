object fDistType: TfDistType
  Left = 289
  Top = 63
  Width = 744
  Height = 761
  Caption = 'Distances between analyzes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 0
    Top = 0
    Width = 736
    Height = 39
    Align = alTop
    Caption = 'Distances type'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Full distance matrix'
      'Distances to selected analisis')
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 693
    Width = 736
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 46
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 39
    Width = 736
    Height = 654
    Align = alClient
    DataSource = DataSource1
    Enabled = False
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Sample'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descript'
        Title.Caption = 'Description'
        Width = 607
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    Left = 210
    Top = 106
  end
end
