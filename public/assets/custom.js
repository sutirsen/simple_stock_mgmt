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

});

function openAddToCart(){
  $('#addtocart').modal();
}