function verificaSenha(input,nomeSenha) {
    if (input.value != document.getElementById(nomeSenha).value) {
        input.setCustomValidity('Senhas devem ser iguais.');
    } else {
        input.setCustomValidity('');
    }
}
