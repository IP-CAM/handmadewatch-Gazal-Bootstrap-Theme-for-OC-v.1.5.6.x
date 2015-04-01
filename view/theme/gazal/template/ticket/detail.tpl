<?php echo $header; ?>
<div class="container" id="ticket-module">
<?php echo $column_left; ?><?php echo $column_right; ?>
  <div id="content"><?php echo $content_top; ?>
    <div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>
	    <div class="heading">
	      <h1><?php echo $heading_title; ?></h1>
	    </div>
		<div class="wishlist-info">
        <table>
            <tr>
              <td><?php echo $entry_subject; ?></td>
              <td><?php echo $ticket['ticket_subject']; ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_department; ?></td>
              <td><?php echo $ticket['department_name']; ?></td>
            </tr>
            <?php if($order_status){ ?>
            <tr>
              <td><?php echo $entry_order; ?></td>
              <td>#<?php echo $ticket['ticket_order_id']; ?></td>
            </tr>
            <?php } ?>
            
	      	<tr>
              <td>Статус</td>
              <td><span class="label label-important"><?php echo $ticket['ticket_status']; ?></span></td>
            </tr>
	     
		<?php if(isset($formdata)) echo $formdata; ?>
        </table>
		</div>
	    <div class="heading">
	      <h1><?php echo $heading_chat_title; ?></h1>
	    </div>
		
		
		<table cellpadding="0" cellspacing="0" style="width: 100%;">
      <?php 
	  $i = 1;
	foreach ( $messages as $data ) { 
		if ( false == $data['is_user']  ) {
			$author_avatar = HTTP_IMAGE . 'support.jpg';
			$author_name = 'Администрация handmadewatch.ru';
		} else { 
			$author_avatar = HTTP_IMAGE . '/cache/data/male-50x50_0.png';
			$author_name = $this->customer->getLastName() . ' ' . $this->customer->getFirstName();
		}
		?>
		<tr>
			<td class="testleft">
				<img src="<?php echo $author_avatar; ?>" width="50" height="50" />				
			</td>
			<td>
	  
	  <div class="oblako1long"></div>
	  <div class="kruk"></div>
<div class="oblakolong">
        <div class="namelong">
			<b><?php echo $author_name; ?></b>, 
			<span style="color:#666666"><?php echo $data['created']; ?></span>
		</div>
          <div class="description"><?php echo $data['content'] ; ?></div>
</div>

<div class="underlong">
        <div class="namelong">
			<b><?php echo $author_name; ?></b>,
			<br><span style="color:#666666"><?php echo $data['created']; ?></span>
		</div>
          <div class="description"><?php echo $data['content'] ; ?></div>
</div>
<div class="oblako2long"></div>
       
	   <?php
	   
	   echo "<br><br>";
	   
	   
	   ?>
	   
	   
	   </td>
	   
      </tr>

      <?php 
	  $i = $i + 1;
	  } ?>

 </table>
		
    
		<?php if($ticket['ticket_status']!='Решено'){ ?>
		<div class="myform">
		<form method="post" action="<?php echo $action; ?>" enctype="multipart/form-data" id="form">
	        
		    <div class="row-fluid">
	    		<div class="span2"><?php echo $entry_message; ?></div>
	            <div class="span8"><textarea rows="3" name="message" style="width: 90%; "><?php echo $message; ?></textarea></div>
	            <?php if ($error_message) { ?>
	              <div class="span10 offset2"><span class="error"><?php echo $error_message; ?></span></div>
	              <?php } ?>
	    	</div>
    	</form>
		</div>
    	<div style="height: 20px;"></div>
    	<div class="span4 offset4">
    	  
	      <a class="button" onclick="$('form').submit();"><span><?php echo $button_save; ?></span></a>
	      
	      <a class="button" href="<?php echo $cancel; ?>"><span><?php echo $button_cancel?></span></a>
	    </div>
	    <?php } ?>
	    <div style="height: 20px;"></div>
    <?php echo $content_bottom; ?></div>
</div>
<?php echo $footer; ?>