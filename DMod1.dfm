object DM1: TDM1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 234
  Top = 185
  Height = 612
  Width = 812
  object DataSource4: TDataSource
    DataSet = qSource
    Left = 122
    Top = 70
  end
  object DataSource2: TDataSource
    DataSet = TabM1
    OnDataChange = DataSource2DataChange
    Left = 248
    Top = 144
  end
  object DataSource3: TDataSource
    DataSet = TabD1
    Left = 98
    Top = 240
  end
  object DSTasks: TDataSource
    DataSet = TTasks
    Left = 683
    Top = 366
  end
  object DSDiagr: TDataSource
    DataSet = TbDiagr
    OnDataChange = DSDiagrDataChange
    Left = 354
    Top = 74
  end
  object DSField: TDataSource
    DataSet = TbFields
    OnDataChange = DSFieldDataChange
    Left = 406
    Top = 180
  end
  object DSLines: TDataSource
    DataSet = TbLines
    Left = 524
    Top = 60
  end
  object DSFPoint: TDataSource
    DataSet = TbFPoint
    Left = 468
    Top = 168
  end
  object DSLPoint: TDataSource
    DataSet = TbLPoint
    Left = 520
    Top = 164
  end
  object DSDiagrID: TDataSource
    DataSet = TbDiagrId
    Left = 416
    Top = 64
  end
  object DSimpF: TDataSource
    DataSet = ImpFields
    Left = 529
    Top = 224
  end
  object DSEdBook: TDataSource
    DataSet = TabEdBook
    Left = 232
    Top = 62
  end
  object DSSin: TDataSource
    DataSet = Sinonims
    Left = 524
    Top = 280
  end
  object DsLists: TDataSource
    DataSet = TabLists
    Left = 169
    Top = 292
  end
  object DSGBod: TDataSource
    DataSet = GBodies
    Left = 414
    Top = 390
  end
  object DSGId: TDataSource
    DataSet = GeolIds
    Left = 268
    Top = 386
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
  object DSDic: TDataSource
    DataSet = Diction
    Left = 524
    Top = 328
  end
  object DSRec: TDataSource
    DataSet = TabRec
    Left = 329
    Top = 496
  end
  object DSVar: TDataSource
    DataSet = TabVars
    Left = 380
    Top = 494
  end
  object DSInterv: TDataSource
    DataSet = TbInterv
    Left = 472
    Top = 60
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
      'al Catalog=PetrosBase;Data Source=SV;'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 21
    Top = 12
  end
  object TabM1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterInsert = TabM1AfterInsert
    BeforePost = TabM1BeforePost
    BeforeDelete = TabM1BeforeDelete
    AfterDelete = TabM1AfterDelete
    IndexFieldNames = 'ArrNum;ArrayName'
    TableName = 'MainRHA'
    Left = 246
    Top = 104
    object TabM1Id2: TIntegerField
      FieldName = 'Id'
    end
    object TabM1ArrayName2: TWideStringField
      FieldName = 'ArrayName'
      Size = 80
    end
    object TabM1Source2: TIntegerField
      FieldName = 'Source'
    end
    object TabM1Type2: TStringField
      FieldName = 'Type'
      FixedChar = True
      Size = 2
    end
    object TabM1NAnal2: TIntegerField
      FieldName = 'NAnal'
    end
    object TabM1NComp2: TIntegerField
      FieldName = 'NComp'
    end
    object TabM1Descript2: TStringField
      FieldName = 'Descript'
      Size = 400
    end
    object TabM1MaxNum2: TIntegerField
      FieldName = 'MaxNum'
    end
    object TabM1MaxHA2: TIntegerField
      FieldName = 'MaxHA'
    end
    object TabM1Title1: TStringField
      FieldName = 'Title1'
      Size = 800
    end
    object TabM1Alfa: TIntegerField
      FieldName = 'Alfa'
    end
    object TabM1ArrNum: TIntegerField
      FieldName = 'ArrNum'
    end
  end
  object TTasks: TADOTable
    Connection = ADOConnection1
    AfterOpen = TbFields1AfterOpen
    IndexFieldNames = 'Name'
    TableName = 'Tasks'
    Left = 636
    Top = 370
  end
  object TTables: TADOTable
    Connection = ADOConnection1
    IndexFieldNames = 'Order'
    TableName = 'Tables'
    Left = 641
    Top = 424
  end
  object TbDiagr: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TbFields1AfterOpen
    IndexFieldNames = 'Name'
    TableName = 'Diagrams'
    Left = 360
    Top = 18
  end
  object TbInterv: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TbFields1AfterOpen
    IndexName = 'Intervals_DiagId'
    MasterFields = 'ID'
    MasterSource = DSDiagrID
    TableName = 'Intervals'
    Left = 474
    Top = 14
  end
  object TbFields1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TbFields1AfterOpen
    BeforePost = TbFields1BeforePost
    AfterPost = TbFields1AfterPost
    AfterCancel = TbFields1AfterCancel
    BeforeDelete = TbFields1BeforeDelete
    BeforeScroll = TbFields1BeforeScroll
    IndexName = 'Fields_DiagrID'
    MasterFields = 'ID'
    MasterSource = DSDiagr
    TableName = 'Fields'
    Left = 349
    Top = 230
  end
  object TbLines: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TbFields1AfterOpen
    AfterPost = TbLinesAfterPost
    AfterCancel = TbLinesAfterCancel
    BeforeDelete = TbLinesBeforeDelete
    BeforeScroll = TbLinesBeforeScroll
    IndexFieldNames = 'DiagID'
    MasterFields = 'ID'
    MasterSource = DSDiagr
    TableName = 'Lines'
    Left = 522
    Top = 16
  end
  object TbFPoint1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TbFields1AfterOpen
    BeforePost = TbFPoint1BeforePost
    AfterPost = TbFPoint1AfterPost
    IndexFieldNames = 'FieldId;TypCod'
    MasterFields = 'ID'
    MasterSource = DSField
    TableName = 'FPoints'
    Left = 298
    Top = 236
  end
  object TbLPoint: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TbFields1AfterOpen
    BeforePost = TbLPointBeforePost
    AfterPost = TbLPointAfterPost
    IndexFieldNames = 'LineID'
    MasterFields = 'ID'
    MasterSource = DSLines
    TableName = 'LPoints'
    Left = 519
    Top = 122
  end
  object TbDiagrId: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TbFields1AfterOpen
    IndexName = 'PK__Diagrams__78B3EFCA'
    TableName = 'Diagrams'
    Left = 416
    Top = 18
  end
  object ImpFields: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TbFields1AfterOpen
    TableName = 'ImpFields'
    Left = 480
    Top = 226
    object ImpFieldsId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
    end
    object ImpFieldsDName: TStringField
      FieldName = 'DName'
      Size = 50
    end
    object ImpFieldsFName: TStringField
      FieldName = 'FName'
      Size = 10
    end
    object ImpFieldsSize: TIntegerField
      FieldName = 'Size'
    end
  end
  object Sinonims: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TbFields1AfterOpen
    IndexName = 'Sinonims_FieldId'
    MasterFields = 'Id'
    MasterSource = DSimpF
    TableName = 'Sinonims'
    Left = 486
    Top = 280
    object SinonimsId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
    end
    object SinonimsFieldId: TIntegerField
      FieldName = 'FieldId'
    end
    object SinonimsText: TStringField
      FieldName = 'Text'
      Size = 50
    end
  end
  object TabEdBook: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TabD1AfterOpen
    BeforePost = TabEdBookBeforePost
    AfterCancel = TabEdBookAfterCancel
    IndexFieldNames = 'Num'
    MasterFields = 'Source'
    TableName = 'Source'
    Left = 231
    Top = 12
  end
  object TabLists: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterPost = TabListsAfterScroll
    BeforeDelete = TabListsBeforeDelete
    AfterDelete = TabListsAfterScroll
    AfterScroll = TabListsAfterScroll
    IndexFieldNames = 'Id'
    TableName = 'Lists'
    Left = 171
    Top = 248
    object TabListsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object TabListsName: TStringField
      FieldName = 'Name'
    end
    object TabListsComment: TStringField
      FieldName = 'Comment'
      Size = 80
    end
  end
  object GeolIds: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterPost = GeolIdsBeforePost
    BeforeDelete = GeolIdsBeforeDelete
    IndexFieldNames = 'GeolID'
    TableName = 'GeolIds'
    Left = 263
    Top = 340
    object GeolIdsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object GeolIdsGeolId: TStringField
      DisplayWidth = 30
      FieldName = 'GeolId'
      Size = 80
    end
    object GeolIdsDescript: TStringField
      FieldName = 'Descript'
      Size = 100
    end
  end
  object GBodies: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterPost = GeolIdsBeforePost
    BeforeDelete = GeolIdsBeforeDelete
    IndexFieldNames = 'GBody'
    TableName = 'GBodies'
    Left = 412
    Top = 346
    object GBodiesID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object GBodiesGBody: TStringField
      DisplayWidth = 30
      FieldName = 'GBody'
      Size = 80
    end
    object GBodiesDescript: TStringField
      FieldName = 'Descript'
      Size = 100
    end
  end
  object Rocks: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterPost = GeolIdsBeforePost
    BeforeDelete = GeolIdsBeforeDelete
    IndexFieldNames = 'Rock'
    TableName = 'Rocks'
    Left = 312
    Top = 336
    object RocksId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
    end
    object RocksRock: TStringField
      DisplayWidth = 30
      FieldName = 'Rock'
      Size = 80
    end
    object RocksDescript: TStringField
      FieldName = 'Descript'
      Size = 50
    end
  end
  object Regions: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterPost = GeolIdsBeforePost
    BeforeDelete = GeolIdsBeforeDelete
    IndexFieldNames = 'Region'
    TableName = 'Regions'
    Left = 357
    Top = 338
    object RegionsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object RegionsRegion: TStringField
      DisplayWidth = 30
      FieldName = 'Region'
      Size = 80
    end
    object RegionsDescript: TStringField
      FieldName = 'Descript'
      Size = 50
    end
  end
  object Diction: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TbFields1AfterOpen
    AfterInsert = DictionAfterInsert
    TableName = 'Dictionar'
    Left = 489
    Top = 328
    object DictionId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
    end
    object DictionFieldId: TIntegerField
      FieldName = 'FieldId'
    end
    object DictionWord: TStringField
      FieldName = 'Word'
      Size = 50
    end
    object DictionDesc: TIntegerField
      FieldName = 'Desc'
    end
  end
  object TabRec: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    BeforeDelete = TabRecBeforeDelete
    IndexFieldNames = 'Id'
    TableName = 'Recalcs'
    Left = 327
    Top = 444
  end
  object TabVars: TADOTable
    Connection = ADOConnection1
    AfterInsert = TabVarsAfterInsert
    BeforePost = TabVarsBeforePost
    IndexFieldNames = 'RecId;Pos'
    MasterFields = 'Id'
    MasterSource = DSRec
    TableName = 'Vars'
    Left = 378
    Top = 442
  end
  object tabElem: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    BeforeDelete = tabElemBeforeDelete
    TableName = 'Elements'
    Left = 31
    Top = 324
  end
  object q1Time: TADOQuery
    Connection = ADOConnection1
    ParamCheck = False
    Parameters = <>
    Left = 630
    Top = 106
  end
  object q2Time: TADOQuery
    Connection = ADOConnection1
    ParamCheck = False
    Parameters = <>
    Left = 699
    Top = 108
  end
  object prClearData: TADOStoredProc
    Connection = ADOConnection1
    ProcedureName = 'ClearData'
    Parameters = <>
    Left = 720
    Top = 280
  end
  object prClearAll: TADOStoredProc
    Connection = ADOConnection1
    ProcedureName = 'ClearAll'
    Parameters = <>
    Left = 716
    Top = 226
  end
  object qAnal: TADOQuery
    Connection = ADOConnection1
    AfterOpen = TabD1AfterOpen
    Parameters = <>
    Left = 630
    Top = 48
  end
  object qAnalLong: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 694
    Top = 48
  end
  object qLongTime1: TADOQuery
    Connection = ADOConnection1
    ParamCheck = False
    Parameters = <>
    Left = 630
    Top = 158
  end
  object qSource: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 124
    Top = 18
  end
  object TabD1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TabD1AfterOpen
    AfterInsert = TabD2AfterInsert
    BeforePost = TabD2BeforePost
    AfterPost = TabD2AfterPost
    BeforeDelete = TabD2BeforeDelete
    OnCalcFields = TabD2CalcFields
    Parameters = <>
    SQL.Strings = (
      'Select * from RHADATA where ArrID=0')
    Left = 96
    Top = 186
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
      Size = 400
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
    object TabD1ArrNum: TStringField
      FieldName = 'ArrNum'
      Size = 50
    end
    object TabD1A95: TFloatField
      FieldName = 'A95'
    end
    object TabD1A96: TFloatField
      FieldName = 'A96'
    end
    object TabD1A97: TFloatField
      FieldName = 'A97'
    end
    object TabD1A98: TFloatField
      FieldName = 'A98'
    end
    object TabD1A99: TFloatField
      FieldName = 'A99'
    end
    object TabD1A100: TFloatField
      FieldName = 'A100'
    end
    object TabD1Alfa: TIntegerField
      FieldName = 'Alfa'
    end
    object TabD1E: TFloatField
      FieldName = 'E'
    end
    object TabD1t: TFloatField
      FieldName = 't'
    end
    object TabD1Tn: TFloatField
      FieldName = 'Tn'
    end
    object TabD1N51: TFloatField
      FieldName = 'N51'
    end
    object TabD1N52: TFloatField
      FieldName = 'N52'
    end
    object TabD1N53: TFloatField
      FieldName = 'N53'
    end
    object TabD1N54: TFloatField
      FieldName = 'N54'
    end
    object TabD1N55: TFloatField
      FieldName = 'N55'
    end
    object TabD1N56: TFloatField
      FieldName = 'N56'
    end
    object TabD1N57: TFloatField
      FieldName = 'N57'
    end
    object TabD1N58: TFloatField
      FieldName = 'N58'
    end
    object TabD1N59: TFloatField
      FieldName = 'N59'
    end
    object TabD1N60: TFloatField
      FieldName = 'N60'
    end
  end
  object TabM2: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterOpen = TabD1AfterOpen
    AfterInsert = TabM1AfterInsert
    BeforePost = TabM1BeforePost
    BeforeDelete = TabM1BeforeDelete
    AfterDelete = TabM1AfterDelete
    IndexFieldNames = 'ArrNum'
    TableName = 'MainRHA'
    Left = 158
    Top = 126
    object IntegerField1: TIntegerField
      FieldName = 'Id'
    end
    object WideStringField1: TWideStringField
      FieldName = 'ArrayName'
      Size = 80
    end
    object IntegerField2: TIntegerField
      FieldName = 'Source'
    end
    object StringField1: TStringField
      FieldName = 'Type'
      FixedChar = True
      Size = 2
    end
    object IntegerField3: TIntegerField
      FieldName = 'NAnal'
    end
    object IntegerField4: TIntegerField
      FieldName = 'NComp'
    end
    object StringField2: TStringField
      FieldName = 'Descript'
      Size = 400
    end
    object IntegerField5: TIntegerField
      FieldName = 'MaxNum'
    end
    object IntegerField6: TIntegerField
      FieldName = 'MaxHA'
    end
    object StringField3: TStringField
      FieldName = 'Title1'
      Size = 800
    end
    object IntegerField7: TIntegerField
      FieldName = 'Alfa'
    end
    object TabM2ArrNum: TIntegerField
      FieldName = 'ArrNum'
    end
  end
  object dsMain: TDataSource
    DataSet = TabM2
    Left = 160
    Top = 180
  end
  object qqCalcFields: TADOQuery
    Connection = ADOConnection1
    ParamCheck = False
    Parameters = <>
    Left = 620
    Top = 240
  end
  object q3Time: TADOQuery
    Connection = ADOConnection1
    ParamCheck = False
    Parameters = <>
    Left = 702
    Top = 164
  end
  object TbFields: TADOQuery
    Connection = ADOConnection1
    AfterInsert = TbFieldsAfterInsert
    Parameters = <>
    SQL.Strings = (
      'select * from Fields')
    Left = 406
    Top = 128
  end
  object TbFPoint: TADOQuery
    Connection = ADOConnection1
    AfterInsert = TbFPointAfterInsert
    Parameters = <>
    SQL.Strings = (
      'select * from Fields')
    Left = 466
    Top = 122
  end
end
