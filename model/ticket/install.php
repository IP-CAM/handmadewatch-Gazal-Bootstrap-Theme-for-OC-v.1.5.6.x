<?php
class ModelTicketInstall extends Model {
	public function install() {
		$this->db->query("
			CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "ticket(
				ticket_id int NOT NULL AUTO_INCREMENT,
				PRIMARY KEY(ticket_id),
				ticket_subject text,
				ticket_status varchar(255),
				ticket_created datetime,
				ticket_department_id int,
				ticket_customer_id int,
				ticket_user_id int,
				ticket_order_id int,
				ticket_last_update varchar(255)
			)
			DEFAULT CHARACTER SET utf8   
			COLLATE utf8_general_ci;
		");
		
		$this->db->query("
			CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "ticket_config(
				config_id int NOT NULL AUTO_INCREMENT,
				PRIMARY KEY(config_id),
				order_status int,
				order_required int,
				formdata text
			)
			DEFAULT CHARACTER SET utf8   
			COLLATE utf8_general_ci;
		");

		$this->db->query("INSERT INTO `" . DB_PREFIX . "ticket_config` SET config_id = 1, order_status = 1, order_required = 1,formdata = ''");

		$this->db->query("
			CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "department(
				department_id int NOT NULL AUTO_INCREMENT,
				PRIMARY KEY(department_id),
				department_name varchar(255)
			)
			DEFAULT CHARACTER SET utf8   
			COLLATE utf8_general_ci;
		");
		
		$this->db->query("
			CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "ticket_message(
				message_id int NOT NULL AUTO_INCREMENT,
				PRIMARY KEY(message_id),
				content text,
				is_user boolean,
				created datetime,
				ticket_id int,
				file varchar(255)
			)
			DEFAULT CHARACTER SET utf8   
			COLLATE utf8_general_ci;
		");
		
		print "Database is installed";
	}	
}
?>