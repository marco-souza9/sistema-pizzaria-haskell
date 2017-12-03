{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies, DeriveGeneric #-}
module Handler.Pedido where

import Import
import Database.Persist.Sql
import Data.Time
import Prelude (read) 

verificarStatusPedido :: Int -> Text
verificarStatusPedido 1 = "Aberto"
verificarStatusPedido 2 = "Montando"
verificarStatusPedido 3 = "A caminho"
verificarStatusPedido 4 = "Finalizado"
verificarStatusPedido _ = "Cancelado"

verificarStatusPedidoCor :: Int -> Text
verificarStatusPedidoCor 1 = "Green"
verificarStatusPedidoCor 2 = "Blue"
verificarStatusPedidoCor 3 = "Yellow"
verificarStatusPedidoCor 4 = "DarkGreen"
verificarStatusPedidoCor _ = "DarkRed"

formatarData :: UTCTime -> String
formatarData dt = formatTime defaultTimeLocale dateTimeFormat dt
    where dateTimeFormat = "%d/%m/%Y"
    
buscarPedidos :: Maybe Text -> Handler [Entity Pedido]
buscarPedidos (Just valor) = runDB $ selectList [PedidoUsuario ==. (chave)] []
    where
        valorInt = read (unpack valor) :: Int
        chave = toSqlKey (fromIntegral (valorInt) ) :: UsuarioId

getPedidoListarR :: Handler Html
getPedidoListarR = do
    usuId <- lookupSession "usuId"
    pedidos <- buscarPedidos $ usuId
    defaultLayout $ do
        setTitle "Meus pedidos"
        --css estático
        addStylesheet $ (StaticR css_bootstrap_css)
        addStylesheet $ (StaticR css_font_awesome_min_css)
        addStylesheet $ (StaticR css_jquery_ui_css)
        addStylesheet $ (StaticR css_main_css)
        addStylesheet $ (StaticR css_normalize_css)
        addStylesheet $ (StaticR css_picto_foundry_food_css)
        addStylesheet $ (StaticR css_style_portfolio_css)
        --corpo html
        $(whamletFile "templates/commons/navbarcli.hamlet")
        $(whamletFile "templates/listarPedidosCliente.hamlet")
        --javascript estátic7o
        addScript $ (StaticR js_jquery_1_10_2_min_js) 
        addScript $ (StaticR js_jquery_1_10_2_js)        
        addScript $ (StaticR js_jquery_mixitup_min_js)
        addScript $ (StaticR js_bootstrap_min_js)
        addScript $ (StaticR js_jquery_mask_js)
        addScript $ (StaticR js_jquery_mask_min_js)
        addScript $ (StaticR js_mascaras_js)
        addScript $ (StaticR js_main_js) 

getPedidoDetalharR :: Handler Html
getPedidoDetalharR = undefined
getPedidoAberDetalharR :: Handler Html
getPedidoAberDetalharR = undefined

postPedidoAberAlterarR :: Handler Html
postPedidoAberAlterarR = undefined

getPedidoAberConcluirR :: Handler Html
getPedidoAberConcluirR = undefined

postPedidoAberConcluirR :: Handler Html
postPedidoAberConcluirR = undefined

getAdmPedidoListarR :: Handler Html
getAdmPedidoListarR = undefined

getAdmPedidoDetalharR :: PedidoId -> Handler Html
getAdmPedidoDetalharR id = undefined

postAdmPedidoAlterarR :: PedidoId -> Handler Html 
postAdmPedidoAlterarR id= undefined