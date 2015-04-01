<?php
class ModelModuleJVQuickorder extends Model {
	
  public function isShowButtonQOInCategory($category_id) {
    $show_in_category = false;
    
    // Категории
    if ($category_id) { 
      $config_var_categories = $this->config->get('config_var_category');

      if ( isset($config_var_categories[$category_id]) && ($category_id == $config_var_categories[$category_id]) ) {
        $show_in_category = true;
      }
    }
    // Категории
    
    return $show_in_category;
  }
  
  public function isShowButtonQOInProduct($product_id) {
    $show_in_category = false;
    
    // Категории
    $this->load->model('catalog/product');
    $categories_of_product = $this->model_catalog_product->getCategories($product_id);
    
    if ($categories_of_product) {
      $config_var_categories = $this->config->get('config_var_category');
      
      foreach ($categories_of_product as $category_of_product) {  
        if ( isset($config_var_categories[$category_of_product['category_id']]) && ($category_of_product['category_id'] == $config_var_categories[$category_of_product['category_id']]) ) {
          $show_in_category = true;
          break;
        }	
      }	
    }
    // Категории
    
    return $show_in_category;
  }
  
}
?>