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
import Prelude (read,head,foldl,length) 

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

retornarIdsCarrinho :: [(Int,Int)] -> [Key Produto]
retornarIdsCarrinho xs = [(toSqlKey $ fromIntegral $ fst x) :: ProdutoId | x <- xs]

retornaQuantidadeCarrinho :: ProdutoId -> [(Int,Int)] -> Int
retornaQuantidadeCarrinho pid xs = Prelude.head [snd x | x <- xs, pid == (toSqlKey $ fromIntegral $ fst x)]

getPedidoAberDetalharR :: Handler Html
getPedidoAberDetalharR = do
    carrinho <- lookupSession "carrinho"
    lista <- return $ retornarCarrinho carrinho
    listaIdProdutos <- return $ retornarIdsCarrinho lista
    produtos <- runDB $ selectList [ProdutoId <-. listaIdProdutos] []
    defaultLayout $ do
        setTitle "Carrinho"
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
        $(whamletFile "templates/carrinho.hamlet")
        --javascript estátic7o
        addScript $ (StaticR js_jquery_1_10_2_min_js) 
        addScript $ (StaticR js_jquery_1_10_2_js)        
        addScript $ (StaticR js_jquery_mixitup_min_js)
        addScript $ (StaticR js_bootstrap_min_js)
        addScript $ (StaticR js_jquery_mask_js)
        addScript $ (StaticR js_jquery_mask_min_js)
        addScript $ (StaticR js_mascaras_js)
        addScript $ (StaticR js_main_js)   

retornarCarrinho :: Maybe Text -> [(Int,Int)]
retornarCarrinho (Just valor) = read (unpack valor) :: [(Int,Int)]

adicionarCarrinho :: Int -> [(Int,Int)] -> [(Int,Int)]
adicionarCarrinho id [] = [(id,1)]
adicionarCarrinho id (x:xs) 
            | fst x == id = (id,(snd x) + 1) : xs
            | otherwise = x : adicionarCarrinho id xs


postPedidoAberAdicionarR :: ProdutoId -> Handler Html
postPedidoAberAdicionarR pid = do
    carrinho <- lookupSession "carrinho"
    lista <- return $ retornarCarrinho carrinho
    novoCarrinho <- return $ adicionarCarrinho (fromIntegral (fromSqlKey pid) :: Int) lista
    setSession "carrinho" $ pack $ show novoCarrinho
    redirect PedidoAberDetalharR

postPedidoAberAlterarR :: Handler Html
postPedidoAberAlterarR = undefined

buscarEndereco :: Maybe Text -> HandlerT App IO (Maybe (Entity Endereco))
buscarEndereco (Just valor) = runDB $ selectFirst [EnderecoUsuario ==. (chave)] []
    where
        valorInt = read (unpack valor) :: Int
        chave = toSqlKey (fromIntegral (valorInt) ) :: UsuarioId

getPedidoAberConcluirR :: Handler Html
getPedidoAberConcluirR = do
    usuId <- lookupSession "usuId"
    endereco <- buscarEndereco usuId
    formas <- runDB $ selectList [FormaPagamentoDisponivel !=. False]  []
    defaultLayout $ do
        setTitle "Finalizar pedido"
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
        $(whamletFile "templates/formaPagamentoCliente.hamlet")
        --javascript estátic7o
        addScript $ (StaticR js_jquery_1_10_2_min_js) 
        addScript $ (StaticR js_jquery_1_10_2_js)        
        addScript $ (StaticR js_jquery_mixitup_min_js)
        addScript $ (StaticR js_bootstrap_min_js)
        addScript $ (StaticR js_jquery_mask_js)
        addScript $ (StaticR js_jquery_mask_min_js)
        addScript $ (StaticR js_mascaras_js)
        addScript $ (StaticR js_main_js)   

retornarIdUsuario :: Maybe Text ->Key Usuario
retornarIdUsuario (Just valor) = chave
    where
        valorInt = read (unpack valor) :: Int
        chave = toSqlKey (fromIntegral (valorInt) ) :: UsuarioId
        
calculaTotal :: [(Produto,Double)] -> Double
calculaTotal [] = 0.0
calculaTotal (x:xs) = ((produtoPreco $ fst x) * (snd x)) + calculaTotal xs

