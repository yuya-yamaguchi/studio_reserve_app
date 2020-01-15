$(function(){
  
  /****************************************************************/
  /* HTML組み立て関数(メッセージ送信時、自動更新時)                      */
  /****************************************************************/
  function buildMessage(message){
    var html = `<div class="message">
                  <div class="message__own">
                    <div class="message__own__top">
                      <div class="message__own__top__text">
                        ${message.text}
                      </div>
                    </div>
                    <div class="message__own__bottom">
                      ${message.created_at}
                    </div>
                  </div>
                </div>
               `
    return html;
  }

  $('#new_message').on('click', function(e){
    e.preventDefault();
    var href = window.location.href
    var text_hash = {}
    var text = $('.chatroom-show__form--message').val();
    text_hash = {text: text};
    $.ajax({
      url: href + "/messages",
      type: "POST",
      data: { message: text_hash },
      dataType: 'json'
    })
    // 非同期通信成功時
    .done(function(data){
      var html = buildMessage(data);
      $('.chatroom-show__messages').append(html);
      $("#message_scroll").animate({ scrollTop: $('#message_scroll')[0].scrollHeight});
      $('#message_form')[0].reset();
    })
    // 非同期通信失敗時
    .fail(function(){
      alert('メッセージ送信に失敗しました');
    })
    // submitボタンのdisabled解除
    .always(() => {
      $(".chatroom-show__form--send").removeAttr("disabled");
    });
  });
});