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