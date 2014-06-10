var selectProcedure = [];
var city = 0;
$(function() {
    $(document).on('click','.delete_row',function(){
        if(confirm("Are you sure?"))
            $(this).closest('tr').hide();
    });

    $("#location").click(function(){
        $("#zipCodeContainer").show();
    });
    
    $("#addZip").click(function(){
        var cityAdded = true;
        city += 1;
        console.log(city);
        $("#zipCode").val('');
        renderProcedure();
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

    

    $("#procedure-btn").click(function(){
        renderProcedure();
    });

    
    $( "#category_consumer_name" ).catcomplete({
      source: "/dashboard/get_suggestions",
      minLength: 3
    });
    
    $('#map_view').hide();

    $('#btn_map_view').on('click', function(){
        $('#list_view').hide();
        $('#map_view').show();
        $(this).css('background','#3d4753');
        $(this).toggleClass('red')
    });

    $('#btn_list_view').on('click', function(){
        $('#map_view').hide();
        $('#list_view').show();
        $(this).css('background','#3d4753');
    });

    
    //Multiselect functionality
    // $("select").multiselect({});
});

function renderProcedure() {
    var procedure = $("#category_consumer_name").val();
    $("#category_consumer_name").val('');
    if( procedure != ""){
        var data = {};
        data['name'] = procedure;
        selectProcedure.push(data);
    }
    var template = $("#proceduresList").html();
    $("#procedure").html(_.template(template,{items:selectProcedure,city:city}));
}

