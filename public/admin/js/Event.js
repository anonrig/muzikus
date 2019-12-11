var start = moment();
	start.set('second', 0);
    $('#event_starts_at').bootstrapMaterialDatePicker({
		format: 'ddd, DD MMM - HH:mm',
        weekStart: 1,
        minDate: start
	});

var editor;
    InlineEditor.create(document.querySelector( '#editor' ), {
            toolbar: ['heading', 'bold', 'italic', 'link', 'blockQuote', '|', 'numberedList', 'bulletedList', '|', 'undo', 'redo']
        })
        .then(newEditor => {
            editor = newEditor;
        })
        .catch(error => {
            console.error( error );
        });
$(function(){
    ko.bindingHandlers.ckeditor = {
        init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
            var modelValue = valueAccessor();
            
            editor.model.document.on( 'change:data', () => {
                modelValue(editor.getData());
            });
        }
    }

    ko.bindingHandlers.timePicker = {
        init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
            var modelValue = valueAccessor();
            $(element).on('change', function(e, date){
                modelValue(date._d)
            })
        },
        update:function(element, valueAccessor, allBindings, viewModel, bindingContext){
            var modelValue = valueAccessor()
            modelValue(start._d)
        }
    }
    
    function EventViewModel(){
        var self = this;
    
        this.title = ko.observable();
        this.location = ko.observable();
        this.starts_at = ko.observable();
        this.details = ko.observable(editor.getData());
        this.picture = ko.observable();
    
        this.Title = ko.computed(function () { return self.title() == null || self.title() == '' ? 'Event Title' : self.title() } )
        this.Location = ko.computed(function () { return self.location() == null || self.location() == '' ? 'Location' : self.location() } )
        this.StartsAt = ko.computed(function () { return self.starts_at() == null || self.starts_at() == '' ? 'Start Time' : moment(self.starts_at()).fromNow() } )
        this.Info = ko.computed(function() { return self.Location() + " | " + self.StartsAt() } )
        this.Details = ko.computed(function () { return self.details() == null || self.details() == '' || self.details() == '<p>&nbsp;</p>' ? 'Details....' : self.details() } )
    
    }
    
    
    ko.applyBindings(new EventViewModel())
});