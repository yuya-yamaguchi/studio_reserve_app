$(function(){
  
  $('#session_submit').on('click',function(e){
    e.preventDefault();
    e.stopPropagation();
    // セッション名
    var session_title     = $('#session_title').val();
    var session_exlpain   = $('#session_explain').val().replace(/\n/g,"<br>\n");
    var session_studio    = $('#session_studio_id option:selected').text();
    var session_year      = $('#session_date_1i option:selected').text();
    var session_month     = $('#session_date_2i option:selected').text();
    var session_day       = $('#session_date_3i option:selected').text();
    var session_start_h   = $('#session_start_hour option:selected').text();
    var session_end_h     = $('#session_end_hour option:selected').text();
    var session_max_music = $('#session_max_music').val();
    var hold_date = session_year + "年" + session_month + "月" + session_day + "日 " + session_start_h + "時〜" +  session_end_h + "時";

    $("#modal-title").empty();
    $("#modal-explain").empty();
    $("#modal-studio").empty();
    $("#modal-hold-date").empty();
    $("#modal-max-music").empty();

    $("#modal-title").append(session_title);
    $("#modal-explain").append(session_exlpain);
    $("#modal-studio").append(session_studio);
    $("#modal-hold-date").append(hold_date);
    $("#modal-max-music").append(session_max_music);

    $('.js-modal').fadeIn();
    return false;
  });

  $('.session-correct').on('click',function(){
    $('.js-modal').fadeOut();
    return false;
  });

  $('#session-done').on('click',function(){
    $('form').submit();
  });
});
