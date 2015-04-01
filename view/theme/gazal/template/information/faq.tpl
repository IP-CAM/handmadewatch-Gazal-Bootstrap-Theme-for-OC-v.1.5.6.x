<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<style>
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active{
border:1px solid #CCCCCC !important;
}
</style>
	<h1><?php echo $heading_title; ?></h1>
	<?php foreach( $department as $key => $dpt ) : 
		$topics = $dpt['topics'];
		//print_r( $topics );
	?>
		<h2><?php echo $dpt['title'] ?></h2>
			<?php if ( isset( $topics ) ) { ?>
			<div id="accordion<?php echo $key; ?>" 
				class="ui-accordion ui-widget ui-helper-reset ui-accordion-icons"
				role="tablist">
			<ul>
				<?php foreach ($topics as $topic) : ?>
				
				<li>
					<h3 style="text-align:left;text-transform:uppercase;" 
						class="ui-accordion-header ui-helper-reset ui-state-default 
						ui-state-active ui-corner-top" role="tab" aria-expanded="true" 
						aria-selected="true" tabindex="0">					
						<a href="#" class='head' style="color:#000000;">
							<span class="ui-icon ui-icon-triangle-1-e"></span>
							<?php echo $topic['title']; ?>
						</a>
					</h3>
					<div style="background:#fff;overflow:auto;padding:10px;"
					class="content ui-accordion-content ui-helper-reset 
					ui-widget-content ui-corner-bottom" >
	
						<?php 
						foreach ( $topic['faq_dec'][0] as $message )
							echo $message['content'] . '<br><br>';
						?>
					</div>
					</li>
				<?php endforeach; ?>
			</ul>
			</div>
			<?php } ?>
			<script>
			$(document).ready(function(){
				$('#accordion<?php echo $key; ?> .head').click(function(e){
					e.preventDefault();
					$(this).closest('li').find('.content').not(':animated').slideToggle();
					$(this).closest('li').find('span').toggleClass( 'ui-icon-triangle-1-s' );
				});
			});
		</script>
		<br />
	<?php endforeach; ?>
	<div style="padding: 10px;"><h2>Не нашли ответ на свой вопрос? Тогда <a href="<?php echo HTTP_SERVER; ?>index.php?route=ticket/create">жмите здесь</a>!</h2></div>
	<div class="buttons">
		
		<div class="right"><a onclick="location = '<?php echo $continue; ?>'" class="button"><span><?php echo $button_continue; ?></span></a></div>
		
	</div>
<?php echo $content_bottom; ?> </div>
<?php echo $footer; ?> 