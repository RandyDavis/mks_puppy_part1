module TheMill
  class Request
    attr_reader :breed
  
    def initialize(breed)
      @breed = breed
      @status = :pending
    end

    def activate!
      @status = :pending
    end

    def pending?
      @status == :pending
    end
  
    def accept!
      @status = :accepted
    end

    def accepted?
      @status == :accepted
    end

    def hold!
      @status = :on_hold
    end

    def on_hold?
      @status == :on_hold
    end
  end
end
