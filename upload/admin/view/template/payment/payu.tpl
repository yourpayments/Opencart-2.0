<?= $header; ?>
  <?= $column_left; ?>
  
  <div id="content">
    <div class="page-header">
      <div class="container-fluid">
          <div class="pull-right">
            <button type="submit" form="form-amazon-login-pay" data-toggle="tooltip" title="<?= $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
            <a href="<?= $cancel; ?>" data-toggle="tooltip" title="<?= $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
          </div>
          <h1><?= $heading_title ?></h1>

          <ul class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
              <li><a href="<?= $breadcrumb['href']; ?>"><?= $breadcrumb['text']; ?></a></li>
            <?php } ?>
            </ul>
      </div>
    </div>

    <div class="container-fluid">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
        </div>
        <div class="panel-body">
          <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?= $error_warning; ?>
              <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
          <?php } ?>

          <div class="content">
            <form action="<?= $action; ?>" method="post" enctype="multipart/form-data" id="form-payu-payment" class="form-horizontal">
              <div class="form-group required">
                <label class="col-sm-2 control-label" for=""><?= $entry_merchant; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="payu_merchant" value="<?= $payu_merchant; ?>" class="form-control" />
                    <?php if ($error_merchant) { ?>
                      <div class="text-danger"><?= $error_merchant; ?></div>
                    <?php } ?>
                </div>
              </div>

              <div class="form-group required">  
                <label class="col-sm-2 control-label" for=""><?= $entry_secretkey; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="payu_secretkey" value="<?= $payu_secretkey; ?>" class="form-control" />
                 
                  <?php if ($error_secretkey) { ?>
                    <div class="text-danger"><?= $error_secretkey; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for=""><?= $entry_debug; ?></label>
                <div class="col-sm-10">
                  <select name="payu_debug" class="form-control">
                    <?php
                      $st0 = $st1 = ""; 
                      
                      if ($payu_debug == 0) {
                        $st0 = 'selected="selected"';
                      } else {
                        $st1 = 'selected="selected"';
                      }
                    ?>
                    <option value="1" <?= $st1 ?> ><?= $entry_debug_on; ?></option>
                    <option value="0" <?= $st0 ?> ><?= $entry_debug_off; ?></option>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for=""><?= $entry_LU; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="payu_LU" value="<?= $payu_LU; ?>" class="form-control" />
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for=""><?= $entry_backref; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="payu_backref" value="<?= $payu_backref; ?>" class="form-control" />
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-ipn-url"><?php echo $entry_ipn; ?></label>
                <div class="col-sm-10">
                  <div class="input-group"><span class="input-group-addon"><i class="fa fa-link"></i></span>
                    <input type="text" readonly value="<?php echo $payu_ipn; ?>" id="input-ipn-url" class="form-control" />
                  </div>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for=""><?= $entry_currency; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="payu_currency" value="<?= ($payu_currency == "") ? "RUB" : $payu_currency; ?>" class="form-control" />
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for=""><?= $entry_vat; ?></label>
                <div class="col-sm-10">
                  <select name="payu_vat" class="form-control">
                    <option value="0" <?= $payu_vat != '19' ? 'selected="seleted"' : '' ?>>0%</option>
                    <option value="19" <?= $payu_vat == '19' ? 'selected="seleted"' : '' ?>>18%</option>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for=""><?= $entry_order_type; ?></label>
                <div class="col-sm-10">
                  <select name="payu_entry_order_type" class="form-control">
                    <?php
                      $st0 = $st1 = ""; 
                      
                      if ($payu_entry_order_type == 0) {
                        $st0 = 'selected="selected"';
                      } else {
                        $st1 = 'selected="selected"';
                      }
                    ?>

                    <option value="0" <?= $st0 ?> ><?= $entry_order_net; ?></option>
                    <option value="1" <?= $st1 ?> ><?= $entry_order_gross; ?></option>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for=""><?= $entry_language; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="payu_language" value="<?= ($payu_language == "") ? "RU" : $payu_language; ?>" class="form-control" />
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for=""><?= $entry_order_status; ?></label>
                <div class="col-sm-10">
                  <select name="payu_order_status_id" class="form-control">
                    <?php foreach ($order_statuses as $order_status) { 
                      $st = ($order_status['order_status_id'] == $payu_order_status_id) ? ' selected="selected" ' : ""; 
                    ?>
                      <option value="<?= $order_status['order_status_id']; ?>" <?= $st ?> ><?= $order_status['name']; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for=""><?= $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="payu_status" class="form-control">
                    <?php
                      $st0 = $st1 = ""; 
                      if ($payu_status == 0) {
                        $st0 = 'selected="selected"';
                      } else {
                        $st1 = 'selected="selected"';
                      }
                    ?>

                    <option value="1" <?= $st1 ?> ><?= $text_enabled; ?></option>
                    <option value="0" <?= $st0 ?> ><?= $text_disabled; ?></option>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for=""><?= $entry_sort_order; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="payu_sort_order" value="<?= $payu_sort_order; ?>" size="1" class="form-control" />
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
<?= $footer; ?>