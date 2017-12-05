{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies, DeriveGeneric #-}
module Handler.Produto where

import Import

formCadastro :: Form (Text, Maybe FileInfo,Textarea,Double,Text)
formCadastro = renderTable $ (,,,,) 
    <$> areq textField nomeSettings Nothing
    <*> aopt fileField arquivoSettings Nothing
    <*> areq textareaField  descricaoSettings Nothing
    <*> areq doubleField precoSettings Nothing
    <*> areq (selectFieldList [("Pizza" :: Text, "pizza"),("Promoções", "promocoes"),("Bebidas", "bebidas"),("Sobremesas","sobremesas")]) tipoSettings Nothing
  where nomeSettings = FieldSettings{fsId= Nothing,
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control inputForm"),("placeholder","Nome do produto"),("maxlength","50")]}
        arquivoSettings = FieldSettings{fsId= Nothing,
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control inputForm")]}
        tipoSettings = FieldSettings{fsId= Nothing,
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control inputForm")]}                   
        descricaoSettings = FieldSettings{fsId= Nothing,
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control inputForm"),("placeholder","Descrição do produto"),("maxlength","200")]}
        precoSettings = FieldSettings{fsId= Nothing,
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control inputForm"),("placeholder","Preço")]}

getProdutoListarR :: Handler Html
getProdutoListarR =  do
    promocoes <- runDB $ selectList [ProdutoTipo ==. "promocoes"] []
    pizzas <- runDB $ selectList [ProdutoTipo ==. "pizza"] []
    sobremesas <- runDB $ selectList [ProdutoTipo ==. "sobremesas"] []
    bebidas <- runDB $ selectList [ProdutoTipo ==. "bebidas"] []
    defaultLayout $ do 
        setTitle "Cardápio"
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
        $(whamletFile "templates/cardapio.hamlet")
        --javascript estático
        addScript $ (StaticR js_jquery_1_10_2_min_js) 
        addScript $ (StaticR js_jquery_1_10_2_js)        
        addScript $ (StaticR js_jquery_mixitup_min_js)
        addScript $ (StaticR js_bootstrap_min_js)
        
getAdmProdutoGerenciarR :: Handler Html
getAdmProdutoGerenciarR =  do    
    (widget, enctype) <- generateFormPost formCadastro
    defaultLayout $ do
        setTitle "Gerenciar Produto"
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
        $(whamletFile "templates/gerenciarProduto.hamlet")
        --javascript estático
        addScript $ (StaticR js_jquery_1_10_2_min_js) 
        addScript $ (StaticR js_jquery_1_10_2_js)        
        addScript $ (StaticR js_jquery_mixitup_min_js)
        addScript $ (StaticR js_bootstrap_min_js)
        addScript $ (StaticR js_jquery_mask_js)
        addScript $ (StaticR js_jquery_mask_min_js)
        addScript $ (StaticR js_mascaras_js)


postAdmProdutoCadastrarR :: Handler Html 
postAdmProdutoCadastrarR = do 
    ((res,_),_) <- runFormPost formCadastro
    case res of 
        FormSuccess (nomeP,imagemP,descricaoP,precoP,tipoP) -> do 
            case imagemP of
                Just imagem -> do
                    _ <- runDB $ insert (Produto nomeP (unTextarea descricaoP) precoP (pack ("/static/img/uploads" ++ (removeCaracteres (unpack $ fileName imagem) " "))) True tipoP)
                    liftIO $ fileMove imagem ("static/img/uploads" ++ (removeCaracteres (unpack $ fileName imagem) " "))
                    redirect $ AdmProdutoGerenciarR
                _ -> do 
                    _ <- runDB $ insert (Produto nomeP (unTextarea descricaoP) precoP "/static/img/padrao.png" True tipoP)
                    redirect $ AdmProdutoGerenciarR
        _ -> redirect $ AdmProdutoGerenciarR
        
postAdmProdutoAlterarR :: Handler Html
postAdmProdutoAlterarR = undefined

postAdmProdutoOcultarR :: Handler Html
postAdmProdutoOcultarR = undefined