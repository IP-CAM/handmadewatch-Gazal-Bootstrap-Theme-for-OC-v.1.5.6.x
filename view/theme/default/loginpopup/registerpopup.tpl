<div class="headingpop"><h2><?php echo $heading_title;?></h2></div>
<div class="popregister">
	<div class="left">
	<fieldset>
		<legend><?php echo $text_your_details; ?></legend>
		 <span class="required">*</span> <?php echo $entry_firstname; ?><br />
		  <input type="text" name="firstname" value="" class="large-field" />
		  <br />

		  <span class="required">*</span> <?php echo $entry_lastname; ?><br />
		  <input type="text" name="lastname" value="" class="large-field" />
		  <br />

		  <span class="required">*</span> <?php echo $entry_email; ?><br />
		  <input type="text" name="email" value="" class="large-field" />
		  <br />

		  <span class="required">*</span> <?php echo $entry_telephone; ?><br />
		  <input type="text" name="telephone" value="" class="large-field" />
		  <br />

		  <?php echo $entry_fax; ?><br />
		  <input type="text" name="fax" value="" class="large-field" />
		  <br />
	</fieldset>
	
  	<fieldset>
		<legend><?php echo $text_your_password; ?></legend>
		<span class="required">*</span> <?php echo $entry_password; ?><br />
	  <input type="password" name="password" value="" class="large-field" />
	  <br />

	  <span class="required">*</span> <?php echo $entry_confirm; ?> <br />
	  <input type="password" name="confirm" value="" class="large-field" />
	  <br />
	</fieldset>
</div>
<div class="right">
	<fieldset>
		<legend><?php echo $text_your_address; ?></legend>
		<?php echo $entry_company; ?><br />
		  <input type="text" name="company" value="" class="large-field" />
		  <br />
		  <div style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;">
		  <?php echo $entry_customer_group; ?><br />
		  <?php foreach ($customer_groups as $customer_group) { ?>
		  <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
		  <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
		  <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
		  <br />
		  <?php } else { ?>
		  <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
		  <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
		  <br />
		  <?php } ?>
		  <?php } ?>
		  <br />
		</div>
		<div id="company-id-display"><span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?><br />
		  <input type="text" name="company_id" value="" class="large-field" />
		  <br />
		</div>
		<div id="tax-id-display"><span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?><br />
		  <input type="text" name="tax_id" value="" class="large-field" />
		  <br />

		</div>
		<span class="required">*</span> <?php echo $entry_address_1; ?><br />
		<input type="text" name="address_1" value="" class="large-field" />
		<br />

		<?php echo $entry_address_2; ?><br />
		<input type="text" name="address_2" value="" class="large-field" />
		<br />

		<span class="required">*</span> <?php echo $entry_city; ?><br />
		<input type="text" name="city" value="" class="large-field" />
		<br />

		<span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?><br />
		<input type="text" name="postcode" value="" class="large-field" />
		<br />

		<span class="required">*</span> <?php echo $entry_country; ?><br />
		<select name="country_id" class="large-field">
		  <option value=""><?php echo $text_select; ?></option>
		  <?php foreach ($countries as $country) { ?>
		  <?php if ($country['country_id'] == $country_id) { ?>
		  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
		  <?php } else { ?>
		  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
		  <?php } ?>
		  <?php } ?>
		</select>
		<br />

		<span class="required">*</span> <?php echo $entry_zone; ?><br />
		<select name="zone_id" class="large-field">
		</select>
		<br />
	</fieldset>
	 <input type="hidden" name="redirect" value="<?php echo $redirect;?>" />
	 
</div>
<div style="clear: both;height:5px"></div>
<?php if ($text_agree) { ?>
<div class="buttons">
  <div class="right"><?php echo $text_agree; ?>
    <input type="checkbox" name="agree" value="1" />
    <input type="button" value="<?php echo $button_continue; ?>" id="popbutton-register" class="button" />
  </div>
</div>
<?php } else { ?>
<div class="buttons">
  <div class="right">
    <input type="button" value="<?php echo $button_continue; ?>" id="popbutton-register" class="button" />
  </div>
</div>
<?php } ?>
</div>
<script type="text/javascript"><!--
$('input[name=\'redirect\']').attr('value',window.location.href);
$('.popregister input[name=\'customer_group_id\']:checked').live('change', function() {
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}	
	}
});

$('.popregister input[name=\'customer_group_id\']:checked').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('.popregister select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('.popregister select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#payment-postcode-required').show();
			} else {
				$('#payment-postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {

				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('.popregister select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('.popregister select[name=\'country_id\']').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	width: 640,
	height: 480,
	onClosed : function(){
		$('#welcome > a + a').trigger('click');
	}
});
$('#popbutton-register').live('click', function() {
	$.ajax({
		url: 'index.php?route=common/popup/oregistervalidate',
		type: 'post',
		data: $('.popregister input[type=\'text\'], .popregister input[type=\'password\'], .popregister input[type=\'checkbox\']:checked, .popregister input[type=\'radio\']:checked, .popregister input[type=\'hidden\'], .popregister select'),
		dataType: 'json',
		beforeSend: function() {
			$('#popbutton-register').attr('disabled', true);
			$('#popbutton-register').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#popbutton-register').attr('disabled', false); 
			$('.wait').remove();
		},			
		success: function(json) {
			$('.warning, .error').remove();
						
			if (json['redirect']) {
				$.colorbox.resize()
				location = json['redirect'];				
			} else if (json['error']) {
				if (json['error']['warning']) {
					$('.popregister').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
					$('.warning').fadeIn('slow');
				}
				
				if (json['error']['firstname']) {
					$('.popregister input[name=\'firstname\'] + br').after('<span class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('.popregister input[name=\'lastname\'] + br').after('<span class="error">' + json['error']['lastname'] + '</span>');
				}	
				
				if (json['error']['email']) {
					$('.popregister input[name=\'email\'] + br').after('<span class="error">' + json['error']['email'] + '</span>');
				}
				
				if (json['error']['telephone']) {
					$('.popregister input[name=\'telephone\'] + br').after('<span class="error">' + json['error']['telephone'] + '</span>');
				}	
					
				if (json['error']['company_id']) {
					$('.popregister input[name=\'company_id\'] + br').after('<span class="error">' + json['error']['company_id'] + '</span>');
				}	
				
				if (json['error']['tax_id']) {
					$('.popregister input[name=\'tax_id\'] + br').after('<span class="error">' + json['error']['tax_id'] + '</span>');
				}	
																		
				if (json['error']['address_1']) {
					$('.popregister input[name=\'address_1\'] + br').after('<span class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('.popregister input[name=\'city\'] + br').after('<span class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('.popregister input[name=\'postcode\'] + br').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('.popregister select[name=\'country_id\'] + br').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('.popregister select[name=\'zone_id\'] + br').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
				
				if (json['error']['password']) {
					$('.popregister input[name=\'password\'] + br').after('<span class="error">' + json['error']['password'] + '</span>');
				}	
				
				if (json['error']['confirm']) {
					$('.popregister input[name=\'confirm\'] + br').after('<span class="error">' + json['error']['confirm'] + '</span>');
				}
				$.colorbox.resize();								
			}
		}
	});	
});
//--></script> 