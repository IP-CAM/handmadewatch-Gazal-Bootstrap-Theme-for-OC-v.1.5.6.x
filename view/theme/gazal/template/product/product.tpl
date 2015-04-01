
<?php
//foreach ($images as $image) {
//echo $image['popup']."<br>";
//}
?>
<?php echo $header; ?>
<?php echo $column_left; ?>
<?php echo $column_right; ?>
<div id="content">
<?php echo $content_top; ?>
<script src="catalog/view/javascript/jquery/jquery.jcarousel.min1.js"></script>
  <!-- breadcrumb 
  ===========================================================-->
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  
  <!-- Title 
  ===========================================================-->
  <h1 class="product-title"><?php echo $heading_title; ?></h1>
  
  <!-- product-info 
  ===========================================================-->
  <div class="product-info">
  
  	<!-- **** Left **** -->
    <?php if ($thumb || $images) { ?>
        <div class="left">
        
          <?php if ($thumb) { ?>
          <div class="image">
		  <div class="wish-compare">
          <a class="wish tooltip" onclick="addToWishList('<?php echo $product_id; ?>');"><span><?php echo $button_wishlist; ?></span></a>
          <a class="compare tooltip" onclick="addToCompare('<?php echo $product_id; ?>');"><span><?php echo $button_compare; ?></span></a>
        </div>
          	<span class="zoom"></span>
            <a href="<?php echo $popup; ?>" class = 'cloud-zoom' id='zoom1' rel="">
            <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" />
            </a>
          </div>
		  
          
          
          <?php if ($images) { ?>
          
          <div id="dopcarusel" class="image-additional">
		  <ul class="jcarousel1-skin-opencart">
            <?php foreach ($images as $image) { 
			
			?>
			
            <li>
			<span style="width: 65px";>
            <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="cloud-zoom-gallery" rel="useZoom: 'zoom1', smallImage: '<?php echo $image['thumb']; ?>' ">
            <img src="<?php echo $image['thumb']; ?>"  title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
            </a>
			</span>
			<?php }		  ?>
			</li>
            
            <?php } ?>
			</ul>
          </div>
		  
	<script type="text/javascript"><!--
$('#dopcarusel ul').jcarousel1({
	vertical: false,
	visible: 4,
	scroll: 1
});
//--></script>
		  
          
          <?php } ?>
          
        </div>
		
    <?php } ?>
    
    <!-- **** right **** -->
    <div class="right">
    
      <!-- description -->
      <div class="description">
	  
	  
	  
	  <?php foreach ($attribute_groups as $attribute_group) { 
		if ($attribute_group['name'] == "main") {
	   foreach ($attribute_group['attribute'] as $attribute) { ?>
        <span><?php echo $attribute['name']; ?>:</span> <?php echo $attribute['text']; ?><br />
            
        <?php } 
	  }
	  } ?>
	  
	  <table width="100%"><tr><td width="50%">
        <?php if ($manufacturer) { ?>
        <span>Марка:</span> <a class="m" href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
		</td><td>
        <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
		</td></tr><tr><td>
        <?php if ($reward) { ?>
        <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
		
        <?php } ?>
        <span><?php echo $text_stock; ?></span> <?php echo $stock; ?><br />
		</td><td>
		<span>Артикул:</span> <?php echo $sku; ?>
		</td></tr></table>
		
		</div>
		
        
      <!-- price -->
      <?php if ($price) { ?>
      <div class="price">
        <div class="price-text"><?php echo $text_price; ?></div>
        
        <div class="price-data">
        <?php if (!$special) { ?>
        <?php echo $price; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
        <?php } ?>
        <br />
        <?php 
		$tax = '';
		if ($tax) { ?>
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
        <?php } ?>
        <?php if ($points) { ?>
        <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
        <?php } ?>
        <?php if ($discounts) { ?>
        <div class="discount">
          <?php foreach ($discounts as $discount) { ?>
          <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
          <?php } ?>
        </div>
        <?php } ?>
      </div>
      </div>
      <?php } ?>
      
      <!-- cart -->
      <div class="cart">
        <div>
			
		Кол-во:
          <input type="text" class="quantity" name="quantity" size="2" value="<?php echo $minimum; ?>" />
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
          &nbsp;
          <input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button cart-product" />&nbsp;
		  
		  <!--//////fast-->
		  
		 
		 
						<?php 
							if (($quantity < 1) && $waitlist_enabled) {
							  if ($product_already_in_waitlist) { 
                                echo $text_already_waitlist;
                              } else { ?>
                                <a class="button cart-product" onclick="addToWaitList('<?php echo $product_id; ?>');"><?php echo $fast_order; ?></a>
                              <?php }
                          } else { ?>						  
                            <a class="button cart-product" /><?php echo $fast_order; ?></a>
                          <?php } ?>
					  <!--//////fast-->			  
						  
						  
				<div style="display:none">
          <div id="fast_order_form">       
            <input id="product_name" type="hidden" value="<?php echo $heading_title; ?>">
            <input id="product_price" type="hidden" value="<?php echo ($special ? $special : $price); ?>">
            <div class="fast_order_center"><?php echo $heading_title; ?> — ваш заказ</div>
            <div class="fast_order_left">
              <p>Имя:</p>
              <p>Телефон:</p>
              <p>Комментарий:</p>
            </div>
            <div class="fast_order_right">
              <p><input type="text" id="customer_name"/></p>
              <p><input type="text" id="customer_phone"/></p>
              <p><input type="text" id="customer_message"/></p>
            </div>
            <div class="fast_order_center">
              <p id="fast_order_result">Пожалуйста, укажите ваше имя и телефон, чтобы мы могли связаться с вами</p>
              <button class="fast_order_button"><span>Оформить заказ</span></button>
            </div>
          </div>
        </div>
		
		 <!--//////fast-->
		  
        </div>
        <!--<div><span>&nbsp;&nbsp;&nbsp;<?php echo $text_or; ?>&nbsp;&nbsp;&nbsp;</span></div>-->
        
        <?php if ($minimum > 1) { ?>
        <div class="minimum"><?php echo $text_minimum; ?></div>
        <?php } ?>
      </div>
       <div class="description">
	  <?php foreach ($attribute_groups as $attribute_group) { 
		if ($attribute_group['name'] == "additional") {
	   foreach ($attribute_group['attribute'] as $attribute) { ?>
        <span><?php echo $attribute['name']; ?>:</span> <?php echo $attribute['text']; ?><br />
            
        <?php } 
	  }
	  } ?>
	 <a class="product_ask" data-name="<?php echo $this->customer->getFirstName(); ?>" data-email="<?php echo $this->customer->getEmail(); ?>" data-product="<?php echo $sku; ?>" data-productname="<?php echo $heading_title; ?>">Задать вопрос о товаре</a>
</div>
<script>
 $(function() {
    $('.product_ask').jbcallme({
        postfix: 'product_ask', // идентификатор окна
        // поля tel и name установлены по-умолчанию. Отключаются добавлением no_tel:true и no_name:true
        //no_tel: true, // не выводить стандартное поле телефона
        //no_name: true,
        no_submit: true, // не выводить стандартную кнопку
        title: "Задать вопрос о товаре", // заголовок окна
        action_url: "/postmaster.php", // путь к обработчику запрсов
        success: "Вопрос принят и будет обработан в ближайшее время", 
        fail: "Сообщение не доставлено. Извините за неудобство!", 
        fields: { // добавление полей	
            
            email: {
                required: true, // обязательное ли
                placeholder: "Ваш e-mail", 
                type: "email",
            },
            
            productname: { // невидимое поле, передющее тип формы
				required: true,
				label: "Название продукта",
                type: "text",
                
            },
            intro: {
				required: true,
                label: "Ваш вопрос",
                type: "textarea",
            },
            action: { // невидимое поле, передющее тип формы
                type: "hidden",
                value: "ask_order",
            },
			
			product: { // невидимое поле, передющее тип формы
                type: "hidden",
                
            },
            send: {
                type: "submit",
                value: "Задать вопрос",
            },
        },
    }); 
});
</script>
      <!-- review - share -->
      <?php if ($review_status) { ?>
      <div class="review">
      	
        <div class="review-text">
        <img class="review-img" src="catalog/view/theme/gazal/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />
        <a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;
        <a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a>
        </div>
        
        
        
      </div>
      <?php } ?>
      
      
		
      <!-- options -->
      <?php if ($options) { ?>
      <div class="options">
        <h2 class="option-title"><?php echo $text_option; ?></h2>
        <br />
        <?php foreach ($options as $option) { ?>
        <?php if ($option['type'] == 'select') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <select name="option[<?php echo $option['product_option_id']; ?>]">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
            </option>
            <?php } ?>
          </select>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'radio') { ?>
<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'checkbox') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'image') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <table class="option-image">
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <tr>
              <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
              <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
              <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                  <?php if ($option_value['price']) { ?>
                  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                  <?php } ?>
                </label></td>
            </tr>
            <?php } ?>
          </table>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'text') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'textarea') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'file') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
          <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'date') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'datetime') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'time') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
        </div>
        <br />
        <?php } ?>
        <?php } ?>
      </div>
      <?php } ?>
      
      
    </div>
  </div><!--/product-info-->
  
  <div class="share">
          Нравится? Поделись...<script type="text/javascript" src="//yastatic.net/share/share.js" charset="utf-8"></script><div class="yashare-auto-init" data-yashareL10n="ru" data-yashareType="button" data-yashareQuickServices="vkontakte,facebook,twitter,odnoklassniki,moimir"></div>
        </div>
		
		
		
		<?php echo $lpbc; ?>
		
		
  <!-- Tabs 
  =========================================================-->
  <div id="tabs" class="htabs"><a href="#tab-description"><?php echo $tab_description; ?></a>
    <?php if ($attribute_groups) { ?>
    <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
    <?php } ?>
    <?php if ($review_status) { ?>
    <a href="#tab-review"><?php echo $tab_review; ?></a>
    <?php } ?>
    <?php if ($tags) { ?>
    <!--<a href="#tab-tags"><?php echo $text_tags; ?></a>-->
    <?php } ?>
  </div>
  
  
  <div id="tab-description" class="tab-content"><?php echo $description; ?></div>
  <?php if ($attribute_groups) { ?>
  <div id="tab-attribute" class="tab-content">
    <table class="attribute">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <!--<thead>
        <tr>
          <td colspan="2"><?php echo $attribute_group['name']; ?></td>
        </tr>
      </thead>-->
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>
  <?php } ?>
  <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
    <div id="review"></div>
    <h2 id="review-title"><?php echo $text_write; ?></h2>
    <b><?php echo $entry_name; ?></b><br /><br />
    <input type="text" name="name" value="" />
    <br />
    <br />
    <b><?php echo $entry_review; ?></b><br /><br />
    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    <br />
    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp;<span><?php echo $entry_good; ?></span><br />
    <br />
    <b><?php echo $entry_captcha; ?></b><br /><br />
    <input type="text" name="captcha" value="" />
    <br /><br />
    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  <?php } ?>
  
  
  
  <!--
  <?php if ($tags) { ?>
  <div id="tab-tags" class="tab-content">
  <div class="tags">
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  </div>
  <?php } ?>
 -->
  
  <!--
  <?php if ($products) { ?>
  <div class="related-product">
  	<h2 class="realted-title"><?php echo $tab_related; ?>(<?php echo count($products); ?>)</h2>
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      <div class="related grid_2">
        <?php if ($product['thumb']) { ?>
        <div class="image">
        	<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
        </div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <div class="rating">
        	<img src="catalog/view/theme/gazal/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
        </div>
        <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  -->
  <div style="margin-bottom:30px">
  <a href="<?php echo $manufacturers; ?>">Посмотреть все товары данной марки</a>
  </div>
   <?php echo $featured; ?></div>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	overlayClose: true,
	opacity: 0.5
});
//--></script> 
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			} 
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/gazal/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
					
				$('#cart-total').html(json['total']);
				document.getElementById('ex').style.display = 'block';
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/gazal/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
		
		$('.error').remove();
		
		if (json['success']) {
			alert(json['success']);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}
		
		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}
		
		$('.loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');
		
	$('#review').load(this.href);
	
	$('#review').fadeIn('slow');
	
	return false;
});			

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/gazal/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
if ($.browser.msie && $.browser.version == 6) {
	$('.date, .datetime, .time').bgIframe();
}

$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script> 

<?php echo $footer; ?>