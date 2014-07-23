require 'pry-byebug'

class Puppy
  attr_reader :breed, :name, :age
  
  def initialize(breed, name, age)
    @breed = breed
    @name = name
    @age = age
  end
end

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
