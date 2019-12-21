object RecResForm: TRecResForm
  Left = 325
  Top = 396
  Width = 756
  Height = 549
  HelpContext = 88
  Caption = 'RecResForm'
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
  Scaled = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object QR: TQuickRep
    Left = 91
    Top = -59
    Width = 1123
    Height = 794
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New Cyr'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
      50.000000000000000000
      200.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    object TitleBand1: TQRBand
      Left = 19
      Top = 38
      Width = 1029
      Height = 40
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        2722.562500000000000000)
      BandType = rbTitle
      object QRLabel1: TQRLabel
        Left = 20
        Top = 12
        Width = 1500
        Height = 27
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          71.437500000000000000
          52.916666666666700000
          31.750000000000000000
          3968.750000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1057#1090#1072#1085#1076#1072#1088#1090#1085#1099#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
        Color = clWhite
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 12
      end
    end
    object ColumnHeaderBand1: TQRBand
      Left = 19
      Top = 78
      Width = 1029
      Height = 34
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = True
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Frame.Width = 2
      AlignToBottom = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New Cyr'
      Font.Style = [fsBold]
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        89.958333333333340000
        2722.562500000000000000)
      BandType = rbColumnHeader
      object QRLabel2: TQRLabel
        Left = 15
        Top = 15
        Width = 14
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          39.687500000000000000
          39.687500000000000000
          37.041666666666670000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'N'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New Cyr'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel3: TQRLabel
        Left = 45
        Top = 15
        Width = 1040
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          119.062500000000000000
          39.687500000000000000
          2751.666666666667000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'Title'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New Cyr'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object DetailBand1: TQRBand
      Left = 19
      Top = 112
      Width = 1029
      Height = 24
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        63.500000000000000000
        2722.562500000000000000)
      BandType = rbDetail
      object QRLabel4: TQRLabel
        Left = 5
        Top = 8
        Width = 28
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          13.229166666666670000
          21.166666666666670000
          74.083333333333340000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'NNN'
        Color = clWhite
        OnPrint = QRLabel4Print
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel5: TQRLabel
        Left = 44
        Top = 8
        Width = 994
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          116.416666666666700000
          21.166666666666670000
          2629.958333333333000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = 'QRLabel5'
        Color = clWhite
        OnPrint = QRLabel5Print
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
  end
  object SG1: TStringGrid
    Left = 0
    Top = 0
    Width = 1214
    Height = 735
    Align = alClient
    DefaultColWidth = 56
    DefaultRowHeight = 18
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 0
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
        Action = ExcAct
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
      OnExecute = PreviewExecute
    end
    object Print: TAction
      Caption = 'Print'
      Hint = 'Print contens of'#13#10'current window'
      ImageIndex = 15
      OnExecute = PrintExecute
    end
    object ExcAct: TAction
      Caption = 'Export to EXCEL'
      ImageIndex = 29
      OnExecute = ExcActExecute
    end
  end
end
