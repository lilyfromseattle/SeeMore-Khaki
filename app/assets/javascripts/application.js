// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {

  // $(".search-icon").hover(function () {
  //   $(this).siblings(".form-stuff").slideToggle(600);
  // });

  // $(".search-icon").hover(function () {
  //   $(this).parent(".search").css("margin-left", "0");
  // });

  $(".search-icon").hover(function() {
    $(this).parent(".search").animate(
      {"margin-left": "0px",
      "margin-right": "0px"},
      "slow");
    });



    $("body").hover(function() {
      $(".search").animate(
        {"margin-left": "-250px",
        "margin-right": "110px"},
        "slow");
      });

    $("body").mousemove(function() {
      $(".lids").animate(
        {"height": "toggle"},
        900);
      });
    $(".btn").click(function(e) {
      e.preventDefault();
      
    });
    $.ajax( $form.attr(""), {
            type: 'Post',
            success: function() {

            }
    });

  // $("body").mousemove(function () {
  //   $(".lids").animate("slow");
  // });

  // jquery animate
  //   $(".search-icon").click(function(e) {
  //     e.preventDefault();
  //     $(this).addClass("red");
  //     // , function() {
  //     //   $(this).fadeIn("fast");
  //     // });
  //   });
  //
  //   $("#clear").click(function(e) {
  //     e.preventDefault();
  //     $("#list").css("display", "none");
  //   });
  // });

});
