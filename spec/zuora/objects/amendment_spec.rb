require 'spec_helper'

describe Zuora::Objects::Amendment do
  it "supports subscription options" do
    MockResponse.responds_with(:subscription_find_success) do
      subscription = Zuora::Objects::Subscription.find('stub')
      subject.subscription = subscription
      @end_date = subscription.subscription_end_date
    end
    subject.status = "Completed"
    subject.type = "TermsAndConditions"
    subject.name = "Change Terms"
    subject.contract_effective_date = @end_date + 1.day
    subject.term_start_date = @end_date + 1.day
    subject.initial_term = 1
    subject.renewal_term = 1
    subject.amend_options = { generate_invoice: false }

    MockResponse.responds_with(:amendment_success) do
      subject.should be_valid
      subject.create.should == true
    end

    xml = Zuora::Api.instance.last_request
    xml.should have_xml("//env:Body/#{zns}:amend/#{zns}:requests/#{zns}:AmendOptions/#{zns}:GenerateInvoice").
      with_value('false')
  end
end
