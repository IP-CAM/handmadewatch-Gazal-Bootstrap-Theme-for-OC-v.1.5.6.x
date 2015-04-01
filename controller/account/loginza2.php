<?php
class ControllerAccountLoginza2 extends Controller {
	private $error = array();

	/*
		google, yandex, mailruapi, mailru, vkontakte, facebook, odnoklassniki, livejournal, twitter, linkedin, loginza, myopenid, webmoney, rambler, flickr, lastfm, verisign, aol, steam, openid 
	*/
	private $socnets = array(
				'google.com'=>'google', 
				'yandex.ru'=>'yandex', 
				'openid.mail.ru'=>'mailruapi', 
				'http://mail.ru/'=>'mailru',
				'vk.com'=>'vkontakte', 
				'facebook.com'=>'facebook', 
				'odnoklassniki'=>'odnoklassniki', 
				'livejournal.com'=>'livejournal', 
				'twitter.com'=>'twitter', 
				'linkedin'=>'linkedin',
				'loginza.ru'=>'loginza', 
				'myopenid.com'=>'myopenid', 
				'webmoney'=>'wmkeeper.com', 
				'rambler'=>'rambler',   //?
				'flickr'=>'flickr',     //?
				'last.fm'=>'last.fm',    
				'verisign'=>'verisign', //?
				'aol'=>'aol.com',       
				'steam'=>'steamcommunity.com',    
				'openid'=>'openid'  
	);
	
