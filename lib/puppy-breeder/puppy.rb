module TheMill
  class Puppy
    attr_reader :breed, :name, :age
    
    def initialize(breed, name, age)
      @breed = breed
      @name = name
      @age = age
    end
  end
end
