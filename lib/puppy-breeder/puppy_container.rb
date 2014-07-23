module TheMill
  class PuppyContainer
    @container = {}
  
    def self.add_puppy(puppy)
      return "no such breed: '#{puppy.breed}'" if @container[puppy.breed].nil?
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
  
    def self.remove_a_puppy(breed)
      @container[breed][:list].shift
    end
  
    def self.my_puppies
      @container
    end
  end
end 
