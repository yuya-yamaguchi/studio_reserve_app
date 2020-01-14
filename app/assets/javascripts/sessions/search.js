$(function(){
  
  function holdDateSelect(){
    var date_select_1 = $("#date_select_1").prop("checked");
    // 「日付を指定」が選択されている場合
    if (date_select_1 === true){
      $('.hold-date-calendar').show();
    // 「すべての日付」が選択されている場合
    } else {
      $('.hold-date-calendar').hide();
    }
  }

  $(document).ready( function(){
    holdDateSelect();
  });
  $(document).on('click', '.hold-date_select', function(){
    holdDateSelect();
  });
});