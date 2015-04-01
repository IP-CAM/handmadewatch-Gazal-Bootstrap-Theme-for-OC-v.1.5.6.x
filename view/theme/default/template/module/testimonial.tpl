<div class="box">
  <div class="box-heading"><?php if ($testimonial_title=="") echo "<br>"; else echo $testimonial_title; ?></div>
  <div class="box-content">
    <div class="box-product">

    <table cellpadding="0" cellspacing="0" style="width: 100%;">
      <?php 
	  $i = 1;
	  foreach ($testimonials as $testimonial) { 
	  
	  ?>
      <tr><td class="testleft"><img src="<?php echo $testimonial['thumb']; ?>" title="<?php echo $testimonial['name']; ?>" alt="<?php echo $testimonial['name']; ?>" />
	  
	  <?php 				
				if ($testimonial['rating'] == 1) { 
				?>
                  <div class="test_rating"><img src="catalog/view/theme/default/image/testimonials/bad.png" /></div>
                <?php } 
				
				if ($testimonial['rating'] == 3) { 
				?>
                  <div class="test_rating"><img src="catalog/view/theme/default/image/testimonials/good.png" /></div>
                <?php } ?>
	  
	  </td><td>
	  <div class="oblako1"></div>
	  <div class="kruk"></div>
<div class="oblako">
          <div class="name"><b><?php echo $testimonial['name']; ?></b>,<br><span style="color:#666666"><?php echo $testimonial['date_added']; ?></span></div>
          <div class="description"><?php echo $testimonial['description'] ; ?></div>
</div>

<div class="under">
         <div class="name"><b><?php echo $testimonial['name']; ?></b>,<br><span style="color:#666666"><?php echo $testimonial['date_added']; ?></span></div>
          <div class="description"><?php echo $testimonial['description'] ; ?></div>
</div>
<div class="oblako2"></div>
       
	   <?php
	   if ($i != count($testimonials)) {
	   
	   echo "<br><br>";
	   }
	   
	   ?>
	   
	   
	   </td>
	   
      </tr>

      <?php 
	  $i = $i + 1;
	  } ?>

 </table>
 <div style="width: 100%; text-align: center; margin-top: 25px;"><a href="<?php echo $showall_url;?>"><?php echo $show_all; ?></a></div>
  <div style="width: 100%; text-align: center;"><a href="<?php echo $isitesti; ?>"><?php echo $isi_testimonial; ?></a></div>

	

    </div>
  </div>
</div>

