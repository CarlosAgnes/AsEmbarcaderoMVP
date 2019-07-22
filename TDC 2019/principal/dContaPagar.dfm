inherited dmdContaPagar: TdmdContaPagar
  Height = 258
  Width = 379
  object qryChecarContasPagarVencendo: TFDQuery
    Connection = dmdConexao.FDConnection
    SQL.Strings = (
      'select '
      '  count(1) resultado'
      'from '
      '  conta_pagar'
      'where'
      '  data_vencimento <= :data_vencimento and'
      '  situacao = 0')
    Left = 104
    Top = 32
    ParamData = <
      item
        Name = 'DATA_VENCIMENTO'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object qryChecarContasPagarVencendoresultado: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'resultado'
      Origin = 'resultado'
      ProviderFlags = []
      ReadOnly = True
    end
  end
end
