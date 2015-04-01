<div class="box">
  <div class="newsletter-widget">
  <h1><?php echo $heading_title; ?></h1>
  <p><a href="">Хотите знать, что получите! Посмотрите пример письма!</a></p>
  <div class="box-content" style="text-align: center;">
  
  <?php if($thickbox) { ?>
	<a href="#frm_subscribe" title="Newsletter Subscribe" class="fancybox_sub"> <?php echo($text_subscribe); ?> </a>
  <?php }  ?>
  
  <?php if($thickbox) { ?> <div id="frm_subscribe_hidden" style="display:none;"> <?php } ?>
  <div id="frm_subscribe">
  <form name="subscribe" id="subscribe">
	<input placeholder="<?php echo $entry_email; ?>*" type="text" value="" name="subscribe_email" id="subscribe_email">
	<input placeholder="<?php echo $entry_name; ?>" type="text" value="" name="subscribe_name" id="subscribe_name"> 
   <?php for($ns=1;$ns<=$option_fields;$ns++) {  $ns_var= "option_fields".$ns; ?>
   <?php if($$ns_var!=""){
         echo($$ns_var."&nbsp;<br/>");
         echo('<input type="text" value="" name="option'.$ns.'" id="option'.$ns.'">');
       } ?>
   <?php } ?>
	<!--buttons-->
	<a class="button" onclick="email_subscribe()"><span><?php echo $entry_button; ?></span></a><?php if($option_unsubscribe) { ?>
    <a class="button" onclick="email_unsubscribe()"><span><?php echo $entry_unbutton; ?></span></a>
    <?php } ?>    
	<div id="subscribe_result"></div>
  </form>
  </div>
  <?php if($thickbox) { ?> </div> <?php } ?>
  
  </div>

<script language="javascript">
	<?php 
  		if(!$thickbox) { 
	?>	
function email_subscribe(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/newslettersubscribe/subscribe',
			dataType: 'html',
            data:$("#subscribe").serialize(),
			success: function (html) {
				eval(html);
			}}); 
}
function email_unsubscribe(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/newslettersubscribe/unsubscribe',
			dataType: 'html',
            data:$("#subscribe").serialize(),
			success: function (html) {
				eval(html);
			}}); 
}
   <?php }else{ ?>
function email_subscribe(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/newslettersubscribe/subscribe',
			dataType: 'html',
            data:$("#subscribe").serialize(),
			success: function (html) {
				eval(html);
			}}); 
}
function email_unsubscribe(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/newslettersubscribe/unsubscribe',
			dataType: 'html',
            data:$("#subscribe").serialize(),
			success: function (html) {
				eval(html);
			}}); 
}
   <?php } ?>
   
$('.fancybox_sub').fancybox({
	width: 180,
	height: 180,
	autoDimensions: false
});
</script>
</div>
</div>