	/* start metka: a1 */
	public function getLink($data)
	{
		$link = '';
		
		$identity_list = array(
			"mailru"=>1,
			"vkontakte"=>1,
			"facebook"=>1,
			"livejournal"=>1,
			"twitter"=>1,
			"linkedin"=>1,
			"wmkeeper.com"=>1,
			"last.fm"=>1,
			"aol.com"=>1
		);
		
		if( !empty($identity_list[ $data['provider'] ]) )
		{
			$link = $data['identity'];
		}
		
		return $link;
	}
	/* end metka: a1 */
		
	
	public function index() {	
		if ($this->customer->isLogged()) {
			$this->redirect($this->url->link($this->session->data['loginza2_lastlink'], '', 'SSL'));
		}
		
		if( empty( $this->request->post['token'] ) )
		{
			$this->redirect($this->url->link('account/login', '', 'SSL'));
		}
		
		$TOKEN = $this->request->post['token'];
		
		if( $this->config->get('loginza2_safemode') && $this->config->get('loginza2_widget_id') && $this->config->get('loginza2_widget_sig') )
		{
			$ID = $this->config->get('loginza2_widget_id');
			$SIG = $this->config->get('loginza2_widget_sig');
			$SIG = md5($TOKEN.$SIG);
			
			$url = "http://loginza.ru/api/authinfo?token=".$TOKEN."&id=".$ID."&sig=".$SIG;
		}
		else
		{
			$url = "http://loginza.ru/api/authinfo?token=".$TOKEN;
		}
		
		
		if( extension_loaded('curl') )
		{
			$c = curl_init($url);
			curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
			$page = curl_exec($c);
			curl_close($c);
		}
		else
		{
			$page = file_get_contents($url);
		}
		
		if( empty($page) )
		{
			exit('error connection');
		}
		
		
		
		$arr = json_decode($page, true);
		
		
	/* * /
		foreach($arr as $key=>$val)
		{
			echo $key." - ".$val."<br>";
				
						echo "1===";
			if( is_array($val) )
			{
						echo "2===";
				foreach($val as $k=>$v)
				{
						echo "3===";
					echo '-'.$k." - ".$v."<br>";
					if(  is_array( $v ) )
					{
						echo "4===";
						foreach($v as $k1=>$v1)
						{
						echo "5===";
							echo "--".$k1." - ".$v1."<br>";
						}
					}
					
				}
			}
		}
		//echo "<hr>".$arr['provider'];
		
		exit();
	/* */	
	
		
		if( !empty($arr['error_type']) )
		{
			exit($arr['error_type']." - ".$arr['error_message']);
		}
		
		if( empty($arr['identity']) ) exit('not identity');
		
		$provider = '';
		
		foreach($this->socnets as $search=>$net)
		{
			if( strstr($arr['provider'], $search) )
			{
				$provider = $net;
				break;
			}
		}
		
		$data = array(
			'identity'  => $arr['identity'],
			'firstname' => '',
			'lastname'  => '',
			'email'     => '',
			'telephone'	=> '',
			'data'		=> serialize($arr),
			'provider'  => $provider
		);
		
		/* start metka: a1 */
		$data['link'] = $this->getLink($data);
		/* end metka: a1 */
		
		if( !empty( $arr['name']['first_name'] ) )
		{
			$data['firstname'] = $arr['name']['first_name'];
		}
		
		if( !empty( $arr['name']['last_name'] ) )
		{
			$data['lastname'] = $arr['name']['last_name'];
		}
		
		if( !empty( $arr['email'] ) )
		{
			$data['email'] = $arr['email'];
		}
		
		if( !empty( $arr['phone']['preferred'] ) )
		{
			$data['telephone'] = $ar['phone']['preferred'];
		}
		elseif( !empty( $arr['phone']['mobile'] ) )
		{
			$data['telephone'] = $arr['phone']['mobile'];
		}
		elseif( !empty( $arr['phone']['home'] ) )
		{
			$data['telephone'] = $arr['phone']['home'];
		}
		elseif( !empty( $arr['phone']['work'] ) )
		{
			$data['telephone'] = $arr['phone']['work'];
		}
		elseif( !empty( $arr['phone']['fax'] ) )
		{
			$data['telephone'] = $arr['phone']['fax'];
		}
		
		
		if( empty( $arr['name']['first_name'] ) && 
			empty( $arr['name']['last_name'] ) &&  
			!empty( $arr['name']['full_name'] ) )
		{
			$ar = explode(" ", $arr['name']['full_name']);
			
			$data['firstname'] = $ar[0];
			if( !empty($ar[1]) )
			$data['lastname']  = $ar[1]; 
		}
		
		/* kin insert metka: c1 */
		$data['company'] = '';
		$data['address_1'] = '';
		$data['postcode'] = '';
		$data['city'] = '';
		$data['zone'] = '';
		$data['country'] = '';
		/* end kin metka: c1 */
		
		$this->load->model('account/loginza2');
		
		if( $customer_id = $this->model_account_loginza2->checkNew( $data ) )
		{
			$this->session->data['customer_id'] = $customer_id;
			$this->session->data['loginza2_confirmdata_show'] = 0;
			$this->redirect( $this->session->data['loginza2_lastlink'] );
		}
		else
		{
			
			if( $confirm_data = $this->isNeedConfirm( $data ) )
			{
				$confirm_data['data'] = $data;
				$this->session->data['loginza2_confirmdata'] = serialize($confirm_data);
				$this->session->data['loginza2_confirmdata_show'] = 1;
				$this->redirect( $this->session->data['loginza2_lastlink'] );
			}
			else
			{
				$this->session->data['loginza2_confirmdata'] = '';
				$this->session->data['loginza2_confirmdata_show'] = '';
				
				
				$customer_id = $this->model_account_loginza2->addCustomer( $data );
				$this->session->data['customer_id'] = $customer_id;	
				$this->redirect( $this->session->data['loginza2_lastlink'] );
			}
		}
	}
	
	
	
	
	
	public function frame()
	{
		$this->language->load('account/loginza2');
		$this->load->model('account/loginza2');
		
		$loginza_data = unserialize( $this->session->data['loginza2_confirmdata'] );
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && 
			$data = $this->validate($loginza_data['data'])) 
		{
			$this->session->data['loginza2_confirmdata'] = '';
			$customer_id = $this->model_account_loginza2->addCustomer( $data );
			$this->session->data['customer_id'] = $customer_id;	
			$this->redirect( $this->url->link('account/loginza2/success', '', 'SSL') );
		}
		
