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

  const link = document.querySelector('.broker-page_video-section_video_link');
  const video = document.querySelector('.embedly-embed');
  const close = document.querySelector('.youtube-modal_close');

  const originalSrc = video ? video.src : null;

  if (link) {
    link.addEventListener('click', function (event) {
      video.src = `${originalSrc}&autoplay=true`;
    });
  }

  if (close) {
    close.addEventListener('click', function (event) {
      video.src = originalSrc;
    });
  }
});