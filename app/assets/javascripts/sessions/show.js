$(function(){
  function partSelect(select_part, select_this){
    // 前回選択していたclassを削除
    $(select_part).removeClass('part-selected');
    // 選択した評価にclassを設定
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
});