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

    $('.pref-open-pane').click(function(){
        $(".pref-pane").toggleClass("hidden");   
    });


};

$(document).ready(main);


