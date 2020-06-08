/*********************************
 * Ready!
 *********************************/
console.info("Yay! You are good to go.");

/*********************************
 * Imports
 *********************************/
import "jquery";
import "lazysizes";
import "lazysizes/plugins/unveilhooks/ls.unveilhooks";
import "@fancyapps/fancybox";

window.$ = $;
window.jQuery = jQuery;

import "./ck-arquitetura";


$(window).on("load", function() {
  document.addEventListener("lazybeforeunveil", function(e) {
    var bg = e.target.getAttribute("data-bg");
    if (bg) {
      e.target.style.backgroundImage = "url(" + bg + ")";
    }
  });

  $('.broker-page_video-section_video_link').click(e => {
    $('.youtube-modal').css({ display: 'flex', opacity: 1 });
  })
});