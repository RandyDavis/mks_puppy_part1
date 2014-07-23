module TheMill
  class PuppyContainer
    @container = {}
  
    def self.add_puppy(puppy)
      return "no such breed: '#{puppy.breed}'" if @container[puppy.breed].nil?

      if @container[puppy.breed][:list].empty?
        on_hold_requests = TheMill::RequestLog.log.select { |r| r.breed == puppy.breed }
        on_hold_requests.each { |r| r.activate! }
      end

      @container[puppy.breed][:list] << puppy
    end
  
    def self.create_new_breed(breed, price=1000)
      return "breed '#{breed}' already exists!" if !@container[breed].nil?
      @container[breed] = {price: price, list: []}
    end
  
    def self.set_breed_price(breed, price)
      return "no such breed: '#{breed}'" if @container[breed].nil?
      @container[breed][:price] = price
    end
  
    def self.show_puppies_by_breed(breed)
      @container[breed][:list]
    end
  
#    def self.remove_a_puppy(breed)
#      @container[breed][:list].shift
#    end
  
    def self.log
      @container
    end
  end
end 
