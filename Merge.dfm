object fMerge: TfMerge
  Left = 177
  Top = 111
  Width = 516
  Height = 733
  Caption = 'Merge datasets'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 653
    Width = 500
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 354
      Top = 6
      Width = 76
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object Button2: TButton
      Left = 36
      Top = 6
      Width = 130
      Height = 28
      Caption = 'Merge with selected'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 500
    Height = 653
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 6
      Top = 6
      Width = 94
      Height = 13
      Caption = 'Destination dataset:'
    end
    object Label2: TLabel
      Left = 6
      Top = 72
      Width = 221
      Height = 13
      Caption = 'Datasets with the same components sequence'
    end
    object Label3: TLabel
      Left = 6
      Top = 27
      Width = 32
      Height = 13
      Caption = 'Label3'
    end
    object Label4: TLabel
      Left = 6
      Top = 48
      Width = 32
      Height = 13
      Caption = 'Label4'
    end
    object DBG: TDBGrid
      Left = 1
      Top = 87
      Width = 498
      Height = 565
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ArrayName'
          Width = 460
          Visible = True
        end>
    end
  end
  object DataSource1: TDataSource
    DataSet = DM1.qLongTime1
    Left = 225
    Top = 291
  end
end
