require 'spec_helper'  

describe "NoSettlements" do
  describe "normally" do
    before do
      @cust = double('customer')
      @rule = RefundEligibilityRules::NoSettlements.new @cust
    end      
    it "returns customer" do
      @rule.customer.should == @cust
    end                         
    it "returns array of eligible authnet records -- most recent 3, successful 'purchase' transactions" do
      @cust.stub_chain(:settlements, :order, :limit, :collect, :flatten).and_return([])
      @rule.eligible_authnet_records.should be_instance_of Array
    end                                                                  
    it "returns refundable amount -- comprised of sum aforementioned transactions" do       
      @rule.should_receive(:eligible_authnet_records).and_return([double(amount_in_cents: 10), double(amount_in_cents: 10), double(amount_in_cents: 10)])
      @rule.refundable_amount.should == 30
    end
  end
end
