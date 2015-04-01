<?php
/**
 *
 * @ This file is created by DeZend.Org
 * @ DeZend (PHP5 Decoder for ionCube Encoder)
 *
 * @	Version			:	1.1.7.0
 * @	Author			:	TuhanTS
 * @	Release on		:	25.02.2013
 * @	Official site	:	http://DeZend.Org
 *
 */
 
class ControllerModuleJVquickorder extends Controller {
	protected $version = 'ver 2.88';
 
	function versioncore() {
		$myversioncore = 'unknown_version_core';
 
		if (( ( VERSION == '1.0.1' || VERSION == '1.5.1' ) || VERSION == '1.5.1.3' )) {
			$myversioncore = 'old_version_core';
		}
 
 
		if (( ( ( ( ( ( VERSION == '1.5.2' || VERSION == '1.5.2.1' ) || VERSION == '1.5.3' ) || VERSION == '1.5.3.1' ) || VERSION == '1.5.4' ) || VERSION == '1.5.4.1' ) || VERSION == '1.5.5.1' )) {
			$myversioncore = 'new_version_core';
		}
 
		return $myversioncore;
	}
 
	function IsWorkOnCurrentVersionCore() {
		$array_version_core_list = array( '1.0.1', '1.5.1', '1.5.1.3', '1.5.2', '1.5.2.1', '1.5.3', '1.5.3.1', '1.5.4', '1.5.4.1', '1.5.5.1' );
		return in_array( VERSION, $array_version_core_list );
	}
 
	function IsWorkOnCurrentVersionPHP() {
		if (( 50300 <= PHP_VERSION_ID && PHP_VERSION_ID < 50400 )) {
			return true;
		}
 
		return false;
	}
 
	function inputinfoorder($data) {
		$error_field = '';
 
		if (!empty( $data['customer_name'] )) {
			
			$customer_name = $data['customer_name'];
		}
		else {
			$customer_name = $customer_comment;
		}
 
 
		if (!empty( $data['customer_phone'] )) {
			$data['customer_phone'];
			$customer_phone = ;
		}
		else {
			$customer_phone = $customer_comment;
		}
 
 
		if (!empty( $data['customer_email'] )) {
			$data['customer_email'];
			$customer_email = ;
		}
		else {
			$customer_email = $customer_comment;
		}
 
 
		if (!empty( $data['customer_comment'] )) {
			$data['customer_comment'];
			$customer_comment = ;
		}
		else {
			$customer_comment = $customer_comment;
		}
 
 
		if (!empty( $data['order_product_quantity'] )) {
			$data['order_product_quantity'];
			$order_product_quantity = ;
		}
		else {
			$this->load->model( 'catalog/product' );
			$this->model_catalog_product->getProduct( $data['product_id'] );
			$product_info = ;
 
			if ($product_info) {
				if ($product_info['minimum'] < 1) {
					$minimum = 247;
				}
				else {
					$product_info['minimum'];
					$minimum = ;
				}
			}
 
			$order_product_quantity = $error_field;
		}
 
		$this->request->server['REMOTE_ADDR'];
		$customer_ip = $this->language->get( 'error_field' );
		$inputinfo_array = array( 'customer_name' => $customer_name, 'customer_phone' => $customer_phone, 'customer_email' => $customer_email, 'customer_comment' => $customer_comment, 'order_product_quantity' => $order_product_quantity, 'customer_ip' => $customer_ip );
		return $inputinfo_array;
	}
 
	function index($setting) {
	}
 
