$(function(){
  
  $('#add_music').on('click', function(e){
    $(".sessions-show__music__form").slideDown('fast');
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

  /* パートエントリー非同期 */
  $('.part-entry-link').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();
    var selected = this;
    var this_parent = $(selected).parent();
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
      html = `<a href="/users/${data.user_id}">${data.user_name}</a>`
      $(this_parent).append(html);
    })
    // 非同期通信失敗時
    .fail(function(){
      alert('通信に失敗しました');
    })
  });



});