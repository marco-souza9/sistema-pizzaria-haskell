var options = {
	onKeyPress: function (cpf, ev, el, op) {
		var masks = ['000.000.000-000', '00.000.000/0000-00'],
			mask = (cpf.length > 14) ? masks[1] : masks[0];
		el.mask(mask, op);
	}
}

var SPMaskBehavior = function (val) {
return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
},
spOptions = {
onKeyPress: function(val, e, field, options) {
	field.mask(SPMaskBehavior.apply({}, arguments), options);
  }
};

$('.cpfcnpj').mask('000.000.000-000', options);
$('.cpf').mask('000.000.000-000');
$('.cnpj').mask('00.000.000/0000-00');
$('.residencial').mask('(00) 0000-0000');
$('.celular').mask(SPMaskBehavior, spOptions);
$('.cep').mask('00000-000');
$('.date').mask('00/00/0000');