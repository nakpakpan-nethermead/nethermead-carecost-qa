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
//= require jquery.min
//= require jquery_ujs
//= require jquery.ui.slider
//= require underscore
//= require angular
//= require angular/directives/angular-gm.min
//= require dashboard
//= require bootstrap.min


$("document").ready(function(){
  $("[data-toggle=popover]").each(function () {
    var elem = $(this);
    elem.popover({
      trigger: 'hover',
      html: 'true',
      container: elem,
      content: function() {
        return $("#"+$(this).attr("data-contentId")).html();
      },
      placement: 'bottom'
    });
  });
});