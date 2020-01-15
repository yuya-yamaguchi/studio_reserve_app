$(function(){
  /*******************************/
  /* 投稿削除確認モーダル           */
  /*******************************/
  $('.post-del-btn').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();

    var del_btn = '.post-del-modal__btn__move';
    var del_url = $(this).attr('href');
    var del_html = `<a href="${del_url}" data-method="delete">投稿を削除する</a>`;

    $(del_btn).empty();
    $(del_btn).append(del_html);

    $('.js-post-del-modal').fadeIn();
    return false;
  });

  $('.post-del-back').on('click',function(){
    $('.js-post-del-modal').fadeOut();
    return false;
  });
});