// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('#slider').slick({
    dots: true, //スライドの下にドットのナビゲーションを表示
    autoplay: true, //自動再生
    autoplaySpeed: 4000, //再生スピード
  });
});

$(document).ready(function () {
  $(".file").on('change', function(){
    var fileprop = $(this).prop('files')[0],
    find_img = $(this).parent().find('img'),
    filereader = new FileReader(),
    view_box = $(this).parent('.view_box');
    
    if(find_img.length){
      find_img.nextAll().remove();
      find_img.remove();
    }
    
    var img = '<div class="img_view"><img alt="" class="img"><p><a href="#" class="img_del">画像を削除する</a></p></div>';
    
    view_box.append(img);
    
    filereader.onload = function() {
      view_box.find('img').attr('src', filereader.result);
      img_del(view_box);
    }
    filereader.readAsDataURL(fileprop);
  });
  
  function img_del(target){
    target.find("a.img_del").on('click',function(){
      var self = $(this),
          parentBox = self.parent().parent().parent();
      if(window.confirm('画像を削除します。\nよろしいですか？')){
        setTimeout(function(){
          parentBox.find('input[type=file]').val('');
          parentBox.find('.img_view').remove();
        } , 0);            
      }
      return false;
    });
  }  
});

$(document).on('turbolinks:load', function() {
  // inputのidから情報の取得
  $(".item-image").on('change', function (e) {
    // ここから既存の画像のurlの取得
    var reader = new FileReader();
    reader.onload = function (e) {
      $(".profile_image").attr('src', e.target.result);
    }
    // ここまで
    reader.readAsDataURL(e.target.files[0]);
  //取得したurlにアップロード画像のurlを挿入
  });
});

$(document).on('turbolinks:load', function() {
  $(window).on('load scroll',function (){
    $('.animation').each(function(){
      //ターゲットの位置を取得
      var target = $(this).offset().top;
      //スクロール量を取得
      var scroll = $(window).scrollTop();
      //ウィンドウの高さを取得
      var height = $(window).height();
      //ターゲットまでスクロールするとフェードインする
      if (scroll > target - height){
        //クラスを付与
        $(this).addClass('active');
      }
    });
  });
});

$(document).on('turbolinks:load', function() {
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
    event.preventDefault();
  });
});

$(function () {
  $('#ButtonStateful').on('click', function () {
    $(this).button('loading');
  });
});