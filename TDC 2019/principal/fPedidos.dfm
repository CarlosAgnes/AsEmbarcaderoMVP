inherited frmPedidos: TfrmPedidos
  Caption = 'Emitir Pedido'
  ClientHeight = 325
  ClientWidth = 731
  ExplicitWidth = 747
  ExplicitHeight = 364
  PixelsPerInch = 96
  TextHeight = 13
  object dbgPedido: TDBGrid
    Left = 8
    Top = 56
    Width = 513
    Height = 261
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dtsPedido
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnEmitir: TButton
    Left = 535
    Top = 8
    Width = 188
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Emitir'
    TabOrder = 1
    OnClick = btnEmitirClick
  end
  object GridPanel1: TGridPanel
    Left = 8
    Top = 9
    Width = 217
    Height = 41
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = lblCodigoCliente
        Row = 0
      end
      item
        Column = 0
        Control = edtCodigoCliente
        Row = 1
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 21.000000000000000000
      end>
    TabOrder = 2
    object lblCodigoCliente: TLabel
      Left = 0
      Top = 7
      Width = 217
      Height = 13
      Align = alBottom
      Caption = 'C'#243'digo Cliente'
      ExplicitWidth = 69
    end
    object edtCodigoCliente: TEdit
      Left = 0
      Top = 20
      Width = 217
      Height = 21
      Align = alClient
      TabOrder = 0
      Text = '321123'
    end
  end
  object mmoLog: TMemo
    Left = 535
    Top = 56
    Width = 188
    Height = 261
    TabOrder = 3
  end
  object cdsPedido: TClientDataSet
    PersistDataPacket.Data = {
      540000009619E0BD01000000180000000200000000000300000054000A69645F
      70726F6475746F04000100000000000A76616C6F725F6974656D080004000000
      010007535542545950450200490006004D6F6E6579000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 440
    Top = 40
    object cdsPedidoid_produto: TIntegerField
      DisplayLabel = 'C'#243'digo Produto'
      DisplayWidth = 17
      FieldName = 'id_produto'
    end
    object cdsPedidovalor_item: TCurrencyField
      DisplayLabel = 'Total Item'
      DisplayWidth = 11
      FieldName = 'valor_item'
    end
  end
  object dtsPedido: TDataSource
    DataSet = cdsPedido
    Left = 440
    Top = 96
  end
end
