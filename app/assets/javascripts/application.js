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
//= require jquery.ui.autocomplete
//= require underscore
//= require angular
//= require angular/directives/angular-gm.min
//= require dashboard
//= require bootstrap.min
//= require jquery.tokeninput
//= require d3
//= require topojson
//= require maps/datamaps.usa.min

$("document").ready(function(){
  var maxValue = 100,
     $slider = $('<div>').slider({
          range: "max",
          max: maxValue,
          min: maxValue / 5,
          value: maxValue / 2
      });

  $("[data-toggle=popover]").each(function () {
    var elem = $(this);
    elem.popover({
      trigger: 'manual',
      html: 'true',
      container: 'body',
      content: function() {
        // return $("#"+$(this).attr("data-contentId")).html();
      },
      placement: 'bottom'
    }).click(function() {
        var $this = $(this);
        if ($this.toggleClass('active').hasClass('active')) {
            $this.popover('show');
            $('.popover-content')
                .append($slider);
        } else {
            $slider.detach();
            $this.popover('hide');
        }
    });
  });
});