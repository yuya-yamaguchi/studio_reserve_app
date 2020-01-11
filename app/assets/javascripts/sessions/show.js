$(function(){
  
  $('#add_music').on('click', function(e){
    $(".add-music__form").slideDown('fast');
  });

  function partSelect(select_part, select_this){
    $(select_part).removeClass('part-selected');
    $(select_this).addClass('part-selected');
  }

  $(document).on('click', '.part-vo', function(){
    var select_part = $(".part-vo");
    partSelect(select_part, this);
  });
  $(document).on('click', '.part-cho', function(){
    var select_part = $(".part-cho");
    partSelect(select_part, this);
  });
  $(document).on('click', '.part-gt1', function(){
    var select_part = $(".part-gt1");
    partSelect(select_part, this);
  });
  $(document).on('click', '.part-gt2', function(){
    var select_part = $(".part-gt2");
    partSelect(select_part, this);
  });
  $(document).on('click', '.part-ba', function(){
    var select_part = $(".part-ba");
    partSelect(select_part, this);
  });
  $(document).on('click', '.part-dr', function(){
    var select_part = $(".part-dr");
    partSelect(select_part, this);
  });
  $(document).on('click', '.part-key', function(){
    var select_part = $(".part-key");
    partSelect(select_part, this);
  });

  /***********************/
  /* パートエントリー非同期 */
  /***********************/
  $('.part-entry-link').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();
    var selected = this;
    var this_parent = $(selected).parent();

    // セッションエントリー有無チェック
    var current_user_entry = $('#current_user_entry').val();
    if (current_user_entry == false){
      alert('ログイン後（または会員登録後）、エントリーしてください');
      return
    }
    path = $(selected).attr('href');
    $.ajax({
      url: path,
      type: "PATCH",
      data: {},
      dataType: 'json'
    })
    // 非同期通信成功時
    .done(function(data){
      selected.remove();
      html = `<a href="/users/${data.user_id}">${data.user_name}</a>
              <a href="/sessions/${data.session_id}/entry_musics/${data.entry_music_id}/entry_parts/${data.id}/cancel">
                <i class="fas fa-times-circle part-entry-cansel">
                </i>
              </a>
              `
      $(this_parent).append(html);
    })
    // 非同期通信失敗時
    .fail(function(){
      alert('通信に失敗しました');
    })
  });

  /*******************************/
  /* パートエントリーキャンセル非同期 */
  /*******************************/
  $('.part-entry-cansel').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();
    var canceled = $(this).parent();
    var romove_elements = $(this).parents('td').children();
    var cancel_parent = $(canceled).parent();
    path = $(canceled).attr('href');
    $.ajax({
      url: path,
      type: "GET",
      data: {},
      dataType: 'json'
    })
    // 非同期通信成功時
    .done(function(data){
      romove_elements.remove();
        
      if (data.apply_status == 1){
        class_name = "entry_need"
        set_string = "エントリー"
      }
      else if(data.apply_status == 2){
        class_name = "entry_whichever"
        set_string = "(エントリー)"
      }
      html = `<a class="${class_name} part-entry-link" rel="nofollow" data-method="patch" href="/sessions/${data.session_id}/entry_musics/${data.entry_music_id}/entry_parts/${data.id}">${set_string}</a>`
      $(cancel_parent).append(html);
    })
    // 非同期通信失敗時
    .fail(function(){
      alert('通信に失敗しました');
    })
  });

  /*******************************/
  /* セッション中止確認モーダル      */
  /*******************************/
  $('.session-destroy').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();

    var cancel_main_msg = '.session-cancel-modal__msg__main';
    var cancel_sub_msg = '.session-cancel-modal__msg__sub';
    var cancel_move_btn = '.session-cancel-modal__btn__move';
    var move_url = $(this).attr('href');
    var main_msg = 'セッションを中止します';
    var sub_msg = `中止した場合、現在ご登録したセッション内容は戻すことができません。<br>
                   なお、予約したスタジオは自動キャンセルとなります。`;
    var move_html = `<a href="${move_url}" data-method="delete">セッションを中止する</a>`;

    // 前回設定内容のリセット
    $(cancel_main_msg).empty();
    $(cancel_sub_msg).empty();
    $(cancel_move_btn).empty();
    // メッセージ、ボタンの設定
    $(cancel_main_msg).append(main_msg);
    $(cancel_sub_msg).append(sub_msg);
    $(cancel_move_btn).append(move_html);

    $('.js-session-modal').fadeIn();
    return false;
  });

  $('.session-cancel-back').on('click',function(){
    $('.js-session-modal').fadeOut();
    return false;
  });
});