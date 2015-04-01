<?php   
class ControllerTicketCreate extends Controller {
	private $error;
	
	public function index() {
		if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/account', '', 'SSL');
	  
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	} 
    	
    	$this->document->addScript('catalog/view/javascript/module/ticket/bootstrap-fileupload.js');
    	
    	//$this->document->addStyle('catalog/view/theme/default/stylesheet/bootstrap.css');
    	
    	$this->load->model('ticket/ticket');
    	$this->load->model('ticket/message');
    	
    	$this->language->load('ticket/create');
    	
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
//    		print $this->request->post['message']; exit;
    		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
    			unset($_SESSION['upload']);
	         	if(isset($_FILES)){
				   $tmp = array_keys($_FILES);
				   $i = 0;
				   foreach($tmp as $row){
					   if($_FILES[$row]['tmp_name'] != ''){
						   move_uploaded_file($_FILES[$row]['tmp_name'], DIR_IMAGE. "data/". $_FILES[$row]["name"]);
						   $_SESSION['upload'][$i]['field'] = $row;
						   $_SESSION['upload'][$i]['upload_file'] = "data/". $_FILES[$row]["name"];
						}
					   $i++;
				   }
				}
	         }
    		$ticket_id = $this->model_ticket_ticket->addTicket($this->request->post);
    		
    		if ( $this->request->post['message'] != "" ){
    			$this->request->post['ticket_id'] = $ticket_id;
	    		$this->model_ticket_message->addMessage($this->request->post);
    		}
    		
    		$this->model_ticket_ticket->lastUpdate($ticket_id, $this->customer->getFirstname() . ' ' . $this->customer->getLastname());
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('ticket/detail', '&ticket_id=' . $ticket_id));
    	}
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->data['breadcrumbs'] = array();
 
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);		
		
		if (isset($this->request->get['route'])) {
       		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link($this->request->get['route']),
        		'separator' => $this->language->get('text_separator')
      		);	   	
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->language->load('ticket/custom');

        $this->load->model('ticket/custom');

        $form_info = $this->model_ticket_custom->getForm();

        $this->data['text_location'] = $this->language->get('text_location');
        $this->data['text_creator'] = $this->language->get('text_creator');
        $this->data['text_address'] = $this->language->get('text_address');
        $this->data['text_telephone'] = $this->language->get('text_telephone');
        $this->data['text_fax'] = $this->language->get('text_fax');

        $this->data['entry_name'] = $this->language->get('entry_name');
        $this->data['entry_email'] = $this->language->get('entry_email');
        $this->data['entry_enquiry'] = $this->language->get('entry_enquiry');
        $this->data['entry_captcha'] = $this->language->get('entry_captcha');


        if (isset($this->error['error_captcha'])) {
            $this->data['error_captcha'] = $this->error['error_captcha'];
        } else {
            $this->data['error_captcha'] = '';
        }

        if (isset($this->error['email'])) {
            $this->data['error_email'] = $this->error['email'];
        } else {
            $this->data['error_email'] = '';
        }
        $this->data['formdata'] = $this->model_ticket_custom->getFormShow(unserialize($form_info['formdata']));

		$this->data['entry_subject'] = $this->language->get('entry_subject');
		$this->data['entry_department'] = $this->language->get('entry_department');
		$this->data['entry_attach'] = $this->language->get('entry_attach');
		$this->data['entry_content'] = $this->language->get('entry_content');
		$this->data['entry_message'] = $this->language->get('entry_message');
		$this->data['entry_order'] = $this->language->get('entry_order');
		$this->data['entry_empty_order'] = $this->language->get('entry_empty_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['subject'])) {
			$this->data['error_subject'] = $this->error['subject'];
		} else {
			$this->data['error_subject'] = array();
		}
		
		if (isset($this->error['attach'])) {
			$this->data['error_attach'] = $this->error['attach'];
		} else {
			$this->data['error_attach'] = array();
		}
		
		if (isset($this->error['message'])) {
			$this->data['error_message'] = $this->error['message'];
		} else {
			$this->data['error_message'] = array();
		}

		if (isset($this->error['order'])) {
			$this->data['error_order'] = $this->error['order'];
		} else {
			$this->data['error_order'] = array();
		}
		
		$this->data['action'] = $this->url->link('ticket/create');
		$this->data['cancel'] = $this->url->link('ticket/ticket_manage');
		
		if (isset($this->request->post['subject'])) {
      		$this->data['subject'] = $this->request->post['subject'];
		} else {
      		$this->data['subject'] = '';
    	}
    	
		if (isset($this->request->post['department'])) {
      		$this->data['department'] = $this->request->post['department'];
		} else {
      		$this->data['department'] = 0;
    	}
    	
		if (isset($this->request->post['message'])) {
      		$this->data['message'] = $this->request->post['message'];
		} else {
      		$this->data['message'] = '';
    	}
    	
    	if (isset($this->request->post['ticket_order_id'])) {
      		$this->data['ticket_order_id'] = $this->request->post['ticket_order_id'];
		} else {
      		$this->data['ticket_order_id'] = '';
    	}
    	
    	$config_info = $this->model_ticket_ticket->getConfig();
		$this->data['order_status'] = $config_info['order_status'];
		
		$this->data['order'] = $this->model_ticket_ticket->getOrderID();
    	$this->load->model('ticket/department');
    	
    	$this->data['departments'] = $this->model_ticket_department->getDepartments();
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/ticket/create.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/ticket/create.tpl';
		} else {
			$this->template = 'default/template/ticket/create.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
		
		$this->response->setOutput($this->render());
  	}
  	
  	private function validateForm() {
  		$this->language->load('ticket/custom');
  		if ((utf8_strlen($this->request->post['subject']) < 1) || (utf8_strlen($this->request->post['subject']) > 150)) {
      		$this->error['subject'] = $this->language->get('text_error_subject');
    	}
    	
  		if (utf8_strlen($this->request->post['message']) < 3) {
      		$this->error['message'] = $this->language->get('text_error_message');
    	}

    	$config_info = $this->model_ticket_ticket->getConfig();
		if($config_info['order_status']&&$config_info['order_required']){
	    	if ($this->request->post['ticket_order_id'] == "") {
	      		$this->error['order'] = $this->language->get('text_error_order');
	    	}
		}
		if ( isset($this->request->files['file']["name"]) && !empty($this->request->files['file']["name"])){
			$allowed = array(
				'image/jpeg',
	            'image/png',
	            'application/rar',
	            'application/octet-stream',
	            'image/gif', 
				'application/x-zip-compressed',                               
			);
			
			$uploaddir = DIR_IMAGE. 'data/upload/'; 
		
			if($this->request->files['file']['size'] > 50000000){
	        	$this->error['attach'] = $this->language->get('text_error_size');
			
			}elseif (!in_array($this->request->files['file']['type'], $allowed)){
				$this->error['attach'] = $this->language->get('text_error_extension');
			
			}elseif(!file_exists($uploaddir)){
	        	if(!mkdir($uploaddir)){
	             	$this->error['attach'] = $this->language->get('text_error_save');                  
				}
	        
			}else{
	        	$temp =  $this->request->files['file']['tmp_name'];
	        	$name = $this->request->files["file"]["name"];
	        	
	        	if (!move_uploaded_file($temp, "$uploaddir/$name")) { 
					$this->error['attach'] = $this->language->get('text_error_save');       
				}else{
					$this->request->post['file'] = "data/upload/$name";
				}
	        }
		}
		
		 foreach ($this->request->post as $key => $val) {
            if (strpos($key, "_1_")) {
                list($type,$name) = explode("_1_", $key);

                if( $type == 'email')
                if (!preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post[$key])) {
		            $this->error['email'] = $this->language->get('error_email');
		            }

                if( $type == 'captcha')
                if (!isset($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post[$key])) {
                    $this->error['error_captcha'] = $this->language->get('error_captcha');
                }
            }
        }
       

		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
					
    	if (!$this->error) {
			return true;
    	} else {
      		return false;
    	}
  	}
}
?>