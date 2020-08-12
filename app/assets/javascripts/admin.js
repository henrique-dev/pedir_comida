//= require cable
//= require jquery
//= require popper.js/dist/umd/popper
//= require bootstrap/dist/js/bootstrap
//= require fastclick/lib/fastclick
//= require nprogress/nprogress
//= require malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar
//= require gentelella

(function($){
  $.fn.extend({
      applyRealMask: function() {
        return this.each(function() {
          let value;          
          if (this.tagName == "TD" || this.tagName == "H5") {
            value = jQuery(this).text();
          } else {
            value = jQuery(this).val();
          }
          if (value.match(/\./)) {
            let unit = value.split(".")[0];
            let decimal = value.split(".")[1];
            if (decimal.length == 1) {
              value = unit + "," + decimal + "0";
            } else {
              value = unit + "," + decimal;
            }
          } else if (value.length == 0){
            value = value + "0,00";
          } else {
            value = value + ",00";
          }

          if (this.tagName == "TD" || this.tagName == "H5") {
            jQuery(this).text(value);
          } else {
            jQuery(this).val(value);
          }                    
        });
      }
    });
})(jQuery);

function applyRealMask2(value) {
  if (value.match(/\./)) {
    let unit = value.split(".")[0];
    let decimal = value.split(".")[1];
    if (decimal.length == 1) {
      value = unit + "," + decimal + "0";
    } else {
      value = unit + "," + decimal;
    }
  } else if (value.length == 0){
    value = value + "0,00";
  } else {
    value = value + ",00";
  }
  return value;
}

function newOrderReceived(order) {
  let orderOBJ = JSON.parse(order);
  let tbody = jQuery("#tbl_orders_waiting").children("tbody");
  console.log(orderOBJ);
  if (tbody.find(".tr-order").length > 0) {
    tbody.append(
      "<tr class='tr-order'>"
        + "<td>"+(orderOBJ["id"])+"</td>"
        + "<td>"+(applyRealMask2(orderOBJ["cart"]["total"]))+"</td>"
        + "<td><a class='btn btn-success btn-sm' href='/orders/confirm?id="+(orderOBJ["id"])+"'>Confirmar</a></td>"
      + "</tr>"
    );
  } else {
    tbody.empty().append(
      "<tr class='tr-order'>"
        + "<td>"+(orderOBJ["id"])+"</td>"
        + "<td>"+(applyRealMask2(orderOBJ["cart"]["total"]))+"</td>"
        + "<td><a class='btn btn-success btn-sm' href='/orders/confirm?id="+(orderOBJ["id"])+"'>Confirmar</a></td>"
    + "</tr>"
    );
  }
}