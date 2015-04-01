</div><!--/container_12-->
<div class="container_12 footer-bg">

    <!--Aboutus-->
    <?php if($this->config->get('gazal_custom_widget_title_' . $this->config->get('config_language_id')) != '') { ?> 
	<div class="adap">
	<div class="grid_3">
    	<h3 class="widgetsTitle"><?php echo $this->config->get('gazal_custom_widget_title_' . $this->config->get('config_language_id'))?></h3>
    	<div class="marB30">
    	<div class="about">
            <p>
            Наручные часы сегодня - это не только надёжный хронометр, но и неотъемлемый атрибут стиля, модный аксессуар. <br><br>В нашем интернет-магазине handmadewatch.ru Вы можете купить часы, которые помогут идти "в ногу со временем" в прямом и переносном смысле. <br><br> Команда интернет-магазина handmadewatch.ru внимательно относится к каждому Клиенту. Наши менеджеры готовы проконсультировать Вас при выборе часов, осуществлении заказа, помогут отследить доставку посылки при отправке по почте. <br><br> Приобретая наши наручные часы, Вы сможете оставаться собой, идя в ногу со временем!
            </p>
        </div>   
        
        <div class="clearfix"></div>
        
        <?php if($this->config->get('gazal_shipping_text_' . $this->config->get('config_language_id')) != '') { ?> 
        <div class="shipping">
        	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
            else $path_image = HTTP_IMAGE; 
            if($this->config->get('gazal_cus_img')!='') { ?>
            <img src="<?php echo $path_image . $this->config->get('gazal_cus_img') ?>" alt="" width="75" >
            <?php } ?> 
            <span class="second-line"><?php echo $this->config->get('gazal_shipping_text_' . $this->config->get('config_language_id'))?></span> <br />
            <span class="third-line"><?php echo $this->config->get('gazal_shipping_last_text_' . $this->config->get('config_language_id'))?></span>
        </div>
        <?php } ?>
        </div>
    </div>
	</div>
    <?php } ?>
    
   
	
    <div class="adap2">
    <!--twitter-->
    
    <?php if($this->config->get('gazal_twitter_username') != '') { ?>
    <div class="grid_3">
    	<h3 class="widgetsTitle">ВКонтакте</h3>
    	<script type="text/javascript" src="//vk.com/js/api/openapi.js?116"></script>

<!-- VK Widget -->
<div id="vk_groups"></div>
<script type="text/javascript">
VK.Widgets.Group("vk_groups", {mode: 0, width: "220", height: "360", color1: 'FFFFFF', color2: '2B587A', color3: '5B7FA6'}, 44053335);
</script>
    </div>
    <?php } ?>
    
    
    
    <!--facebook-->
    
    <?php if($this->config->get('gazal_facebook_id') != '') { ?>
    <div class="grid_3">
    	<h3 class="widgetsTitle">Facebook</h3>
          <div class="fb-like-box" data-href="https://www.facebook.com/handmadewatch.ru" data-width="220" data-height="360" data-colorscheme="light" data-show-faces="true" data-header="true" data-stream="false" data-show-border="true"></div>    </div>
	<?php } ?>
	
	 <!--contact us-->
    
    <?php if($this->config->get('gazal_phone') != '') { ?>
    <div class="grid_3">
    <h3 class="widgetsTitle"><?php echo $text_contact; ?></h3>
    	<div class="contact marB30">
            <?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
            else $path_image = HTTP_IMAGE; 
            if($this->config->get('gazal_contact_img')!='') { ?>
            <img src="<?php echo $path_image . $this->config->get('gazal_contact_img') ?>" alt="" width="100" class="contactImg" >
            <?php } ?> 
                <div class="rightCont">
                <?php if($this->config->get('gazal_address_' . $this->config->get('config_language_id')) != '') { ?> 
                    <img class="icon" src="catalog/view/theme/gazal/image/home-2.png" width="30" alt="" > <?php echo $this->config->get('gazal_address_' . $this->config->get('config_language_id'))?>
                <?php } ?>
                <div style="clear: both"></div><br />
                <?php if($this->config->get('gazal_phone') != '') { ?>
                    <img class="icon" src="catalog/view/theme/gazal/image/phone.png" width="30" alt="" style="margin-top: -5px;"> <?php echo $this->config->get('gazal_phone')?><?php echo $this->config->get('gazal_phone_second')?>
                <?php } ?>
                <div style="clear: both"></div><br />
                <?php if($this->config->get('gazal_email') != '') { ?>
                    <img class="icon" src="catalog/view/theme/gazal/image/mail.png" width="30" alt="" style="margin-top: -5px;"> <a href="mailto:<?php echo $this->config->get('gazal_email')?>"><?php echo $this->config->get('gazal_email')?></a> 
                    <a href="mailto:<?php echo $this->config->get('gazal_email_second')?>"><?php echo $this->config->get('gazal_email_second')?></a>
                <?php } ?>
                </div>
            </div>
			<div class="handmade">
			
			</div>
    </div>
    <?php } ?>
    </div>
    
	<div class="clearfix"></div>
	<hr/>
    <div class="clearfix"></div>

  <!--  <footer>
      <?php if ($informations) { ?>
	  <div class="adap">
      <div class="column grid_3">
        <h3><?php echo $text_information; ?></h3>
        <ul>
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
	  </div>
      <?php } ?>
      <div class="column grid_3">
        <h3><?php echo $text_service; ?></h3>
        <ul>
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>
      <div class="column grid_3">
        <h3><?php echo $text_extra; ?></h3>
        <ul>
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
          <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
          <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
          <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
        </ul>
      </div>
      <div class="column grid_3">
        <h3><?php echo $text_account; ?></h3>
        <ul>
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>
      </div>
      -->
      <div class="clearfix"></div>
      
      <div class="grid_5">
      	  <ul class="payment">
          
          	<?php if($this->config->get('gazal_pay1_img') != '') { ?>
          	<li>
            	<a href="<?php echo $this->config->get('gazal_pay1_link')?>" target="_blank">
            	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
				else $path_image = HTTP_IMAGE; 
                if($this->config->get('gazal_pay1_img')!='') { ?>
            	<img src="<?php echo $path_image . $this->config->get('gazal_pay1_img') ?>" alt="" width="44" ><!--custom image-->
                <?php } ?>    
                </a>
            </li>
            <?php } ?>
            
            <?php if($this->config->get('gazal_pay2_img') != '') { ?>
          	<li>
            	<a href="<?php echo $this->config->get('gazal_pay2_link')?>" target="_blank">
            	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
				else $path_image = HTTP_IMAGE; 
                if($this->config->get('gazal_pay2_img')!='') { ?>
            	<img src="<?php echo $path_image . $this->config->get('gazal_pay2_img') ?>" alt="" width="43" ><!--custom image-->
                <?php } ?>    
                </a>
            </li>
            <?php } ?>
            
            <?php if($this->config->get('gazal_pay3_img') != '') { ?>
          	<li>
            	<a href="<?php echo $this->config->get('gazal_pay3_link')?>" target="_blank">
            	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
				else $path_image = HTTP_IMAGE; 
                if($this->config->get('gazal_pay3_img')!='') { ?>
            	<img src="<?php echo $path_image . $this->config->get('gazal_pay3_img') ?>" alt="" width="63" ><!--custom image-->
                <?php } ?>    
                </a>
            </li>
            <?php } ?>
            
            <?php if($this->config->get('gazal_pay4_img') != '') { ?>
          	<li>
            	<a href="<?php echo $this->config->get('gazal_pay4_link')?>" target="_blank">
            	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
				else $path_image = HTTP_IMAGE; 
                if($this->config->get('gazal_pay4_img')!='') { ?>
            	<img src="<?php echo $path_image . $this->config->get('gazal_pay4_img') ?>" alt="" width="71" ><!--custom image-->
                <?php } ?>    
                </a>
            </li>
            <?php } ?>
            
            <?php if($this->config->get('gazal_pay5_img') != '') { ?>
          	<li>
            	<a href="<?php echo $this->config->get('gazal_pay5_link')?>" target="_blank">
            	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
				else $path_image = HTTP_IMAGE; 
                if($this->config->get('gazal_pay5_img')!='') { ?>
            	<img src="<?php echo $path_image . $this->config->get('gazal_pay5_img') ?>" alt="" width="105" ><!--custom image-->
                <?php } ?>    
                </a>
            </li>
            <?php } ?>
            
            <?php if($this->config->get('gazal_pay6_img') != '') { ?>
          	<li>
            	<a href="<?php echo $this->config->get('gazal_pay6_link')?>" target="_blank">
            	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
				else $path_image = HTTP_IMAGE; 
                if($this->config->get('gazal_pay6_img')!='') { ?>
            	<img src="<?php echo $path_image . $this->config->get('gazal_pay6_img') ?>" alt="" width="45" ><!--custom image-->
                <?php } ?>    
                </a>
            </li>
            <?php } ?>
            
            <?php if($this->config->get('gazal_pay7_img') != '') { ?>
          	<li>
            	<a href="<?php echo $this->config->get('gazal_pay7_link')?>" target="_blank">
            	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
				else $path_image = HTTP_IMAGE; 
                if($this->config->get('gazal_pay7_img')!='') { ?>
            	<img src="<?php echo $path_image . $this->config->get('gazal_pay7_img') ?>" alt="" width="45" ><!--custom image-->
                <?php } ?>    
                </a>
            </li>
            <?php } ?>
            
            <?php if($this->config->get('gazal_pay8_img') != '') { ?>
          	<li>
            	<a href="<?php echo $this->config->get('gazal_pay8_link')?>" target="_blank">
            	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
				else $path_image = HTTP_IMAGE; 
                if($this->config->get('gazal_pay8_img')!='') { ?>
            	<img src="<?php echo $path_image . $this->config->get('gazal_pay8_img') ?>" alt="" width="45" ><!--custom image-->
                <?php } ?>    
                </a>
            </li>
            <?php } ?>
            
            <?php if($this->config->get('gazal_pay9_img') != '') { ?>
          	<li>
            	<a href="<?php echo $this->config->get('gazal_pay9_link')?>" target="_blank">
            	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
				else $path_image = HTTP_IMAGE; 
                if($this->config->get('gazal_pay9_img')!='') { ?>
            	<img src="<?php echo $path_image . $this->config->get('gazal_pay9_img') ?>" alt="" width="45" ><!--custom image-->
                <?php } ?>    
                </a>
            </li>
            <?php } ?>
            
            <?php if($this->config->get('gazal_pay10_img') != '') { ?>
          	<li>
            	<a href="<?php echo $this->config->get('gazal_pay10_link')?>" target="_blank">
            	<?php if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') $path_image = HTTPS_IMAGE;
				else $path_image = HTTP_IMAGE; 
                if($this->config->get('gazal_pay10_img')!='') { ?>
            	<img src="<?php echo $path_image . $this->config->get('gazal_pay10_img') ?>" alt="" width="45" ><!--custom image-->
                <?php } ?>    
                </a>
            </li>
            <?php } ?>
          </ul>
      </div>
	  <div class="adap3">
       <div class="grid_3">
      	<div style="margin-top:21px; text-align:right; "><a href="index.php?route=information/information&information_id=3">Политика конфиденциальности</a>
		</div>
      </div>	
      </div>
      <div class="grid_4">
      	
		
      	<div id="powered"><?php echo $powered; ?></div>
      </div>
      
    </footer>
    
    
</div><!--/container_12-->




</body></html>