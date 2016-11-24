<?php 
class ControllerExtensionPaymentPayu extends Controller {
	private $error = array(); 

	public function index() {
		$this->load->language('extension/payment/payu');
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
//------------------------------------------------------------

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('payu', $this->request->post);				
			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] .'&type=payment', 'SSL'));
		}

		$arr = array( 
				"heading_title", "text_payment", "text_success", "text_pay", "text_card", 
				"entry_merchant", "entry_secretkey", "entry_debug", "entry_LU", "entry_order_status", 
				"entry_currency", "entry_backref", "entry_vat", "entry_order_type", "entry_language", "entry_status", 
				"entry_sort_order", "error_permission", "error_merchant", "error_secretkey",
				"entry_debug_on", "entry_debug_off", "entry_order_net", "entry_order_gross", "entry_ipn", "text_edit");

		foreach ($arr as $v) $data[$v] = $this->language->get($v);
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		#$data['LUURL'] = "index.php?route=payment/payu/callback";


//------------------------------------------------------------
        $arr = array("warning", "merchant", "secretkey", "type");
        foreach ( $arr as $v ) $data['error_'.$v] = ( isset($this->error[$v]) ) ? $this->error[$v] : "";
//------------------------------------------------------------

		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_payment'),
			'href'      => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] .'&type=payment', 'SSL'),
      		'separator' => ' :: '
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/payment/payu', 'token=' . $this->session->data['token'], 'SSL'),      		
      		'separator' => ' :: '
   		);
				
		$data['action'] = $this->url->link('extension/payment/payu', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] .'&type=payment', 'SSL');

//------------------------------------------------------------
		$this->load->model('localisation/order_status');
		
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		$arr = array( "payu_merchant", "payu_secretkey", "payu_debug", "payu_LU", "payu_currency", 
					  "payu_backref", "payu_vat", "payu_entry_order_type", "payu_language", "payu_status", "payu_sort_order", "payu_order_status_id" );

		foreach ($arr as $v) {
			$data[$v] = ( isset($this->request->post[$v]) ) ? $this->request->post[$v] : $this->config->get($v);
		}

		$data['payu_LU']      = is_null($data['payu_LU']) ? 'https://secure.payu.ru/order/lu.php' : $data['payu_LU'];
		$data['payu_backref'] = is_null($data['payu_backref']) ? HTTPS_CATALOG . 'index.php?route=extension/payment/payu/result_payment' : $data['payu_backref'];
		$data['payu_ipn']     = HTTPS_CATALOG . 'index.php?route=extension/payment/payu/callback';

//------------------------------------------------------------

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['header'] = $this->load->controller('common/header');
		$data['footer'] = $this->load->controller('common/footer');
				
		$this->response->setOutput($this->load->view('extension/payment/payu', $data));
	}

//------------------------------------------------------------
	private function validate() {
		if (!$this->user->hasPermission('modify', 'extension/payment/payu')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->request->post['payu_merchant']) {
			$this->error['merchant'] = $this->language->get('error_merchant');
		}

		if (!$this->request->post['payu_secretkey']) {
			$this->error['secretkey'] = $this->language->get('error_secretkey');
		}

		return (!$this->error) ? true : false ;
	}
}
?>