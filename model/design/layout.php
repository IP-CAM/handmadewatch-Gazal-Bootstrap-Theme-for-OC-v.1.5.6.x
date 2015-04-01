<?php
class ModelDesignLayout extends Model {	
	public function getLayout($route) {
	if (($route == "ticket/ticket_manage") or ($route == "ticket/create") or ($route == "ticket/detail") or ($route == "ticket/detail/view")) {
	$route = "account";
	}
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "layout_route WHERE '" . $this->db->escape($route) . "' LIKE CONCAT(route, '%') AND store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY route DESC LIMIT 1");
		
		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return 0;	
		}
	}
}
?>