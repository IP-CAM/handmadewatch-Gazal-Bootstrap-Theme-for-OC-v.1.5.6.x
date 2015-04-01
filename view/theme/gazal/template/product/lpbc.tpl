
<div class="tsvet">
<div class="box tf subs">

<h2 class="tsvet-title">Выбрать цвет:</h2>

    <div class="box-content">
    
        <div class="box-product">
        
            <div id="lpbccarousel0" style="width: 100%; margin-right: 0px; margin-bottom: 0px;">
              <ul class="jcarousel-skin-opencart">
            <?php foreach ($products as $product) { ?>
                <li>
                
                          <div class="tsvet-image">
                              <a href="<?php echo $product['href']; ?>">
                                  <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" 
                                  alt="<?php echo $product['name']; ?>" />
                              </a>
                          </div>
                   
                </li>
                <?php } ?>
              </ul>
            </div><!--/lpbccarousel-->
        
        </div><!--/box-product-->
    
    </div><!--/box-content-->
    
</div><!--/box-->
</div>

<script type="text/javascript"><!--
$('#lpbccarousel0 ul').jcarousel({
	vertical: false,
	visible: 6,
	scroll: 1
});
//--></script>
