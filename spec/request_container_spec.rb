require_relative '../lib/puppy-breeder.rb'
require 'pry-byebug'

describe TheMill::RequestLog do
  after(:each) do
    TheMill::RequestLog.instance_variable_set :@list, []
  end

  it "can log a request" do
    request = TheMill::Request.new(:boxer)
    TheMill::RequestLog.add_request(request)
    expect(TheMill::RequestLog.log.count).to eq(1)
  end

  context "when we have many requests" do
    before(:all) do 
      TheMill::RequestLog.log << TheMill::Request.new(:boxer)
      TheMill::RequestLog.log << TheMill::Request.new(:spaniel)
      TheMill::RequestLog.log << TheMill::Request.new(:pit)
    end

    it "will show approved requests" do
      TheMill::RequestLog.log.first.accept!
      TheMill::RequestLog.log.last.accept!
      approved_requests = TheMill::RequestLog.show_accepted_requests
      expect(approved_requests.count).to eq(2)
    end
  end

  context "when puppies are not available" do
    before(:all) do
      TheMill::RequestLog.instance_variable_set :@list, []

      TheMill::PuppyContainer.create_new_breed(:boxer)
      pup = TheMill::Puppy.new(:boxer, "Atlas", 60)
      TheMill::PuppyContainer.add_puppy(pup)
      req1 = TheMill::Request.new(:boxer)
      req2 = TheMill::Request.new(:spaniel)
      TheMill::RequestLog.add_request(req1)
      TheMill::RequestLog.add_request(req2)
    end

    it "will not show requests that are on hold" do
      pending_requests = TheMill::RequestLog.show_requests
      expect(pending_requests.count).to eq(1)
    end
  end
end
