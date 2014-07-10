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
      }
    });
  });


  $(".amount").keypress(function(event){
    if(event.keyCode > 47 && event.keyCode < 58) {
      if($(this).attr('prefix') == '%')
        var value = this.value.substring(0,this.value.length-1);
      else
        var value = this.value.substring(1);
      
      $(this).next().slider("value", parseInt(value));
      if($(this).val() == '')
        $(this).val($(this).attr('prefix'));
    } else {
      return false;
    }
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

// $( "#medicalCondition" ).catcomplete({
//     source: function( request, response ) {
//       $.getJSON( "/dashboard/get_suggestions", {
//         term: extractLast( request.term ),
//         diagnosis: $("#searchDiagnosis").is(':checked'),
//         procedure: $("#searchProcedure").is(':checked')
//       }, response );
//     },
//     minLength: 3,
//     select: function( event, ui ) {
//       var terms = split( this.value );
//       // remove the current input
//       terms.pop();
//       // add the selected item
//       terms.push( ui.item.value );
//       // add placeholder to get the comma-and-space at the end
//       terms.push( "" );
//       this.value = terms.join( ", " );
//       $("#procedureId").val(this.value);
//       $("#procedureId").trigger('input');
//      return false;
//     }
//   });

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
        if (ui.item.category == "ZipCode")
          ui.item.category = 'City'
        $("#newLocationCategory").val(ui.item.category);
        $("#newLocation").trigger('input');
        $("#newLocationType").trigger('input');
        $("#newLocationCategory").trigger('input');
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

  var medicalConditionUrl = '/dashboard/get_suggestions?procedure=true&diagnosis=true';

  $(".conditionSearchIn").change(function(){
    medicalConditionUrl = "/dashboard/get_suggestions";
    medicalConditionUrl += "?diagnosis="+$("#searchDiagnosis").is(':checked')
    medicalConditionUrl += "&procedure="+$("#searchProcedure").is(':checked')
    console.log(medicalConditionUrl);
  });

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
      console.log('On Result Called');
      return results;
    },
    onKeyDown: function() {
      currentCategory = '';
    },
    searchingText: "Fetching procedures",
    hintText: "Type your medical conditions",
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


});

function split( val ) {
  return val.split( /,\s*/ );
}     
  
function extractLast( term ) {
  return split( term ).pop();
} 


