<?php echo $header; ?>
<div class="container" id="ticket-module">
  <div id="content"><?php echo $content_top; ?>
    <div class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>
    <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>	
    <a class="btn btn-success" style="color: white;" href="<?php echo $insert; ?>"><span><?php echo $button_add; ?></span></a>
    <div class="heading">
      <h1><?php echo $heading_open_title; ?></h1>
    </div>
      <form method="post" enctype="multipart/form-data" id="form">
        <table class="table table-bordered table-hover">
          <thead>
            <tr>
              <th style="text-align: center;">ID#</th>
              <th style="text-align: center;"><?php echo $column_subject; ?></th>
              <th style="text-align: center;"><?php echo $column_department; ?></th>
              <th style="text-align: center;"><?php echo $column_status; ?></th>
              <th style="text-align: center;"><?php echo $column_date_added; ?></th>
              <th style="text-align: center;"><?php echo $column_last_update; ?></th>
              <th style="text-align: center;"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php if ($tickets) { ?>
            <?php foreach ($tickets as $ticket) { ?>
            <tr>
              <td style="text-align: center;"><?php echo $ticket['ticket_id']; ?></td>
              <td><?php echo $ticket['ticket_subject']; ?></td>
              <td style="text-align: center;"><?php echo $ticket['department_name']; ?></td>
              <td style="text-align: center;">
              <?php
              $class = ''; 
              	switch ($ticket['ticket_status']){
              		case 'Resolved':
              			$class = 'label-important';
              			break;
              			
              		case 'New':
              			$class = 'label-success';
              			break;
              			
              		default:
              			$class = 'label-info';
              			break;
              	}
              ?>
              	<span style="color: white;" class="label <?php echo $class; ?>"><?php echo $ticket['ticket_status']; ?></span>
              </td>
              <td style="text-align: center;"><?php echo date('d-F-Y (h:i A)', strtotime($ticket['ticket_created'])); ?></td>
              <td style="text-align: center;"><?php if( $ticket['ticket_last_update'] != $customer_name ){ echo 'Admin'; }else{ echo $customer_name;} ?></td>
              <td style="text-align: center;">
              	<a class="btn btn-primary" style="color: white;" href="<?php echo $actions[$ticket['ticket_id']]['href']; ?>"><?php echo $actions[$ticket['ticket_id']]['text']; ?></a>
              </td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    <?php echo $content_bottom; ?></div>
</div>
<?php echo $footer; ?>