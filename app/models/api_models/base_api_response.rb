class ApiModels::BaseApiResponse
    @hasError
    @message
    @data
    def setMessage message
        @hasError = true
        @message = message
    end

    def initialize
        self.hasError = false
        self.message = "" 
        self.data = nil
    end

    attr_accessor :hasError, :message, :data
end