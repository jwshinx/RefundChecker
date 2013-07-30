require 'spec_helper'  

describe "LatestCimsAndSettlementsSinceDate" do
  describe "without proper customer" do
    it "raises 'Invalid customer' message" do   
      @cust = double('customer')
      expect {
        @rule = RefundEligibilityRules::LatestCimsAndSettlementsSinceDate.new({ :card_number => '1233', :since_date => (Date.today)-200, :customer => @cust})
      }.to raise_error('Invalid customer.') 
    end                         
  end
  describe "without proper since-date" do
    it "raises 'Invalid date' message" do   
      @cust = Customer.new
      expect {
        @rule = RefundEligibilityRules::LatestCimsAndSettlementsSinceDate.new({ :card_number => '1233', :since_date => 'xxx', :customer => @cust})
      }.to raise_error('Invalid date.') 
    end                         
  end
  describe "without proper 4-digit credit card number" do
    it "raises 'Invalid credit card number' message" do   
      @cust = Customer.new
      expect {
        @rule = RefundEligibilityRules::LatestCimsAndSettlementsSinceDate.new({ :card_number => 'xxxx', :since_date => Date.today, :customer => @cust})
      }.to raise_error('Invalid credit card number.') 
    end                         
  end             
           
  describe "when retrieving customer's refund-eligible transactions" do
    before do
      @cust = Customer.new 
      @rule = RefundEligibilityRules::LatestCimsAndSettlementsSinceDate.new({ :card_number => '1111', :since_date => Date.today, :customer => @cust})
    end
    describe "of cims" do 
      it "returns array of transactions -- successful, most-recent, since-date" do 
        @rule.stub_chain(:find_recent_auth_capture_cim_transactions_of_customer, :order, :all).and_return([])      
        @rule.find_cim_transactions_by_desc_created_at.should be_instance_of Array
      end
    end 
    describe "of settlements" do 
      it "returns array of transactions -- successful, most-recent, since-date" do 
        @rule.stub_chain(:find_recent_purchase_settlement_transactions_of_customer, :order, :all).and_return([])      
        @rule.find_settlement_transactions_by_desc_created_at.should be_instance_of Array
      end 
    end
  end
  describe "when retrieving eligible authnet records" do
    it "returns array sorted by created date" do  
      @rule = RefundEligibilityRules::LatestCimsAndSettlementsSinceDate.new({ :card_number => '1111', :since_date => Date.today, :customer => Customer.new})
      @rule.should_receive(:find_cim_transactions_by_desc_created_at).and_return([])
      @rule.should_receive(:find_settlement_transactions_by_desc_created_at).and_return([])
      @rule.should_receive(:sort_array).and_return([])
      @rule.eligible_authnet_records.should be_instance_of Array
    end
  end  
  describe "when determining total refundable amount" do
    it "returns array sorted by created date" do
      @rule = RefundEligibilityRules::LatestCimsAndSettlementsSinceDate.new({ :card_number => '1111', :since_date => Date.today, :customer => Customer.new})
      @rule.stub_chain(:eligible_authnet_records, :inject).and_return(100)
      @rule.refundable_amount.should == 100
    end
  end  
end
