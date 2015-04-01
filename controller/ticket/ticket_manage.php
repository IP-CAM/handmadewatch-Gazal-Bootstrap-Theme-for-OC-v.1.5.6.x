<?php   
class ControllerTicketTicketManage extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/account', '', 'SSL');
	  
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	} 
    	
    	//$this->document->addStyle('catalog/view/theme/default/stylesheet/bootstrap.css');
    			
		$this->language->load('ticket/ticket_manage');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->data['breadcrumbs'] = array();
 
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);		
		
		if (isset($this->request->get['route'])) {
       		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_ticket'),
				'href'      => $this->url->link($this->request->get['route']),
        		'separator' => $this->language->get('text_separator')
      		);	   	
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['heading_open_title'] = $this->language->get('heading_open_title');
		$this->data['heading_other_title'] = $this->language->get('heading_other_title');
		
		$this->data['column_subject'] = $this->language->get('column_subject');
		$this->data['column_department'] = $this->language->get('column_department');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_last_update'] = $this->language->get('column_last_update');
		$this->data['column_action'] = $this->language->get('column_action');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		
		$this->data['button_add'] = $this->language->get('button_add');

		$this->load->model('ticket/ticket');
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else { 
			$page = 1;
		}	
							
		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = 10;
		}

		$data = array(
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);

		$tickets = $this->model_ticket_ticket->getTickets($data);
		//echo $this->model_ticket_ticket->getDate($tickets[0]['ticket_created']);
		$total_tickets = $this->model_ticket_ticket->getTickets();

		$pagination = new Pagination();
		$pagination->total = count($total_tickets);
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('ticket/ticket_manage', 'page={page}');
		$this->data['pagination'] = $pagination->render();

		$this->data['tickets'] = $tickets;
		
		
		$this->data['customer_name'] = $this->customer->getFirstname() . ' ' . $this->customer->getLastname();
		
		foreach ( $tickets as $ticket ){
			//$this->data['tickets'][]['ticket_created'] = $this->model_ticket_ticket->getDate($ticket['ticket_created']);
			//echo $this->data['tickets'][]['ticket_created'];
			$this->data['actions'][$ticket['ticket_id']] = array(
				'text' => $this->language->get('text_detail'),
				'href' => $this->url->link('ticket/detail', '&ticket_id=' . $ticket['ticket_id'])
			);
		}
		
		$this->data['insert'] = $this->url->link('ticket/create');
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/ticket/ticket_manage.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/ticket/ticket_manage.tpl';
		} else {
			$this->template = 'default/template/ticket/ticket_manage.tpl';
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
}
?>