$(function(){

  function paramsCheck(title, exlpain, studio, year, month, day, start_h, end_h, max_music, entry_fee){
    var check_result = true;

    $('.error-messages').empty();
    if (title == ""){
      $('#title-error').append("セッション名を入力してください");
      check_result = false;
    }

    if (exlpain == ""){
      $('#explain-error').append("説明を入力してください");
      check_result = false;
    }

    if (studio == "--"){
      $('#studio-error').append("利用スタジオを選択してください");
      check_result = false;
    }

    if (year == "--" || month == "--" || day == "--" || start_h == "--" || end_h == "--"){
      $('#hold-date-error').append("開催日時を選択してください");
      check_result = false;
    } else {
      var today = new Date();
      var today_ymd = new Date(today.getFullYear(),
                               today.getMonth() + 1,
                               today.getDate(),
                               today.getHours());
      var select_ymd = new Date(year,
                                month,
                                day,
                                start_h);
      
      if (today_ymd >= select_ymd){
        $('#hold-date-error').append("開始日時を過ぎています");
        check_result = false;
      } else if ((select_ymd - today_ymd) / 86400000 > 185){
        $('#hold-date-error').append("予約日は半年以内にしてください");
        check_result = false;
      }
    }
    
    if (max_music == ""){
      $('#max-music-error').append("最大曲数を入力してください");
      check_result = false;
    } else if (max_music < 1){
      $('#max-music-error').append("最大曲数は1以上で入力してください");
      check_result = false;
    }

    if (entry_fee == ""){
      $('#entry-fee-error').append("参加費を入力してください");
      check_result = false;
    }
    
    return check_result;
  }

  function reserveDuplicateChk(year, month, day, start_h, end_h){
    var studio_id = $('#session_studio_id option:selected').val();
    
    // 予約重複チェック
    $.ajax({
      url: `/studios/${studio_id}/reserves/duplicate`,
      type: "GET",
      data: { date_y: year,
              date_m: month,
              date_d: day,
              start_hour: start_h,
              end_hour:   end_h },
      dataType: 'json'
    })
    .done(function(data){
      if (data.reserved_result == true){
        $('#modal-hold-date-msg').append("その時間帯はすでに予約されています。<br>別の時間帯をご指定ください");
        return false;
      }
      return true;
    })
    .fail(function(){
      alert("通信に失敗しました");
    });
  }
  
  $('#session_submit').on('click',function(e){
    e.preventDefault();
    e.stopPropagation();
    // セッション名
    var title     = $('#session_title').val();
    var exlpain   = $('#session_explain').val().replace(/\n/g,"<br>\n");
    var studio    = $('#session_studio_id option:selected').text();
    var year      = $('#session_date_1i option:selected').text();
    var month     = $('#session_date_2i option:selected').text();
    var day       = $('#session_date_3i option:selected').text();
    var start_h   = $('#session_start_hour option:selected').text();
    var end_h     = $('#session_end_hour option:selected').text();
    var max_music = $('#session_max_music').val();
    var entry_fee = $('#session_entry_fee').val();
    var hold_date = `${year}年${month}月${day}日 ${start_h}時〜${end_h}時`
    var check_result = true;

    // パラメータチェック
    check_result = paramsCheck(title, exlpain, studio, year, month, day, start_h, end_h, max_music, entry_fee);
    if (!check_result){
      return false;
    }
    // 予約重複チェック
    reserveDuplicateChk(year, month, day, start_h, end_h);
    
    $(".session-confirm-modal__value").empty();

    $("#modal-title").append(title);
    $("#modal-explain").append(exlpain);
    $("#modal-studio").append(studio);
    $("#modal-hold-date").append(hold_date);
    $("#modal-max-music").append(max_music);
    $("#modal-entry-fee").append(entry_fee);

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

  $(document).on('change', '.session-image',function() {
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    var img = $(`<img class="user-img-default">`);
    
    // ファイルが選択されている場合
    if (file != undefined){
      // 現在のプレビュー画像の削除
      $('.user-img-default').remove();
      // 画像プレビュー
      reader.onload = function(e) {
        img.attr('src', e.target.result)
      }
      reader.readAsDataURL(file);
      $('.session-img__value').prepend(img);
    }
  });
});
