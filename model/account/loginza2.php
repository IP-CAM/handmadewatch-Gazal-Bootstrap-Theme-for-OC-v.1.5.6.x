<?php
class ModelAccountLoginza2 extends Model 
{
	public function checkNew($data)
	{
		$check = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer 
								   WHERE loginza2_identity='".$this->db->escape($data['identity'])."'");
		
		if( empty($check->rows) )
		{
			return false;
		}
		else
		{
			$upd = '';
			
			if( !empty($data['firstname']) )
			{
				$upd .= " firstname = '".$this->db->escape($data['firstname'])."', ";
			}
			
			if( !empty($data['lastname']) )
			{
				$upd .= " lastname = '".$this->db->escape($data['lastname'])."', ";
			}
			
			if( !empty($data['telephone']) )
			{
				$upd .= " telephone = '".$this->db->escape($data['telephone'])."', ";
			}
			
			if( !empty($data['email']) )
			{
				$upd .= " email = '".$this->db->escape($data['email'])."', ";
			}
			
			$this->db->query("UPDATE " . DB_PREFIX . "customer 
							  SET
							  ". $upd ."
							  
								loginza2_data = '".$this->db->escape($data['data'])."',
								ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'
							  WHERE
							    loginza2_identity = '" .$this->db->escape($data['identity']) . "'");
			

			/* start specific block: system/library/customer.php */
			if( $check->row['cart'] && is_string($check->row['cart']) ) {
				$cart = unserialize($check->row['cart']);
				
				foreach ($cart as $key => $value) {
					if (!array_key_exists($key, $this->session->data['cart'])) {
						$this->session->data['cart'][$key] = $value;
					} else {
						$this->session->data['cart'][$key] += $value;
					}
				}			
			}

			if ($check->row['wishlist'] && is_string($check->row['wishlist'])) {
				if (!isset($this->session->data['wishlist'])) {
					$this->session->data['wishlist'] = array();
				}
								
				$wishlist = unserialize($check->row['wishlist']);
			
				foreach ($wishlist as $product_id) {
					if (!in_array($product_id, $this->session->data['wishlist'])) {
						$this->session->data['wishlist'][] = $product_id;
					}
				}			
			}
			/* end specific block */

			
			return $check->row['customer_id'];
		}
	}

	public function addCustomer($data)
	{
		/* kin insert metka: c1 */
		$fields = array("firstname", "lastname", "email", "telephone", "company", "postcode",
		"country", "zone", "city", "address_1", "link" );
		
		foreach($fields as $field)
		{
			if( !isset($data[$field]) )
			{
				$data[$field] = '';
			}
		}
		/* end kin metka: c1 */
		
		/* start specific block: catalog/model/account/customer.php */
		$customer_group_id = $this->config->get('config_customer_group_id');
		
		$this->load->model('account/customer_group');
		
		$customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer 
							  SET
								firstname = '".$this->db->escape($data['firstname'])."',
								lastname = '".$this->db->escape($data['lastname'])."',
								email = '".$this->db->escape($data['email'])."',
								telephone = '".$this->db->escape($data['telephone'])."',
							    loginza2_identity = '" .$this->db->escape($data['identity']) . "',
								loginza2_provider = '".$this->db->escape($data['provider']) ."',
								loginza2_data = '".$this->db->escape($data['data'])."',
								loginza2_link = '".$this->db->escape($data['link'])."',
								ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "',
								approved = '" . (int)!$customer_group_info['approval'] . "',
								customer_group_id = '" . (int)$customer_group_id . "', 
								status = '1', 
								date_added = NOW()");
		/* end specific block */
		
		$customer_id = $this->db->getLastId();
		
		/* kin insert metka: c1 */
		$this->db->query("INSERT INTO " . DB_PREFIX . "address 
		SET 
			customer_id = '" . (int)$customer_id . "', 
			firstname = '" . $this->db->escape($data['firstname']) . "', 
			lastname = '" . $this->db->escape($data['lastname']) . "', 
			company = '" . $this->db->escape($data['company']) . "', 
			address_1 = '" . $this->db->escape($data['address_1']) . "', 
			postcode = '" . $this->db->escape($data['postcode']) . "', 
			city = '" . $this->db->escape($data['city']) . "', 
			zone_id = '" . (int)$data['zone'] . "', 
			country_id = '" . (int)$data['country'] . "'");
		
		$address_id = $this->db->getLastId();
		
		$this->db->query("UPDATE " . DB_PREFIX . "customer 
						  SET address_id = '" . (int)$address_id . "' 
						  WHERE customer_id = '" . (int)$customer_id . "'");
		/* end kin metka: c1 */
		
		return $customer_id;
	}
}

?>