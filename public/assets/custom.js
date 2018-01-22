$(document).ready(function(){

  $(".submenu > a").click(function(e) {
    e.preventDefault();
    var $li = $(this).parent("li");
    var $ul = $(this).next("ul");

    if($li.hasClass("open")) {
      $ul.slideUp(350);
      $li.removeClass("open");
    } else {
      $(".nav > li > ul").slideUp(350);
      $(".nav > li").removeClass("open");
      $ul.slideDown(350);
      $li.addClass("open");
    }
  });

  $('#rawDtTbl').DataTable({
    "aoColumnDefs": [
        { 'bSortable': false, 'aTargets': [ -1, -2, -3 ] },
        { 'bSearchable': false, 'aTargets': [ -1, -2, -3 ] }
    ],
    "pageLength": 100
  });

  $('#prodDtTbl').DataTable({
    "aoColumnDefs": [
        { 'bSortable': false, 'aTargets': [ -1, -2, -3, -4 ] },
        { 'bSearchable': false, 'aTargets': [ -1, -2, -3, -4 ] }
    ],
    "pageLength": 100
  });

  $('#thirdPartyLedger').DataTable({
    "order": [[ 1, "desc" ]],
    "dom": 'Bfrtip',
    "buttons": [
      'csv', 'excel', 'pdf', 'print'
    ],
    "pageLength": 100
  });

  $('#reportTable').DataTable({
    "order": [[ 2, "desc" ]],
    "dom": 'Bfrtip',
    "buttons": [
      'csv', 'excel', 'pdf', 'print'
    ],
    "pageLength": 100
  });

  if($("#slqty").length) {
    $("#slqty").bootstrapSlider().on("slideStop", function(valObj) {
      document.getElementById("txtQty").value = valObj.target.value;
    });
  }

  // $('#addtocart').on('hidden.bs.modal', function (e) {
  //   $("#slqty").bootstrapSlider('destroy');
  // });

});

function openAddToCart(id, name, qty){
  $('#productNameForModal').html(name);
  $('#productQtyForModal').val(qty);
  $('#productIdForModal').val(id);
  $("#slqty").bootstrapSlider({max: qty, value: 1});
  $("#slqty").bootstrapSlider('refresh');
  document.getElementById("txtQty").value = 0;
  $('#addtocart').modal();
}

function updateSlider() {
  var qty = document.getElementById("txtQty").value;
  if(!isNaN(qty)) {
    $("#slqty").bootstrapSlider('setValue', Number(qty));
  } else {
    document.getElementById("txtQty").value = 0;
    $("#slqty").bootstrapSlider('setValue', Number(0));
  }
}

function addToCart() {
  var productId = $('#productIdForModal').val();
  var qty = $('#slqty').bootstrapSlider('getValue');
  document.getElementById('status').innerHTML = "Please wait while adding product to cart"; 
  var token = $("meta[name='csrf-token']").attr('content');
  fetch('/cart/add', {
        method: 'post',
        headers: {
          "Content-type": "application/x-www-form-urlencoded; charset=UTF-8",
          'X-Requested-With': 'XMLHttpRequest',
          "X-CSRF-Token": $("meta[name='csrf-token']").attr('content')
        },
        credentials: 'same-origin',
        body: 'product_id=' + productId + '&qty=' + qty
      })
      .then(function(response) {
        return response.json();
      })
      .then(function (data) {
        if(data["status"]) {
          document.getElementById('status').innerHTML = "Product added to cart!"; 
          window.location.reload();
        }
      })
      .catch(function (error) {
        console.log('Request failed', error);
      });
}

function takeToTheCart() {
  window.location = '/cart';
}

function applyCoupon() {
  var couponId = $('#coupon_id').val();
  if (couponId != '') {
    fetch('/coupons/apply', {
          method: 'post',
          headers: {
            "Content-type": "application/x-www-form-urlencoded; charset=UTF-8",
            'X-Requested-With': 'XMLHttpRequest',
            "X-CSRF-Token": $("meta[name='csrf-token']").attr('content')
          },
          credentials: 'same-origin',
          body: 'coupon_id=' + couponId
        })
        .then(function(response) {
          return response.json();
        })
        .then(function (data) {
          if(data["status"] == 'error') {
            document.getElementById('coupon_application_status').innerHTML = data['msg']; 
          } else {
            document.getElementById('coupon_application_status').innerHTML = data['msg'];
            window.location = '/cart';
          }
        })
        .catch(function (error) {
          console.log('Request failed', error);
        });
  } else {
    alert('Please select a coupon!');
  }
}

function removeCoupon(){
  fetch('/coupons/remove', {
        method: 'post',
        headers: {
          "Content-type": "application/x-www-form-urlencoded; charset=UTF-8",
          'X-Requested-With': 'XMLHttpRequest',
          "X-CSRF-Token": $("meta[name='csrf-token']").attr('content')
        },
        credentials: 'same-origin',
        body: ''
      })
      .then(function(response) {
        return response.json();
      })
      .then(function (data) {
        window.location = '/cart';
      })
      .catch(function (error) {
        console.log('Request failed', error);
      });
}

function removeFromCart(productId) {
  fetch('/cart/remove', {
        method: 'post',
        headers: {
          "Content-type": "application/x-www-form-urlencoded; charset=UTF-8",
          'X-Requested-With': 'XMLHttpRequest',
          "X-CSRF-Token": $("meta[name='csrf-token']").attr('content')
        },
        credentials: 'same-origin',
        body: 'product_id='+productId
      })
      .then(function(response) {
        return response.json();
      })
      .then(function (data) {
        if(data['cart_empty']) {
          window.location = '/products';
        } else {
          window.location = '/cart';
        }
      })
      .catch(function (error) {
        console.log('Request failed', error);
      });
}