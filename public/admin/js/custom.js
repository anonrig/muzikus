/* Add here all your JS customizations */

$.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
});

function Delete(e){
    var url = $(e).data('delete-action');
    
    Swal.fire({
        title: '<p class="text-dark-scale-5">Are you sure?<p>',
        text: "You won't be able to revert this!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
      }).then((result) => {
        if (result.value) {
            $.ajax(url, {
                type: "DELETE",
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).done(() => {
                Swal.fire({
                    title: '<p class="text-dark-scale-5">Deleted!</p>',
                    type: 'success'
                })
                var row = $(e).parent().parent(); 
                row.fadeOut(500).promise().done(function(){
                    row.remove();
                });
            }).fail(
                Swal.fire({
                    title: '<p class="text-dark-scale-5">Something went wrong...</p>',
                    type: 'error'
                })
            )
        }
    });
}

var modal = $('.modal-with-form');
if(modal[0])
{
    modal.magnificPopup({
        type: 'inline',
        preloader: false,
        focus: '#name',
        modal: true,
    
        // When elemened is focused, some mobile browsers in some cases zoom in
        // It looks not nice, so we disable it:
        callbacks: {
            beforeOpen: function() {
                if($(window).width() < 700) {
                    this.st.focus = false;
                } else {
                    this.st.focus = '#name';
                }
            }
        }
    });

    $('.modal-dismiss').on('click', function(e){
       e.preventDefault();
       $.magnificPopup.close(); 
    });

    $('.modal-confirm').on('click', function(e){
        e.preventDefault();

        //TODO: Send Form Data...

        $.magnificPopup.close();
     });
}

var scheduleForm = $("#create-schedule-form");
if(scheduleForm[0])
{
    // scheduleForm.validate({
    //     highlight: function(element) {
    //         $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
    //     },
    //     success: function(element) {
    //         $(element).closest('.form-group').removeClass('has-error');
    //     },
    //     errorPlacement: function( error, element ) {
    //         var placement = $(element).parent();
            
    //         placement.append(error);
    //     }
    // });
}
