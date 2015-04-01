var PrLogin = function() {
    function register() {
        var widget = $('#dialog-register').dialog('widget');
        $.ajax({
            url:        'index.php?route=module/pr_login/register',
            type:       'post',
            data:       $('#register-form').serialize(),
            dataType:   'json',
            beforeSend: function() {
                widget.find('.ui-dialog-buttonset button:first').attr('disabled', true);
                widget.find('.ui-dialog-buttonset').prepend('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },
            complete:   function() {
                $('.wait').remove();
            },
            success:    function(json) {
                $('.warning, .error').remove();
                if (json['redirect']) {
                    if (json['success']) {
                        $('#dialog-register').dialog('option', 'buttons', []);
                        $('#register-form').before(json['success']).remove();
                        setTimeout(function() {
                            location = json['redirect']
                        }, 3000);
                    }
                    else {
                        location = json['redirect'];
                    }
                }
                else if (json['error']) {
                    if (json['error']['warning']) {
                        $('#register-form').before('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                        $('.warning').fadeIn('slow');
                    }
                    if (json['error']['firstname']) {
                        $('#register-form input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
                    }
                    if (json['error']['lastname']) {
                        $('#register-form input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
                    }
                    if (json['error']['email']) {
                        $('#register-form input[name=\'email\']').after('<span class="error">' + json['error']['email'] + '</span>');
                    }
                    if (json['error']['telephone']) {
                        $('#register-form input[name=\'telephone\']').after('<span class="error">' + json['error']['telephone'] + '</span>');
                    }
                    if (json['error']['password']) {
                        $('#register-form input[name=\'password\']').after('<span class="error">' + json['error']['password'] + '</span>');
                    }
                    if (json['error']['confirm']) {
                        $('#register-form input[name=\'confirm\']').after('<span class="error">' + json['error']['confirm'] + '</span>');
                    }
                    widget.find('.ui-dialog-buttonset button:first').attr('disabled', false);
                }
            },
            error:      function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

    function login() {
        $('#dialog-login').find('.error').remove();
        var widget = $('#dialog-login').dialog('widget');
        var email = $('#login-form input[name=\'email\']');
        var password = $('#login-form input[name=\'password\']');
        if ('' == email.val()) {
            email.after('<span class="error">Укажите E-Mail</span>');
            return;
        }
        if ('' == password.val()) {
            password.after('<span class="error">Укажите пароль</span>');
            return;
        }
        $.ajax({
            url:        'index.php?route=module/pr_login/login',
            type:       'post',
            data:       $('#login-form').serialize(),
            dataType:   'json',
            beforeSend: function() {
                widget.find('.ui-dialog-buttonset button:first').attr('disabled', true);
                widget.find('.ui-dialog-buttonset').prepend('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },
            complete:   function() {
                $('.wait').remove();
                widget.find('.ui-dialog-buttonset button:first').attr('disabled', false);
            },
            success:    function(json) {
                $('.warning, .error').remove();
                if (json['redirect']) {
                    location = json['redirect'];
                }
                else if (json['error']) {
                    if (json['error']['warning']) {
                        $('#dialog-login').height(165);
                        $('#login-form').before('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                        $('.warning').fadeIn('slow');
                    }
                }
            },
            error:      function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

    return {
        register: register,
        login:    login
    };
}();
$(function() {
    var welcome = $('#welcome');
    welcome.find('a:first').attr('id', 'open-login');
    welcome.find('a:last').attr('id', 'open-register');

    var dialogLogin = $('<div></div>').attr('id', 'dialog-login');
    var dialogRegister = $('<div></div>').attr('id', 'dialog-register');
    $('body').append(dialogLogin, dialogRegister);

    var register_load = false;
    dialogRegister.dialog({
        autoOpen:  false,
        modal:     true,
        minHeight: 370,
        width:     350,
        title:     'Регистрация',
        buttons:   {
            "Отправить": function() {
                PrLogin.register();
            },
            "Отменить":  function() {
                $(this).dialog('close');
            }
        },
        open:      function(event, ui) {
            if (!register_load) {
                $.get('index.php?route=module/pr_login/register_form', function(html) {
                    dialogRegister.html(html);
                    $('#register-form input:first').focus();
                    register_load = true;
                }, 'html');
            }
        }
    });
    dialogLogin.dialog({
        autoOpen:  false,
        modal:     true,
        minHeight: 215,
        width:     300,
        title:     'Вход в Личный кабинет',
        buttons:   {
            "Отправить": function() {
                PrLogin.login();
            },
            "Отменить":  function() {
                $(this).dialog('close');
            }
        },
        open:      function(event, ui) {
            $.get('index.php?route=module/pr_login/login_form', function(html) {
                dialogLogin.html(html);
                $('#login-form input:first').focus();
            }, 'html');
        }
    });
    $('#open-register').click(function() {
        dialogRegister.dialog('open');
        return false;
    });
    $('#open-login').click(function() {
        dialogLogin.dialog('open');
        return false;
    });
    $('#register-form').live('submit', function() {
        PrLogin.register();
        return false;
    });
    $('#login-form').live('submit', function() {
        PrLogin.login();
        return false;
    });
});