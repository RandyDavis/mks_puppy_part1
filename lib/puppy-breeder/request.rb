module TheMill
  class Request
    attr_reader :breed
  
    def initialize(breed)
      @breed = breed
      @approve = false
    end
  
    def approve!
      @approve = true
      PuppyContainer.remove_a_puppy
    end
  
    def approved?
      @approve
    end
  end
end
