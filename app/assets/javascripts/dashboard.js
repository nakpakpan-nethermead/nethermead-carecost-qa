var maxHeight=0;
var currentCategory = 1;
$(document).ready(function(){

  $( ".slider-range" ).each(function() {
    
    $( this ).slider({
      range: "max",
      min: 0,
      max: $(this).attr('max'),
      value: 0,
      slide: function( event, ui ) {
        var value;
        if ($(event.target).prev().attr("prefix") == "%") {
          value = ui.value + $(event.target).prev().attr("prefix");
        } else {
          value = $(event.target).prev().attr("prefix") + ui.value;

        }
        $(event.target).prev().val(value);
        $(event.target).prev().trigger('input');
      },
      
      change: function( event, ui ) {
        angular.element('#insuranceController').scope().calculatePrice();
        angular.element('#insuranceController').scope().$apply();
      }
    });
  });


  $(".amount").keyup(function(event){
      if($(this).attr('prefix') == '%')
        var value = this.value.substring(0,this.value.length-1);
      else
        var value = this.value.substring(1);
      
      $(this).next().slider("value", parseInt(value));
      if($(this).val() == '')
        $(this).val($(this).attr('prefix'));
  });

  $(".amount").keypress(function(event){
    if(event.keyCode > 47 && event.keyCode < 58)
      return true;

    return false;
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

  $( "#cityComplete" ).catcomplete({
      source: function( request, response ) {
        $.getJSON( "/procedure/get_city_suggestions", {
          term: request.term
        }, response );
      },
      minLength: 2,
      select: function( event, ui ) {
        $("#newLocation").val(ui.item.name);
        $("#newLocationZip").val(ui.item.id);
        $("#newLocationType").val(ui.item.originalCat);
        if (ui.item.category == "ZipCode")
          ui.item.category = 'City'
        $("#newLocationCategory").val(ui.item.category);

        $("#newLocation,#newLocationZip,#newLocationType,#newLocationCategory").trigger('input');
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

  $("#medicalCondition").tokenInput(medicalConditionUrl, {
    theme: "facebook",
    preventDuplicates: true,
    resultsFormatter: function(item){ 
      var rData = '';
      if(currentCategory != item.category) {
        rData = "<lh class='ui-menu-token-item-header'>"+item.category+"</lh>";
        currentCategory = item.category
      }
      if(rData == '')
        rData = "<li class='ui-menu-token-item'>"+item.name+"</li>";
      else
        rData += "<li class='ui-menu-token-item'>"+item.name+"</li>";
      return rData;
    },
    onResult: function(results){
      currentCategory = '';
      return results;
    },
    onKeyDown: function() {
      currentCategory = '';
    },
    searchingText: "Fetching procedures",
    hintText: "Type your medical conditions",
  });


  var colWidth = 175;
  $('#next-column').click(function(event) {
    $t = $('.sliding-window');
    $tUp = $('.table-container');        
    $tUp.animate({scrollLeft:'+=' + colWidth}, 'slow');
  });
  
  $('#previous-column').click(function(event) {
    $t = $('.sliding-window');
    $tUp = $('.table-container');
    $tUp.animate({scrollLeft:'-=' + colWidth}, 'slow');
  });


  var world = new Datamap({
    element: document.getElementById('mapContainer'),
    scope: 'usa',
    projection: 'mercator',
    fills: {
        defaultFill: '#ABDDA4',
        'DEM': 'blue'
    },
    geographyConfig: {
        hideAntarctica: false
    },
    fills: {
        defaultFill: '#f0af0a',
        zipFound: 'rgba(0,244,244,0.9)',
    },
    data: {
        'AZ': {fillKey: 'zipFound' },
    }
  });

  setTimeout(function(){
    $("#showList").trigger('click');
  },100);

  $("#emailShare").click(function(){
    // Space for Shalini

    // Space for Shalini
    
    // On Everything success call this
    angular.element('#procedureController').scope().emailShare();
  });

});

function split( val ) {
  return val.split( /,\s*/ );
}     
  
function extractLast( term ) {
  return split( term ).pop();
} 

function medicalConditionUrl(){
    var medicalConditionUrl = "/dashboard/get_suggestions";
    medicalConditionUrl += "?diagnosis="+$("#searchDiagnosis").is(':checked')
    medicalConditionUrl += "&procedure="+$("#searchProcedure").is(':checked')
    return medicalConditionUrl;
}

