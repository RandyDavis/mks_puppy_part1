require_relative '../lib/puppy-breeder.rb'
require 'pry-byebug'

describe TheMill::PuppyContainer do
  after(:each) do
    TheMill::PuppyContainer.instance_variable_set :@container, {}
  end

  it "can show the entire puppy container" do
    expect(TheMill::PuppyContainer.log).to be_a(Hash)
  end

  it "can add a new breed" do
    expect(TheMill::PuppyContainer.log[:boxer]).to be_nil
    TheMill::PuppyContainer.create_new_breed(:boxer)
    expect(TheMill::PuppyContainer.log[:boxer]).to_not be_nil
  end

  it "will give a breed a default price" do
    TheMill::PuppyContainer.create_new_breed(:boxer)
    expect(TheMill::PuppyContainer.log[:boxer][:price]).to_not be_nil
  end

  it "can set a breed price" do
    TheMill::PuppyContainer.create_new_breed(:boxer)
    TheMill::PuppyContainer.set_breed_price(:boxer, 5000)
    expect(TheMill::PuppyContainer.log[:boxer][:price]).to eq(5000)
  end
  
  it "can add a new puppy" do
    pup = TheMill::Puppy.new(:boxer, "Atlas", 60)
    TheMill::PuppyContainer.create_new_breed(:boxer)
    TheMill::PuppyContainer.add_puppy(pup)
    list_pup = TheMill::PuppyContainer.log[:boxer][:list].first
    expect(list_pup).to eq(pup)
  end

  context "when we have many puppies" do
    before(:all) do
      TheMill::PuppyContainer.create_new_breed(:boxer)
      TheMill::PuppyContainer.create_new_breed(:pit)
      3.times { TheMill::PuppyContainer.add_puppy(TheMill::Puppy.new(:boxer, "x", 0)) }
      2.times { TheMill::PuppyContainer.add_puppy(TheMill::Puppy.new(:pit, "y", 1)) }
    end

    it "can retrieve a list of puppies by breed" do
      boxers = TheMill::PuppyContainer.show_puppies_by_breed(:boxer)
      pits = TheMill::PuppyContainer.show_puppies_by_breed(:pit)
      expect(boxers.count).to eq(3)
      expect(pits.count).to eq(2)
    end
  end
end
