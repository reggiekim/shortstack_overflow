"use strict";
(function(){

$("#get-started").click(function() {
    $('html, body').animate({
        scrollTop: $(".one-third.column").offset().top
    }, 700);
});
//got this from: http://stackoverflow.com/questions/19012495/smooth-scroll-to-div-id-jquery

})();