		$this->data['action'] = $this->url->link('account/loginza2/frame', '', 'SSL');
		
		$this->data['header'] = $this->language->get('header');
		$this->data['header_notice'] = $this->language->get('header_notice');
		$this->data['entry_firstname'] = $this->language->get('entry_firstname');
		$this->data['entry_lastname'] = $this->language->get('entry_lastname');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_telephone'] = $this->language->get('entry_telephone');
		
		/* kin insert metka: c1 */
		$this->data['entry_company'] = $this->language->get('entry_company');
		$this->data['entry_address_1'] = $this->language->get('entry_address_1');
		$this->data['entry_postcode'] = $this->language->get('entry_postcode');
		$this->data['entry_city'] = $this->language->get('entry_city');
		$this->data['entry_zone'] = $this->language->get('entry_zone');
		$this->data['entry_country'] = $this->language->get('entry_country');
		
		$this->data['text_select'] = $this->language->get('text_select');
		
		$this->data['firstname_required'] = $this->config->get('loginza2_confirm_firstname_required');
		$this->data['lastname_required']  = $this->config->get('loginza2_confirm_lastname_required');
		$this->data['email_required']     = $this->config->get('loginza2_confirm_email_required');
		$this->data['telephone_required'] = $this->config->get('loginza2_confirm_telephone_required');
		$this->data['company_required']   = $this->config->get('loginza2_confirm_company_required');
		$this->data['postcode_required']  = $this->config->get('loginza2_confirm_postcode_required');
		$this->data['country_required']   = $this->config->get('loginza2_confirm_country_required');
		$this->data['zone_required']      =	$this->config->get('loginza2_confirm_zone_required');
		$this->data['city_required']      = $this->config->get('loginza2_confirm_city_required');
		$this->data['address_1_required'] = $this->config->get('loginza2_confirm_address_1_required');
		
		
		
		$this->load->model('localisation/country');
    	$this->data['countries'] = $this->model_localisation_country->getCountries();

		if( !empty($this->request->post['company']) )
		{
			$this->data['company'] = $this->request->post['company'];
		}
		else
		{
			$this->data['company'] = '';
		}
		
		if( isset($loginza_data['company']) )
		{
			$this->data['is_company'] = 1;
		}
		else
		{
			$this->data['is_company'] = 0;
		}
		
		if( !empty($this->request->post['address_1']) )
		{
			$this->data['address_1'] = $this->request->post['address_1'];
		}
		else
		{
			$this->data['address_1'] = '';
		}
		
		if( isset($loginza_data['address_1']) )
		{
			$this->data['is_address_1'] = 1;
		}
		else
		{
			$this->data['is_address_1'] = 0;
		}
		
		if( !empty($this->request->post['postcode']) )
		{
			$this->data['postcode'] = $this->request->post['postcode'];
		}
		else
		{
			$this->data['postcode'] = '';
		}
		
		if( isset($loginza_data['postcode']) )
		{
			$this->data['is_postcode'] = 1;
		}
		else
		{
			$this->data['is_postcode'] = 0;
		}
		
		if( !empty($this->request->post['city']) )
		{
			$this->data['city'] = $this->request->post['city'];
		}
		else
		{
			$this->data['city'] = '';
		}
		
		if( isset($loginza_data['city']) )
		{
			$this->data['is_city'] = 1;
		}
		else
		{
			$this->data['is_city'] = 0;
		}
		
		if( !empty($this->request->post['zone']) )
		{
			$this->data['zone'] = $this->request->post['zone'];
		}
		else
		{
			$this->data['zone'] = '';
		}
		
		if( isset($loginza_data['zone']) )
		{
			$this->data['is_zone'] = 1;
		}
		else
		{
			$this->data['is_zone'] = 0;
		}
		
		
		if( !empty($this->request->post['country']) )
		{
			$this->data['country'] = $this->request->post['country'];
		}
		elseif( isset($this->request->post['country']) )
		{
			$this->data['country'] = '';
		}
		else
		{
			$this->data['country'] = $this->config->get('config_country_id');
		}
		
