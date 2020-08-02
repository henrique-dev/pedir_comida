//= require jquery
//= require popper.js/dist/umd/popper
//= require bootstrap/dist/js/bootstrap
//= require fastclick/lib/fastclick
//= require nprogress/nprogress
//= require malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar
//= require gentelella

(function($){
  $.fn.extend({
      applyRealMask: function(options = {}) {
        return this.each(function() {
          let value;
          if (this.tagName == "TD") {
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

          if (this.tagName == "TD") {
            jQuery(this).text(value);
          } else {
            jQuery(this).val(value);
          }                    
        });
      }
    });
})(jQuery);