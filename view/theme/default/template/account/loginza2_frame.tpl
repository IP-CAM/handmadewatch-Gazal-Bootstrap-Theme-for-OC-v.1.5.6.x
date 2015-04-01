<script type="text/javascript" src="catalog/view/javascript/jquery/loginza2-jquery.js"></script>

<style>
h1
{    
	font-family: "Trebuchet MS","Arial";
	color: #0099FF;
    font-size: 24px;
	padding-left: 5px;
}

p
{
	font-family: "Trebuchet MS","Arial";
	color: #999999;
	padding-left: 5px;
}

td
{
	font-family: "Trebuchet MS","Arial";
	color: #000;
	padding: 5px;
}

input[type=submit]
{
	  background-color: #F0F0F0;
    background-image: url("/img/widget/button_bg.gif");
    background-repeat: repeat-x;
    border: 1px solid #C4C4C4;
    color: #838383;
    font-family: "Arial";
    font-size: 18px;
    font-weight: bold;
    padding: 5px;
}

input[type=text]
{
	border: 1px #ccc solid;
	width: 160px;
}


input[type=submit]:hover
{
	background-color: #F4FAFD;
    background-image: url("http://loginza.ru/img/widget/button_hover_bg.gif");
    border: 1px solid #D3ECFD;
    color: #2E9CD8;
}

.err
{
	color: red;
	font-family: "Trebuchet MS","Arial";
	font-weight: bold;
	padding-left: 5px;
}

</style>
<h1><? echo $header; ?></h1>
<p><? echo $header_notice; ?></p>
<form action="<? echo $action; ?>" method="POST">
<table>
<? if( $is_firstname ) { ?>
<tr>
	<td><? echo $entry_firstname; ?><? if( $firstname_required ) echo "*"; ?></td>
	<td><input type="text" name="firstname" value="<? echo $firstname; ?>"><? if( $error_firstname ) { ?><span class="err"><? echo $error_firstname; 
	?></span><? } ?></td>
</tr>
<? } ?>

<? if( $is_lastname ) { ?>
<tr>
	<td width=80><? echo $entry_lastname; ?><? if( $lastname_required ) echo "*"; ?></td>
	<td><input type="text" name="lastname" value="<? echo $lastname; ?>"><? if( $error_lastname ) { ?><span class="err"><? echo $error_lastname; 
	?></span><? } ?></td>
</tr>
<? } ?>

<? if( $is_email ) { ?>
<tr>
	<td width=80><? echo $entry_email; ?><? if( $email_required ) echo "*"; ?></td>
	<td><input type="text" name="email" value="<? echo $email; ?>"><? if( $error_email ) { ?><span class="err"><? echo $error_email; 
	?></span><? } ?></td>
</tr>
<? } ?>

<? if( $is_telephone ) { ?>
<tr>
	<td width=80><? echo $entry_telephone; ?><? if( $telephone_required ) echo "*"; ?></td>
	<td><input type="text" name="telephone" value="<? echo $telephone; ?>"><? if( $error_telephone ) { ?><span class="err"><? echo $error_telephone; 
	?></span><? } ?></td>
</tr>
<? } ?>

<? if( $is_company ) { ?>
<tr>
	<td width=80><? echo $entry_company; ?><? if( $company_required ) echo "*"; ?></td>
	<td><input type="text" name="company" value="<? echo $company; ?>">
	<? if( $error_company ) { ?><span class="err"><? echo $error_company; ?></span><? } ?></td>
</tr>
<? } ?>

<? if( $is_postcode ) { ?>
<tr>
	<td width=80><? echo $entry_postcode; ?><? if( $postcode_required ) echo "*"; ?></td>
	<td><input type="text" name="postcode" value="<? echo $postcode; ?>">
	<? if( $error_postcode ) { ?><span class="err"><? echo $error_postcode; ?></span><? } ?></td>
</tr>
<? } ?>

<? if( $is_country ) { ?>
<tr>
	<td width=80><? echo $entry_country; ?><? if( $country_required ) echo "*"; ?></td>
	<td><select name="country">
              <?php foreach ($countries as $item) { ?>
              <?php if ($item['country_id'] == $country) { ?>
              <option value="<?php echo $item['country_id']; ?>" selected="selected"><?php echo $item['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $item['country_id']; ?>"><?php echo $item['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
	<? if( $error_country ) { ?><span class="err"><? echo $error_country; ?></span><? } ?></td>
</tr>
<? } ?>

<? if( $is_zone ) { ?>
<tr>
	<td width=80><? echo $entry_zone; ?><? if( $zone_required ) echo "*"; ?>
		<? if( empty($is_country) ) {  ?> 
		<div style="display: none;">
		<select name="country">
              <?php foreach ($countries as $item) { ?>
              <?php if ($item['country_id'] == $country) { ?>
              <option value="<?php echo $item['country_id']; ?>" selected="selected"><?php echo $item['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $item['country_id']; ?>"><?php echo $item['name']; ?></option>
              <?php } ?>
              <?php } ?>
        </select></div>
		<? } ?>
	
	</td>
	<td><select name="zone">
            </select>
	<? if( $error_zone ) { ?><span class="err"><? echo $error_zone; ?></span><? } ?></td>
</tr>
<? } ?>

<? if( $is_city ) { ?>
<tr>
	<td width=80><? echo $entry_city; ?><? if( $city_required ) echo "*"; ?></td>
	<td><input type="text" name="city" value="<? echo $city; ?>">
	<? if( $error_city ) { ?><span class="err"><? echo $error_city; ?></span><? } ?></td>
</tr>
<? } ?>

<? if( $is_address_1 ) { ?>
<tr>
	<td width=80><? echo $entry_address_1; ?><? if( $address_1_required ) echo "*"; ?></td>
	<td><input type="text" name="address_1" value="<? echo $address_1; ?>">
	<? if( $error_address_1 ) { ?><span class="err"><? echo $error_address_1; ?></span><? } ?></td>
</tr>
<? } ?>

<tr>
	<td width=80></td>
	<td><input type="submit" value="<? echo $text_submit; ?>"></td>
</tr>
</table>
<? if( $is_zone ) { ?>
<script type="text/javascript"><!--
$('select[name=\'country\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=module/loginza2/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone'] == '<?php echo $zone; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'zone\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country\']').trigger('change');

//--></script> 
<? } ?>
</form>