		if( isset($loginza_data['country']) )
		{
			$this->data['is_country'] = 1;
		}
		else
		{
			$this->data['is_country'] = 0;
		}
		
		if( !empty( $this->error['company'] ) )
		{
			$this->data['error_company'] = $this->error['company'];
		}
		else
		{
			$this->data['error_company'] = '';
		}
		
		if( !empty( $this->error['address_1'] ) )
		{
			$this->data['error_address_1'] = $this->error['address_1'];
		}
		else
		{
			$this->data['error_address_1'] = '';
		}
		
		if( !empty( $this->error['postcode'] ) )
		{
			$this->data['error_postcode'] = $this->error['postcode'];
		}
		else
		{
			$this->data['error_postcode'] = '';
		}
		
		if( !empty( $this->error['city'] ) )
		{
			$this->data['error_city'] = $this->error['city'];
		}
		else
		{
			$this->data['error_city'] = '';
		}
		
		if( !empty( $this->error['zone'] ) )
		{
			$this->data['error_zone'] = $this->error['zone'];
		}
		else
		{
			$this->data['error_zone'] = '';
		}
		
		if( !empty( $this->error['country'] ) )
		{
			$this->data['error_country'] = $this->error['country'];
		}
		else
		{
			$this->data['error_country'] = '';
		}
		
		/* 
		company
		address_1
		address_2
		postcode
		city
		zone_id
		country_id
		end kin metka: c1 */
		
		$this->data['text_submit'] = $this->language->get('text_submit');
		
		
		
		if( !empty($this->request->post['firstname']) )
		{
			$this->data['firstname'] = $this->request->post['firstname'];
		}
		elseif( isset($loginza_data['firstname']) )
		{
			$this->data['firstname'] = $loginza_data['firstname'];
		}
		else
		{
			$this->data['firstname'] = '';
		}
		
		if( isset($loginza_data['firstname']) )
		{
			$this->data['is_firstname'] = 1;
		}
		else
		{
			$this->data['is_firstname'] = 0;
		}
		
		if( !empty($this->request->post['lastname']) )
		{
			$this->data['lastname'] = $this->request->post['lastname'];
		}
		elseif( isset($loginza_data['lastname']) )
		{
			$this->data['lastname'] = $loginza_data['lastname'];
		}
		else
		{
			$this->data['lastname'] = '';
		}
		
		if( isset($loginza_data['lastname']) )
		{
			$this->data['is_lastname'] = 1;
		}
		else
		{
			$this->data['is_lastname'] = 0;
		}
		
		if( !empty($this->request->post['email']) )
		{
			$this->data['email'] = $this->request->post['email'];
		}
		elseif( isset($loginza_data['email']) )
		{
			$this->data['email'] = $loginza_data['email'];
		}
		else
		{
			$this->data['email'] = '';
		}
		
		if( isset($loginza_data['email']) )
		{
			$this->data['is_email'] = 1;
		}
		else
		{
			$this->data['is_email'] = 0;
		}
		
		if( !empty($this->request->post['telephone']) )
		{
			$this->data['telephone'] = $this->request->post['telephone'];
		}
		elseif( isset($loginza_data['telephone']) )
		{
			$this->data['telephone'] = $loginza_data['telephone'];
		}
		else
		{
			$this->data['telephone'] = '';
		}
		
		if( isset($loginza_data['telephone']) )
		{
			$this->data['is_telephone'] = 1;
		}
		else
		{
			$this->data['is_telephone'] = 0;
		}
		
		if( !empty( $this->error['firstname'] ) )
		{
			$this->data['error_firstname'] = $this->error['firstname'];
		}
		else
		{
			$this->data['error_firstname'] = '';
		}
		
		if( !empty( $this->error['lastname'] ) )
		{
			$this->data['error_lastname'] = $this->error['lastname'];
		}
		else
		{
			$this->data['error_lastname'] = '';
		}
		
