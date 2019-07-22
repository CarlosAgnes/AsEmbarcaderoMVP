inherited dmdMenuCustomizado: TdmdMenuCustomizado
  OldCreateOrder = True
  Height = 209
  Width = 308
  object qryMenuCustomizado: TFDQuery
    Connection = dmdConexao.FDConnection
    SQL.Strings = (
      'select'
      '  id'
      ' ,caption'
      'from'
      '  menu_customizado')
    Left = 96
    Top = 64
    object qryMenuCustomizadoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryMenuCustomizadocaption: TWideMemoField
      FieldName = 'caption'
      Origin = 'caption'
      BlobType = ftWideMemo
    end
  end
end
