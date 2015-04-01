<div id="banner<?php echo $module; ?>" class="banner">
  <?php foreach ($banners as $banner) { ?>
   <?php if ($banner['title'] == "garant") { ?>
   <div class="garant"><a href="index.php?route=account/return/insert"><img src="<?php echo "image/" . $banner['image1']; ?>"></a><h1>100% гарантия</h1><p><a href="index.php?route=account/return/insert">- проверка каждой 
единицы Вашего заказа до отправки
<br>
-гарантия 100%-го возврата денег в течении месяца, если наш товар Вам не понравится</a></p></div>
 <?php } elseif ($banner['title'] == "delivery") { ?>
   <div class="delivery"><a href="index.php?route=information/information&information_id=4"><img src="<?php echo "image/" . $banner['image1']; ?>"></a><h1>Доставка</h1><p><a href="index.php?route=information/information&information_id=4">- по Москве курьером
<br>- по России – 
Почтой России (наложенным 
платежом) или экспресс доставка курьерскими службами. Бесплатная доставка при заказе > 5000р.</a></p></div>
  <?php 
  } else {
  if ($banner['link']) { ?>
  <div><a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a></div>
  <?php } else { ?>
  <div><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></div>
  <?php } ?>
  
  <?php 
  }
  } ?>
</div>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#banner<?php echo $module; ?> div:first-child').css('display', 'block');
});

var banner = function() {
	$('#banner<?php echo $module; ?>').cycle({
		before: function(current, next) {
			$(next).parent().height($(next).outerHeight());
		}
	});
}

setTimeout(banner, 2000);
//--></script>