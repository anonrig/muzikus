$("#deleteSession").click(function(){
    debugger
    Swal.fire({
        title: '<p class="text-dark-scale-5">Are you sure?<p>',
        text: "You won't be able to revert this!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then(result => {
        if(result.value){
            $.ajax('/admin/clear/sessions').done(res => {
                $("#sessionCount").css('width', res.sessionCount / 100 + '%')
            }).fail(() => {
                Swal.fire({
                    title: '<p class="text-dark-scale-5">Something went wrong...</p>',
                    type: 'error'
                })
            })
        }
    })
});

$("#deleteReservations").click(function(){
    debugger
    Swal.fire({
        title: '<p class="text-dark-scale-5">Are you sure?<p>',
        text: "You won't be able to revert this!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then(result => {
        if(result.value){
            $.ajax('/admin/clear/reservations').done(res => {
                $("#reservationCount").css('width', res.reservationCount / 100 + '%')
            }).fail(() => {
                Swal.fire({
                    title: '<p class="text-dark-scale-5">Something went wrong...</p>',
                    type: 'error'
                })
            })
        }
    })
});