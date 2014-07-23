module TheMill
  class RequestLog
    @list = []
  
    def self.log
      @list
    end
  
    def self.add_request(request)
      puppy_log = TheMill::PuppyContainer.log

      if !puppy_log.has_key?(request.breed)
        request.hold!
      elsif puppy_log[request.breed][:list].empty?
        request.hold!
      end

      @list << request
    end
  
    def self.show_requests
      @list.select { |r| r.pending? }
    end

    def self.show_accepted_requests
      @list.select { |r| r.accepted? }
    end
  end
end