	function update() {
		$this->data['version'] = $this->version;
		$json = array(  );
 
		if (!$this->IsWorkOnCurrentVersionCore(  )) {
			if ($this->config->get( 'config_language' ) == 'ru') {
				$json['error'] = 'Код ошибки: 10' . '
' . 'Версия движка: ' . VERSION . '
' . 'Сообщение: Работа модуля не поддерживается на текущей версии движка!';
			}
			else {
				$json['error'] = 'Error code: 10' . '
' . 'Engine version: ' . VERSION . '
' . 'Message: Operation of module is not supported in the current version of the engine!';
			}
 
			$this->response->setOutput( json_encode( $json ) );
			return false;
		}
 
 
		if (!$this->IsWorkOnCurrentVersionPHP(  )) {
			if ($this->config->get( 'config_language' ) == 'ru') {
				$json['error'] = 'Код ошибки: 20' . '
' . 'Версия PHP: ' . PHP_VERSION . '
' . 'Сообщение: Работа модуля не поддерживается на текущей версии PHP! Для работы модуля нужна версия PHP 5.3! Пожалуйста, свяжитесь со своим хостинг-провайдером для установки использования версии PHP 5.3!';
			}
			else {
				$json['error'] = 'Error code: 20' . '
' . 'PHP version: ' . PHP_VERSION . '
' . 'Message: Operation of module is not supported in the current version of the PHP! For the operation of the module need version PHP 5.3! Please contact your hosting provider to configure the use of versions of PHP 5.3!';
			}
 
			$this->response->setOutput( json_encode( $json ) );
			return false;
		}
 
 
		if (!( mktime( 0, 0, 0, 7, 10, 2013 ) <= time(  ) && time(  ) <= mktime( 0, 0, 0, 8, 20, 2013 ) )) {
			if ($this->config->get( 'config_language' ) == 'ru') {
				$json['error'] = 'Код ошибки: 666' . '
' . 'Версия движка: ' . VERSION . '
' . 'Сообщение: Срок действия модуля истёк! Пожалуйста, свяжитесь с автором модуля, чтобы получить последнюю актуальную версию модуля!';
			}
			else {
				$json['error'] = 'Error code: 666' . '
' . 'Engine version: ' . VERSION . '
' . 'Message: Validity expired module! Please, contact the author of  module to get the latest actual version of module!';
			}
 
			$this->response->setOutput( json_encode( $json ) );
			return false;
		}
 
		$this->language->load( 'module/jvquickorder' );
 
		if (isset( $this->request->post['product_id'] )) {
			$this->load->model( 'catalog/product' );
			$this->model_catalog_product->getCategories( $this->request->post['product_id'] );
			$categories_of_product = ;
 
			if ($categories_of_product) {
				$this->data['show_in_category'] = false;
				$this->config->get( 'config_var_category' );
				$config_var_categories = ;
				foreach ($categories_of_product as ) {
					$category_of_product = ;
 
					if (( isset( $config_var_categories[$category_of_product['category_id']] ) && $category_of_product['category_id'] == $config_var_categories[$category_of_product['category_id']] )) {
						$this->data['show_in_category'] = true;
						continue;
					}
				}
			}
			else {
				$this->data['show_in_category'] = false;
			}
 
			$this->model_catalog_product->getProduct( $this->request->post['product_id'] );
			$product_info = ;
 
			if ($product_info) {
				if ($this->config->get( 'consider_in_stock' ) == '1') {
					$this->data['consider_in_stock'] = true;
				}
				else {
					$this->data['consider_in_stock'] = false;
				}
 
 
				if ($this->config->get( 'config_stock_checkout' ) == '1') {
					$this->data['config_stock_checkout'] = true;
				}
				else {
					$this->data['config_stock_checkout'] = false;
				}
 
 
				if (0 < $product_info['quantity']) {
					$this->data['instock'] = true;
				}
				else {
					$this->data['instock'] = false;
				}
 
 
				if ($this->config->get( 'title_before_form' )) {
					$this->config->get( 'title_before_form' );
					$title_before_form = ;
					$this->data['title_before_form'] = trim( $title_before_form[$this->config->get( 'config_language_id' )] );
				}
				else {
					$this->data['title_before_form'] = '';
				}
 
 
				if ($this->config->get( 'text_before_form' )) {
					$this->config->get( 'text_before_form' );
					$text_before_form = ;
					$this->data['text_before_form'] = trim( $text_before_form[$this->config->get( 'config_language_id' )] );
				}
				else {
					$this->data['text_before_form'] = '';
				}
 
				$this->load->model( 'tool/image' );
 
				if ($product_info['image']) {
					$this->model_tool_image->resize( $product_info['image'], 120, 120 );
					$image = ;
				}
				else {
					$image = '';
				}
 
 
				if (( ( $this->config->get( 'config_customer_price' ) && $this->customer->isLogged(  ) ) || !$this->config->get( 'config_customer_price' ) )) {
					$this->currency->format( $this->tax->calculate( $product_info['price'], $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) );
					$price = ;
				}
				else {
					$price = false;
				}
 
 
				if ((double)$product_info['special']) {
					$this->currency->format( $this->tax->calculate( $product_info['special'], $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) );
					$special = ;
				}
				else {
					$special = false;
				}
 
 
				if (!$special) {
					$lastprice = $results;
				}
				else {
					$lastprice = $result;
				}
 
 
				if ($product_info['minimum'] < 1) {
					$minimum = 1066;
				}
				else {
					$product_info['minimum'];
					$minimum = ;
				}
 
				strip_tags( html_entity_decode( $product_info['description'], ENT_QUOTES, 'UTF-8' ) );
				$description = ;
				str_ireplace( '"', '&quot;', $description );
				$description = ;
				$description = utf8_substr( $description, 0, 1300 ) . '..';
				$shortdescription = utf8_substr( strip_tags( html_entity_decode( $product_info['description'], ENT_QUOTES, 'UTF-8' ) ), 0, 200 ) . '..';
				$this->data['product'] = array( 'product_id' => $product_info['product_id'], 'href' => $this->url->link( 'product/product', 'product_id=' . $product_info['product_id'] ), 'thumb' => $image, 'name' => $product_info['name'], 'model' => $product_info['model'], 'minimum' => $minimum, 'quantity' => $product_info['quantity'], 'price' => $lastprice, 'special' => $special, 'shortdescription' => $shortdescription, 'description' => $description );
				$this->data['images'] = array(  );
				$this->model_catalog_product->getProductImages( $this->request->post['product_id'] );
				$results = ;
				foreach ($results as ) {
					$result = ;
					$this->data['images'][] = array( 'thumb' => $this->model_tool_image->resize( $result['image'], 120, 120 ) );
				}
			}
 
 
			if ($this->customer->isLogged(  )) {
				$this->data['FirstName'] = $this->customer->getFirstName(  );
				$this->data['LastName'] = $this->customer->getLastName(  );
				$this->data['Phone'] = $this->customer->getTelephone(  );
				$this->data['Email'] = $this->customer->getEmail(  );
			}
			else {
				$this->data['FirstName'] = '';
				$this->data['LastName'] = '';
				$this->data['Phone'] = '';
				$this->data['Email'] = '';
			}
 
			$this->data['FullName'] = $this->data['FirstName'] . $this->data['LastName'];
 
			if (( !empty( $this->data['FirstName'] ) && !empty( $this->data['LastName'] ) )) {
				$this->data['FullName'] = $this->data['FirstName'] . ' ' . $this->data['LastName'];
			}
 
			$lang_vars = array( 'heading_title', 'hint_description_heading_text', 'legend_text', 'label_name_text', 'hint_name_heading_text', 'hint_name_descr_text', 'error_name_descr_text', 'label_phone_text', 'placeholder_phone_text', 'hint_phone_heading_text', 'hint_phone_descr_text', 'error_phone_descr_text', 'error_rangelengthphone_descr_text', 'error_digitsphone_descr_text', 'label_email_text', 'placeholder_email_text', 'hint_email_heading_text', 'hint_email_descr_text', 'error_email_descr_text', 'error_validemail_descr_text', 'label_comment_text', 'placeholder_comment_text', 'hint_comment_descr_text', 'hint_comment_heading_text', 'hint_comment_descr_text', 'error_comment_descr_text', 'error_rangelengthcomment_descr_text', 'label_product_quantity_text', 'placeholder_product_quantity_text', 'hint_product_quantity_heading_text', 'hint_product_quantity_descr_text', 'error_product_quantity_descr_text', 'error_digits_prod_quantity_descr_text', 'button_order_text', 'button_close_text', 'button_send_text', 'success_message_heading_text', 'success_message_body_text', 'error_message_heading_text', 'error_message_body_text', 'error_message_disable_email_sending', 'error_message_ordererror_body_text', 'error_message_unknownerror_body_text', 'error_message_nostock_body_text', 'error_message_not_work_in_categories_body_text' );
			foreach ($lang_vars as ) {
				$lang_var = ;
				$this->data[$lang_var] = $this->language->get( $lang_var );
			}
 
			$this->data['error_min_prod_quantity_descr_text'] = sprintf( $this->language->get( 'error_min_prod_quantity_descr_text' ), $this->data['product']['minimum'] );
			$this->data['error_max_prod_quantity_descr_text'] = sprintf( $this->language->get( 'error_max_prod_quantity_descr_text' ), $this->data['product']['quantity'] );
			$config_vars = array( 'show_product_name_price', 'show_product_desc', 'show_product_images', 'type_product_images', 'show_popover', 'type_colour_button_quickorder', 'how_time_show_popup_message', 'field_user_name_show', 'field_user_name_required', 'field_user_phone_show', 'field_user_phone_required', 'field_email_show', 'field_email_required', 'field_comment_show', 'field_comment_required', 'field_product_quantity_show', 'field_product_quantity_required', 'send_email_status', 'type_email', 'order_offon', 'del_system_css_on_show' );
			foreach ($config_vars as ) {
				$config_var = ;
				$this->data[$config_var] = $this->config->get( $config_var );
			}
 
			$this->config->get( 'field_user_phone_maskedinput' );
			$myfield_user_phone_maskedinput = ;
 
			if (!empty( $$myfield_user_phone_maskedinput )) {
				$this->data['field_user_phone_maskedinput'] = $this->config->get( 'field_user_phone_maskedinput' );
			}
			else {
				$this->data['field_user_phone_maskedinput'] = '+9 (999) 999-9999';
			}
 
			$this->load->model( 'catalog/product' );
			$this->data['options'] = array(  );
			$this->request->post['product_id'];
			$product_id = ;
			foreach ($this->model_catalog_product->getProductOptions( $product_id ) as ) {
				$option = ;
 
				if (( ( ( $option['type'] == 'select' || $option['type'] == 'radio' ) || $option['type'] == 'checkbox' ) || $option['type'] == 'image' )) {
					$option_value_data = array(  );
					foreach ($option['option_value'] as ) {
						$option_value = ;
 
						if (( !$option_value['subtract'] || 0 < $option_value['quantity'] )) {
							if (( ( ( $this->config->get( 'config_customer_price' ) && $this->customer->isLogged(  ) ) || !$this->config->get( 'config_customer_price' ) ) && (double)$option_value['price'] )) {
								$this->currency->format( $this->tax->calculate( $option_value['price'], $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) );
								$price = ;
							}
							else {
								$price = false;
							}
 
							$option_value_data[] = array( 'product_option_value_id' => $option_value['product_option_value_id'], 'option_value_id' => $option_value['option_value_id'], 'name' => $option_value['name'], 'image' => $this->model_tool_image->resize( $option_value['image'], 50, 50 ), 'price' => $price, 'price_prefix' => $option_value['price_prefix'] );
							continue;
						}
					}
 
					$this->data['options'][] = array( 'product_option_id' => $option['product_option_id'], 'option_id' => $option['option_id'], 'name' => $option['name'], 'type' => $option['type'], 'option_value' => $option_value_data, 'required' => $option['required'] );
					continue;
				}
 
 
				if (( ( ( ( ( $option['type'] == 'text' || $option['type'] == 'textarea' ) || $option['type'] == 'file' ) || $option['type'] == 'date' ) || $option['type'] == 'datetime' ) || $option['type'] == 'time' )) {
					$this->data['options'][] = array( 'product_option_id' => $option['product_option_id'], 'option_id' => $option['option_id'], 'name' => $option['name'], 'type' => $option['type'], 'option_value' => $option['option_value'], 'required' => $option['required'] );
					continue;
				}
			}
 
			$this->data['text_option'] = $this->language->get( 'text_option' );
			$this->data['text_select'] = $this->language->get( 'text_select' );
			$this->data['button_upload'] = $this->language->get( 'button_upload' );
 
			if (file_exists( DIR_TEMPLATE . $this->config->get( 'config_template' ) . '/template/module/jvquickorder.tpl' )) {
				$this->template = $this->config->get( 'config_template' ) . '/template/module/jvquickorder.tpl';
			}
			else {
				$this->template = 'default/template/module/jvquickorder.tpl';
			}
		}
 
		$json['output'] = $this->render(  );
		json_encode( $json );
		$json_encode_output = ;
		$this->response->setOutput( $json_encode_output );
	}
 
