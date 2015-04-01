<?php
class ControllerInformationFaq extends Controller {
	public function index() {
	
	//print_r (get_loaded_extensions());
	
		$this->load->language('information/faq');
		$this->load->model('fido/faq');
		
		$heading_title = $this->language->get('heading_title');
		$this->document->setTitle( $heading_title );
		//echo $heading_title;
			
		$this->data['heading_title'] = $heading_title;

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home'),
			'text'      => $this->language->get('text_home'),
			'separator' => FALSE
		);

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('information/faq'),
			'text'      => $this->language->get('heading_title'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['button_faq'] = $this->language->get('button_faq');

		$this->data['faq'] = $this->url->link('information/faq');
		
		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['continue'] = $this->url->link('common/home');
		
		$topic = '';
		$this->load->model('ticket/department');
    	
		$departments = $this->model_ticket_department->getDepartments();
		$error = true;	
		if ($departments) {
			foreach ($departments as $department) {
				$topic_id = $department['department_id'];
				//error_log( $topic_id );
				$topic_info = $this->model_fido_faq->getTopic($topic_id);	
				//error_log( print_r( $topic_info ,true ) );
				if ($topic_info) {
					$error = false;
					error_log( print_r( $this->getTopics( $topic_info ),true ) );
					$this->data['department'][ $topic_id ] = $this->getTopics( $topic_info );	
					error_log( 'Occurence' );
				}
			}			
		}
		
		if ($error) $this->getError();

		if ( 
			file_exists( 
				DIR_TEMPLATE . 
				$this->config->get('config_template') . 
				'/template/information/faq.tpl' 
			) 
		) {
			$this->template = 
				$this->config->get('config_template') . 
				'/template/information/faq.tpl';
		} else {
			$this->template = 'default/template/information/faq.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
		//echo $heading_title;
		$this->response->setOutput($this->render());
		
	}

	private function getTopics( $topic_info ) {
		foreach ($topic_info as $faq) {
			$ticket_id = $faq['ticket_id'];
			//здесь все сообщения 
			$topic_data[ $ticket_id ][] = $this->model_fido_faq->getTopics( $ticket_id ); 
		}      
		
		//error_log( print_r( $topic_data, true ) );
		
		if ( ! $topic_data )
			return false;
			
		//error_log( print_r( $topic_info, true ) );
		
		$result['title'] = $topic_info[0]['department_name'];
		
		//error_log( $topic_info[0]['department_name'] );
			
		$result['topics'] = array();
                
		foreach ( $topic_info as $info ) {					
			$result['topics'][] = array(
				'title' => $info['ticket_subject'],
				'id' => $info['ticket_id'],
				'faq_dec' => $topic_data[ $info['ticket_id'] ],
			);
		}
		
		return $result;
				
  	}

	private function getError() {
	
		$href = $this->url->link('information/faq');
		error_log( 'Went to error' );
		$this->data['breadcrumbs'][] = array(
			'href'      => $href,
			'text'      => $this->language->get('text_error'),
			'separator' => $this->language->get('text_separator')
		);

		$this->document->setTitle($this->language->get('text_error'));

		$this->data['heading_title'] = $this->language->get('text_error');

		$this->data['text_error'] = $this->language->get('text_error');

		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['continue'] = HTTP_SERVER . 'index.php?route=common/home';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
		} else {
			$this->template = 'default/template/error/not_found.tpl';
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
