<?php

    class ControllerModulePrLogin extends Controller {

        private $error = array();

        public function login_form() {

            $this->load->model('account/customer');

            if ($this->customer->isLogged()) {
                exit();
            }

            $this->language->load('account/login');

            $this->data['text_forgotten'] = $this->language->get('text_forgotten');

            $this->data['entry_email'] = $this->language->get('entry_email');
            $this->data['entry_password'] = $this->language->get('entry_password');

            $this->data['button_continue'] = $this->language->get('button_continue');
            $this->data['button_login'] = $this->language->get('button_login');

            $this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

            if ($this->config->get('config_account_id')) {
                $this->load->model('catalog/information');

                $information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

                if ($information_info) {
                    $this->data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/info', 'information_id=' . $this->config->get('config_account_id'), 'SSL'), $information_info['title'], $information_info['title']);
                }
                else {
                    $this->data['text_agree'] = '';
                }
            }
            else {
                $this->data['text_agree'] = '';
            }

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pr_login/login_form.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/module/pr_login/login_form.tpl';
            }
            else {
                $this->template = 'default/template/module/pr_login/login_form.tpl';
            }

            $this->response->setOutput($this->render());
        }

        public function register_form() {

            if ($this->customer->isLogged()) {
                exit();
            }

            $this->load->model('account/customer');
            $this->language->load('account/register');

            $country_id = $this->config->get('config_country_id');

            $this->data['text_account_already'] = sprintf($this->language->get('text_account_already'), $this->url->link('account/login', '', 'SSL'));
            $this->data['text_yes'] = $this->language->get('text_yes');
            $this->data['text_no'] = $this->language->get('text_no');
            $this->data['text_select'] = $this->language->get('text_select');
            $this->data['text_none'] = $this->language->get('text_none');

            $this->data['entry_firstname'] = $this->language->get('entry_firstname');
            $this->data['entry_lastname'] = $this->language->get('entry_lastname');
            $this->data['entry_email'] = $this->language->get('entry_email');
            $this->data['entry_telephone'] = $this->language->get('entry_telephone');
            $this->data['entry_account'] = $this->language->get('entry_account');
            $this->data['entry_address_1'] = $this->language->get('entry_address_1');
            $this->data['entry_postcode'] = $this->language->get('entry_postcode');
            $this->data['entry_city'] = $this->language->get('entry_city');
            $this->data['entry_zone'] = $this->language->get('entry_zone');
            $this->data['entry_newsletter'] = $this->language->get('entry_newsletter');
            $this->data['entry_password'] = $this->language->get('entry_password');
            $this->data['entry_confirm'] = $this->language->get('entry_confirm');

            $this->data['button_continue'] = $this->language->get('button_continue');

            $this->load->model('localisation/zone');

            $this->data['zones'] = $this->model_localisation_zone->getZonesByCountryId($country_id);

            if (isset($this->session->data['shipping_zone_id'])) {
                $this->data['zone_id'] = $this->session->data['shipping_zone_id'];
            }
            else {
                $this->data['zone_id'] = $this->config->get('config_zone_id');
            }

            if ($this->config->get('config_account_id')) {
                $this->load->model('catalog/information');

                $information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

                if ($information_info) {
                    $this->data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/info', 'information_id=' . $this->config->get('config_account_id'), 'SSL'), $information_info['title'], $information_info['title']);
                }
                else {
                    $this->data['text_agree'] = '';
                }
            }
            else {
                $this->data['text_agree'] = '';
            }

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pr_login/register_form.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/module/pr_login/register_form.tpl';
            }
            else {
                $this->template = 'default/template/module/pr_login/register_form.tpl';
            }

            $this->response->setOutput($this->render());
        }

        public function login() {

            $json = array();

            if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateLogin()) {
                unset($this->session->data['guest']);

                // Default Shipping Address
                $this->load->model('account/address');

                $address_info = $this->model_account_address->getAddress($this->customer->getAddressId());

                if ($address_info) {
                    if ($this->config->get('config_tax_customer') == 'shipping') {
                        $this->session->data['shipping_zone_id'] = $address_info['zone_id'];
                        $this->session->data['shipping_postcode'] = $address_info['postcode'];
                    }

                    if ($this->config->get('config_tax_customer') == 'payment') {
                        $this->session->data['payment_country_id'] = $address_info['country_id'];
                        $this->session->data['payment_zone_id'] = $address_info['zone_id'];
                    }
                }
                else {
                    unset($this->session->data['shipping_zone_id']);
                    unset($this->session->data['shipping_postcode']);
                    unset($this->session->data['payment_country_id']);
                    unset($this->session->data['payment_zone_id']);
                }

                $redirect = $this->request->server['HTTP_REFERER'] && strpos($this->request->server['HTTP_REFERER'], 'logout') === false
                        ? $this->request->server['HTTP_REFERER'] : HTTP_SERVER;

                $json['redirect'] = str_replace(array('&amp;', "\n", "\r"), array('&', '', ''), $redirect);
            }

            if (!$json) {

                foreach ($this->error as $k => $v) {
                    $json['error'][$k] = $v;
                }
            }

            $this->response->setOutput(json_encode($json));
        }

        public function register() {

            $json = array();

            $this->load->model('account/customer');
            $this->load->model('module/pr_login');
            $this->language->load('account/register');

            if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateRegister()) {

                $this->model_module_pr_login->addCustomer($this->request->post);

                $this->customer->login($this->request->post['email'], $this->request->post['password']);

                unset($this->session->data['guest']);

                $this->language->load('account/success');
                $json['success'] = $this->language->get('text_message');

                $redirect = $this->request->server['HTTP_REFERER'] && strpos($this->request->server['HTTP_REFERER'], 'logout') === false ? $this->request->server['HTTP_REFERER'] : '/';
                $json['redirect'] = str_replace(array('&amp;', "\n", "\r"), array('&', '', ''), $redirect);
            }

            if (!$json) {

                foreach ($this->error as $k => $v) {
                    $json['error'][$k] = $v;
                }
            }

            $this->response->setOutput(json_encode($json));
        }

        private function validateLogin() {

            $this->load->model('account/customer');
            $this->language->load('account/login');

            if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
                $this->error['warning'] = $this->language->get('error_login');
            }

            $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

            if ($customer_info && !$customer_info['approved']) {
                $this->error['warning'] = $this->language->get('error_approved');
            }

            return !$this->error;
        }

        private function validateRegister() {

            if ((utf8_strlen($this->request->post['firstname']) < 1) || (utf8_strlen($this->request->post['firstname']) > 32)) {
                $this->error['firstname'] = $this->language->get('error_firstname');
            }

            if ((utf8_strlen($this->request->post['lastname']) < 1) || (utf8_strlen($this->request->post['lastname']) > 32)) {
                $this->error['lastname'] = $this->language->get('error_lastname');
            }

            if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
                $this->error['email'] = $this->language->get('error_email');
            }

            if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
                $this->error['warning'] = $this->language->get('error_exists');
            }

            if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
                $this->error['telephone'] = $this->language->get('error_telephone');
            }

            // Customer Group
            $this->load->model('account/customer_group');

            if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
                $this->error['password'] = $this->language->get('error_password');
            }

            if ($this->request->post['confirm'] != $this->request->post['password']) {
                $this->error['confirm'] = $this->language->get('error_confirm');
            }

            if ($this->config->get('config_account_id')) {
                $this->load->model('catalog/information');

                $information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

                if ($information_info && !isset($this->request->post['agree'])) {
                    $this->error['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
                }
            }

            return !$this->error;
        }
    }