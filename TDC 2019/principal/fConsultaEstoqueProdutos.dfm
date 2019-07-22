inherited frmConsultaEstoqueProdutos: TfrmConsultaEstoqueProdutos
  Caption = 'Consulta de Estoque de Produtos'
  ClientHeight = 429
  ClientWidth = 851
  ExplicitWidth = 867
  ExplicitHeight = 468
  PixelsPerInch = 96
  TextHeight = 13
  object dbgProdutos: TDBGrid
    Left = 24
    Top = 8
    Width = 673
    Height = 401
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dtsProdutos
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'estoque_local'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'estoque_rede'
        Width = 100
        Visible = True
      end>
  end
  object btnAtualizar: TButton
    Left = 703
    Top = 8
    Width = 140
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Atualizar'
    TabOrder = 1
    OnClick = btnAtualizarClick
  end
  object qryProdutos: TFDQuery
    Connection = dmdConexao.FDConnection
    SQL.Strings = (
      'select'
      '  id'
      ' ,nome'
      ' ,estoque_local'
      'from'
      '  produto')
    Left = 560
    Top = 32
    object qryProdutosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryProdutosestoque_local: TFloatField
      FieldName = 'estoque_local'
      Origin = 'estoque_local'
    end
    object qryProdutosnome: TWideMemoField
      FieldName = 'nome'
      Origin = 'nome'
      BlobType = ftWideMemo
    end
  end
  object dspProdutos: TDataSetProvider
    DataSet = qryProdutos
    Left = 560
    Top = 80
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProdutos'
    Left = 560
    Top = 128
    object cdsProdutosid: TAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'id'
      ReadOnly = True
    end
    object cdsProdutosnome: TWideMemoField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      OnGetText = cdsProdutosnomeGetText
      BlobType = ftWideMemo
    end
    object cdsProdutosestoque_local: TFloatField
      DisplayLabel = 'Local'
      FieldName = 'estoque_local'
    end
    object cdsProdutosestoque_rede: TFloatField
      DisplayLabel = 'Rede'
      FieldKind = fkInternalCalc
      FieldName = 'estoque_rede'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 560
    Top = 176
  end
  object cdsClone: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 656
    Top = 128
  end
end
