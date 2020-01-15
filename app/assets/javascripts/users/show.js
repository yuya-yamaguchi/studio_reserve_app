$(function(){
  var tabs_header = $(".mypage__tabs__header__tab");
  
  function mypageInfoSwitch () {
    $(".active").removeClass("active");
    $(".active-contents").removeClass("active-contents");
    $(this).addClass("active");
    const index = tabs_header.index(this);
    $(".mypage__tabs__contents").eq(index).addClass("active-contents")
  }

  tabs_header.click(mypageInfoSwitch);
});