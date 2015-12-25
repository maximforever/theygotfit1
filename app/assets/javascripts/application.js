// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap.min
//= require_tree .
//= require turbolinks
//= require pickadate/picker 
//= require pickadate/picker.date 




var main = function(){



    console.log("jQuery is go.");

    $('.gender-age-row input:radio').screwDefaultButtons({
        image: 'url("/assets/radio-buttons/radioSmall-alt.png")',
        width: 22,
        height: 22
    });

    $('.weight-options-row input:radio').screwDefaultButtons({
        image: 'url("/assets/radio-buttons/radioSmall-alt.png")',
        width: 22,
        height: 22
    });

    $('.metric input:radio').screwDefaultButtons({
        image: 'url("/assets/radio-buttons/radioSmall-alt.png")',
        width: 22,
        height: 22
    });

    $('.search-metric input:radio').screwDefaultButtons({
        image: 'url("/assets/radio-buttons/radioSmall-alt.png")',
        width: 22,
        height: 22
    });

    $('.edit-metric input:radio').screwDefaultButtons({
        image: 'url("/assets/radio-buttons/radioSmall-alt.png")',
        width: 22,
        height: 22
    });

    $('.datepicker').pickadate({
        selectYears: true,
        selectMonths: true
    });

    $('.profile-weight').mouseenter(function(){
        $(this).find(".delete-rec:first").stop().fadeTo("fast", 1)
      });

    $('.profile-weight').mouseleave(function(){
        $(".delete-rec").stop().fadeTo("fast", 0)

      });

    $('.profile-text-weight').mouseenter(function(){
        $(this).parent('.col-md-8').next('.col-md-4').first().find(".delete-rec:first").stop().fadeTo("fast", 1)
      });

    $('.profile-text-weight').mouseleave(function(){
        $(".delete-rec").stop().fadeTo("fast", 0)

      });


    $('.pref-open-pane').click(function(){
        $(".pref-pane").toggleClass("hidden");   
    });

    $('.get-more-photos').click(function(){
        $(".extra-photos").toggleClass("hidden");
        $(".photo-arrow").toggleClass("glyphicon-triangle-bottom");   
    });

    var clicked = false;

//    this handles little picture clicks

    $('.little-photo').mouseenter(function(){

        $(this).parents().eq(0).css("border", "5px solid #FFBF5D")
        
        big_photo = $(this).parents().eq(2).siblings(".photo-container").find(".record-photo");
        big_photo_src = big_photo.attr("src");

        big_photo.attr("src",$(this).attr("src"));
        $(this).attr("src", big_photo_src);
    });

    $('.little-photo').mouseleave(function(){
        $(this).parents().eq(0).css("border", "5px solid rgba(30, 30, 30, 1)")
        $(".photo-container").css("border", "15px solid rgba(51, 51, 51, 0.8)");
        if(!clicked){
            big_photo = $(this).parents().eq(2).siblings(".photo-container").find(".record-photo");
            big_photo_src = big_photo.attr("src");
            big_photo.attr("src", $(this).attr("src"));
            $(this).attr("src", big_photo_src);
            
        }
        clicked = false;
    });

    $('.little-photo').click(function(){
        small_photo = $(this).attr("src");
        $(this).parents().eq(0).css("border", "5px solid #C4E0FF");
        big_photo = $(this).parents().eq(2).siblings(".photo-container").find(".record-photo");
        $(this).parents().eq(2).siblings(".photo-container").css("border", "15px solid #C4E0FF");
        big_photo.attr("src", big_photo.attr("src"));
        $(this).attr("src", small_photo);
        clicked = true;
    });

    $('.record-photo').click(function(){
        console.log("big picture shows!");
        //to be filled in later

    });



};

$(document).ready(main);


