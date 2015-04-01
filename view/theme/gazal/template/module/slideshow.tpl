<div class="<?php echo $this->config->get('option_slideshow')?>">
<div class="flexslider" id="<?php echo $module; ?>" style="direction:ltr">
  <ul class="slides">
  	<?php foreach ($banners as $banner) { ?>
    <li>
    <?php if ($banner['link']) { ?>
        <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" /></a>
    <?php } else { ?>
        <img src="<?php echo $banner['image']; ?>" />
    <?php } ?>
    </li> 
    <?php } ?>
  </ul>
</div>

<div class="mytimer first-my timerhello timerhello_152"><p class="result">
<?php echo $mytimer['text']; 
if ($mytimer['enabled']) {
?>
&nbsp;<span class="result-day"></span> дней, <span class="result-hour"></span>:<span class="result-minute"></span>:<span class="result-second"></span> 
<?php } ?>						
						
						</p> 
						
					
				</div>


</div>

<script>
$(window).load(function(){
  $('.flexslider').flexslider({
	animation: "slide",
	start: function(slider){
	  $('body').removeClass('loading');
	}
  });
});
</script>

<script type="text/javascript">
function get_timer_152(string_152) {
	var date_new_152 = string_152; 
	var date_t_152 = new Date(date_new_152);
	var date_152 = new Date();
	var timer_152 = date_t_152 - date_152;
	if (date_t_152 > date_152) {
		var day_152 = parseInt(timer_152/(60*60*1000*24));
		if (day_152 < 10) {
			day_152 = "0" + day_152;
		}
		day_152 = day_152.toString();
		var hour_152 = parseInt(timer_152/(60*60*1000))%24;
		if (hour_152 < 10) {
			hour_152 = "0" + hour_152;
		}
		hour_152 = hour_152.toString();
		var min_152 = parseInt(timer_152/(1000*60))%60;
		if (min_152 < 10) {
			min_152 = "0" + min_152;
		}
		min_152 = min_152.toString();
		var sec_152 = parseInt(timer_152/1000)%60;
		if (sec_152 < 10) {
			sec_152 = "0" + sec_152;
		}
		sec_152 = sec_152.toString(); 
		timethis_152 = day_152 + " : " + hour_152 + " : " + min_152 + " : " + sec_152;
		$(".timerhello_152 p.result .result-day").text(day_152);
		$(".timerhello_152 p.result .result-hour").text(hour_152);
		$(".timerhello_152 p.result .result-minute").text(min_152);
		$(".timerhello_152 p.result .result-second").text(sec_152);
	} else {
		$(".timerhello_152 p.result .result-day").text("00");
		$(".timerhello_152 p.result .result-hour").text("00");
		$(".timerhello_152 p.result .result-minute").text("00");
		$(".timerhello_152 p.result .result-second").text("00");
	} 
}
function getfrominputs_152() {
	string_152 = "<?php echo $mytimer['time']; ?>"; 
	get_timer_152(string_152);
	setInterval(function(){get_timer_152(string_152);},1000);
}
$(document).ready(function(){ getfrominputs_152();});
</script>

