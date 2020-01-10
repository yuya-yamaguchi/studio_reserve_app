$(function(){
  var error_msg  = '';
  var chk_result = true;

  /* 予約モーダル表示 */
  $('.reserve__table--possible').on('click',function(e){
    e.preventDefault();
    e.stopPropagation();

    var select_date = $(this).children('#select_date').val();
    var select_year  = Number(select_date.substr(0, 4));
    var select_month = Number(select_date.substr(5, 2));
    var select_day   = Number(select_date.substr(8, 2));
    var studio_fee   = $('#studio_fee').val();
    console.log(studio_fee);
    
    var select_start_hour = $(this).children('#select_hour').val();
    var select_end_hour = Number(select_start_hour) + 1;
    
    // デフォルト値設定
    $("#_date_1i").val(select_year);
    $("#_date_2i").val(select_month);
    $("#_date_3i").val(select_day);
    $("#start_hour").val(select_start_hour);
    $("#end_hour").val(select_end_hour);
    $("#payment_fee").text(`${studio_fee} 円`);

    $('.js-reserve-modal').fadeIn();
    return false;
  });
  /* 予約モーダル非表示 */
  $('.reserve-back').on('click',function(){
    $('.js-reserve-modal').fadeOut();
    return false;
  });

  /****************************************/
  /* 日付チェック関数                        */
  /****************************************/
  function dateCheck(){
    // 本日日付の設定
    var today = new Date();
    var today_ymd = new Date(today.getFullYear(),
                             today.getMonth() + 1,
                             today.getDate(),
                             today.getHours());
    // 選択日付の設定
    var select_ymd = new Date($('#_date_1i').val(),
                              $('#_date_2i').val(),
                              $('#_date_3i').val(),
                              $('#start_hour').val());

    // 本日日付が予約開始日を過ぎている場合
    if (today_ymd >= select_ymd){
      error_msg = "開始日時を過ぎています";
      reserveDisable();
      return false;
    }

    // 半年以内チェック
    if ((select_ymd - today_ymd) / 86400000 > 185){
      error_msg = "予約日は半年以内にしてください";
      reserveDisable();
      return false;
    }
    return true;
  }

  /****************************************/
  /* 時間チェック関数                        */
  /****************************************/
  function timeCheck(){
    var start_hour = $('#start_hour').val();
    var end_hour   = $('#end_hour').val();
    // 開始時間が終了時間以降の場合
    if (start_hour >= end_hour){
      error_msg = "終了時間は開始時間より後にしてください";
      reserveDisable();
      return false;
    }
  }

  /****************************************/
  /* 予約重複チェック関数                    */
  /****************************************/
  function reserveDuplicateChk(){
    var date_y =  $('#_date_1i').val();
    var date_m =  $('#_date_2i').val();
    var date_d =  $('#_date_3i').val();
    var start_hour = $('#start_hour').val();
    var end_hour   = $('#end_hour').val();
    var href = window.location.href;
    
    $.ajax({
      url: href + "/reserves/duplicate",
      type: "GET",
      data: { date_y: date_y,
              date_m: date_m,
              date_d: date_d,
              start_hour: start_hour,
              end_hour:   end_hour },
      dataType: 'json'
    })
    .done(function(data){
      if (data.reserved_result == true){
        error_msg = `その時間帯はすでに予約されています。<br>
                     別の時間帯をご指定ください`;
        reserveDisable();
      } else {
        reservePossible();
      }
    })
    .fail(function(){
      alert("通信に失敗しました");
    });
  }

  /****************************************/
  /* 予約ボタン有効関数                      */
  /****************************************/
  function reservePossible(){
    $("#reserve-done").removeAttr("disabled");
    $('.reserve-modal__form__btn__move input').css('background','lightsalmon');
    $('.reserve-modal__form__btn__move input').css('cursor','pointer');
    $(".reserve-date-error-msg").empty();
  }

  /****************************************/
  /* 予約ボタン無効・エラーメッセージ設定関数   */
  /****************************************/
  function reserveDisable(){
    $("#reserve-done").prop('disabled', true);
    $('.reserve-modal__form__btn__move input').css('background','#888888');
    $('.reserve-modal__form__btn__move input').css('cursor','not-allowed');
    // 前回のエラーメッセージ削除
    $(".reserve-date-error-msg").empty();
    // 今回のエラーメッセージ設定
    $(".reserve-date-error-msg").append(error_msg);
  }

  $('#_date_1i').on('change',function(e){
    // 日付チェック
    chk_result = dateCheck();
    if (chk_result == false){
      reserveDisable();
      return;
    }
    // 予約重複チェック
    reserveDuplicateChk();
  });

  $('#_date_2i').on('change',function(e){
    // 日付チェック
    chk_result = dateCheck();
    if (chk_result == false){
      reserveDisable();
      return;
    }
    // 予約重複チェック
    reserveDuplicateChk();
  });

  $('#_date_3i').on('change',function(e){
    // 日付チェック
    chk_result = dateCheck();
    if (chk_result == false){
      reserveDisable();
      return;
    }
    // 予約重複チェック
    reserveDuplicateChk();
  });

  $('.select-reserve-hour').on('change',function(e){
    
    // 時間チェック
    chk_result = timeCheck();
    if (chk_result == false){
      return;
    }
    // 予約重複チェック
    reserveDuplicateChk();

    // 料金計算
    var start_hour = $('#start_hour').val();
    var end_hour = $('#end_hour').val();
    var base_fee = $('#base_fee').val();

    // 利用時間算出
    use_time = end_hour - start_hour
    // 支払料金算出
    chaged_fee = base_fee * use_time

    $("#payment_fee").text(chaged_fee + " 円");
  });
});