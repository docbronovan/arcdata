require 'spec_helper'

describe Incidents::IncidentCreated do
  before(:each) do
    @incident = FactoryGirl.create :incident
    @person = FactoryGirl.create :person
  end

  it "should notify someone subscribed to new_incident" do
    Incidents::NotificationSubscription.create! person: @person, county: @incident.county, notification_type: 'new_incident'

    Incidents::IncidentsMailer.should_receive(:new_incident).with(@incident, @person).and_return(stub :deliver => true)

    Incidents::IncidentCreated.new(@incident).save
  end
end