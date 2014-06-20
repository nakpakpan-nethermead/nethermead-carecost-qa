var maxHeight=0;
$(document).ready(function(){

  $.widget( "custom.catcomplete", $.ui.autocomplete, {
    _renderMenu: function( ul, items ) {
      var that = this,
        currentCategory = "";
      $.each( items, function( index, item ) {
        if ( item.category != currentCategory ) {
          ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
          currentCategory = item.category;
        }
        that._renderItemData( ul, item );
      });
    }
  });

  $( "#medicalCondition" ).catcomplete({
      source: function( request, response ) {
        $.getJSON( "/dashboard/get_suggestions", {
          term: extractLast( request.term )
        }, response );
      },
      minLength: 3,
      select: function( event, ui ) {
        $("#procedureId").val(ui.item.id);
        $("#procedureId").trigger('input');
      }
    });

  $( "#cityComplete" ).catcomplete({
      source: function( request, response ) {
        $.getJSON( "/procedure/get_city_suggestions", {
          term: extractLast( request.term )
        }, response );
      },
      minLength: 3,
      select: function( event, ui ) {
        $("#cityComplete").val(ui.item.label);
        $("#cityComplete").trigger('input');
      }
    });

  $(".procedureView").click(function(){
    $(".procedureLayout").hide();
    $(".procedureView").removeClass('current');
    $("."+$(this).attr("data-show")).show()
    $(this).addClass('current');
  });

  $(".physicians .btn").click(function(){
    $(".physicians .btn").removeClass('current');
    $(this).addClass('current');
  });

  setTimeout(function(){
    $(".physician-details").each(function(){    
      if ($(this).height() > maxHeight) maxHeight = $(this).height();    
    }).promise().done( function(){ 
      $(".physician-details").height(maxHeight);
    });
  },300);
});