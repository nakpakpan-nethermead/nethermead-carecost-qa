var maxHeight=0;
$(document).ready(function(){

  $( ".slider-range" ).each(function() {
    $( this ).slider({
      range: "max",
      min: 0,
      max: $(this).attr('max'),
      value: 0,
      slide: function( event, ui ) {
        var value;
        if ($(event.target).attr("prefix") == "%") {
          value = ui.value+$(event.target).attr("prefix");
        } else {
          value = $(event.target).attr("prefix")+ui.value;
        }
        $(event.target).prev().html(value);
      }
    });
  });

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
          term: request.term,
          diagnosis: $("#searchDiagnosis").is(':checked'),
          procedure: $("#searchProcedure").is(':checked')
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
          term: request.term
        }, response );
      },
      minLength: 2,
      select: function( event, ui ) {
        $("#newLocation").val(ui.item.id);
        $("#newLocationType").val(ui.item.originalCat);
        $("#newLocation").trigger('input');
        $("#newLocationType").trigger('input');
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

  // $('.selectpicker').selectpicker({
  //   'selectedText': 'cat'
  // });
  
});