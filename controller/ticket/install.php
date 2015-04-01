<?php  
class ControllerTicketInstall extends Controller {  
	public function index() {
    	$this->load->model('ticket/install');
    	
    	$this->model_ticket_install->install();
  	}
}
?>