	function addorder() {
		$data = array(  );
		$this->language->load( 'module/jvquickorder' );
		$this->inputinfoorder( $this->request->post );
		$myinput_info_order = ;
		$data['invoice_prefix'] = $this->config->get( 'config_invoice_prefix' );
		$data['store_id'] = $this->config->get( 'config_store_id' );
		$data['store_name'] = $this->config->get( 'config_name' );
 
		if ($data['store_id']) {
			$data['store_url'] = $this->config->get( 'config_url' );
		}
		else {
			$data['store_url'] = HTTP_SERVER;
		}
 
		$myinput_info_order['customer_name'];
		$customer_name = ;
		$myinput_info_order['customer_phone'];
		$customer_phone = ;
		$myinput_info_order['customer_email'];
		$customer_email = ;
		$myinput_info_order['customer_comment'];
		$customer_comment = ;
		$myinput_info_order['customer_ip'];
		$customer_ip = ;
		$myinput_info_order['order_product_quantity'];
		$order_product_quantity = ;
 
		if ($this->customer->isLogged(  )) {
			$data['customer_id'] = $this->customer->getId(  );
			$data['customer_group_id'] = $this->customer->getCustomerGroupId(  );
			$data['fax'] = $this->customer->getFax(  );
		}
		else {
			$data['customer_id'] = 0;
			$data['customer_group_id'] = 0;
			$data['fax'] = '';
		}
 
		$data['firstname'] = $this->config->get( 'order_name_in_admin' ) . $customer_name;
		$data['lastname'] = $this->config->get( 'order_name_in_admin' ) . $customer_name;
		$this->language->get( 'error_field' );
		$error_field = ;
 
		if ($customer_email != $error_field) {
			$data['email'] = $customer_email;
		}
		else {
			$data['email'] = $this->config->get( 'config_email' );
		}
 
		$data['telephone'] = $customer_phone;
		$data['payment_firstname'] = 'JV_QuiclOrder_firstname';
		$data['payment_lastname'] = 'JV_QuiclOrder_lastname';
		$data['payment_company'] = '';
		$data['payment_company_id'] = '';
		$data['payment_tax_id'] = '';
		$data['payment_address_1'] = 'JV_QuiclOrder_address_1';
		$data['payment_address_2'] = '';
		$data['payment_city'] = 'JV_QuiclOrder_city';
		$data['payment_postcode'] = '';
		$data['payment_zone'] = '';
		$data['payment_zone_id'] = '';
		$data['payment_country'] = '';
		$data['payment_country_id'] = '';
		$data['payment_address_format'] = '';
		$data['payment_code'] = '';
		$data['payment_method'] = '';
		$data['shipping_firstname'] = 'JV_QuiclOrder_firstname';
		$data['shipping_lastname'] = 'JV_QuiclOrder_lastname';
		$data['shipping_company'] = '';
		$data['shipping_address_1'] = 'JV_QuiclOrder_address_1';
		$data['shipping_address_2'] = '';
		$data['shipping_city'] = 'JV_QuiclOrder_city';
		$data['shipping_postcode'] = '';
		$data['shipping_zone'] = '';
		$data['shipping_zone_id'] = '';
		$data['shipping_country'] = '';
		$data['shipping_country_id'] = '';
		$data['shipping_address_format'] = '';
		$data['shipping_code'] = '';
		$data['shipping_method'] = '';
		$product_data = array(  );
 
		if (isset( $this->request->post['product_id'] )) {
			$this->load->model( 'catalog/product' );
			$this->request->post['product_id'];
			$product_id = ;
			$this->model_catalog_product->getProduct( $product_id );
			$product = ;
 
			if (( ( $this->config->get( 'config_customer_price' ) && $this->customer->isLogged(  ) ) || !$this->config->get( 'config_customer_price' ) )) {
				$this->tax->calculate( $product['price'], $product['tax_class_id'], $this->config->get( 'config_tax' ), $format = false );
				$price = ;
			}
			else {
				$price = false;
			}
 
 
			if ((double)$product['special']) {
				$this->tax->calculate( $product['special'], $product['tax_class_id'], $this->config->get( 'config_tax' ) );
				$special = ;
			}
			else {
				$special = false;
			}
 
 
			if (!$special) {
				$lastprice = $lastprice;
			}
			else {
				$lastprice = $download_data;
			}
		}
 
		$option_data = array(  );
		$download_data = array(  );
 
		if ($this->versioncore(  ) == 'old_version_core') {
			$data['reward'] = $product['reward'];
		}
 
 
		if (( VERSION == '1.0.1' || VERSION == '1.5.1' )) {
			$this->tax->getRate( $product['tax_class_id'] );
			$mytax = ;
		}
		else {
			$this->tax->getTax( $product['price'], $product['tax_class_id'] );
			$mytax = ;
		}
 
		$product_data[] = array( 'product_id' => $product['product_id'], 'name' => $product['name'], 'model' => $product['model'], 'option' => $option_data, 'download' => $download_data, 'quantity' => $order_product_quantity, 'price' => $lastprice, 'total' => $lastprice * $order_product_quantity, 'tax' => $mytax, 'reward' => $product['reward'] );
		$data['products'] = $product_data;
		$voucher_data = array(  );
		$data['vouchers'] = $voucher_data;
		$total_data = array(  );
		$data['totals'] = $total_data;
		$data['comment'] = $customer_comment;
		$total = $lastprice * $order_product_quantity;
		$data['total'] = $total;
 
		if (isset( $this->request->cookie['tracking'] )) {
			$this->load->model( 'affiliate/affiliate' );
			$this->model_affiliate_affiliate->getAffiliateByCode( $this->request->cookie['tracking'] );
			$affiliate_info = ;
 
			if ($affiliate_info) {
				$data['affiliate_id'] = $affiliate_info['affiliate_id'];
				$data['commission'] = $total / 100 * $affiliate_info['commission'];
			}
			else {
				$data['affiliate_id'] = 0;
				$data['commission'] = 0;
			}
		}
		else {
			$data['affiliate_id'] = 0;
			$data['commission'] = 0;
		}
 
		$data['language_id'] = $this->config->get( 'config_language_id' );
		$data['currency_id'] = $this->currency->getId(  );
		$data['currency_code'] = $this->currency->getCode(  );
		$data['currency_value'] = $this->currency->getValue( $this->currency->getCode(  ) );
		$data['ip'] = $customer_ip;
 
		if (!empty( $this->request->server['HTTP_X_FORWARDED_FOR'] )) {
			$data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
		}
		else {
			if (!empty( $this->request->server['HTTP_CLIENT_IP'] )) {
				$data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
			}
			else {
				$data['forwarded_ip'] = '';
			}
		}
 
 
		if (isset( $this->request->server['HTTP_USER_AGENT'] )) {
			$data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
		}
		else {
			$data['user_agent'] = '';
		}
 
 
		if (isset( $this->request->server['HTTP_ACCEPT_LANGUAGE'] )) {
			$data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
		}
		else {
			$data['accept_language'] = '';
		}
 
		$this->load->model( 'checkout/order' );
 
		if ($this->versioncore(  ) == 'old_version_core') {
			$this->session->data['order_id'] = $this->model_checkout_order->create( $data );
		}
 
 
		if ($this->versioncore(  ) == 'new_version_core') {
			$this->session->data['order_id'] = $this->model_checkout_order->addOrder( $data );
		}
 
		$this->model_checkout_order->confirm( $this->session->data['order_id'], $this->config->get( 'order_order_status_id' ), '', false );
		$json = array(  );
		$this->response->setOutput( json_encode( $json ) );
	}
 