postPedidoAberConcluirR :: Handler Html
postPedidoAberConcluirR = do
    formaId <- runInputPost $ ireq intField "formaId"
    usuid <- lookupSession "usuId";
    uid <- return $ retornarIdUsuario usuid
    carrinho <- lookupSession "carrinho"
    lista <- return $ retornarCarrinho carrinho
    precos <- runDB $ mapM (get404 . (toSqlKey :: Int64 -> ProdutoId) . fromIntegral . fst) lista 
    quantidades <- return [ (fromIntegral $ snd x) :: Double | x <- lista]
    conjunto <- return $ zip precos quantidades
    total <- return $ calculaTotal conjunto
    
    dataAtual <- liftIO $ getCurrentTime
    fid <- return $ (toSqlKey $ fromIntegral formaId :: FormaPagamentoId)
    pid <- runDB $ insert (Pedido uid fid total 1 dataAtual)
    
    redirect PedidoListarR

mostraPedido :: Entity Pedido -> Widget
mostraPedido (Entity pid pedido) =  do
    usuario <- handlerToWidget $ runDB $ get404 $ pedidoUsuario pedido
    [whamlet|
            <table>
                <tr>
                    <td width="30%">
                        <p>
                            <b>#{usuarioNome usuario}
                        <p style="margin-top:3px;">#{usuarioCpf usuario}
                        <p style="margin-top:3px;">#{formatarData $ pedidoData pedido}
                    <td width="40%">
                    <td>
                    <td width="30%">
                        <select>
                            <option value="pizza">Em aberto
                            <option value="bebida">Montando
                            <option value="sobremesa">Finalizado
                        
                    <td width="15%">
                    <td width="20%">
                        <p>
                            <h2>R$#{show $ pedidoTotal pedido} 
            
            <hr>
    |] 

getAdmPedidoListarR :: Handler Html
getAdmPedidoListarR = do
    pedidos <- runDB $ selectList [PedidoStatus !=. 4, PedidoStatus !=. 5] []
    defaultLayout $ do
        setTitle "Pedidos listados"
        --css estático
        addStylesheet $ (StaticR css_bootstrap_css)
        addStylesheet $ (StaticR css_font_awesome_min_css)
        addStylesheet $ (StaticR css_jquery_ui_css)
        addStylesheet $ (StaticR css_main_css)
        addStylesheet $ (StaticR css_normalize_css)
        addStylesheet $ (StaticR css_picto_foundry_food_css)
        addStylesheet $ (StaticR css_style_portfolio_css)
        --corpo html
        $(whamletFile "templates/commons/navbaradm.hamlet")
        $(whamletFile "templates/listarPedidosAdm.hamlet")
        --javascript estátic7o
        addScript $ (StaticR js_jquery_1_10_2_min_js) 
        addScript $ (StaticR js_jquery_1_10_2_js)        
        addScript $ (StaticR js_jquery_mixitup_min_js)
        addScript $ (StaticR js_bootstrap_min_js)
        addScript $ (StaticR js_jquery_mask_js)
        addScript $ (StaticR js_jquery_mask_min_js)
        addScript $ (StaticR js_mascaras_js)
        addScript $ (StaticR js_main_js) 

getAdmPedidoDetalharR :: PedidoId -> Handler Html
getAdmPedidoDetalharR id = do
    defaultLayout $ do
        setTitle "Pedido detalhado"
        --css estático
        addStylesheet $ (StaticR css_bootstrap_css)
        addStylesheet $ (StaticR css_font_awesome_min_css)
        addStylesheet $ (StaticR css_jquery_ui_css)
        addStylesheet $ (StaticR css_main_css)
        addStylesheet $ (StaticR css_normalize_css)
        addStylesheet $ (StaticR css_picto_foundry_food_css)
        addStylesheet $ (StaticR css_style_portfolio_css)
        --corpo html
        $(whamletFile "templates/commons/navbaradm.hamlet")
        $(whamletFile "templates/pedidoDetalhado.hamlet")
        --javascript estátic7o
        addScript $ (StaticR js_jquery_1_10_2_min_js) 
        addScript $ (StaticR js_jquery_1_10_2_js)        
        addScript $ (StaticR js_jquery_mixitup_min_js)
        addScript $ (StaticR js_bootstrap_min_js)
        addScript $ (StaticR js_jquery_mask_js)
        addScript $ (StaticR js_jquery_mask_min_js)
        addScript $ (StaticR js_mascaras_js)
        addScript $ (StaticR js_main_js)   

postAdmPedidoAlterarR :: PedidoId -> Handler Html 
postAdmPedidoAlterarR id = undefined