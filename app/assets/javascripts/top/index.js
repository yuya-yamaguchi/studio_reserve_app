$(function() {
  // トップページの画像スライド
  $('.image-slider').slick({
    dots: true,
    autoplay: true,
    autoplaySpeed: 3000,
    speed: 800
  });
  // このアプリについてのスクロールリンク
  $('#about-this-app-link').on('click', function(e){
    var i = $('#about-this-app-link').index(this);
    var p = $(".app-explain__title").eq(i).offset().top;
    $('html,body').animate({ scrollTop: p - 100 }, 'fast');
    return false;
  });
  // スタジオ一覧についてのスクロールリンク
  $('#studio-list-link').on('click', function(e){
      var i = $('#studio-list-link').index(this);
      var p = $(".studio-list").eq(i).offset().top;
      $('html,body').animate({ scrollTop: p - 100 }, 'fast');
      return false;
  });
});
