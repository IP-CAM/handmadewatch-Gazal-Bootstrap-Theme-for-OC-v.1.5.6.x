<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content" class="wrap">

  <!--breadcrumb
    ==============================================================-->
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
	
    <?php echo $content_top; ?>
    
    <div style="margin-right: 10px; margin-left: 10px;">  
    <h1><?php echo $heading_title; ?></h1>
    
    
  <div class="content">
    
      <?php if ($search) { ?>
      <input class="bigsearch" type="text" name="search" value="<?php echo $search; ?>" />
      <?php } else { ?>
      <input  class="bigsearch" type="text" name="search" value="<?php echo $search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '000000'" />
      <?php } ?>
	  <!--
      <select name="category_id">
        <option value="0"><?php echo $text_category; ?></option>
        <?php foreach ($categories as $category_1) { ?>
        <?php if ($category_1['category_id'] == $category_id) { ?>
        <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
        <?php } ?>
        <?php foreach ($category_1['children'] as $category_2) { ?>
        <?php if ($category_2['category_id'] == $category_id) { ?>
        <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
        <?php } ?>
        <?php foreach ($category_2['children'] as $category_3) { ?>
        <?php if ($category_3['category_id'] == $category_id) { ?>
        <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
        <?php } ?>
        <?php } ?>
        <?php } ?>
        <?php } ?>
      </select>
	  
      <?php if ($sub_category) { ?>
      <input type="checkbox" name="sub_category" value="1" id="sub_category" checked="checked" />
      <?php } else { ?>
      <input type="checkbox" name="sub_category" value="1" id="sub_category" />
      <?php } ?>
      <label for="sub_category"><?php echo $text_sub_category; ?></label>
    </p>
    <?php if ($description) { ?>
    <input type="checkbox" name="description" value="1" id="description" checked="checked" />
    <?php } else { ?>
    <input type="checkbox" name="description" value="1" id="description" />
    <?php } ?>
    <label for="description"><?php echo $entry_description; ?></label>
	-->
	<input  class="bigsearchbutton" type="button" value="Найти" id="button-search" class="button" />

  </div>
  
  <h2><?php echo $text_search; ?></h2>
  
  </div>
  
  <?php if ($products) { ?>
  <div class="product-filter">
    
    <div class="limit"><b><?php echo $text_limit; ?></b>
      <select onchange="location = this.value;">
        <?php foreach ($limits as $limits) { ?>
        <?php if ($limits['value'] == $limit) { ?>
        <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
    
    <div class="sort"><b><?php echo $text_sort; ?></b>
      <select onchange="location = this.value;">
        <?php foreach ($sorts as $sorts) { ?>
        <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
        <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
    
    <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
	
    
    <!--<div class="display"><b><?php echo $text_display; ?></b> 
    	<?php echo $text_grid; ?><a onclick="display('list');"><?php echo $text_list; ?></a>
    </div>
    -->
  </div>

  
  
<div class="nocarousel">
        <div class="box-product">        
            <div style="display: block; width: 100%; margin-right: 0px; margin-bottom: 0px;">             
            <?php 
			$z = 0;
			$i = 0;
			foreach ($products as $product) { 
			if ($z == 0) { echo "<div style='float: left;'>"; }
			if ($i == 0) { echo "<div style='float: left;'><ul class='jcarousel-skin-opencart'>"; }			
			?>			
                <li style="float: left;" id="liorder<?php echo $product['product_id']; ?>" onmouseover="document.getElementById('fast_order<?php echo $product['product_id']; ?>').style.display='block';" onmouseout="document.getElementById('fast_order<?php echo $product['product_id']; ?>').style.display='none';">
                    <div class="main2">
                      <!-- image //
                        =============-->
                        <!--for swap image-->
                        <?php 
						$product['thumb_swap'] = "";
						if ($product['thumb_swap']) { ?>
                          <div class="image">
                              <a href="<?php echo $product['href']; ?>">
                                 <img oversrc="<?php echo $product['thumb_swap']; ?>" src="<?php echo $product['thumb']; ?>" 
                                 title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" style="border:none"/>
                              </a>
                          </div>
            
                          <?php } else {?>
            
                          <div class="image">
                              <a href="<?php echo $product['href']; ?>">
                                  <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" 
                                  alt="<?php echo $product['name']; ?>" style="border:none"/>
                              </a>
                          </div>
            
                          <?php } ?>
                        <!--/ swap img-->
                        
                        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                        
                        <!-- price //
                        =============-->
                        <?php if ($product['price']) { ?>
                        <div class="price">
                          <?php if (!$product['special']) { ?>
                          <?php echo $product['price']; ?>
                          <?php } else { ?>
                          <span class="price-old"><?php echo $product['price']; ?></span> 
                          <span class="price-new"><?php echo $product['special']; ?></span>
                          <span class="sale">-<?php echo $product['saving']; ?>%</span>
                          <?php } ?>
                        </div>
                        <?php } ?>
                      
                        <div class="rating">
                        <img src="catalog/view/theme/gazal/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
                        <div class="ratingc">
						<a class="wish tooltip" onclick="addToWishList('<?php echo $product['product_id']; ?>');"><span>в заметки</span></a>
                      <a class="compare tooltip" onclick="addToCompare('<?php echo $product['product_id']; ?>');"><span>в сравнение</span></a>
                      </div>
						</div>

                      <div class="hover-options">
                      <div class="cart">
                        <input type="button" value="<?php echo $product['button_cart']; ?>"onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />
                      
					  <a id="fast_order<?php echo $product['product_id']; ?>" class="button" style="float:right; margin-left:5px; display:none;" /><?php echo $product['fast_order']; ?></a>
			  
					  </div>
                      </div>
                      
                    </div><!--/main2-->
                </li>
                <?php 
				$i++;
				if ($i == 2) { 
					echo "</ul></div>";
					$i = 0;
					$z++;
					if ($z == 2) {
						echo "</div>";
						$z = 0;
					}
				}
				} ?>             
            </div><!--/lpbccarousel-->        
        </div><!--/box-product-->
    </div>
    
	
	
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <?php }?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('#content input[name=\'search\']').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('select[name=\'category_id\']').bind('change', function() {
	if (this.value == '0') {
		$('input[name=\'sub_category\']').attr('disabled', 'disabled');
		$('input[name=\'sub_category\']').removeAttr('checked');
	} else {
		$('input[name=\'sub_category\']').removeAttr('disabled');
	}
});

$('select[name=\'category_id\']').trigger('change');

$('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';
	
	var search = $('#content input[name=\'search\']').attr('value');
	
	if (search) {
		url += '&search=' + encodeURIComponent(search);
	}

	var category_id = $('#content select[name=\'category_id\']').attr('value');
	
	if (category_id > 0) {
		url += '&category_id=' + encodeURIComponent(category_id);
	}
	
	var sub_category = $('#content input[name=\'sub_category\']:checked').attr('value');
	
	if (sub_category) {
		url += '&sub_category=true';
	}
		
	var filter_description = $('#content input[name=\'description\']:checked').attr('value');
	
	if (filter_description) {
		url += '&description=true';
	}

	location = url;
});


//--></script> 
<?php echo $footer; ?>