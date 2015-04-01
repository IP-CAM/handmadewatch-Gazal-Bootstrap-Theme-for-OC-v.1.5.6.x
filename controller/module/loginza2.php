<?php  
class ControllerModuleLoginza2 extends Controller {
	private $socnets = array(
				'google'		=> 'Google', 
				'yandex' 		=> 'Yandex', 
				'mailruapi' 	=> 'OpenID.mail.ru', 
				'mailru' 		=> 'Mail.ru', 
				'vkontakte'     => 'ВКонтакте', 
				'facebook'	    => 'FaceBook', 
				'odnoklassniki' => 'Одноклассники', 
				'livejournal'   => 'LiveJournal.com', 
				'twitter'       => 'Twitter',  
				'linkedin'      => 'LinkedIN', 
				'loginza'       => 'Loginza', 
				'myopenid'      => 'MyOpenID', 
				'webmoney'      => 'WebMoney', 
				'rambler'       => 'Rambler',  
				'flickr'        => 'Flickr', 
				'lastfm'        => 'Last.FM', 
				'last.fm'       => 'Last.FM', 
				'verisign'      => 'Verisign.com', 
				'aol'			=> 'Aol.com',	
				'steam'			=> 'Steam', 
				'openid'		=> 'OpenID'
	);
	
	protected function index() {
		
		if( $this->customer->isLogged() && $this->config->get('loginza2_widget_after')=='hide' ) return;
		
		$this->language->load('module/loginza2');
		
		$loginza2_widget_name = $this->config->get('loginza2_widget_name');		
    	$this->data['heading_title'] = $loginza2_widget_name[ $this->config->get('config_language_id') ];
		
		
		$this->data['entry_email'] = $this->language->get('entry_email');		
		$this->data['entry_password'] = $this->language->get('entry_password');		
		$this->data['text_login'] = $this->language->get('text_login');		
		$this->data['text_register'] = $this->language->get('text_register');		
		$this->data['text_forgotten'] = $this->language->get('text_forgotten');		
		
		$this->data['text_register'] = $this->language->get('text_register');
    	$this->data['text_login'] = $this->language->get('text_login');
		$this->data['text_logout'] = $this->language->get('text_logout');
		$this->data['text_forgotten'] = $this->language->get('text_forgotten');
		$this->data['text_account'] = $this->language->get('text_account');
		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_password'] = $this->language->get('text_password');
		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_return'] = $this->language->get('text_return');
		$this->data['text_transaction'] = $this->language->get('text_transaction');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');
		
		$this->data['register'] = $this->url->link('account/register', '', 'SSL');
    	$this->data['login'] = $this->url->link('account/login', '', 'SSL');
		$this->data['logout'] = $this->url->link('account/logout', '', 'SSL');
		$this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
		$this->data['account'] = $this->url->link('account/account', '', 'SSL');
		$this->data['edit'] = $this->url->link('account/edit', '', 'SSL');
		$this->data['password'] = $this->url->link('account/password', '', 'SSL');
		$this->data['wishlist'] = $this->url->link('account/wishlist');
		$this->data['order'] = $this->url->link('account/order', '', 'SSL');
		$this->data['download'] = $this->url->link('account/download', '', 'SSL');
		$this->data['return'] = $this->url->link('account/return', '', 'SSL');
		$this->data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$this->data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');
		$this->data['action'] = $this->url->link('account/login', '', 'SSL');
		
		$this->data['loginza2_widget_format'] = $this->config->get('loginza2_widget_format');	
		$this->data['loginza2_widget_default'] = $this->config->get('loginza2_widget_default');	
		
		if( $this->config->get('loginza2_showtype')=='window' )
		{
			$this->data['classname'] = 'loginza';	
		}
		else
		{
			$this->data['classname'] = '';
		}
		
		
		$this->data['current_url'] = 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		
		if( isset($this->session->data['loginza2_confirmdata_show']) )
		{
			$this->data['loginza2_confirmdata_show'] = $this->session->data['loginza2_confirmdata_show'];
			unset($this->session->data['loginza2_confirmdata_show']);
		}
		
		$this->data['logged'] = $this->customer->isLogged();
			
		$res_socnets = array();
		$res_socnets2 = array();
			
		foreach($this->socnets as $socnet=>$label)
		{			
			$vr = $this->config->get('loginza2_'.$socnet);
			
			if( $vr == 'y' ) 
			{
				$this->data['res_socnets'][] = array( 'name'=>$socnet, 
										'label'=>$label );
				$res_socnets2[] = $socnet;
			}
		}
		
		$this->session->data['loginza2_lastlink'] = $_SERVER['REQUEST_URI'];
		
		$lang_hash = array(
			"ru"=>"ru",
			"uk"=>"uk",
			"ua"=>"uk",
			"be"=>"be",
			"fr"=>"fr",
			"en"=>"en"
		);

		if( !empty($lang_hash[ strtolower($this->config->get('config_language')) ]) )
		{
			$this->data['lang'] = $lang_hash[ strtolower($this->config->get('config_language')) ];
		}
		else
		{
			$this->data['lang'] = '';
		}

		if( !empty($res_socnets2) )
		$this->data['providers'] = implode(",", $res_socnets2);
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/loginza2.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/loginza2.tpl';
		} else {
			$this->template = 'default/template/module/loginza2.tpl';
		}
		
		$this->render();
	}
	
	public function country() 
	{
		$json = array();
		
		$this->load->model('localisation/country');

    	$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
		
		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']		
			);
		}
		
		$this->response->setOutput(json_encode($json));
	}
}
?>