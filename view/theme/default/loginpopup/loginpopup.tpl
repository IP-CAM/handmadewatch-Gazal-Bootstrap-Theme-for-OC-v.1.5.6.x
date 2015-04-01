<div class="headingpop"><h2><?php echo $heading_title;?></h2></div>
<div class="poplogin">
        <div class="content">
          <b><?php echo $entry_email; ?></b><br />
          <input type="text" name="email" value="" />
          <br />
          <br />
          <b><?php echo $entry_password; ?></b><br />
          <input type="password" name="password" value="" />
          <br />
          <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
          <br />
          <input type="submit" id="popbutton-login" value="<?php echo $button_login; ?>" class="button" />
          <input type="hidden" name="redirect" value="<?php echo $redirect;?>" />
        </div>
</div>
<script type="text/javascript"><!--
	//fix to all redirect
	$('input[name=\'redirect\']').attr('value',window.location.href);
	$('#popbutton-login').live('click', function() {
	$.ajax({
		url: 'index.php?route=common/popup/ologinvalidate',
		type: 'post',
		data: $('.poplogin input[type=\'text\'], .poplogin input[type=\'password\'], .poplogin input[type=\'hidden\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#popbutton-login').attr('disabled', true);
			$('#popbutton-login').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#popbutton-login').attr('disabled', false); 
			$('.wait').remove();
		},			
		success: function(json) {
			$('.warning, .error').remove();
						
			if (json['redirect']) {
				$.colorbox.resize();	
				location = json['redirect'];				
			} else if (json['error']) {
				if (json['error']['warning']) {
					$('.poplogin').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
					$('.warning').fadeIn('slow');
				}

				if (json['error']['email']) {
					$('.poplogin input[name=\'email\'] + br').after('<span class="error">' + json['error']['email'] + '</span>');
				}
				
				if (json['error']['password']) {
					$('.poplogin input[name=\'password\'] + br').after('<span class="error">' + json['error']['password'] + '</span>');
				}	
				$.colorbox.resize()								
			}
		}
	});	
});
//--></script>