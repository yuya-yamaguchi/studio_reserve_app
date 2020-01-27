$(function(){

  /****************************************/
  /* パラメータチェック関数                   */
  /****************************************/
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

  /****************************************/
  /* 予約重複チェック関数                    */
  /****************************************/
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

  /****************************************/
  /* 音楽ジャンル選択処理                    */
  /****************************************/
  var music_genre_colors =
    ["rgb(243, 31, 31)",  // J-POP
     "rgb(243, 116, 31)", // ロック
     "rgb(243, 158, 31)", // ハードロック
     "rgb(200, 212, 20)", // メタル
     "rgb(162, 243, 31)", // パンク
     "rgb(98, 243, 31)",  // ヒッピホップ
     "rgb(31, 243, 31)",  // アニソン
     "rgb(31, 243, 155)", // ブルース
     "rgb(31, 201, 243)", // ジャズ
     "rgb(31, 116, 243)", // クラシック
     "rgb(35, 31, 243)",  // フュージョン
     "rgb(95, 31, 243)",  // R&B
     "rgb(176, 31, 243)", // レゲエ
     "rgb(208, 31, 243)", // エレクトロニカ
     "rgb(243, 31, 162)", // K-POP
     "rgb(243, 31, 84)",  // 演歌
     "rgb(87, 85, 86)"    // その他
    ];

  function musicGenreSelect(select_music_genre, check_value, music_color){
    if (check_value == undefined){
      $(`label[for="${select_music_genre}"]`).css('background', 'lightgray');
      $(`label[for="${select_music_genre}"]`).css('color', 'black');
    }
    else{
      $(`label[for="${select_music_genre}"]`).css('background', music_color);
      $(`label[for="${select_music_genre}"]`).css('color', '#FFFFFF');
    }
  }
  
  /* J-POP選択 */
  $(document).on('click', '#session_music_genre_ids_1', function(){
    var select_music_genre = "session_music_genre_ids_1";
    var check_value = $('#session_music_genre_ids_1:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[0]);
  });
  /* ロック選択 */
  $(document).on('click', '#session_music_genre_ids_2', function(){
    var select_music_genre = "session_music_genre_ids_2";
    var check_value = $('#session_music_genre_ids_2:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[1]);
  });
  /* ロック選択 */
  $(document).on('click', '#session_music_genre_ids_3', function(){
    var select_music_genre = "session_music_genre_ids_3";
    var check_value = $('#session_music_genre_ids_3:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[2]);
  });

  $(document).on('click', '#session_music_genre_ids_4', function(){
    var select_music_genre = "session_music_genre_ids_4";
    var check_value = $('#session_music_genre_ids_4:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[3]);
  });

  $(document).on('click', '#session_music_genre_ids_5', function(){
    var select_music_genre = "session_music_genre_ids_5";
    var check_value = $('#session_music_genre_ids_5:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[4]);
  });

  $(document).on('click', '#session_music_genre_ids_6', function(){
    var select_music_genre = "session_music_genre_ids_6";
    var check_value = $('#session_music_genre_ids_6:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[5]);
  });

  $(document).on('click', '#session_music_genre_ids_7', function(){
    var select_music_genre = "session_music_genre_ids_7";
    var check_value = $('#session_music_genre_ids_7:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[6]);
  });

  $(document).on('click', '#session_music_genre_ids_8', function(){
    var select_music_genre = "session_music_genre_ids_8";
    var check_value = $('#session_music_genre_ids_8:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[7]);
  });

  $(document).on('click', '#session_music_genre_ids_9', function(){
    var select_music_genre = "session_music_genre_ids_9";
    var check_value = $('#session_music_genre_ids_9:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[8]);
  });

  $(document).on('click', '#session_music_genre_ids_10', function(){
    var select_music_genre = "session_music_genre_ids_10";
    var check_value = $('#session_music_genre_ids_10:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[9]);
  });

  $(document).on('click', '#session_music_genre_ids_11', function(){
    var select_music_genre = "session_music_genre_ids_11";
    var check_value = $('#session_music_genre_ids_11:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[10]);
  });

  $(document).on('click', '#session_music_genre_ids_12', function(){
    var select_music_genre = "session_music_genre_ids_12";
    var check_value = $('#session_music_genre_ids_12:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[11]);
  });

  $(document).on('click', '#session_music_genre_ids_13', function(){
    var select_music_genre = "session_music_genre_ids_13";
    var check_value = $('#session_music_genre_ids_13:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[12]);
  });

  $(document).on('click', '#session_music_genre_ids_14', function(){
    var select_music_genre = "session_music_genre_ids_14";
    var check_value = $('#session_music_genre_ids_14:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[13]);
  });

  $(document).on('click', '#session_music_genre_ids_15', function(){
    var select_music_genre = "session_music_genre_ids_15";
    var check_value = $('#session_music_genre_ids_15:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[14]);
  });

  $(document).on('click', '#session_music_genre_ids_16', function(){
    var select_music_genre = "session_music_genre_ids_16";
    var check_value = $('#session_music_genre_ids_16:checked').val();
    musicGenreSelect(select_music_genre, check_value,music_genre_colors[15]);
  });

  $(document).on('click', '#session_music_genre_ids_17', function(){
    var select_music_genre = "session_music_genre_ids_17";
    var check_value = $('#session_music_genre_ids_17:checked').val();
    musicGenreSelect(select_music_genre, check_value, music_genre_colors[16]);
  });

  $(document).ready( function(){
    for(var i = 1; i <= 18; i++){
      var select_music_genre = `session_music_genre_ids_${i}`;
      var check_value = $(`#session_music_genre_ids_${i}:checked`).val();
      musicGenreSelect(select_music_genre, check_value, music_genre_colors[i-1]);
    }
  });
});
