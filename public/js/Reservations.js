var start = moment();
start.set('second', 0)
var dateLimit = moment(start);
var end = moment(start);
dateLimit.add(2, 'day');
dateLimit.set('hour', 23);
dateLimit.set('minute', 59);
end.add(2, 'hour');
$('#end_date').bootstrapMaterialDatePicker({
    format: 'ddd, DD MMM - HH:mm',
    weekStart: 1,
    currentDate: end,
    minDate: start,
    maxDate: end
});
$('#start_date').bootstrapMaterialDatePicker({
    format: 'ddd, DD MMM - HH:mm',
    weekStart: 1,
    currentDate: start,
    minDate: start,
    maxDate: dateLimit
})


function reservation(data = {}) {
    this.id = data.id
    this.user_id = data.user_id
    this.room_id = data.room_id
    this.user = data.user
    this.room_name = data.room_name
    this.date = moment(data.start_at).format("MMM Do YYYY")
    this.weekday = moment(data.start_at).format("dddd")
    this.time = `${moment(data.start_at).format("HH:mm")} - ${moment(data.end_at).format("HH:mm")}`
    this.detail = data.detail ? data.detail : ""
    this.managers = data.managers
}

ko.bindingHandlers.timePicker = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var modelValue = valueAccessor();
        $(element).on('change', function(e, date){
            modelValue(date._d)
            if(element == $("#start_date")[0]){
                var obj = $('#end_date')
                var maxDate = date.clone().add(2, 'hour')
                obj.val(maxDate.format('ddd, DD MMM - HH:mm'));
                obj.bootstrapMaterialDatePicker('setDate', maxDate);
                obj.bootstrapMaterialDatePicker('setMinDate', date);
                obj.bootstrapMaterialDatePicker('setMaxDate', maxDate);
                obj.trigger('change', [maxDate])
            }
        })
    },
    update:function(element, valueAccessor, allBindings, viewModel, bindingContext){
        var modelValue = valueAccessor()
        if(element == $("#start_date")[0])
            modelValue(start._d)
        else if(element == $("#end_date")[0])
            modelValue(end._d)
    }
}

function ReservationViewModel(){
    self = this
    self.allReservations = ko.observableArray([])
    self.reservationForm = {
        room_id: ko.observable(),
        user_id: ko.observable(),
        start_at: ko.observable(),
        end_at: ko.observable(),
        detail: ko.observable()
    }
    
    self.showSpinner = ko.observable(true)

    self.filteredResult = ko.computed(() => {
        if(self.reservationForm.room_id() == "")
            return self.allReservations()
        else
            return ko.utils.arrayFilter(self.allReservations(), (item) => {
                return item.room_id == self.reservationForm.room_id()
            })
    })

    self.managerNames = (managers) => {
        return ko.computed(() => {
            return "<strong>Name: </strong>" + ko.utils.arrayFilter(managers, (item) => {
                return item.room_id == self.reservationForm.room_id()
            }).map((item) => {
                if(!item.manager.name)
                    item.manager.name = "Not found"
                return item.manager.name
            }).join(', ')
        })
    }
    self.managerEmails = (managers) => {
        return ko.computed(() => {
            return "<strong>Email: </strong>" + ko.utils.arrayFilter(managers, (item) => {
                return item.room_id == self.reservationForm.room_id()
            }).map((item) => {
                if(!item.manager.email)
                    item.manager.email = "Not found"
                return item.manager.email
            }).join(', ')
        })
    }
    self.managerNums = (managers) => {
        return ko.computed(() => {
            return "<strong>Phone: </strong>" + ko.utils.arrayFilter(managers, (item) => {
                return item.room_id == self.reservationForm.room_id()
            }).map((item) => {
                if(!item.manager_num)
                    item.manager_num = "Not found"
                return item.manager_num
            }).join(', ').toString()
        })
    }
    // self.roomManagers = (managers) =>{
    //     ko.utils.arrayMap(managers, (item) =>{
    //         if(!item.manager.name)
    //             item.manager.name = "Not Found"
    //         if(!item.manager.email)
    //             item.manager.email = "Not Found"
    //         if(!item.manager_num)
    //             item.manager_num = "Not Found"
    //     })

    //     return ko.computed(() => {
    //         return ko.utils.arrayFilter(managers, (item) => {
    //             return item.room_id == self.reservationForm.room_id()
    //         })
    //     })
    // }

    self.isManager = (managerList, user_id)=>{
        debugger
        var match = ko.utils.arrayFirst(managerList, (item) => {
            return item.user_id == user_id
        })

        if(match)
            return true

        return false
    }

    self.formData = ko.computed(() => {
        var form = $("#new_reservation")
        return ko.toJSON({ 
            utf8: form.children()[0].value,
            authenticity_token: form.children()[1].value,
            reservation: self.reservationForm })
    });

    self.submitForm = (e) =>
    {
        var form = $(e)
        self.showSpinner(true)
        $.ajax(form.attr('action'), {
            method: form.attr('method'),
            data: self.formData(),
            contentType: 'application/json'
        }).done(res => {
            $.getJSON('/reservations.json')
            .done(function(result){
                self.allReservations(
                    ko.utils.arrayMap(result, function(item){
                        return new reservation(item)
                    })
                )
            }).fail(function(jqxhr, textStatus, error){
                
            }).always(() => {
                Swal.fire({
                    title: `<p class="text-dark-scale-5">${res.title}</p>`,
                    text: `${res.text}`,
                    type: res.type
                })
            })
        }).fail((xhr, status) => {
            if(xhr.status == 406)
                Swal.fire({
                    title: `<p class="text-dark-scale-5">${xhr.responseJSON.title}</p>`,
                    text: `${xhr.responseJSON.text}`,
                    type: xhr.responseJSON.type
                })
            else
                Swal.fire({
                    text: `Unexpected error occured while adding reservation.`,
                    type: 'error'
                })
        }).always(() =>{
            self.showSpinner(false);
        })

    }

    self.deleteReservation = reservation => {
        var url = '/reservations/' + reservation.id;
    
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

                    self.allReservations.remove(reservation);
                }).fail(
                    Swal.fire({
                        title: '<p class="text-dark-scale-5">Something went wrong...</p>',
                        type: 'error'
                    })
                )
            }
        });
    }
    
    $.getJSON('/reservations.json')
    .done(function(result){
        self.allReservations(
            ko.utils.arrayMap(result, function(item){
                return new reservation(item)
            })
        )
    })
    .fail(function(jqxhr, textStatus, error){
        
    })
    .always(function(){
        self.showSpinner(false)
    })
}

ko.applyBindings(new ReservationViewModel())
