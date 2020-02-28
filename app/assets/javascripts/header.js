$(function() {
  var menus = $('.header-menus');
  $('.header-menus__menu', menus).mouseover(function(e) {
    $('ul', this).stop().slideDown('fast');
  })
  .mouseout(function(e) {
    $('ul', this).stop().slideUp('fast');
  });

  $('.menues-bar-icon').on('click', function(e){
    // $(".sumaho-header").css('display','block');
    if( !$('.sumaho-header').hasClass('open') ) {
      $(".sumaho-header").fadeIn('fast').addClass('open');;
    } else {
      $(".sumaho-header").fadeOut('fast').removeClass('open');;
    }
  });
});