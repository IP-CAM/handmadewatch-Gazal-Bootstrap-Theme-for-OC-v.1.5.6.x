<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
  <div class="top">
    <div class="left"></div>
    <div class="right"></div>
    <div class="center">
      <h1><?php echo $heading_title ?></h1>
    </div>
  </div>
  <div class="middle">
  	
  	<div class="content"><?php echo $text_conditions ?></div>
  
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="testimonial">
	<div class="content">
        <table width="100%">
          <tr>
            <td><?php echo $entry_name ?><span class="required">*</span><br />
              <input type="text" name="name" value="<?php 
			  if (!$name) {
			  $name = $this->customer->getFirstName();
			  }
			  echo $name; 
			  ?>" />
              <?php if ($error_name) { ?>
              <span class="error"><?php echo $error_name; ?></span>
              <?php } ?>
		</td>
          </tr>
		   <tr>
             <td><?php echo $entry_city ?><br />
			<input type="text" name="city" value="<?php echo $city; ?>" />
		</td>
          </tr>
		  <tr>
            <td>
		  <?php echo $entry_email ?><br />
              <input type="text" name="email" value="<?php 
			  if (!$email) {
			  $email = $this->customer->getEmail();
			  }
			  echo $email; 
			  ?>" />
              <?php if ($error_email) { ?>
              <span class="error"><?php echo $error_email; ?></span>
              <?php } ?></td>
          </tr>
		  <tr>
            <td><br>Выберите ваш пол: &nbsp;&nbsp;&nbsp; <span><img src="image/data/male.png"></span>&nbsp;
        		<input type="radio" name="sex" value="1" style="margin: 0;" <?php if ( $sex == 1 ) echo 'checked="checked"';?> />
        		&nbsp;
        		<input type="radio" name="sex" value="2" style="margin: 0;" <?php if ( $sex == 2 ) echo 'checked="checked"';?> />
        		&nbsp;
        		<span><img src="image/data/female.png"></span><br /><br>

          	</td>
          </tr>
		  
		  <tr>
            <td>
			
		  
        <div class="option">   
Загрузите свою аватарку:		
          <input type="button" value="Выбрать файл" id="button-image" class="button">
          <input type="hidden" name="image" value="<?php echo $image; ?>" />
        </div>
        <br />
       
		  
		  </td>
          </tr>
		  
          <tr>
            <td><?php echo $entry_enquiry ?><span class="required">*</span><br />
              <textarea name="description" style="width: 99%;" rows="10"><?php echo $description; ?></textarea><br />

              <?php if ($error_enquiry) { ?>
              <span class="error"><?php echo $error_enquiry; ?></span>
              <?php } ?></td>
          </tr>
          
         
          
          <tr>
            <td><br><?php echo $entry_rating; ?> &nbsp;&nbsp;&nbsp; <span><img src="catalog\view\theme\default\image\testimonials/bad.png"></span>&nbsp;
        		<input type="radio" name="rating" value="1" style="margin: 0;" <?php if ( $rating == 1 ) echo 'checked="checked"';?> />
        		&nbsp;
        		<input type="radio" name="rating" value="2" style="margin: 0;" <?php if ( $rating == 2 ) echo 'checked="checked"';?> />
        		&nbsp;
        		<input type="radio" name="rating" value="3" style="margin: 0;" <?php if ( $rating == 3 ) echo 'checked="checked"';?> />
        		&nbsp;
        		<span><img src="catalog\view\theme\default\image\testimonials/good.png"></span><br /><br>

          	</td>
          </tr>
          <tr>
            <td>
              <?php if ($error_captcha) { ?>
              <span class="error"><?php echo $error_captcha; ?></span>
              <?php } ?>
              
              <img src="index.php?route=information/contact/captcha" /> <br>
		<?php echo $entry_captcha; ?><span class="required">*</span> <br>

              <input type="text" name="captcha" value="<?php echo $captcha; ?>" /><br>
		</td>
          </tr>
        </table>
	  </div>
      <div class="buttons">
        <table width=100%>
          <tr>
            <td width=50%><a  onclick="$('#testimonial').submit();" class="button"><span><?php echo $button_send; ?></span></a></td>
		<td align="right"><a class="button" href="<?php echo $showall_url;?>"><span><?php echo $show_all; ?></span></a>
		</td>
          </tr>
        </table>

      </div>
    </form>
  </div>
  <div class="bottom">
    <div class="left"></div>
    <div class="right"></div>
    <div class="center"></div>
  </div>
</div>
<?php echo $footer; ?> 

<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<script type="text/javascript"><!--
new AjaxUpload('#button-image', {
	action: 'index.php?route=product/product/upload&test=1',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-image').after('<img src="catalog/view/theme/gazal/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-image').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-image').attr('disabled', false);
		
		$('.error').remove();
		
		if (json['success']) {
			alert(json['success']);
		
			$('input[name=\'image\']').attr('value', json['file']);
		}
		
		if (json['error']) {
			$('#image').after('<span class="error">' + json['error'] + '</span>');
		}
		
		$('.loading').remove();	
	}
});
//--></script>