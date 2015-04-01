<div class="box">
    <div class="box-heading">Новости и акции</div>
	<span class="heading-shadow"></span>
    <div class="box-content">
      <?php foreach ($news as $news_story) { ?>
      <div class="postSide">

          <?php if ($news_story['thumb']) { ?>
          <div class="image newSideImg">
		
              <a href="<?php echo $news_story['href']; ?>">
              	<img style="border: 1px solid #eee;" src="<?php echo $news_story['thumb']; ?>" title="<?php echo $news_story['title']; ?>" alt="<?php echo $news_story['title']; ?>" />
              </a>
			  <?php if ($news_story['acom']) { ?>
			  
            <span style="font-style: italic; color: #777;"><nowrap><?php echo $news_story['total_comments']; ?>&nbsp;комментариев</nowrap></span>
          <?php } ?>
          </div>
		  
          <?php } ?>
          
          <a class="newsTitle" href="<?php echo $news_story['href']; ?>"><?php echo $news_story['title']; ?></a><br />
          
          <span><?php echo $news_story['short_description']; ?>...</span><b> 
          <a style="color: #787878;" href="<?php echo $news_story['href']; ?>">подробнее</a></b> <br />
	  	  
          
       
	  </div>
      <?php } ?>
	  
      <div style="width: 100%; text-align: center;"><a href="<?php echo $newslink; ?>">Читать все новости</a></div>
   </div>
</div>

