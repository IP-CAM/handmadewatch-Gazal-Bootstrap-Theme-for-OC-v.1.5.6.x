$(document).ready(function() {
	var is = $('#welcome > a + a').length;
	if(is){
		$('#welcome > a').attr('id','poplogin');
		$('#welcome > a + a').attr('id','popregister');
	}else{
		$('#welcome a').removeAttr('id');
	}
	$('#welcome > a#poplogin').click(function(e){
		addclass();
		e.preventDefault();
		$.colorbox({
			overlayClose: true,
			opacity: 0.5,
			fixed : true,
			rel : "opopup",
			scrolling :false,
			href : 'index.php?route=common/popup/ologin',
			onClosed : function(){
				removeclass();
			}
			
		});
		
	});
	$('#welcome > a#popregister').click(function(e){
		addclass();
		e.preventDefault();
		$.colorbox({
			overlayClose: true,
			opacity: 0.5,
			fixed : true,
			rel : "opopup",
			scrolling :true,
			href : 'index.php?route=common/popup/oregister',
			onClosed : function(){
				removeclass();
			}
			
		});
		
	})
	
	$('.quicklook').hide();
	
	$('.quicklook').parent('a').addClass(function(index,currentClass){return currentClass + ' wrapql'});
	
	var top = ($('.wrapql > img').height() - $('.quicklook').outerHeight()) / 2;
    var left = ($('.wrapql > img').width() - $('.quicklook').outerWidth()) / 2;
	
	$('.quicklook').css({top: (top > 0 ? top : 0)+'px', left: (left > 0 ? left : 0)+'px'});
	
	/*$('a[rel=quicklook]').colorbox({
		overlayClose: true,
		opacity: 0.5,
		href : function(){
			return 'index.php?route=common/popup/oquicklook&product_id='+ $(this).find('input[name=product_id]').val();
		}
	});*/
});

function opQuicklook(id){
	addclass();
	$.colorbox({
			opacity: 0.5,
			fixed : true,
			rel : "quicklook",
			scrolling :false,
			height : "100%",
			href : 'index.php?route=common/popup/oquicklook&product_id='+id,
			onClosed : function(){
				removeclass();
			}
		});
}

function addclass(){
	$('#colorbox').addClass('popup');
	$('#cboxContent').addClass('contentpop');
	$('#cboxClose').addClass('popclose');
}
function removeclass(){
	$('#colorbox').removeClass('popup');
	$('#cboxContent').removeClass('contentpop');
	$('#cboxClose').removeClass('popclose');
}