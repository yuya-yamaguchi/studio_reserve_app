$(function(){
  /************************/
  /* セッション曲追加枠の表示 */
  /************************/
  $('#add_music').on('click', function(e){
    $(".add-music__form").slideDown('fast');
  });

  /************************/
  /* パート選択関数         */
  /************************/
  function partSelect(select_part, select_this){
    $(select_part).removeClass('part-selected');
    $(select_this).addClass('part-selected');
  }
  /* Vo選択 */
  $(document).on('click', '.part-vo', function(){
    var select_part = $(".part-vo");
    partSelect(select_part, this);
  });
  /* Cho選択 */
  $(document).on('click', '.part-cho', function(){
    var select_part = $(".part-cho");
    partSelect(select_part, this);
  });
  /* Gt1選択 */
  $(document).on('click', '.part-gt1', function(){
    var select_part = $(".part-gt1");
    partSelect(select_part, this);
  });
  /* Gt2選択 */
  $(document).on('click', '.part-gt2', function(){
    var select_part = $(".part-gt2");
    partSelect(select_part, this);
  });
  /* Ba選択 */
  $(document).on('click', '.part-ba', function(){
    var select_part = $(".part-ba");
    partSelect(select_part, this);
  });
  /* Dr選択 */
  $(document).on('click', '.part-dr', function(){
    var select_part = $(".part-dr");
    partSelect(select_part, this);
  });
  /* Key選択 */
  $(document).on('click', '.part-key', function(){
    var select_part = $(".part-key");
    partSelect(select_part, this);
  });

  $('#add-music-btn').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();

    var check_result = true;
    var music_name   = $('#entry_music_music_name').val();
    var artist_name  = $('#entry_music_artist_name').val();
    
    $('.error-messages').empty();
    // 曲名チェック
    if (music_name == ""){
      $('#music_name-error').append("曲名を入力してください");
      check_result = false;
    }
    // アーティスト名チェック
    if (artist_name == ""){
      $('#artist_name-error').append("アーティスト名を入力してください");
      check_result = false;
    }
    if (check_result){
      $('form').submit();
    }
  });
});