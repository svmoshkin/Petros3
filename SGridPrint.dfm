object fQRep: TfQRep
  Left = 170
  Top = 212
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Table printing'
  ClientHeight = 280
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 525
    Height = 280
    Align = alClient
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 248
      Top = 6
      Width = 273
      Height = 269
      Caption = 'Fields selecting'
      TabOrder = 4
      object Label2: TLabel
        Left = 12
        Top = 16
        Width = 70
        Height = 13
        Caption = 'Available fields'
      end
      object Label3: TLabel
        Left = 164
        Top = 16
        Width = 60
        Height = 13
        Caption = 'Printed fields'
      end
      object Label1: TLabel
        Left = 24
        Top = 98
        Width = 32
        Height = 13
        Caption = 'Label1'
        Visible = False
      end
      object ListBox1: THListBox
        Left = 8
        Top = 34
        Width = 113
        Height = 227
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 0
        OnClick = ListBox1Click
        SpHint = True
      end
      object ListBox2: THListBox
        Left = 156
        Top = 32
        Width = 109
        Height = 227
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 1
        OnClick = ListBox1Click
        SpHint = True
      end
      object MButton5: TMButton
        Left = 124
        Top = 58
        Width = 29
        Height = 29
        Hint = 
          #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1087#1086#1083#1103', '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1074' '#1083#1077#1074#1086#1084' '#1089#1087#1080#1089#1082#1077#13#10#1074' '#1089#1087#1080#1089#1086#1082' '#1087#1077#1095#1072#1090#1072#1077#1084#1099#1093' '#1087 +
          #1086#1083#1077#1081
        Caption = '>'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = MButton5Click
        SimpleView = True
        Hint_UTF7 = 
          '+BB8ENQRABDUEPQQ1BEEEQgQ4 +BD8EPgQ7BE8, +BDIESwQ0BDUEOwQ1BD0EPQR' +
          'LBDU +BDI +BDsENQQyBD4EPA +BEEEPwQ4BEEEOgQ1'#13#10'+BDI +BEEEPwQ4BEEEP' +
          'gQ6 +BD8ENQRHBDAEQgQwBDUEPARLBEU +BD8EPgQ7BDUEOQ'
      end
      object MButton6: TMButton
        Left = 124
        Top = 92
        Width = 29
        Height = 29
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1087#1086#1083#1103' '#1080#1079#13#10#1089#1087#1080#1089#1082#1072' '#1087#1077#1095#1072#1090#1072#1077#1084#1099#1093' '#1087#1086#1083#1077#1081
        Caption = '<'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = MButton6Click
        SimpleView = True
        Hint_UTF7 = 
          '+BCMENAQwBDsEOARCBEw +BDIESwQ0BDUEOwQ1BD0EPQRLBDU +BD8EPgQ7BE8 +' +
          'BDgENw'#13#10'+BEEEPwQ4BEEEOgQw +BD8ENQRHBDAEQgQwBDUEPARLBEU +BD8EPgQ7' +
          'BDUEOQ'
      end
      object MButton7: TMButton
        Left = 124
        Top = 140
        Width = 29
        Height = 29
        Hint = #1055#1086#1084#1077#1089#1090#1080#1090#1100' '#1074#1089#1077' '#1087#1086#1083#1103' '#13#10#1074' '#1089#1087#1080#1089#1086#1082' '#1087#1077#1095#1072#1090#1072#1077#1084#1099#1093
        Caption = '>>'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = MButton7Click
        SimpleView = True
        Hint_UTF7 = 
          '+BB8EPgQ8BDUEQQRCBDgEQgRM +BDIEQQQ1 +BD8EPgQ7BE8 '#13#10'+BDI +BEEEPwQ' +
          '4BEEEPgQ6 +BD8ENQRHBDAEQgQwBDUEPARLBEU'
      end
      object MButton8: TMButton
        Left = 124
        Top = 174
        Width = 29
        Height = 29
        Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1087#1077#1095#1072#1090#1072#1077#1084#1099#1093' '#1087#1086#1083#1077#1081
        Caption = '<<'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = MButton8Click
        SimpleView = True
        Hint_UTF7 = 
          '+BB4ERwQ4BEEEQgQ4BEIETA +BEEEPwQ4BEEEPgQ6 +BD8ENQRHBDAEQgQwBDUEP' +
          'ARLBEU +BD8EPgQ7BDUEOQ'
      end
    end
    object MButton2: TMButton
      Left = 4
      Top = 248
      Width = 75
      Height = 25
      Caption = '  Preview  '
      TabOrder = 0
      OnClick = MButton2Click
      SimpleView = True
    end
    object MButton3: TMButton
      Left = 82
      Top = 248
      Width = 75
      Height = 25
      Caption = '  Print  '
      TabOrder = 1
      OnClick = MButton3Click
      SimpleView = True
      Kind = bkPrint
    end
    object MButton4: TMButton
      Left = 168
      Top = 248
      Width = 75
      Height = 25
      Caption = '  Cancel  '
      ModalResult = 2
      TabOrder = 2
      SimpleView = True
      Kind = bkCancel
    end
    object GroupBox1: TGroupBox
      Left = 4
      Top = 8
      Width = 233
      Height = 233
      Caption = 'Settings'
      TabOrder = 3
      object Label4: TLabel
        Left = 8
        Top = 190
        Width = 20
        Height = 13
        Caption = 'Title'
      end
      object Label5: TLabel
        Left = 12
        Top = 26
        Width = 41
        Height = 13
        Caption = 'Atributes'
      end
      object MButton9: TMButton
        Left = 108
        Top = 52
        Width = 121
        Height = 25
        Hint = #1042#1099#1073#1086#1088' '#1096#1088#1080#1092#1090#1072' '#13#10#1079#1072#1075#1086#1083#1086#1074#1082#1072' '#1086#1090#1095#1077#1090#1072
        Caption = '  Title font  '
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = MButton9Click
        SimpleView = True
        Hint_UTF7 = 
          '+BBIESwQxBD4EQA +BEgEQAQ4BEQEQgQw '#13#10'+BDcEMAQzBD4EOwQ+BDIEOgQw +B' +
          'D4EQgRHBDUEQgQw'
      end
      object MButton10: TMButton
        Left = 108
        Top = 77
        Width = 121
        Height = 25
        Hint = #1042#1099#1073#1086#1088' '#1096#1088#1080#1092#1090#1072' '#13#10#1079#1072#1075#1086#1083#1086#1074#1082#1086#1074' '#1082#1086#1083#1086#1085#1086#1082' '#1090#1072#1073#1083#1080#1094#1099
        Caption = '  Header font  '
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = MButton10Click
        SimpleView = True
        Hint_UTF7 = 
          '+BBIESwQxBD4EQA +BEgEQAQ4BEQEQgQw '#13#10'+BDcEMAQzBD4EOwQ+BDIEOgQ+BDI' +
          ' +BDoEPgQ7BD4EPQQ+BDo +BEIEMAQxBDsEOARGBEs'
      end
      object MButton11: TMButton
        Left = 108
        Top = 101
        Width = 121
        Height = 25
        Hint = #1042#1099#1073#1086#1088' '#1096#1088#1080#1092#1090#1072' '#13#10#1090#1072#1073#1083#1080#1094#1099
        Caption = '  Table font  '
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = MButton11Click
        SimpleView = True
        Hint_UTF7 = '+BBIESwQxBD4EQA +BEgEQAQ4BEQEQgQw '#13#10'+BEIEMAQxBDsEOARGBEs'
      end
      object HEdit1: THEdit
        Left = 4
        Top = 204
        Width = 225
        Height = 21
        TabOrder = 4
        OnChange = HEdit1Change
        SpHint = True
      end
      object MButton12: TMButton
        Left = 108
        Top = 126
        Width = 121
        Height = 25
        Hint = #1042#1099#1073#1086#1088' '#1096#1088#1080#1092#1090#1072' '#13#10#1080#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085#1099#1093' '#1072#1090#1088#1080#1073#1091#1090#1086#1074#13#10#1082#1086#1083#1086#1085#1090#1080#1090#1091#1083#1072
        Caption = '   Atributes font   '
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = MButton12Click
        SimpleView = True
        Hint_UTF7 = 
          '+BBIESwQxBD4EQA +BEgEQAQ4BEQEQgQw '#13#10'+BDgEPQREBD4EQAQ8BDAERgQ4BD4' +
          'EPQQ9BEsERQ +BDAEQgRABDgEMQRDBEIEPgQy'#13#10'+BDoEPgQ7BD4EPQRCBDgEQgRD' +
          'BDsEMA'
      end
      object MCheckRadioBox1: TCheckBox
        Left = 8
        Top = 54
        Width = 89
        Height = 17
        TabStop = False
        Caption = 'Date'
        TabOrder = 6
        OnClick = MCheckRadioBox1Click
      end
      object MCheckRadioBox2: TCheckBox
        Left = 8
        Top = 88
        Width = 89
        Height = 17
        TabStop = False
        Caption = 'Time'
        TabOrder = 7
        OnClick = MCheckRadioBox1Click
      end
      object MCheckRadioBox4: TCheckBox
        Left = 8
        Top = 122
        Width = 89
        Height = 17
        TabStop = False
        Caption = 'Page number'
        TabOrder = 8
        OnClick = MCheckRadioBox1Click
      end
      object MCheckRadioBox5: TCheckBox
        Left = 40
        Top = 160
        Width = 157
        Height = 17
        TabStop = False
        Caption = 'Columns border'
        TabOrder = 9
        OnClick = MCheckRadioBox1Click
      end
      object MButton1: TButton
        Left = 110
        Top = 14
        Width = 119
        Height = 25
        Caption = 'Printer'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = MButton1Click
      end
    end
  end
  object TitleFontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Left = 364
    Top = 68
  end
  object PrintDialog1: TPrintDialog
    Options = [poPageNums]
    Left = 312
    Top = 174
  end
  object ColumnFontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Left = 324
    Top = 72
  end
  object DetailFontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 348
    Top = 120
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 364
    Top = 160
  end
  object AttribFontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 432
    Top = 48
  end
end
