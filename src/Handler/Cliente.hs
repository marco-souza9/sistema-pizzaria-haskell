{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies, DeriveGeneric #-}
module Handler.Cliente where

import Import

{-formCadastro :: Form (Text,Text,Text,Text,Text,Text,Text,Text,Text)
formCadastro = renderDivs $ (,,,,,,,,) 
    <$> areq textField nomeSettings Nothing
    <*> areq emailField emailSettings Nothing
    <*> areq textField telefoneSettings Nothing
    <*> areq textField cepSettings Nothing
    <*> areq textField logradouroSettings Nothing
    <*> areq textField bairroSettings Nothing
    <*> areq textField cidadeSettings Nothing
    <*> areq textField estadoSettings Nothing    
    <*> areq passwordField senhaSettings Nothing
  where nomeSettings = FieldSettings{fsId= Nothing,
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control"),("placeholder","Nome"),("maxlength","100")]}
        emailSettings = FieldSettings{fsId= Nothing,
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control"),("placeholder","Email"),("maxlength","255")]}
        telefoneSettings = FieldSettings{fsId= Nothing,
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control telefone"),("placeholder","Telefone ou celular"),("maxlength","15")]}
        cepSettings = FieldSettings{fsId= Just "cep",
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control cep"),("placeholder","CEP"),("maxlength","9")]}
        logradouroSettings = FieldSettings{fsId= Just "nomeLogradouro",
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control"),("placeholder","Logradouro"),("maxlength","75")]}
        bairroSettings = FieldSettings{fsId= Just "bairro",
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control"),("placeholder","Bairro"),("maxlength","50")]}
        cidadeSettings = FieldSettings{fsId= Just "cidade",
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control"),("placeholder","Cidade"),("maxlength","50")]}
        estadoSettings = FieldSettings{fsId= Just "estado",
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control"),("placeholder","Estado"),("maxlength","50")]}
                                   
        senhaSettings = FieldSettings{fsId= Nothing,
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control"),("placeholder","Senha"),("maxlength","16")]} -}

getClienteAlterarR :: Handler Html
getClienteAlterarR = undefined {- do    
    (widget, enctype) <- generateFormPost formCadastro
    defaultLayout $ do
        setTitle "Alterar dados cadastrais"
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
        $(whamletFile "templates/alterarCadastroCliente.hamlet")
        --javascript estátic7o
        addScript $ (StaticR js_jquery_1_10_2_min_js) 
        addScript $ (StaticR js_jquery_1_10_2_js)        
        addScript $ (StaticR js_jquery_mixitup_min_js)
        addScript $ (StaticR js_bootstrap_min_js)
        addScript $ (StaticR js_jquery_mask_js)
        addScript $ (StaticR js_jquery_mask_min_js)
        addScript $ (StaticR js_mascaras_js)
        addScript $ (StaticR js_main_js) -}

postClienteAlterarR :: Handler Html
postClienteAlterarR = undefined