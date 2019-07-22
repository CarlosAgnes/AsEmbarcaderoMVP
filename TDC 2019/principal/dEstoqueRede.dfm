object dmdEstoqueRede: TdmdEstoqueRede
  OldCreateOrder = False
  Height = 371
  Width = 474
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8080/datasnap/rest/api/'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 120
    Top = 48
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'pIDProduto'
        Options = [poAutoCreated]
      end>
    Resource = 'EstoqueTotal/{pIDProduto}'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 120
    Top = 96
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 120
    Top = 144
  end
end
