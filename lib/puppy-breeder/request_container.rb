module TheMill
  class RequestLog
    @list = []
  
    def self.log
      @list
    end
  
    def self.add_request(request)
      @list << request
    end
  
    def self.show_approved_requests
      @list.select { |r| r.approved? }
    end
  end
end
