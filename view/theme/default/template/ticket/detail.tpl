<?php echo $header; ?>
<div class="container" id="ticket-module">
  <div id="content"><?php echo $content_top; ?>
    <div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>
	    <div class="heading">
	      <h1><?php echo $heading_title; ?></h1>
	    </div>
        <table class="table table-bordered">
            <tr>
              <th><?php echo $entry_subject; ?></th>
              <td><?php echo $ticket['ticket_subject']; ?></td>
            </tr>
            <tr>
              <th><?php echo $entry_department; ?></th>
              <td><?php echo $ticket['department_name']; ?></td>
            </tr>
            <?php if($order_status){ ?>
            <tr>
              <th><?php echo $entry_order; ?></th>
              <td>#<?php echo $ticket['ticket_order_id']; ?></td>
            </tr>
            <?php } ?>
            <?php if($ticket['ticket_status']=='Resolved'){ ?>
	      	<tr>
              <th>Status</th>
              <td><span style="color: white;" class="label label-important">Resolved</span></td>
            </tr>
	      <?php } ?>
		<?php if(isset($formdata)) echo $formdata; ?>
        </table>
	    <div class="heading">
	      <h1><?php echo $heading_chat_title; ?></h1>
	    </div>
	    <div class="row-fluid">
			<?php foreach ($messages as $data){ ?>
			<div class="row-fluid">
				<?php if ($data['is_user'] == false){ ?>
					<div class="span2"><?php if (isset($data['file']) && !empty($data['file'])){ ?><a href="<?php echo HTTP_IMAGE . $data['file']; ?>">Download File</a><?php } ?></div>
					<div class="span9">
						<div class="alert alert-error" style="word-wrap: break-word;">
					        <?php echo $data['content']; ?>
				        </div>
		        		<div style="color: silver; font-size: 12px;margin-left:0;" class="span4 offset2"><?php echo date('d-F-Y (h:i A)', strtotime($data['created'])); ?></div>
				    </div>
			        <div class="span1" >
			        	<img src="<?php echo HTTP_IMAGE; ?>support.jpg" />
			        	<div class="caption"><span class="badge badge-info" style="color: white;"><?php echo $text_admin; ?></span></div>
			        </div>
				
			    <?php }else{ ?>
				    <div class="span1" >
			        	<img src="<?php echo HTTP_IMAGE; ?>customer.jpg" />
			        	<div class="caption"><span class="badge badge-info" style="color: white;"><?php echo $text_you; ?></span></div>
			        </div>
					<div class="alert alert-success span9" style="word-wrap: break-word;">
				        <?php echo $data['content']; ?>
			        </div>
			        <div class="span2"><?php if (isset($data['file']) && !empty($data['file'])){ ?><a href="<?php echo HTTP_IMAGE . $data['file']; ?>">Download File</a><?php } ?></div>
			        <div style="color: silver; font-size: 12px;float: right;" class="span4 offset7"><?php echo date('d-F-Y (h:i A)', strtotime($data['created'])); ?></div>
		        <?php } ?>
			</div>
			<div style="height: 30px;"></div>
			<?php } ?>
		</div>
		<?php if($ticket['ticket_status']!='Resolved'){ ?>
		<form method="post" action="<?php echo $action; ?>" enctype="multipart/form-data" id="form">
	        <div class="row-fluid">
		        <div class="span2">Attach File: </div>
		        <div class="span8 fileupload fileupload-new" data-provides="fileupload">
				  <div class="input-append">
				    <div class="uneditable-input span3">
					    <i class="icon-file fileupload-exists"></i> 
					    <span class="fileupload-preview"></span>
				    </div>
				    <span class="btn btn-file">
				    	<span class="fileupload-new">Select file</span>
				    	<span class="fileupload-exists">Change</span>
				    	<input class="attach-file" type="file" name="file" />
				    </span>
				    <a href="#" class="btn fileupload-exists" data-dismiss="fileupload">Remove</a>
				  </div>
		        </div>
		        <?php if ($error_attach) { ?>
	              <div class="span10 offset2"><span class="error"><?php echo $error_attach; ?></span></div>
	              <?php } ?>
		    </div>
		    <div class="row-fluid">
	    		<div class="span2"><?php echo $entry_message; ?></div>
	            <div class="span8"><textarea rows="3" name="message" style="width: 90%; "><?php echo $message; ?></textarea></div>
	            <?php if ($error_message) { ?>
	              <div class="span10 offset2"><span class="error"><?php echo $error_message; ?></span></div>
	              <?php } ?>
	    	</div>
    	</form>
    	<div style="height: 20px;"></div>
    	<div class="span4 offset4">
    	  <?php if($ticket['ticket_status']!='Resolved'){ ?>
	      <a class="btn btn-success" onclick="$('form').submit();"><span><?php echo $button_save; ?></span></a>
	      <?php } ?>
	      <a class="btn btn-danger" style="color: white;" href="<?php echo $cancel; ?>"><span><?php echo $button_cancel?></span></a>
	    </div>
	    <?php } ?>
	    <div style="height: 20px;"></div>
    <?php echo $content_bottom; ?></div>
</div>
<?php echo $footer; ?>