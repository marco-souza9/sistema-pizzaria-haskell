{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Pedido where

import Import

getPedidoListarR :: Handler Html
getPedidoListarR = undefined

getPedidoDetalharR :: PedidoId -> Handler Html
getPedidoDetalharR id = undefined

getPedidoAberDetalharR :: PedidoId -> Handler Html
getPedidoAberDetalharR id= undefined

postPedidoAberAlterarR :: PedidoId -> Handler Html
postPedidoAberAlterarR id = undefined

getPedidoAberConcluirR :: PedidoId -> Handler Html
getPedidoAberConcluirR id = undefined

postPedidoAberConcluirR :: PedidoId -> Handler Html
postPedidoAberConcluirR id = undefined

getAdmPedidoListarR :: Handler Html
getAdmPedidoListarR = undefined

getAdmPedidoDetalharR :: PedidoId -> Handler Html
getAdmPedidoDetalharR id = undefined

getAdmPedidoAlterarR :: PedidoId -> Handler Html
getAdmPedidoAlterarR id = undefined

postAdmPedidoAlterarR :: PedidoId -> Handler Html
postAdmPedidoAlterarR id = undefined