	function SendTextMail() {
		if (isset( $this->request->post['product_id'] )) {
			$this->language->load( 'module/jvquickorder' );
			$this->load->model( 'catalog/product' );
			$this->request->post['product_id'];
			$product_id = ;
			$this->model_catalog_product->getProduct( $product_id );
			$product_info = ;
			$this->inputinfoorder( $this->request->post );
			$myinput_info_order = ;
			$body_message_admin = $this->language->get( 'body_message_admin_data_text_product' ) . '
';
			$body_message_admin .= $this->language->get( 'body_message_admin_name_product' ) . $product_info['name'] . '
';
			$body_message_admin .= $this->language->get( 'body_message_admin_href_product' ) . $this->url->link( 'product/product', 'product_id=' . $product_info['product_id'] ) . '
';
			$body_message_admin .= $this->language->get( 'body_message_admin_product_quantity' ) . $myinput_info_order['order_product_quantity'] . '
';
			$body_message_admin .= '
 
';
			$body_message_admin .= $this->language->get( 'body_message_admin_data_text_customer' ) . '
';
			$body_message_admin .= $this->language->get( 'body_message_admin_customer_name' ) . $myinput_info_order['customer_name'] . '
';
			$body_message_admin .= $this->language->get( 'body_message_admin_customer_phone' ) . $myinput_info_order['customer_phone'] . '
';
			$body_message_admin .= $this->language->get( 'body_message_admin_customer_email' ) . $myinput_info_order['customer_email'] . '
';
			$body_message_admin .= $this->language->get( 'body_message_admin_customer_ip' ) . $myinput_info_order['customer_ip'] . '
';
			$body_message_admin .= $this->language->get( 'body_message_admin_customer_comment' ) . $myinput_info_order['customer_comment'] . '
';
			$body_message_admin .= '
';
			new Mail(  );
			$mail = ;
			$mail->protocol = $this->config->get( 'config_mail_protocol' );
			$mail->parameter = $this->config->get( 'config_mail_parameter' );
			$mail->hostname = $this->config->get( 'config_smtp_host' );
			$mail->username = $this->config->get( 'config_smtp_username' );
			$mail->password = $this->config->get( 'config_smtp_password' );
			$mail->port = $this->config->get( 'config_smtp_port' );
			$mail->timeout = $this->config->get( 'config_smtp_timeout' );
			$mail->setFrom( $this->config->get( 'config_email' ) );
			$mail->setSender( $this->config->get( 'config_name' ) );
			sprintf( $this->language->get( 'heading_title_mail_admin' ), $myinput_info_order['customer_name'], $product_info['name'] );
			$subject = ;
			$mail->setSubject( html_entity_decode( $subject ), ENT_QUOTES, 'UTF-8' );
			html_entity_decode( sprintf( $body_message_admin ), ENT_QUOTES, 'UTF-8' );
			$content = ;
			$mail->setText( strip_tags( $content ) );
 
			if ($this->config->get( 'offon_email_admin' )) {
				$mail->setTo( $this->config->get( 'config_email' ) );
				$mail->send(  );
			}
 
			explode( ',', $this->config->get( 'email_additional' ) );
			$emails = ;
			foreach ($emails as ) {
				$email = ;
 
				if (( 0 < strlen( $email ) && preg_match( '/^[^\@]+@.*\.[a-z]{2,6}$/i', $email ) )) {
					$mail->setTo( $email );
					$mail->send(  );
					continue;
				}
			}
 
 
			if (( $this->config->get( 'offon_email_customer' ) && $this->request->post['customer_email'] )) {
				$body_message_customer = sprintf( $this->language->get( 'body_message_customer_data_text' ), $this->config->get( 'config_name' ) ) . '
';
				$body_message_customer .= '
';
				$body_message_customer .= $this->language->get( 'body_message_customer_data_text_product' ) . '
';
				$body_message_customer .= $this->language->get( 'body_message_customer_name_product' ) . $product_info['name'] . '
';
				$body_message_customer .= $this->language->get( 'body_message_customer_href_product' ) . $this->url->link( 'product/product', 'product_id=' . $product_info['product_id'] ) . '
';
				$body_message_customer .= $this->language->get( 'body_message_customer_product_quantity' ) . $myinput_info_order['order_product_quantity'] . '
';
				$body_message_customer .= '
';
				$body_message_customer .= $this->language->get( 'text_thanks1' ) . '
' . '
';
				$body_message_customer .= sprintf( $this->language->get( 'text_thanks2' ), $this->config->get( 'config_name' ) ) . '
';
				$body_message_customer .= '
';
				$mail->setTo( $this->request->post['customer_email'] );
				sprintf( $this->language->get( 'heading_title_mail_customer' ), $product_info['name'], $this->config->get( 'config_name' ) );
				$subject = ;
				$mail->setSubject( html_entity_decode( $subject ), ENT_QUOTES, 'UTF-8' );
				html_entity_decode( sprintf( $body_message_customer ), ENT_QUOTES, 'UTF-8' );
				$content = ;
				$mail->setText( strip_tags( $content ) );
				$mail->send(  );
			}
		}
 
		$json = array(  );
		$this->response->setOutput( json_encode( $json ) );
	}
 
