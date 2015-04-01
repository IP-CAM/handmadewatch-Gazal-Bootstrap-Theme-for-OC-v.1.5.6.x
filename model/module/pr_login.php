<?php

    class ModelModulePrLogin extends Model {

        public function addCustomer($data) {

            if (isset($data['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($data['customer_group_id'], $this->config->get('config_customer_group_display'))) {
                $customer_group_id = $data['customer_group_id'];
            }
            else {
                $customer_group_id = $this->config->get('config_customer_group_id');
            }

            $this->load->model('account/customer_group');

            $customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);

            $this->db->query("INSERT INTO " . DB_PREFIX . "customer SET store_id = '" . (int)$this->config->get('config_store_id') . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '', salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', newsletter = '" . (isset($data['newsletter']) ? (int)$data['newsletter'] : 0) . "', customer_group_id = '" . (int)$customer_group_id . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', status = '1', approved = '" . (int)!$customer_group_info['approval'] . "', date_added = NOW()");

            $this->language->load('mail/customer');

            $subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));

            $message = sprintf($this->language->get('text_welcome'), $this->config->get('config_name')) . "\n\n";

            if (!$customer_group_info['approval']) {
                $message .= $this->language->get('text_login') . "\n";
            }
            else {
                $message .= $this->language->get('text_approval') . "\n";
            }

            $message .= $this->url->link('account/login', '', 'SSL') . "\n\n";
            $message .= $this->language->get('text_services') . "\n\n";
            $message .= $this->language->get('text_thanks') . "\n";
            $message .= $this->config->get('config_name');

            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->hostname = $this->config->get('config_smtp_host');
            $mail->username = $this->config->get('config_smtp_username');
            $mail->password = $this->config->get('config_smtp_password');
            $mail->port = $this->config->get('config_smtp_port');
            $mail->timeout = $this->config->get('config_smtp_timeout');
            $mail->setTo($data['email']);
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender($this->config->get('config_name'));
            $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
            $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
            $mail->send();

            // Send to main admin email if new account email is enabled
            if ($this->config->get('config_account_mail')) {
                $message = $this->language->get('text_signup') . "\n\n";
                $message .= $this->language->get('text_website') . ' ' . $this->config->get('config_name') . "\n";
                $message .= $this->language->get('text_firstname') . ' ' . $data['firstname'] . "\n";
                $message .= $this->language->get('text_lastname') . ' ' . $data['lastname'] . "\n";
                $message .= $this->language->get('text_customer_group') . ' ' . $customer_group_info['name'] . "\n";

                if (!empty($data['company'])) {
                    $message .= $this->language->get('text_company') . ' ' . $data['company'] . "\n";
                }

                $message .= $this->language->get('text_email') . ' ' . $data['email'] . "\n";
                $message .= $this->language->get('text_telephone') . ' ' . $data['telephone'] . "\n";

                $mail->setTo($this->config->get('config_email'));
                $mail->setSubject(html_entity_decode($this->language->get('text_new_customer'), ENT_QUOTES, 'UTF-8'));
                $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
                $mail->send();

                // Send to additional alert emails if new account email is enabled
                $emails = explode(',', $this->config->get('config_alert_emails'));

                foreach ($emails as $email) {
                    if (strlen($email) > 0 && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email)) {
                        $mail->setTo($email);
                        $mail->send();
                    }
                }
            }
        }

    }