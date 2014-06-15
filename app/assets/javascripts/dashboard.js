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
        // var terms = split( this.value );
        // // remove the current input
        // terms.pop();
        // // add the selected item
        // terms.push( ui.item.value );
        // // add placeholder to get the comma-and-space at the end
        // terms.push( "" );
        // this.value = terms.join( " | " );
        // document.getElementById($(this).id).value = ui.item.id;
        $("#procedureId").val(ui.item.id);
        // $(this).val(ui.item.id);
        $(this).trigger('input');
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

function split( val ) {
  return val.split(' | ');
}
function extractLast( term ) {
  return split( term ).pop();
}

function ContactController($scope, $http) {
  $scope.items = [];
  $scope.procedures = {};
  $scope.add = function() {
    // var data = {};
    // data['name'] = $scope.procedure
    // $scope.items.push(data);
    $http.get('/procedure/price/'+$("#procedureId").val()).success(function(response) {
      console.log(response);
       $scope.items.push(response);
    });
    $("#medicalCondition").val('');
  }

  $scope.destroy = function($index) {
    $scope.items.splice($index,1);
  }

  $scope.network_change = function(item){
    console.log(item);
    response = $http({
      url: '/procedure/price/'+item.id,
      method: 'GET',
      params: item
    }).success(function (result) {
      for(i=0;i<$scope.items.length;++i) {
        if($scope.items[i].id == result.id){
          console.log($scope.items[i].charge,result.charge);
          $scope.items[i].charge = result.charge;
        }
      }
    });
  } 
}