		if( !empty( $this->error['email'] ) )
		{
			$this->data['error_email'] = $this->error['email'];
		}
		else
		{
			$this->data['error_email'] = '';
		}
		
		if( !empty( $this->error['telephone'] ) )
		{
			$this->data['error_telephone'] = $this->error['telephone'];
		}
		else
		{
			$this->data['error_telephone'] = '';
		}
		
		//-------------------------
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/loginza2_frame.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/loginza2_frame.tpl';
		} else {
			$this->template = 'default/template/account/loginza2_frame.tpl';
		}
		
		$this->response->setOutput($this->render());
	}
	
	public function success()
	{
		$this->language->load('account/loginza2');
		$this->data['header'] = $this->language->get('header');
		$this->data['success'] = $this->language->get('success');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/loginza2_frame_success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/loginza2_frame_success.tpl';
		} else {
			$this->template = 'default/template/account/loginza2_frame_success.tpl';
		}
		
		$this->response->setOutput($this->render());
	}
	
	
  	private function validate($data) {
    	
		if( isset( $this->request->post['firstname'] ) && 
			empty( $this->request->post['firstname'] ) &&
			$this->config->get('loginza2_confirm_firstname_required') 
		)
		{
			$this->error['firstname'] = $this->language->get('error_firstname');
		}
		
		if( isset( $this->request->post['lastname'] ) && 
			empty( $this->request->post['lastname'] ) &&
			$this->config->get('loginza2_confirm_lastname_required')  
		)
		{
			$this->error['lastname'] = $this->language->get('error_lastname');
		}
		
		if( isset( $this->request->post['email'] ) && 
			empty( $this->request->post['email'] ) &&
			$this->config->get('loginza2_confirm_email_required') 
		)
		{
			$this->error['email'] = $this->language->get('error_email');
		}
		elseif( 
			!empty( $this->request->post['email'] ) && 
			!preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'] ) &&
			$this->config->get('loginza2_confirm_firstname_required') 
		)
		{
			$this->error['email'] = $this->language->get('error_email2');
		}
		
		if( isset( $this->request->post['telephone'] ) && 
			empty( $this->request->post['telephone'] ) &&
			$this->config->get('loginza2_confirm_telephone_required') )
		{
			$this->error['telephone'] = $this->language->get('error_telephone');
		}
		
		if( isset( $this->request->post['company'] ) && 
			empty( $this->request->post['company'] ) &&
			$this->config->get('loginza2_confirm_company_required') )
		{
			$this->error['company'] = $this->language->get('error_company');
		}
		
		if( isset( $this->request->post['address_1'] ) && 
			empty( $this->request->post['address_1'] ) &&
			$this->config->get('loginza2_confirm_address_1_required') )
		{
			$this->error['address_1'] = $this->language->get('error_address_1');
		}
		
		if( isset( $this->request->post['postcode'] ) && 
			empty( $this->request->post['postcode'] ) &&
			$this->config->get('loginza2_confirm_postcode_required') )
		{
			$this->error['postcode'] = $this->language->get('error_postcode');
		}
		
		if( isset( $this->request->post['city'] ) && 
			empty( $this->request->post['city'] ) &&
			$this->config->get('loginza2_confirm_city_required') )
		{
			$this->error['city'] = $this->language->get('error_city');
		}
		
		if( isset( $this->request->post['zone'] ) && 
			empty( $this->request->post['zone'] ) &&
			$this->config->get('loginza2_confirm_zone_required') )
		{
			$this->error['zone'] = $this->language->get('error_zone');
		}
		
		if( isset( $this->request->post['country'] ) && 
			empty( $this->request->post['country'] ) &&
			$this->config->get('loginza2_confirm_country_required') )
		{
			$this->error['country'] = $this->language->get('error_country');
		}
		
    	if (!$this->error) {
			if( !empty($this->request->post['firstname']) )
			{
				$data['firstname'] = $this->request->post['firstname'];
			}
			
			if( !empty($this->request->post['lastname']) )
			{
				$data['lastname']  = $this->request->post['lastname'];
			}
						
			if( !empty($this->request->post['email']) )
			{
				$data['email']  = $this->request->post['email'];
			}
						
			if( !empty($this->request->post['telephone']) )
			{
				$data['telephone']  = $this->request->post['telephone'];
			}
			
			if( !empty($this->request->post['company']) )
			{
				$data['company']  = $this->request->post['company'];
			}
			
			if( !empty($this->request->post['address_1']) )
			{
				$data['address_1']  = $this->request->post['address_1'];
			}
			
			if( !empty($this->request->post['postcode']) )
			{
				$data['postcode']  = $this->request->post['postcode'];
			}
			
			if( !empty($this->request->post['city']) )
			{
				$data['city']  = $this->request->post['city'];
			}
			
			if( !empty($this->request->post['zone']) )
			{
				$data['zone']  = $this->request->post['zone'];
			}
			
			if( !empty($this->request->post['country']) )
			{
				$data['country']  = $this->request->post['country'];
			}
			
			
      		return $data;
    	} else {
      		return false;
    	}  	
  	}
	
	
	protected function isNeedConfirm($data)
	{
		$confirm_data = array();
		
		if( $this->config->get('loginza2_confirm_firstname_status') == 2 || (
			$this->config->get('loginza2_confirm_firstname_status') == 1 && empty($data['firstname'])
			) )
		{
			$confirm_data['firstname'] = $data['firstname'];
		}
		
		if( $this->config->get('loginza2_confirm_lastname_status') == 2 || (
			$this->config->get('loginza2_confirm_lastname_status') == 1 && empty($data['lastname'])
		) )
		{
			$confirm_data['lastname'] = $data['lastname'];
		}
		
		if( $this->config->get('loginza2_confirm_email_status') == 2 || (
			$this->config->get('loginza2_confirm_email_status') == 1 && empty($data['email'])
			) )
		{
			$confirm_data['email'] = $data['email'];
		}
		
		if( $this->config->get('loginza2_confirm_telephone_status') == 2 || (
			$this->config->get('loginza2_confirm_telephone_status') == 1 && empty($data['telephone'])
		) )
		{
			$confirm_data['telephone'] = $data['telephone'];
		}
		
		/* kin insert metka: c1 */
		if( $this->config->get('loginza2_confirm_company_status') == 2 || (
			$this->config->get('loginza2_confirm_company_status') == 1 && empty($data['company'])
		) )
		{
			$confirm_data['company'] = '';
		}
		
		if( $this->config->get('loginza2_confirm_address_1_status') == 2 || (
			$this->config->get('loginza2_confirm_address_1_status') == 1 && empty($data['address_1'])
		) )
		{
			$confirm_data['address_1'] = '';
		}
		
		if( $this->config->get('loginza2_confirm_postcode_status') == 2 || (
			$this->config->get('loginza2_confirm_postcode_status') == 1 && empty($data['postcode'])
		) )
		{
			$confirm_data['postcode'] = '';
		}
		
		if( $this->config->get('loginza2_confirm_city_status') == 2 || (
			$this->config->get('loginza2_confirm_city_status') == 1 && empty($data['city'])
		) )
		{
			$confirm_data['city'] = '';
		}
		
		if( $this->config->get('loginza2_confirm_zone_status') == 2 || (
			$this->config->get('loginza2_confirm_zone_status') == 1 && empty($data['zone'])
		) )
		{
			$confirm_data['zone'] = '';
		}
		
		if( $this->config->get('loginza2_confirm_country_status') == 2 || (
			$this->config->get('loginza2_confirm_country_status') == 1 && empty($data['country'])
		) )
		{
			$confirm_data['country'] = '';
		}
		/* end kin metka: c1 */
		
		
		if( !$confirm_data )
		{	
			return false;
		}
		else
		{		
			return $confirm_data;
		}
	}
}
?>