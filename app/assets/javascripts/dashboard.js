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

  $("#procedure-btn").click(function(){
    renderProcedure();
  });
  
  $( "#medicalCondition" )
    .bind( "keydown", function( event ) {
      if ( event.keyCode === $.ui.keyCode.TAB &&
          $( this ).data( "ui-autocomplete" ).menu.active ) {
        event.preventDefault();
      }
    }).catcomplete({
      source: function( request, response ) {
        $.getJSON( "/dashboard/get_suggestions", {
          term: extractLast( request.term )
        }, response );
      },
      minLength: 3,
      select: function( event, ui ) {
        var terms = split( this.value );
        // remove the current input
        terms.pop();
        // add the selected item
        terms.push( ui.item.value );
        // add placeholder to get the comma-and-space at the end
        terms.push( "" );
        this.value = terms.join( " | " );
        return false;
      },
      search: function() {
        // custom minLength
        var term = extractLast( this.value );
        if ( term.length < 2 ) {
          return false;
        }
      },
      focus: function() {
        // prevent value inserted on focus
        return false;
      },
    });
  
  $(document).on("click","#searchClick",function(){
    alert("I am the trigger for click");
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

  $("#procedure-btn").click(function(){
    renderProcedure();
    return false;
  });

  var selectProcedure = [];
  function renderProcedure() {
    var procedure = $("#medicalCondition").val();
    $("#medicalCondition").val('');
    if( procedure != ""){
      var proList = procedure.split('|');
      console.log(proList);
      $.each(proList,function(key,value){
        if($.trim(value) != "") {
          var data = {};
          data['name'] = value;
          selectProcedure.push(data);
        }
      });
    }
    var template = $("#proceduresList").html();
    $("#procedureTable").append(_.template(template,{items:selectProcedure}));
    return false;
  }

});

function split( val ) {
  return val.split(' | ');
}
function extractLast( term ) {
  return split( term ).pop();
}
