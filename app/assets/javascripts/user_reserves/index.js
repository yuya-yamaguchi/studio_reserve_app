$(function(){

  function setModalContent(warn_msg, move_html){
    var cancel_msg = '.reserve-cancel-modal__msg';
    var cancel_move_btn = '.reserve-cancel-modal__btn__move';
    // 前回設定内容のリセット
    $(cancel_msg).empty();
    $(cancel_move_btn).empty();
    // メッセージ、ボタンの設定
    $(cancel_msg).append(warn_msg);
    $(cancel_move_btn).append(move_html);
  }

  $('.session-st-cancel').on('click',function(e){
    e.preventDefault();
    e.stopPropagation();

    var move_url = $(this).attr('href');
    var warn_msg = `セッション開催によって予約されたスタジオです。<br>
                    取消を行う場合はセッション詳細ページから取消をお願いします。`;
    var move_html = `<a href="${move_url}">セッション詳細へ移動</a>`;
    // モーダル内容の設定
    setModalContent(warn_msg, move_html);

    $('.js-reserve-modal').fadeIn();
    return false;
  });

  $('.normal-st-cancel').on('click',function(e){
    e.preventDefault();
    e.stopPropagation();

    var move_url = $(this).attr('href');
    var warn_msg = '予約を取り消します。よろしいですか？';
    var move_html = `<a href="${move_url}" data-method="delete">取り消す</a>`;
    // モーダル内容の設定
    setModalContent(warn_msg, move_html);

    $('.js-reserve-modal').fadeIn();
    return false;
  });

  $('.reserve-cancel-back').on('click',function(){
    $('.js-reserve-modal').fadeOut();
    return false;
  });
});