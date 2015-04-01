<?php
class ModelFidoFaq extends Model {
	public function getTopic($faq_id) {
		$visibility = "Видимость в разделе Вопрос/ответ";
		$positive = 'Сделать мой вопрос видимым';
		$sql = 
			'SELECT * ' .
			'FROM ' . DB_PREFIX . 'ticket t ' .
			'LEFT JOIN ' . DB_PREFIX . 'department d ' .
			'ON (t.ticket_department_id = d.department_id) ' .
			'WHERE t.ticket_status = "Решено" ' .
			'AND `' . $visibility . '` LIKE "%' . $positive . '%" ' .
			'AND t.ticket_department_id = ' . $faq_id;
		//error_log( $sql );
		$query = $this->db->query($sql);
		//error_log( print_r( $query->rows , true ) );
		return $query->rows;
	}

	public function getTopics($ticket_id) {
	
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ticket_message WHERE ticket_id = " . $ticket_id);
		//echo count($query->rows);
		return $query->rows;
	}

	
}
?>
