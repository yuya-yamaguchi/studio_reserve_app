$(function(){
  
  var cancel_main_msg = '.session-cancel-modal__msg__main';
  var cancel_sub_msg = '.session-cancel-modal__msg__sub';
  var cancel_move_btn = '.session-cancel-modal__btn__move';

  /***********************/
  /* パートエントリー非同期 */
  /***********************/
  $('.part-entry-link').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();
    var selected = this;
    var this_parent = $(selected).parent();
    var current_user_entry = $('#current_user_entry').val(); // true or false
    var current_user_admin = $('#current_user_admin').val(); // true or false
    var session_user_id = $('#session_user_id').val();
    var current_user_id = $('#current_user_id').val();

    if (current_user_admin == "true" ||
        session_user_id == current_user_id){
        $("#member_name").val("");
        var path = $(this).attr('href');
        $('#add-player-url').attr('action', path);
      $('.js-select-member-modal').fadeIn();
      return false;
    }
    else {
      // セッションエントリー有無チェック
      if (current_user_entry == "false"){
        alert('当セッションに参加後、エントリーしてください');
        return
      }
      path = $(selected).attr('href');
      console.log(path);
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
    }
  });

  $('.select-member-back').on('click',function(){
    $('.js-select-member-modal').fadeOut();
    return false;
  });

  /***********************/
  /* メンバー検索          */
  /***********************/
  function addUser(user) {
    let html = `
      <div class="play-select-user" data-user-id="${user.id}">
        <p class="play-select-user__name">${user.nickname}</p>
        <div class="play-select-user__add" >選択</div>
      </div>
    `;
    $(".select-member-modal__search-result").append(html);
  }

  function addPlayer(userId, userName) {
    let html = `<div class="select-now-icon">選択中</div>
                <div class="select-player">${userName}</div>
                <input value="${userId}" name="user_id" type="hidden" id="user_id_${userId}" />`;
    $(".select-member-modal__select-now").append(html);
  }

  $("#member_name").on("keyup", function(){
    var search_name = $("#member_name").val();
    $.ajax({
      type: 'GET',
      url: '/users/search',
      dataType: 'json',
      data: { search_name: search_name }
    })
    // 非同期通信_成功
    .done(function(users) {
      $(".play-select-user").remove();
      $(".no-result").remove();
      // 入力がない場合
      if (search_name.length == 0) {
        return false;
      }
      if (users.length !== 0){
        users.forEach(function(user) {
          addUser(user);
        })
      // ユーザの検索結果がヒットしなかった場合
      } else {
        $(".select-member-modal__search-result").append(`<div class="no-result">該当のユーザは存在しません</div>`);
      }
    })
    .fail(function() {
      alert("通信エラーです。ユーザーが表示できません。");
    })
  });

  $(document).on("click", ".play-select-user", function() {
    const userName = $(this).find('.play-select-user__name').text();
    const userId = $(this).attr("data-user-id");
    $(".play-select-user").remove();
    $(".select-player").remove();
    $(".select-now-icon").remove();
    
    addPlayer(userId, userName);
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

  /*******************************/
  /* セッション参加中止確認モーダル   */
  /*******************************/
  $('.session-entry-cancel').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();

    var main_msg = 'セッションの参加を取り消します';
    var sub_msg = `現在エントリーしているパートは取り消されます<br>
                   エントリーした曲の取り消しは行われません`;
    var move_url = $(this).attr('href');
    var move_html = `<a href="${move_url}" data-method="delete">参加をやめる</a>`;

    // 前回設定内容のリセット
    $(cancel_main_msg).empty();
    $(cancel_sub_msg).empty();
    $(cancel_move_btn).empty();

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