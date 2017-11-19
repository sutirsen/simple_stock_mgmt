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
    ]
  });

  $('#prodDtTbl').DataTable({
    "aoColumnDefs": [
        { 'bSortable': false, 'aTargets': [ -1, -2, -3, -4 ] },
        { 'bSearchable': false, 'aTargets': [ -1, -2, -3, -4 ] }
    ]
  });

  // $('#addtocart').on('hidden.bs.modal', function (e) {
  //   $("#slqty").bootstrapSlider('destroy');
  // });

});

function openAddToCart(id, name, qty){
  $('#pid').html(id);
  $('#pname').html(name);
  $('#pqty').html(qty);
  $("#slqty").bootstrapSlider({max: qty, value: 1});
  $("#slqty").bootstrapSlider('refresh');
  $('#addtocart').modal();
}