	function SendHTMLMail() {
		$json = array(  );
 
		if (isset( $this->request->post['product_id'] )) {
			$this->language->load( 'module/jvquickorder' );
			$this->load->model( 'catalog/product' );
			$this->request->post['product_id'];
			$product_id = ;
			$this->model_catalog_product->getProduct( $product_id );
			$product_info = ;
			$this->inputinfoorder( $this->request->post );
			$myinput_info_order = ;
			new Template(  );
			$template = ;
			$template->data['title'] = sprintf( $this->language->get( 'heading_title_mail_admin' ), $myinput_info_order['customer_name'], $product_info['name'] );
			sprintf( $this->language->get( 'heading_title_mail_admin' ), $myinput_info_order['customer_name'], $product_info['name'] );
			$subject = ;
			$template->data['logo'] = 'cid:' . md5( basename( $this->config->get( 'config_logo' ) ) );
			$template->data['store_name'] = $this->config->get( 'config_name' );
			$template->data['store_url'] = $this->url->link( 'common/home', '', 'SSL' );
			$template->data['body_message_text'] = $this->language->get( 'body_message_text' );
			$template->data['data_product_tittle'] = $this->language->get( 'body_message_admin_data_text_product' );
			$template->data['product_name'] = $product_info['name'];
			$template->data['product_link'] = $this->url->link( 'product/product', 'product_id=' . $product_info['product_id'] );
			$this->load->model( 'tool/image' );
 
			if ($product_info['image']) {
				$this->model_tool_image->resize( $product_info['image'], 200, 200 );
				$image = ;
			}
			else {
				$image = '';
			}
 
 
			if ($image) {
				$template->data['product_image'] = 'cid:' . md5( basename( $image ) );
			}
			else {
				$template->data['product_image'] = '';
			}
 
			$template->data['shortdescription'] = utf8_substr( strip_tags( html_entity_decode( $product_info['description'], ENT_QUOTES, 'UTF-8' ) ), 0, 1600 );
			$template->data['body_message_admin_data_text_customer'] = $this->language->get( 'body_message_admin_data_text_customer' );
			$template->data['customer_name'] = $this->language->get( 'body_message_admin_customer_name' ) . $myinput_info_order['customer_name'];
			$template->data['customer_phone'] = $this->language->get( 'body_message_admin_customer_phone' ) . $myinput_info_order['customer_phone'];
			$template->data['customer_email'] = $this->language->get( 'body_message_admin_customer_email' ) . $myinput_info_order['customer_email'];
			$template->data['customer_comment'] = $this->language->get( 'body_message_admin_customer_comment' ) . $myinput_info_order['customer_comment'];
			$template->data['customer_ip'] = $this->language->get( 'body_message_admin_customer_ip' ) . $myinput_info_order['customer_ip'];
			$template->data['body_message_admin_data_text_product'] = $this->language->get( 'body_message_admin_data_text_product' );
			$template->data['order_product_quantity'] = $this->language->get( 'body_message_admin_product_quantity' ) . $myinput_info_order['order_product_quantity'];
			$template->data['data_store_text'] = $this->language->get( 'data_store_text' );
			$template->data['data_store_name'] = sprintf( $this->language->get( 'data_store_name' ), $this->url->link( 'common/home', '', 'SSL' ), $this->config->get( 'config_name' ) );
			$template->data['data_store_phone'] = $this->language->get( 'data_store_phone' ) . $this->config->get( 'config_telephone' );
			$template->data['data_store_email'] = sprintf( $this->language->get( 'data_store_email' ), $this->config->get( 'config_email' ), $this->config->get( 'config_email' ) );
			$template->data['text_thanks1'] = $this->language->get( 'text_thanks1' );
			$template->data['text_thanks2'] = sprintf( $this->language->get( 'text_thanks2' ), $this->config->get( 'config_name' ) );
 
			if (file_exists( DIR_TEMPLATE . $this->config->get( 'config_template' ) . '/template/module/jvquickorder_html_mail.tpl' )) {
				$template->fetch( $this->config->get( 'config_template' ) . '/template/module/jvquickorder_html_mail.tpl' );
				$html = ;
			}
			else {
				$template->fetch( 'default/template/module/jvquickorder_html_mail.tpl' );
				$html = ;
			}
 
			new Mail(  );
			$mail = ;
			$mail->protocol = $this->config->get( 'config_mail_protocol' );
			$mail->parameter = $this->config->get( 'config_mail_parameter' );
			$mail->hostname = $this->config->get( 'config_smtp_host' );
			$mail->username = $this->config->get( 'config_smtp_username' );
			$mail->password = $this->config->get( 'config_smtp_password' );
			$mail->port = $this->config->get( 'config_smtp_port' );
			$mail->timeout = $this->config->get( 'config_smtp_timeout' );
			$mail->setSubject( $subject );
			$mail->setFrom( $this->config->get( 'config_email' ) );
			$mail->setSender( $this->config->get( 'config_name' ) );
			$mail->setHtml( $html );
			$mail->addAttachment( DIR_IMAGE . $this->config->get( 'config_logo' ), md5( basename( DIR_IMAGE . $this->config->get( 'config_logo' ) ) ) );
			strpos( $image, 'data' );
			$startimagefilename = ;
			substr( $image, $startimagefilename );
			$imagefilename = ;
			$mail->addAttachment( DIR_IMAGE . 'cache/' . $imagefilename, md5( basename( $image ) ) );
 
			if ($this->config->get( 'offon_email_admin' )) {
				$mail->setTo( $this->config->get( 'config_email' ) );
				$mail->send(  );
			}
 
			explode( ',', $this->config->get( 'email_additional' ) );
			$emails = ;
			foreach ($emails as ) {
				$email = ;
 
				if (( 0 < strlen( $email ) && preg_match( '/^[^\@]+@.*\.[a-z]{2,6}$/i', $email ) )) {
					$mail->setTo( $email );
					$mail->send(  );
					continue;
				}
			}
 
 
			if (( $this->config->get( 'offon_email_customer' ) && $this->request->post['customer_email'] )) {
				$template->data['body_message_text'] = sprintf( $this->language->get( 'body_message_customer_data_text' ), $this->config->get( 'config_name' ) );
 
				if (file_exists( DIR_TEMPLATE . $this->config->get( 'config_template' ) . '/template/module/jvquickorder_html_mail.tpl' )) {
					$template->fetch( $this->config->get( 'config_template' ) . '/template/module/jvquickorder_html_mail.tpl' );
					$html = ;
				}
				else {
					$template->fetch( 'default/template/module/jvquickorder_html_mail.tpl' );
					$html = ;
				}
 
				$mail->setHtml( $html );
				sprintf( $this->language->get( 'heading_title_mail_customer' ), $product_info['name'], $this->config->get( 'config_name' ) );
				$subject = ;
				$mail->setSubject( $subject );
				$mail->setTo( $this->request->post['customer_email'] );
				$mail->send(  );
			}
		}
 
		$this->response->setOutput( json_encode( $json ) );
	}
 
	function GetCurrentTemplate() {
		$json = array(  );
		$json['currenttemplate'] = $this->config->get( 'config_template' );
		$this->response->setOutput( json_encode( $json ) );
	}
}
 
?>