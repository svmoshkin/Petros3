object DMOld: TDMOld
  OldCreateOrder = False
  Left = 48
  Top = 299
  Height = 612
  Width = 812
  object Database1: TDatabase
    AliasName = 'PetrosBase'
    Connected = True
    DatabaseName = 'Petr$$'
    SessionName = 'Default'
    Left = 40
    Top = 11
  end
  object Database2: TDatabase
    AliasName = 'PetrosBase'
    DatabaseName = 'Source'
    SessionName = 'Default'
    Left = 23
    Top = 307
  end
  object TabMain: TTable
    DatabaseName = 'Petr$$'
    IndexFieldNames = 'Source'
    MasterFields = 'Num'
    TableName = 'MainRha.DB'
    Left = 67
    Top = 96
  end
  object TMain: TTable
    DatabaseName = 'Source'
    IndexFieldNames = 'Source'
    MasterFields = 'Id'
    MasterSource = DSSource
    TableName = 'MainRha.DB'
    Left = 80
    Top = 408
  end
  object DSMain: TDataSource
    DataSet = TMain
    Left = 80
    Top = 452
  end
  object TabData: TTable
    CachedUpdates = True
    DatabaseName = 'Petr$$'
    IndexName = 'ArrayId'
    MasterFields = 'Id'
    TableName = 'Rhadata.DB'
    Left = 115
    Top = 92
  end
  object TData: TTable
    DatabaseName = 'Source'
    IndexName = 'ArrayId'
    MasterFields = 'Id'
    MasterSource = DSMain
    TableName = 'Rhadata.DB'
    Left = 120
    Top = 408
  end
  object TabSource: TTable
    DatabaseName = 'Petr$$'
    IndexFieldNames = 'Num'
    TableName = 'Source.DB'
    Left = 11
    Top = 68
  end
  object TSource: TTable
    DatabaseName = 'Source'
    IndexFieldNames = 'Num'
    TableName = 'Source.DB'
    Left = 24
    Top = 408
  end
  object DSSource: TDataSource
    DataSet = TSource
    Left = 24
    Top = 452
  end
  object TabM3: TTable
    DatabaseName = 'Petr$$'
    IndexFieldNames = 'Id'
    TableName = 'MainRha.DB'
    Left = 172
    Top = 100
  end
  object TabS2: TTable
    DatabaseName = 'Petr$$'
    IndexFieldNames = 'Id'
    MasterFields = 'Source'
    MasterSource = DataSource2
    TableName = 'Source.db'
    Left = 164
    Top = 8
  end
  object DataSource4: TDataSource
    DataSet = TabS2
    Left = 164
    Top = 52
  end
  object DataSource2: TDataSource
    DataSet = TabM1
    Left = 248
    Top = 144
  end
  object TabM1: TTable
    AfterInsert = TabM1AfterInsert
    BeforeDelete = TabM1BeforeDelete
    AfterDelete = TabM1AfterDelete
    OnCalcFields = TabM1CalcFields
    DatabaseName = 'Petr$$'
    IndexName = 'IndName'
    TableName = 'MainRha.DB'
    Left = 252
    Top = 104
    object TabM1Id: TAutoIncField
      FieldName = 'Id'
    end
    object TabM1ArrayName: TStringField
      DisplayLabel = 'Data set name'
      FieldName = 'ArrayName'
      Required = True
      Size = 80
    end
    object TabM1Source: TIntegerField
      FieldName = 'Source'
    end
    object TabM1Type: TStringField
      FieldName = 'Type'
      Size = 2
    end
    object TabM1Title1: TStringField
      FieldName = 'Title1'
      Required = True
      Size = 255
    end
    object TabM1Title2: TStringField
      FieldName = 'Title2'
      Size = 255
    end
    object TabM1NAnal: TSmallintField
      FieldName = 'NAnal'
    end
    object TabM1NComp: TSmallintField
      FieldName = 'NComp'
      Required = True
    end
    object TabM1Descript: TStringField
      FieldName = 'Descript'
      Size = 255
    end
    object TabM1MaxNum: TIntegerField
      FieldName = 'MaxNum'
    end
    object TabM1Tit: TStringField
      FieldKind = fkCalculated
      FieldName = 'Tit'
      Size = 510
      Calculated = True
    end
    object TabM1MAxHA: TIntegerField
      CustomConstraint = 'X>2 and X<51'
      FieldName = 'MAxHA'
    end
  end
  object DataSource3: TDataSource
    DataSet = TabD1
    Left = 28
    Top = 212
  end
  object TabD1: TTable
    AutoCalcFields = False
    CachedUpdates = True
    AfterInsert = TabD1AfterInsert
    BeforePost = TabD1BeforePost
    AfterPost = TabD1AfterPost
    BeforeDelete = TabD1BeforeDelete
    OnCalcFields = TabD1CalcFields
    DatabaseName = 'Petr$$'
    IndexName = 'ArrayId'
    MasterFields = 'Id'
    MasterSource = DataSource2
    TableName = 'RHADATA.db'
    Left = 32
    Top = 168
    object TabD1AnId: TAutoIncField
      FieldName = 'AnId'
      ReadOnly = True
    end
    object TabD1ArrId: TIntegerField
      FieldName = 'ArrId'
    end
    object TabD1H: TFloatField
      DisplayLabel = 'Entropy'
      FieldName = 'H'
    end
    object TabD1A: TFloatField
      FieldName = 'A'
    end
    object TabD1AN: TFloatField
      DisplayLabel = 'Anentopy'
      FieldName = 'AN'
    end
    object TabD1R: TStringField
      DisplayLabel = 'Rank formula'
      FieldName = 'R'
      Size = 200
    end
    object TabD1Eq: TStringField
      FieldName = 'Eq'
    end
    object TabD1Descript: TStringField
      DisplayLabel = 'Description'
      FieldName = 'Descript'
      Required = True
      Size = 100
    end
    object TabD1N1: TFloatField
      FieldName = 'N1'
    end
    object TabD1N2: TFloatField
      FieldName = 'N2'
    end
    object TabD1N3: TFloatField
      FieldName = 'N3'
    end
    object TabD1N4: TFloatField
      FieldName = 'N4'
    end
    object TabD1N5: TFloatField
      FieldName = 'N5'
    end
    object TabD1N6: TFloatField
      FieldName = 'N6'
    end
    object TabD1N7: TFloatField
      FieldName = 'N7'
    end
    object TabD1N8: TFloatField
      FieldName = 'N8'
    end
    object TabD1N9: TFloatField
      FieldName = 'N9'
    end
    object TabD1N10: TFloatField
      FieldName = 'N10'
    end
    object TabD1N11: TFloatField
      FieldName = 'N11'
    end
    object TabD1N12: TFloatField
      FieldName = 'N12'
    end
    object TabD1N13: TFloatField
      FieldName = 'N13'
    end
    object TabD1N14: TFloatField
      FieldName = 'N14'
    end
    object TabD1N15: TFloatField
      FieldName = 'N15'
    end
    object TabD1N16: TFloatField
      FieldName = 'N16'
    end
    object TabD1N17: TFloatField
      FieldName = 'N17'
    end
    object TabD1N18: TFloatField
      FieldName = 'N18'
    end
    object TabD1N19: TFloatField
      FieldName = 'N19'
    end
    object TabD1N20: TFloatField
      FieldName = 'N20'
    end
    object TabD1N21: TFloatField
      FieldName = 'N21'
    end
    object TabD1N22: TFloatField
      FieldName = 'N22'
    end
    object TabD1N23: TFloatField
      FieldName = 'N23'
    end
    object TabD1N24: TFloatField
      FieldName = 'N24'
    end
    object TabD1N25: TFloatField
      FieldName = 'N25'
    end
    object TabD1N26: TFloatField
      FieldName = 'N26'
    end
    object TabD1N27: TFloatField
      FieldName = 'N27'
    end
    object TabD1N28: TFloatField
      FieldName = 'N28'
    end
    object TabD1N29: TFloatField
      FieldName = 'N29'
    end
    object TabD1N30: TFloatField
      FieldName = 'N30'
    end
    object TabD1N31: TFloatField
      FieldName = 'N31'
    end
    object TabD1N32: TFloatField
      FieldName = 'N32'
    end
    object TabD1N33: TFloatField
      FieldName = 'N33'
    end
    object TabD1N34: TFloatField
      FieldName = 'N34'
    end
    object TabD1N35: TFloatField
      FieldName = 'N35'
    end
    object TabD1N36: TFloatField
      FieldName = 'N36'
    end
    object TabD1N37: TFloatField
      FieldName = 'N37'
    end
    object TabD1N38: TFloatField
      FieldName = 'N38'
    end
    object TabD1N39: TFloatField
      FieldName = 'N39'
    end
    object TabD1N40: TFloatField
      FieldName = 'N40'
    end
    object TabD1N41: TFloatField
      FieldName = 'N41'
    end
    object TabD1N42: TFloatField
      FieldName = 'N42'
    end
    object TabD1N43: TFloatField
      FieldName = 'N43'
    end
    object TabD1N44: TFloatField
      FieldName = 'N44'
    end
    object TabD1N45: TFloatField
      FieldName = 'N45'
    end
    object TabD1N46: TFloatField
      FieldName = 'N46'
    end
    object TabD1N47: TFloatField
      FieldName = 'N47'
    end
    object TabD1N48: TFloatField
      FieldName = 'N48'
    end
    object TabD1N49: TFloatField
      FieldName = 'N49'
    end
    object TabD1N50: TFloatField
      FieldName = 'N50'
    end
    object TabD1A1: TFloatField
      FieldName = 'A1'
    end
    object TabD1A2: TFloatField
      FieldName = 'A2'
    end
    object TabD1A3: TFloatField
      FieldName = 'A3'
    end
    object TabD1A4: TFloatField
      FieldName = 'A4'
    end
    object TabD1A5: TFloatField
      FieldName = 'A5'
    end
    object TabD1A6: TFloatField
      FieldName = 'A6'
    end
    object TabD1A7: TFloatField
      FieldName = 'A7'
    end
    object TabD1A8: TFloatField
      FieldName = 'A8'
    end
    object TabD1A9: TFloatField
      FieldName = 'A9'
    end
    object TabD1A10: TFloatField
      FieldName = 'A10'
    end
    object TabD1A11: TFloatField
      FieldName = 'A11'
    end
    object TabD1A12: TFloatField
      FieldName = 'A12'
    end
    object TabD1A13: TFloatField
      FieldName = 'A13'
    end
    object TabD1A14: TFloatField
      FieldName = 'A14'
    end
    object TabD1A15: TFloatField
      FieldName = 'A15'
    end
    object TabD1A16: TFloatField
      FieldName = 'A16'
    end
    object TabD1A17: TFloatField
      FieldName = 'A17'
    end
    object TabD1A18: TFloatField
      FieldName = 'A18'
    end
    object TabD1A19: TFloatField
      FieldName = 'A19'
    end
    object TabD1A20: TFloatField
      FieldName = 'A20'
    end
    object TabD1A21: TFloatField
      FieldName = 'A21'
    end
    object TabD1A22: TFloatField
      FieldName = 'A22'
    end
    object TabD1A23: TFloatField
      FieldName = 'A23'
    end
    object TabD1A24: TFloatField
      FieldName = 'A24'
    end
    object TabD1A25: TFloatField
      FieldName = 'A25'
    end
    object TabD1A26: TFloatField
      FieldName = 'A26'
    end
    object TabD1A27: TFloatField
      FieldName = 'A27'
    end
    object TabD1A28: TFloatField
      FieldName = 'A28'
    end
    object TabD1A29: TFloatField
      FieldName = 'A29'
    end
    object TabD1A30: TFloatField
      FieldName = 'A30'
    end
    object TabD1A31: TFloatField
      FieldName = 'A31'
    end
    object TabD1A32: TFloatField
      FieldName = 'A32'
    end
    object TabD1A33: TFloatField
      FieldName = 'A33'
    end
    object TabD1A34: TFloatField
      FieldName = 'A34'
    end
    object TabD1A35: TFloatField
      FieldName = 'A35'
    end
    object TabD1A36: TFloatField
      FieldName = 'A36'
    end
    object TabD1A37: TFloatField
      FieldName = 'A37'
    end
    object TabD1A38: TFloatField
      FieldName = 'A38'
    end
    object TabD1A39: TFloatField
      FieldName = 'A39'
    end
    object TabD1A40: TFloatField
      FieldName = 'A40'
    end
    object TabD1A41: TFloatField
      FieldName = 'A41'
    end
    object TabD1A42: TFloatField
      FieldName = 'A42'
    end
    object TabD1A43: TFloatField
      FieldName = 'A43'
    end
    object TabD1A44: TFloatField
      FieldName = 'A44'
    end
    object TabD1A45: TFloatField
      FieldName = 'A45'
    end
    object TabD1A46: TFloatField
      FieldName = 'A46'
    end
    object TabD1A47: TFloatField
      FieldName = 'A47'
    end
    object TabD1A48: TFloatField
      FieldName = 'A48'
    end
    object TabD1A49: TFloatField
      FieldName = 'A49'
    end
    object TabD1A50: TFloatField
      FieldName = 'A50'
    end
    object TabD1A51: TFloatField
      FieldName = 'A51'
    end
    object TabD1A52: TFloatField
      FieldName = 'A52'
    end
    object TabD1A53: TFloatField
      FieldName = 'A53'
    end
    object TabD1A54: TFloatField
      FieldName = 'A54'
    end
    object TabD1A55: TFloatField
      FieldName = 'A55'
    end
    object TabD1A56: TFloatField
      FieldName = 'A56'
    end
    object TabD1A57: TFloatField
      FieldName = 'A57'
    end
    object TabD1A58: TFloatField
      FieldName = 'A58'
    end
    object TabD1A59: TFloatField
      FieldName = 'A59'
    end
    object TabD1A60: TFloatField
      FieldName = 'A60'
    end
    object TabD1A61: TFloatField
      FieldName = 'A61'
    end
    object TabD1A62: TFloatField
      FieldName = 'A62'
    end
    object TabD1A63: TFloatField
      FieldName = 'A63'
    end
    object TabD1A64: TFloatField
      FieldName = 'A64'
    end
    object TabD1A65: TFloatField
      FieldName = 'A65'
    end
    object TabD1A66: TFloatField
      FieldName = 'A66'
    end
    object TabD1A67: TFloatField
      FieldName = 'A67'
    end
    object TabD1A68: TFloatField
      FieldName = 'A68'
    end
    object TabD1A69: TFloatField
      FieldName = 'A69'
    end
    object TabD1A70: TFloatField
      FieldName = 'A70'
    end
    object TabD1A71: TFloatField
      FieldName = 'A71'
    end
    object TabD1A72: TFloatField
      FieldName = 'A72'
    end
    object TabD1A73: TFloatField
      FieldName = 'A73'
    end
    object TabD1A74: TFloatField
      FieldName = 'A74'
    end
    object TabD1A75: TFloatField
      FieldName = 'A75'
    end
    object TabD1A76: TFloatField
      FieldName = 'A76'
    end
    object TabD1A77: TFloatField
      FieldName = 'A77'
    end
    object TabD1A78: TFloatField
      FieldName = 'A78'
    end
    object TabD1A79: TFloatField
      FieldName = 'A79'
    end
    object TabD1A80: TFloatField
      FieldName = 'A80'
    end
    object TabD1A81: TFloatField
      FieldName = 'A81'
    end
    object TabD1A82: TFloatField
      FieldName = 'A82'
    end
    object TabD1A83: TFloatField
      FieldName = 'A83'
    end
    object TabD1A84: TFloatField
      FieldName = 'A84'
    end
    object TabD1A85: TFloatField
      FieldName = 'A85'
    end
    object TabD1A86: TFloatField
      FieldName = 'A86'
    end
    object TabD1A87: TFloatField
      FieldName = 'A87'
    end
    object TabD1A88: TFloatField
      FieldName = 'A88'
    end
    object TabD1A89: TFloatField
      FieldName = 'A89'
    end
    object TabD1A90: TFloatField
      FieldName = 'A90'
    end
    object TabD1A91: TFloatField
      FieldName = 'A91'
    end
    object TabD1A92: TFloatField
      FieldName = 'A92'
    end
    object TabD1X: TStringField
      FieldName = 'X'
      Size = 11
    end
    object TabD1Y: TStringField
      FieldName = 'Y'
      Size = 11
    end
    object TabD1Ox: TFloatField
      FieldName = 'Ox'
    end
    object TabD1AW: TFloatField
      FieldName = 'AW'
    end
    object TabD1AWA: TFloatField
      FieldName = 'AWA'
    end
    object TabD1Num: TIntegerField
      DisplayLabel = 'Number'
      FieldName = 'Num'
    end
    object TabD1Sample: TStringField
      DisplayLabel = 'SampleID'
      FieldName = 'Sample'
      Size = 16
    end
    object TabD1Summa: TFloatField
      FieldName = 'Summa'
    end
    object TabD1Source: TIntegerField
      FieldName = 'Source'
    end
    object TabD1GeolId: TIntegerField
      FieldName = 'GeolId'
    end
    object TabD1Rock: TIntegerField
      FieldName = 'Rock'
    end
    object TabD1Region: TIntegerField
      FieldName = 'Region'
    end
    object TabD1GBody: TIntegerField
      FieldName = 'GBody'
    end
    object TabD1LGId: TStringField
      DisplayLabel = 'Geol. ident.'
      FieldKind = fkLookup
      FieldName = 'LGId'
      LookupDataSet = GeolIds
      LookupKeyFields = 'ID'
      LookupResultField = 'GeolID'
      KeyFields = 'GeolId'
      Lookup = True
    end
    object TabD1LRoc: TStringField
      DisplayLabel = 'Rock'
      FieldKind = fkLookup
      FieldName = 'LRoc'
      LookupDataSet = Rocks
      LookupKeyFields = 'Id'
      LookupResultField = 'Rock'
      KeyFields = 'Rock'
      Lookup = True
    end
    object TabD1LReg: TStringField
      DisplayLabel = 'Region'
      FieldKind = fkLookup
      FieldName = 'LReg'
      LookupDataSet = Regions
      LookupKeyFields = 'ID'
      LookupResultField = 'Region'
      KeyFields = 'Region'
      Lookup = True
    end
    object TabD1LGBod: TStringField
      DisplayLabel = 'Geol. body'
      FieldKind = fkLookup
      FieldName = 'LGBod'
      LookupDataSet = GBodies
      LookupKeyFields = 'Id'
      LookupResultField = 'GBody'
      KeyFields = 'GBody'
      Lookup = True
    end
    object TabD1LSource: TStringField
      FieldKind = fkCalculated
      FieldName = 'LSource'
      Size = 255
      Calculated = True
    end
    object TabD1A93: TFloatField
      FieldName = 'A93'
    end
    object TabD1A94: TFloatField
      FieldName = 'A94'
    end
    object TabD1MolFact: TFloatField
      FieldName = 'MolFact'
    end
    object TabD1MolFactAW: TFloatField
      FieldName = 'MolFactAW'
    end
  end
  object TabD2: TTable
    DatabaseName = 'Petr$$'
    TableName = 'RHADATA.db'
    Left = 104
    Top = 164
  end
  object DataSource5: TDataSource
    DataSet = TabD2
    Left = 106
    Top = 214
  end
  object TTasks: TTable
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'Name'
    TableName = 'Tasks.DB'
    Left = 520
    Top = 370
  end
  object TTables: TTable
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'Order'
    TableName = 'Tables.db'
    Left = 468
    Top = 372
  end
  object QuData: TQuery
    DatabaseName = 'Source'
    Left = 148
    Top = 356
  end
  object QuMain: TQuery
    DatabaseName = 'Source'
    Left = 80
    Top = 356
  end
  object QuSource: TQuery
    DatabaseName = 'Source'
    Left = 24
    Top = 360
  end
  object DSTasks: TDataSource
    DataSet = TTasks
    Left = 524
    Top = 416
  end
  object TbDiagr: TTable
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'Name'
    TableName = 'Diagrams.DB'
    Left = 356
    Top = 12
  end
  object TbInterv: TTable
    DatabaseName = 'PetrosBase'
    IndexName = 'DiagId'
    MasterFields = 'ID'
    MasterSource = DSDiagr
    TableName = 'Intervals.DB'
    Left = 464
    Top = 12
  end
  object TbFields: TTable
    BeforePost = TbFieldsBeforePost
    AfterPost = TbFieldsAfterPost
    AfterCancel = TbFieldsAfterCancel
    BeforeDelete = TbFieldsBeforeDelete
    BeforeScroll = TbFieldsBeforeScroll
    DatabaseName = 'PetrosBase'
    IndexName = 'DiagrID'
    MasterFields = 'ID'
    MasterSource = DSDiagr
    TableName = 'Fields.DB'
    Left = 412
    Top = 116
  end
  object DSDiagr: TDataSource
    DataSet = TbDiagr
    Left = 360
    Top = 60
  end
  object DSField: TDataSource
    DataSet = TbFields
    Left = 412
    Top = 168
  end
  object TbLines: TTable
    AfterPost = TbLinesAfterPost
    AfterCancel = TbLinesAfterCancel
    BeforeDelete = TbLinesBeforeDelete
    BeforeScroll = TbLinesBeforeScroll
    DatabaseName = 'PetrosBase'
    IndexName = 'DiagID'
    MasterFields = 'ID'
    MasterSource = DSDiagr
    TableName = 'Lines.DB'
    Left = 512
    Top = 8
  end
  object DSLines: TDataSource
    DataSet = TbLines
    Left = 524
    Top = 60
  end
  object TbFPoint: TTable
    BeforePost = TbFPointBeforePost
    AfterPost = TbFPointAfterPost
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'FieldId;TypCod'
    MasterFields = 'ID'
    MasterSource = DSField
    TableName = 'FPoints.DB'
    Left = 464
    Top = 116
  end
  object DSFPoint: TDataSource
    DataSet = TbFPoint
    Left = 468
    Top = 168
  end
  object TbLPoint: TTable
    BeforePost = TbLPointBeforePost
    AfterPost = TbLPointAfterPost
    DatabaseName = 'PetrosBase'
    IndexName = 'LineId'
    MasterFields = 'ID'
    MasterSource = DSLines
    TableName = 'LPoints.DB'
    Left = 520
    Top = 116
  end
  object DSLPoint: TDataSource
    DataSet = TbLPoint
    Left = 520
    Top = 164
  end
  object TbClassIn: TTable
    DatabaseName = 'Petr$$'
    IndexName = 'DiagrAn'
    MasterFields = 'ID'
    MasterSource = DSDiagrID
    TableName = 'Classif.DB'
    Left = 220
    Top = 190
  end
  object TbDiagrId: TTable
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'ID'
    TableName = 'Diagrams.DB'
    Left = 412
    Top = 12
  end
  object DSDiagrID: TDataSource
    DataSet = TbDiagrId
    Left = 416
    Top = 64
  end
  object TbClassOut: TTable
    DatabaseName = 'Petr$$'
    IndexFieldNames = 'Anal'
    MasterFields = 'AnId'
    MasterSource = DataSource5
    ReadOnly = True
    TableName = 'Classif.DB'
    Left = 280
    Top = 188
  end
  object ImpFields: TTable
    DatabaseName = 'PetrosBase'
    TableName = 'ImpFields.db'
    Left = 468
    Top = 228
    object ImpFieldsId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
    end
    object ImpFieldsDName: TStringField
      DisplayLabel = 'Field in PETROS base'
      FieldName = 'DName'
      Size = 30
    end
    object ImpFieldsFName: TStringField
      FieldName = 'FName'
      Size = 10
    end
    object ImpFieldsSize: TIntegerField
      FieldName = 'Size'
    end
  end
  object DSimpF: TDataSource
    DataSet = ImpFields
    Left = 520
    Top = 228
  end
  object Sinonims: TTable
    DatabaseName = 'PetrosBase'
    IndexName = 'FId'
    MasterFields = 'Id'
    MasterSource = DSimpF
    TableName = 'Sinonims.db'
    Left = 480
    Top = 280
    object SinonimsId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
    end
    object SinonimsFieldId: TIntegerField
      FieldName = 'FieldId'
    end
    object SinonimsText: TStringField
      DisplayLabel = 'Sinonims of field name'
      FieldName = 'Text'
      Size = 30
    end
  end
  object DSEdBook: TDataSource
    DataSet = TabEdBook
    Left = 232
    Top = 52
  end
  object TabEdBook: TTable
    BeforePost = TabEdBookBeforePost
    AfterCancel = TabEdBookAfterCancel
    DatabaseName = 'Petr$$'
    IndexName = 'N'
    MasterFields = 'Source'
    TableName = 'Source.db'
    Left = 244
    Top = 8
  end
  object DSSin: TDataSource
    DataSet = Sinonims
    Left = 524
    Top = 280
  end
  object TabD3: TTable
    DatabaseName = 'Petr$$'
    IndexFieldNames = 'Sample'
    TableName = 'RHAData.DB'
    Left = 184
    Top = 148
  end
  object TabClass: TTable
    DatabaseName = 'Petr$$'
    SessionName = 'Default'
    TableName = 'Classif.DB'
    Left = 8
    Top = 116
  end
  object TClassif: TTable
    DatabaseName = 'Source'
    SessionName = 'Default'
    IndexFieldNames = 'Anal'
    MasterFields = 'AnId'
    MasterSource = DSData
    TableName = 'Classif.DB'
    Left = 188
    Top = 400
  end
  object DSData: TDataSource
    DataSet = QuData
    Left = 188
    Top = 356
  end
  object TabLists: TTable
    AfterPost = TabListsAfterScroll
    BeforeDelete = TabListsBeforeDelete
    AfterDelete = TabListsAfterScroll
    AfterScroll = TabListsAfterScroll
    DatabaseName = 'Petr$$'
    SessionName = 'Default'
    IndexFieldNames = 'Id'
    TableName = 'Lists.db'
    Left = 172
    Top = 225
    object TabListsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object TabListsName: TStringField
      DisplayLabel = 'List name'
      FieldName = 'Name'
    end
    object TabListsComment: TStringField
      DisplayLabel = 'Comment '
      FieldName = 'Comment'
      Size = 80
    end
  end
  object DsLists: TDataSource
    DataSet = TabLists
    Left = 172
    Top = 268
  end
  object TabListData: TTable
    DatabaseName = 'Petr$$'
    SessionName = 'Default'
    IndexName = 'List'
    MasterFields = 'ID'
    MasterSource = DsLists
    TableName = 'ListData.DB'
    Left = 232
    Top = 244
    object TabListDataID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object TabListDataList: TIntegerField
      FieldName = 'List'
    end
    object TabListDataAnal: TIntegerField
      FieldName = 'Anal'
    end
    object TabListDataSample: TStringField
      DisplayLabel = 'Sample ID'
      FieldKind = fkLookup
      FieldName = 'Sample'
      LookupDataSet = TabD2
      LookupKeyFields = 'AnId'
      LookupResultField = 'Sample'
      KeyFields = 'Anal'
      Size = 16
      Lookup = True
    end
    object TabListDataDescr: TStringField
      FieldKind = fkLookup
      FieldName = 'Descr'
      LookupDataSet = TabD2
      LookupKeyFields = 'AnId'
      LookupResultField = 'Descript'
      KeyFields = 'Anal'
      Lookup = True
    end
  end
  object DSListData: TDataSource
    DataSet = TabListData
    Left = 240
    Top = 292
  end
  object GeolIds: TTable
    AfterPost = GeolIdsBeforePost
    BeforeDelete = GeolIdsBeforeDelete
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'GeolID'
    TableName = 'GeolIds.db'
    Left = 412
    Top = 216
    object GeolIdsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object GeolIdsGeolID: TStringField
      DisplayLabel = 'Geol. ident.'
      FieldName = 'GeolID'
    end
    object GeolIdsDescript: TStringField
      DisplayLabel = 'Description'
      FieldName = 'Descript'
      Size = 40
    end
  end
  object GBodies: TTable
    AfterPost = GeolIdsBeforePost
    BeforeDelete = GeolIdsBeforeDelete
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'GBody'
    TableName = 'GBodies.db'
    Left = 416
    Top = 308
    object GBodiesId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
      Visible = False
    end
    object GBodiesGBody: TStringField
      DisplayLabel = 'Geol. body'
      FieldName = 'GBody'
    end
    object GBodiesDescript: TStringField
      DisplayLabel = 'Description'
      FieldName = 'Descript'
      Size = 40
    end
  end
  object Rocks: TTable
    AfterPost = GeolIdsBeforePost
    BeforeDelete = GeolIdsBeforeDelete
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'Rock'
    TableName = 'Rocks.DB'
    Left = 304
    Top = 336
    object RocksId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
      Visible = False
    end
    object RocksRock: TStringField
      FieldName = 'Rock'
    end
    object RocksDescript: TStringField
      DisplayLabel = 'Description'
      FieldName = 'Descript'
      Size = 40
    end
  end
  object Regions: TTable
    AfterPost = GeolIdsBeforePost
    BeforeDelete = GeolIdsBeforeDelete
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'Region'
    TableName = 'Regions.db'
    Left = 364
    Top = 336
    object RegionsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object RegionsRegion: TStringField
      FieldName = 'Region'
    end
    object RegionsDescript: TStringField
      DisplayLabel = 'Description'
      FieldName = 'Descript'
      Size = 40
    end
  end
  object DSGBod: TDataSource
    DataSet = GBodies
    Left = 416
    Top = 352
  end
  object DSGId: TDataSource
    DataSet = GeolIds
    Left = 412
    Top = 260
  end
  object DSReg: TDataSource
    DataSet = Regions
    Left = 364
    Top = 384
  end
  object DSRoc: TDataSource
    DataSet = Rocks
    Left = 312
    Top = 384
  end
  object MainData: TTable
    DatabaseName = 'PetrosBase'
    FilterOptions = [foCaseInsensitive]
    TableName = 'RHAData.DB'
    Left = 473
    Top = 471
  end
  object Diction: TTable
    AfterInsert = DictionAfterInsert
    DatabaseName = 'PetrosBase'
    IndexName = 'FieldId'
    MasterFields = 'Id'
    MasterSource = DSimpF
    TableName = 'Dictionar.DB'
    Left = 468
    Top = 328
    object DictionId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
    end
    object DictionFieldId: TIntegerField
      FieldName = 'FieldId'
    end
    object DictionWord: TStringField
      DisplayLabel = 'Sinonim'
      FieldName = 'Word'
      Size = 40
    end
    object DictionDesc: TIntegerField
      DisplayLabel = 'Description'
      FieldName = 'Desc'
    end
  end
  object DSDic: TDataSource
    DataSet = Diction
    Left = 524
    Top = 328
  end
  object TabRec: TTable
    BeforeDelete = TabRecBeforeDelete
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'Id'
    TableName = 'Recalcs.db'
    Left = 328
    Top = 436
  end
  object DSRec: TDataSource
    DataSet = TabRec
    Left = 332
    Top = 480
  end
  object TabVars: TTable
    AfterInsert = TabVarsAfterInsert
    BeforePost = TabVarsBeforePost
    DatabaseName = 'PetrosBase'
    IndexFieldNames = 'RecId;Pos'
    MasterFields = 'Id'
    MasterSource = DSRec
    TableName = 'Vars.DB'
    Left = 376
    Top = 440
  end
  object DSVar: TDataSource
    DataSet = TabVars
    Left = 380
    Top = 484
  end
  object DSInterv: TDataSource
    DataSet = TbInterv
    Left = 472
    Top = 60
  end
  object tabElem: TTable
    DatabaseName = 'PetrosBase'
    TableName = 'Elements.db'
    Left = 308
    Top = 244
  end
  object TabS1: TTable
    DatabaseName = 'Petr$$'
    IndexFieldNames = 'Id'
    TableName = 'Source.db'
    Left = 108
    Top = 8
  end
  object q1time: TQuery
    DatabaseName = 'Petr$$'
    Left = 638
    Top = 56
  end
  object q2time: TQuery
    DatabaseName = 'Petr$$'
    Left = 676
    Top = 60
  end
  object qLongTime: TQuery
    DatabaseName = 'Petr$$'
    Left = 718
    Top = 64
  end
end
