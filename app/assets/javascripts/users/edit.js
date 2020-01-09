$(function(){
  $(document).on('change', '.set-image',function() {
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    var img = $(`<img class="user-img-default">`);
    
    // ファイルが選択されている場合
    if (file != undefined){
      // 現在のプレビュー画像の削除
      $('.user-img-default').remove();
      // 画像プレビュー
      reader.onload = function(e) {
        img.attr('src', e.target.result)
      }
      reader.readAsDataURL(file);
      $('.profile-img').prepend(img);
    }
  });
});