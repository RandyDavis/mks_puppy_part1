require_relative '../puppy-breeder.rb'
require 'pry-byebug'

describe Puppy do
  let(:test_pup) { Puppy.new(:boxer, "Atlas", 60) }

  it "has a breed" do
    expect(test_pup.breed).to eq(:boxer)
  end

  it "has a name" do
    expect(test_pup.name).to eq("Atlas")
  end

  it "has an age" do
    expect(test_pup.age).to eq(60)
  end
end

describe Request do
  let(:test_request) { Request.new(:boxer) }
  
  it "has a breed" do
    expect(test_request.breed).to eq(:boxer)
  end

  it "is not approved by default" do
    expect(test_request.approved?).to be false
  end

  it "can be approved" do
    test_request.approve!
    expect(test_request.approved?).to be true
  end
end

describe PuppyContainer do
  after(:each) do
    PuppyContainer.instance_variable_set :@container, {}
  end

  it "can show the entire puppy container" do
    expect(PuppyContainer.my_puppies).to be_a(Hash)
  end

  it "can add a new breed" do
    expect(PuppyContainer.my_puppies[:boxer]).to be_nil
    PuppyContainer.create_new_breed(:boxer)
    expect(PuppyContainer.my_puppies[:boxer]).to_not be_nil
  end

  it "will give a breed a default price" do
    PuppyContainer.create_new_breed(:boxer)
    expect(PuppyContainer.my_puppies[:boxer][:price]).to_not be_nil
  end

  it "can set a breed price" do
    PuppyContainer.create_new_breed(:boxer)
    PuppyContainer.set_breed_price(:boxer, 5000)
    expect(PuppyContainer.my_puppies[:boxer][:price]).to eq(5000)
  end
  
  it "can add a new puppy" do
    pup = Puppy.new(:boxer, "Atlas", 60)
    PuppyContainer.create_new_breed(:boxer)
    PuppyContainer.add_puppy(pup)
    list_pup = PuppyContainer.my_puppies[:boxer][:list].first
    expect(list_pup).to eq(pup)
  end

  context "when we have many puppies" do
    before(:all) do
      PuppyContainer.create_new_breed(:boxer)
      PuppyContainer.create_new_breed(:pit)
      3.times { PuppyContainer.add_puppy(Puppy.new(:boxer, "x", 0)) }
      2.times { PuppyContainer.add_puppy(Puppy.new(:pit, "y", 1)) }
    end

    it "can retrieve a list of puppies by breed" do
      boxers = PuppyContainer.show_puppies_by_breed(:boxer)
      pits = PuppyContainer.show_puppies_by_breed(:pit)
      expect(boxers.count).to eq(3)
      expect(pits.count).to eq(2)
    end
  end
end


describe RequestLog do
  after(:each) do
    RequestLog.instance_variable_set :@list, []
  end

  it "can log a request" do
    request = Request.new(:boxer)
    RequestLog.add_request(request)
    expect(RequestLog.log.count).to eq(1)
  end

  context "when we have many requests" do
    before(:all) do 
      RequestLog.log << Request.new(:boxer)
      RequestLog.log << Request.new(:spaniel)
      RequestLog.log << Request.new(:pit)
    end

    it "will show approved requests" do
      RequestLog.log.first.approve!
      RequestLog.log.last.approve!
      approved_requests = RequestLog.show_approved_requests
      expect(approved_requests.count).to eq(2)
    end
  end
end
