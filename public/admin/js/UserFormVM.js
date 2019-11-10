var data = {
    is_myk: $('#form-myk').data('value'),
    is_yk: $('#form-yk').data('value'),
    is_drum: $('#form-drum').data('value'),
    is_workshop: $('#form-workshop').data('value')
}


function UserFormViewModel (data = {}) {
    var self = this;
    
    self.is_myk = ko.observable(data.is_myk)
    self.is_yk = ko.observable(data.is_yk)
    self.is_drum = ko.observable(data.is_drum)
    self.is_workshop = ko.observable(data.is_workshop)
    
    self.is_myk.subscribe(function(value){
        if(value)
        {
            self.is_yk(true)
            self.is_drum(true)
            self.is_workshop(true)
        }
    });
    
    self.is_yk.subscribe(function(value){
        if(!value)
        {
            self.is_myk(false)
            self.is_workshop(false)
        }
    });
    
    self.is_workshop.subscribe(function(value){
        if(value)
            self.is_yk(true)
    });
}

ko.applyBindings(new UserFormViewModel(data));