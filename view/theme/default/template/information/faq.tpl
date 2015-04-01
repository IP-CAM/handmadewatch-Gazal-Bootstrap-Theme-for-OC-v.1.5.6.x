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
    <?php echo $description; ?>
	    <?php if (isset($topics)) { ?>
        <div id="accordion">
            <?php foreach ($topics as $topic) { ?>
            <h3 style="text-align:left;text-transform:uppercase;"><a href="#" style="color:#000000;"><?php echo $topic['title']; ?></a></h3>
            <div  style="background:none;max-height:200px;overflow:auto;padding:10px;"> <?php echo $topic['faq_dec']; ?> </div>
            <?php } ?>
        </div>
        <?php } ?>
    <script>
	$(function() {
		$( "#accordion" ).accordion();
	});
	</script>
    <br />
	<div class="buttons">
		<?php if (isset($button_faq)) { ?>
		<div class="right"><a onclick="location = '<?php echo $faq; ?>'" class="button"><span><?php echo $button_faq; ?></span></a></div>
		<?php } else { ?>
		<div class="right"><a onclick="location = '<?php echo $continue; ?>'" class="button"><span><?php echo $button_continue; ?></span></a></div>
		<?php } ?>
	</div>
<?php echo $content_bottom; ?> </div>
<?php echo $footer; ?> 