<?php echo $header; ?>
<div class="container" id="ticket-module" style="margin-bottom: 20px !important;">
<?php echo $column_left; ?><?php echo $column_right; ?>
  <div id="content" style="min-height:auto;"><?php echo $content_top; ?>
    <div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>
    <div class="heading">
      <h1><?php echo $heading_title; ?></h1>
    </div>
	<div class="myform">
      <form method="post" action="<?php echo $action; ?>" enctype="multipart/form-data" id="form">
      	<div>
	        <div class="span2"><span class="required">*</span> <?php echo $entry_subject; ?></div>
	        <div class="span8"><input class="input-xxlarge" name="subject" type="text" value="<?php echo $subject; ?>" /></div>
              <?php if ($error_subject) { ?>
              <div class="span10 offset2"><span class="error"><?php echo $error_subject; ?></span></div>
              <?php } ?>
        </div>
            
        <div>
	        <div class="span2"><span class="required">*</span> <?php echo $entry_department; ?></div>
	        <div class="span8"><select name="department">
	        <?php foreach ($departments as $depart){ ?>
	        	<option <?php if ($depart['department_id'] == $department){ ?>selected="selected"<?php } ?> value="<?php echo $depart['department_id']; ?>"><?php echo $depart['department_name']; ?></option>
	        <?php } ?>
	        </select></div>
	    </div>
	    
	    <div>
	    	<div class="span2"><?php echo $entry_message; ?></div>
            <div class="span8"><textarea rows="3" name="message"><?php echo $message; ?></textarea></div>
            <?php if ($error_message) { ?>
              <div class="span10 offset2"><span class="error"><?php echo $error_message; ?></span></div>
              <?php } ?>
	    </div>
	    <?php if($order_status){ ?>
	    <div>
	    	<div class="span2"><?php echo $entry_order; ?></div>
            <div class="span8"><select name="ticket_order_id">
            	<option value=""><?php echo $entry_empty_order ?></option>
            	<?php foreach($order as $row){ ?>
            		<option <?php if($row['order_id']==$ticket_order_id) echo "selected" ?> value="<?php echo $row['order_id'] ?>">#<?php echo $row['order_id'] ?></option>
            	<?php } ?>
            </select></div>
            <?php if ($error_order) { ?>
              <div class="span10 offset2"><span class="error"><?php echo $error_order; ?></span></div>
              <?php } ?>
	    </div>
	    <?php } ?>
	    
	    <!--
		<div>
	        <div class="span2"><?php echo $entry_attach; ?></div>
	        <div class="span8 fileupload fileupload-new" data-provides="fileupload">
			  <div class="input-append">
			    <div class="uneditable-input span3">
				    <i class="icon-file fileupload-exists"></i> 
				    <span class="fileupload-preview"></span>
			    </div>
			    <span class="btn btn-file">
			    	<span class="fileupload-new">Select file</span>
			    	<span class="fileupload-exists">Change</span>
			    	<input class="attach-file" type="file" name="file" />
			    </span>
			    <a href="#" class="btn fileupload-exists" data-dismiss="fileupload">Remove</a>
			  </div>
	        </div>
	        <?php if ($error_attach) { ?>
              <div class="span10 offset2"><span class="error"><?php echo $error_attach; ?></span></div>
              <?php } ?>
	    </div>
		-->
	    <script type="text/javascript" src="<?php echo HTTP_SERVER; ?>../catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>
		 <script>
		    jQuery(function() {
		        for (var i=0; i<5; i++){
		        jQuery( "#datepicker_" + i ).datepicker();
		         jQuery( "#timepicker_" + i ).timepicker({
		                                                    hourGrid: 4,
		                                                    minuteGrid: 10
		                                            });
		       }
		    });
		    </script>
		<style type="text/css">
		    .formcreator label {
		        float: left;
		        font-weight: normal;
		        padding-right: 14px;
		        text-align: left;
		        width: 200px;
		    }
		    .formcreator .title {
		        font-weight: bold;
		    }
		    .formcreator li {
		        display: block;
		        line-height: 25px;
		    }
		    legend.title {
		        font-size: 17px;
		        margin: 0 0 5px;
		    }
		 
		    .formh {
		        color: #888888;
		        font-size: 20px;
		        font-weight: bold;
		        margin-bottom: 0;
		        margin-top: 15px;
		    }
		    .submit {
		        text-align: right;
		    }
		    .red {
		    	color: red;
		    }
		    #contact fieldset{ margin-top: 10px; } 
		    .formcreator input[type="text"], input[type="password"], textarea {
		        width: 300px;
		    }

		    .formcreator input[type="text"]:focus, input[type="password"]:focus, textarea:focus {
		        background-color: #fff;
		        border: solid 1px #ccc;
		    }
		    #ticket-module input[type="radio"],#ticket-module input[type="checkbox"]{margin: 10px 5px 10px 10px;}
		    #ticket-module input[type="file"]{margin: 10px 0;}
		</style>

		<?php echo $formdata; ?>
		
		<div class="error span10"><?php echo $error_captcha."<br />".$error_email; ?></div>
		<script type="text/javascript">
		 $('.contents .form').each(function( index ) {
			if($(this).html() == "") {
				$(this).parent().remove();
			}
			});
		jQuery(document).ready(function() {
			jQuery('#form').submit(function() {
			  return checkValidate();
			});
		});
		    function checkValidate(){
			    $flag = true; 
			    jQuery('.require input').each(function(){
			    if(jQuery(this).val() === '' ) {
			    alert('Please enter ' + jQuery(this).parent().prev().text());
			    $flag = false; 
			    jQuery(this).focus(); 
			    return false; 
			               
				}
				});
				var checked = true;
				var element = '';
				jQuery('.require input[type=checkbox]').each(function(){
					checked = false;
					element = jQuery(this);
					if(jQuery(this).prop('checked')) {
						checked = true;
						return false;
				}
				});
				if(checked==false){
					alert('Please check ' + element.parent().prev().text());
					$flag = false; 
					element.focus(); 
					return false; 
				}
				var checked = true;
				var element = '';
				jQuery('.require input[type=radio]').each(function(){
					checked = false;
					element = jQuery(this);
					if(jQuery(this).prop('checked')) {
						checked = true;
						return false;
				}
				});
				if(checked==false){
					alert('Please check ' + element.parent().prev().text());
					$flag = false; 
					element.focus(); 
					return false; 
				}
				var checked = true;
				var element = '';
				jQuery('.require select[multiple=multiple] option').each(function(){
					checked = false;
					element = jQuery(this);
					if(jQuery(this).prop('selected')) {
						checked = true;
						return false;
				}
				});
				if(checked==false){
					alert('Please select' + element.parent().parent().prev().text());
					$flag = false; 
					element.focus(); 
					return false; 
				}
				jQuery('.require textarea').each(function(){
				if(jQuery(this).val() === '' ) {
				alert('Please enter ' + jQuery(this).parent().prev().text());
				$flag = false; 
				jQuery(this).focus(); 
				return false; 
				               
				}
				});
				jQuery('.require select').each(function(){
				if(jQuery(this).val() === '' ) {
				alert('Please enter ' + jQuery(this).parent().prev().text());
				$flag = false; 
				jQuery(this).focus(); 
				return false; 
				               
				}
				});
				  
				    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
					jQuery('.email  input').each(function(){
				 if(!emailReg.test(jQuery(this).val())) {
				 $flag = false; 

				            alert('Invalid Email ! ');
							jQuery(this).focus();
							return false; 
				        }
						
				});

				// return result
				if($flag){
				return true; 
				}else{
				return false; 
				}
		     
			}
		</script>

      </form>
	  </div>
    <div style="clear:both;"></div>
    <div class="span4 offset4" style="margin-top: 10px;margin-bottom:10px;">
      <a class="button" onclick="$('#form').submit();" ><span><?php echo $button_save; ?></span></a>
      <a class="button" href="<?php echo $cancel; ?>"><span><?php echo $button_cancel?></span></a>
    </div>
    <?php echo $content_bottom; ?></div>
</div>
<?php echo $footer; ?>