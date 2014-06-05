$(function() {
    $(document).on('click','.delete_row',function(){
        if(confirm("Are you sure?"))
            $(this).closest('tr').hide();
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
        if($("#category_consumer_name").val() != null){
            var html = '<tr><td>'+$("#category_consumer_name").val()+'</td><td><i class="glyphicon glyphicon-trash delete_row"></i></td></tr>';
            $("#procedure").append(html);
            $("#category_consumer_name").val('');
        }
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
    $("select").multiselect({});
});
