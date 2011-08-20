/* Active Admin JS */

// After I upgraded active admin to an edge version (to allow me to use Kaminari) it was no longer auto loading jquery and rails.js
// This is a major hack. I use js to load the required scripts and then a briefly paused with a setTimeout to allow the
// resources to be loaded.

document.write( "\x3Cscript src='/javascripts/active_admin_vendor.js'>\x3C/script>");

setTimeout(function() {
    $(function(){
        $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});

        $(".clear_filters_btn").click(function(){
          window.location.search = "";
          return false;
        });
        
        // AJAX Comments
        $('form#admin_note_new').submit(function() {

          if ($(this).find('#admin_note_body').val() != "") {
            $(this).fadeOut('slow', function() {
              $('.loading_indicator').fadeIn();
              $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                dataType: 'json',
                data: $(this).serialize(),
                success: function(data, textStatus, xhr) {
                  $('.loading_indicator').fadeOut('slow', function(){
                    
                    // Hide the empty message
                    $('.admin_notes_list li.empty').fadeOut().remove();
                    
                    // Add the note
                    $('.admin_notes_list').append(data['note']);
                    
                    // Update the number of notes
                    $('.admin_notes h3 span.admin_notes_count').html("(" + data['number_of_notes'] + ")");
                    
                    // Reset the form
                    $('form#new_active_admin_admin_note').find('#active_admin_admin_note_body').val("");
                    
                    // Show the form
                    $('form#new_active_admin_admin_note').fadeIn('slow');
                  })
                },
                error: function(xhr, textStatus, errorThrown) {
                  //called when there is an error
                }
              });
            });
            
          };

          return false;
        });

        // Active Admin Tweaks
        p = $('.pagination');

        if (p) {
            target = $('.pagination_information')[0];
            $(p[0]).clone().appendTo(target);
        }
        $('#polygon_link_type_constituency').click(function(){
            $('#polygon_submap_input').hide();
            $('#polygon_constituency_input').show();
        });
        $('#polygon_link_type_submap').click(function(){
            $('#polygon_submap_input').show();
            $('#polygon_constituency_input').hide();
        });

    })}, 
    
    300);
