<?php
class ModelTicketTicket extends Model {

	public function getDate($date) {
	$trans = array(
		"January" => "Января",
        "February" => "Февраля",
        "March" => "Марта",
        "April" => "Апреля",
        "May" => "Мая",
        "June" => "Июня",
        "July" => "Июля",
        "August" => "Августа",
        "September" => "Сентября",
        "October" => "Октября",
        "November" => "Ноября",
        "December" => "Декабря"
	);
 
 return strtr(date($this->language->get('date_format_long'), strtotime($date)), $trans);
	}
	public function addTicket($data) {
		//$this->db->query("INSERT INTO " . DB_PREFIX . "ticket SET ticket_order_id = '" . $this->db->escape($data['ticket_order_id']) . "', ticket_subject = '" . $this->db->escape($data['subject']) . "', ticket_status = 'New', ticket_department_id = '" . $this->db->escape($data['department']) . "', ticket_customer_id = '" . $this->db->escape($this->customer->getId()) . "', ticket_created = NOW(), ticket_last_update = '" . (string)$this->customer->getFirstName() . ' ' . $this->customer->getLastName() . "'");
		$this->db->query("INSERT INTO " . DB_PREFIX . "ticket SET ticket_subject = '" . $this->db->escape($data['subject']) . "', ticket_status = 'Создано', ticket_department_id = '" . $this->db->escape($data['department']) . "', ticket_customer_id = '" . $this->db->escape($this->customer->getId()) . "', ticket_created = NOW(), ticket_last_update = '" . (string)$this->customer->getFirstName() . ' ' . $this->customer->getLastName() . "'");

		$ticket_id = $this->db->getLastId();
		$update_string = "ticket_id = '" . (int)$ticket_id . "'";
		foreach ($data as $key => $row) {
		
		     if(strpos($key, "_1_")){ 
		          list($abc, $k )  = explode("_1_", $key); 
		          if(in_array($abc, array('captcha','submit'))) 
		              continue; 
		          $key = $k ; 
		          $key = str_replace("_", " ", $key) ;
				  
				  echo $key . "<br>";
		          if($abc=="multi") $row = serialize($row);
		          $update_string .= ", `".$key."` = '" . $row . "'";
				  echo $key."` = '" . $row;
		     }
		}
		if(isset($_SESSION['upload']))
			foreach($_SESSION['upload'] as $row){
				list($abc, $k )  = explode("_1_", $row['field']);
				$k = str_replace("_", " ", $k) ;
				$update_string .= ", `".$k."` = '" . $row['upload_file'] . "'";
				
			}
		$this->db->query("UPDATE " . DB_PREFIX . "ticket SET " . $update_string . " WHERE ticket_id = '" . (int)$ticket_id . "'");

		
		$this->load->language('ticket/create');
		
		$subject = sprintf($this->language->get('message_subject'), $this->config->get('config_name'));
		
		$message  = $this->language->get('message_content');
		
		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->hostname = $this->config->get('config_smtp_host');
		$mail->username = $this->config->get('config_smtp_username');
		$mail->password = $this->config->get('config_smtp_password');
		$mail->port = $this->config->get('config_smtp_port');
		$mail->timeout = $this->config->get('config_smtp_timeout');				
		$mail->setTo($this->customer->getEmail());
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject($subject);
		$mail->setText($message);
		$mail->send();

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "user` WHERE user_group_id = 1");
		foreach($query->rows as $row){
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');				
			$mail->setTo($row['email']);
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender($this->config->get('config_name'));
			$mail->setSubject($subject);
			$mail->setText($message);
			$mail->send();
		}
		
		return $ticket_id;
	}
	
	public function getConfig() {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "ticket_config` WHERE config_id = 1");
	
		return $query->row;
	}

	public function getOrderID() {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order` WHERE customer_id = ".(int)$this->customer->getId());
	
		return $query->rows;
	}

	public function lastUpdate($ticket_id, $user_name) {
		$this->db->query("UPDATE `" . DB_PREFIX . "ticket` SET ticket_last_update = '" . (string)$user_name . "' WHERE ticket_id = '" . (int)$ticket_id . "'");
	}
				
	public function getTicket($ticket_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ticket, `" . DB_PREFIX . "department` WHERE ticket_department_id = department_id AND ticket_id = '" . (int)$ticket_id . "'");
		
		return $query->row;
	}
	
	public function getTickets($data = array()) {
		$sql = "SELECT * FROM `" . DB_PREFIX . "ticket`, `" . DB_PREFIX . "department` WHERE ticket_department_id = department_id AND ticket_customer_id = " . (int)$this->customer->getId();
		
		if ( isset($data['filter_status']) && !empty($data['filter_status']) ){
			$sql .= " AND ticket_status = '" . (string)$data['filter_status'] . "'";
		}
			
		$sort_data = array(
			'ticket_subject',
			'ticket_status',
			'ticket_created'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY ticket_created";	
		}
			
		if (isset($data['order']) && ($data['order'] == 'ASC')) {
			$sql .= " ASC";
		} else {
			$sql .= " DESC";
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}			
			
			if ($data['limit'] < 1) {
				$data['limit'] = 10;
			}	
			
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
			//echo $sql;
		$query = $this->db->query($sql);
		
		$result = array();
		
		foreach ($query->rows as $row) {
		//echo $row['ticket_status'];
					$result[] = array(
						'ticket_created'      => $this->getDate($row['ticket_created']),
						'ticket_subject'      => $row['ticket_subject'],
						'department_name'      => $row['department_name'],
						'ticket_status'      => $row['ticket_status'],
						'ticket_last_update'      => $row['ticket_last_update'],
						'ticket_id' => $row['ticket_id']
						
					);
				}
	
		return $result;
	}
}
?>