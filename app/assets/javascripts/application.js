// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require mui
//= require loaders
//= require list
//= require moment
//= require jquery.autocomplete
//= require Chart.2.4.0
//= require lodash.4.17.2
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  $('.moment-format').each(function(index, elem) {
    m = moment($(elem).html());
    $(elem).html(m.fromNow());
  });
})
