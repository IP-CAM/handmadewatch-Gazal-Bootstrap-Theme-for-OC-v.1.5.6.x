<?php echo $header; ?>
<?php echo $column_left; ?>
<?php echo $column_right; ?>
<div class="wrap">

 <!--breadcrumb
    ==============================================================-->
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    
    <?php echo $content_top; ?>
    
    <!--title
    ==============================================================-->
    <h1 class="category-title"><?php echo $heading_title; ?></h1>
    
    <!--img + description + refine search
    ==============================================================-->
    <?php if ($thumb || $description || $categories) { ?>
    <div class="category-info">
    
    <!-- image -->
    <?php if ($thumb) { ?>
    <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" width="200" /></div>
    <?php } ?>
    
    <div class="right-part-2">
    
    <!-- description -->
    <?php if ($description) { ?>
    <?php echo $description; ?>
    <?php } ?>
    
    <!--refine search -->
    <?php if ($categories) { ?>
    <div class="refine">
        <h2 class="refine-search"><?php echo $text_refine; ?></h2>
        <div class="category-list">
              <?php foreach ($categories as $category) { ?>
              <div>
                <?php if ( $category['image']){?>
                <span class="image-refine"><img src="<?php echo $category['image'];?>" width="75"/></span>
                <?php } ?>	
                <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
              </div>
              <?php } ?>
         </div>
     </div>
    <?php } ?>
    
   </div><!--/right-part--> 
   </div><!--/category-info-->
   
   <?php } ?>
    
  <?php if ($products) { ?>
  
  <!--product filter
  ==============================================================-->
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
	
    
  <!--  <div class="display"><b><?php echo $text_display; ?></b> 
    	<?php echo $text_list; ?><a onclick="display('grid');"><?php echo $text_grid; ?></a>
    </div>-->
    
  </div><!--/product-filter-->
  
  
  
  
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
                        <input type="button" value="<?php echo $product['button_cart']; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />
                      
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
  
  <?php } ?>
  <?php if (!$categories && !$products) { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  
  <?php echo $content_bottom; ?>
  
</div>
  

<?php echo $footer; ?>