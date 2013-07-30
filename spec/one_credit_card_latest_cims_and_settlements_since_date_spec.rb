require 'spec_helper'  

describe "OneCreditCardLatestCimsAndSettlementsSinceDate" do
  before do
    @cust = Customer.new 
    @options = {:card_number => '1234', :since_date => Date.today, :customer => @cust}     
    @short_card_number = '1234'
  end

  describe "normally" do  
    subject { RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number) } 
    specify { subject.should be_true }
    its(:customer) { should be_instance_of Customer } 
    its(:since_date) { should be_instance_of Date } 

    its(:short_card_number) { should == '1234' } 
    its(:order_in) { should == :desc  } 
    its(:order_by) { should == :created_at  } 
  end
  describe "when retrieving customer's refund-eligible transactions" do
    describe "of cims" do 
      it "returns array of transactions -- successful, most-recent, since-date" do
        @rule = RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number)
        @rule.stub_chain(:find_cim_transactions_of_short_card_number, :order, :all).and_return([])      
        @rule.find_cim_transactions_by_desc_created_at.should be_instance_of Array
      end
    end 
    describe "of settlements" do 
      it "returns array of transactions -- successful, most-recent, since-date" do
        @rule = RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number)
        @rule.stub_chain(:find_settlement_transactions_of_short_card_number, :order, :all).and_return([])      
        @rule.find_settlement_transactions_by_desc_created_at.should be_instance_of Array                                
      end 
    end
  end                                   

  describe "when retrieving customer's 4-digit card number transactions" do                                                                                                            
    describe "of cims" do                                                                                                            
      it "returns array of payment transactions of customer with same 4-digit card number" do
        @rule = RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number)
        @rule.stub_chain(:find_recent_auth_capture_cim_transactions_of_customer, :where).and_return([])      
        @rule.find_cim_transactions_of_short_card_number.should be_instance_of Array                                
      end                      
    end
    describe "of settlements" do                                                                                                            
      it "returns array of transactions with same 4-digit card number" do
        @rule = RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number)
        @rule.stub_chain(:find_recent_purchase_settlement_transactions_of_customer, :where).and_return([])      
        @rule.find_settlement_transactions_of_short_card_number.should be_instance_of Array                                
      end 
    end
  end
  describe "when retrieving eligible authnet records" do
    it "returns array sorted by created date" do
      @rule = RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number)
      @rule.should_receive(:find_cim_transactions_by_desc_created_at).and_return([])
      @rule.should_receive(:find_settlement_transactions_by_desc_created_at).and_return([])
      @rule.should_receive(:sort_array).and_return([])
      @rule.eligible_authnet_records.should be_instance_of Array
    end
  end  
  describe "when determining total refundable amount" do
    it "returns array sorted by created date" do
      @rule = RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number)
      @rule.stub_chain(:eligible_authnet_records, :inject).and_return(100)
      @rule.refundable_amount.should == 100
    end
  end  
  
  describe "when provided invalid input" do
    describe "customer" do     
      it "returns 'Invalid credit card number.'" do                                                        
        @options[:customer] = nil
        expect {
         RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number)
        }.to raise_error('Invalid customer.')
      end
    end                    
    describe "card number" do     
      it "returns 'Invalid credit card number.'" do                                                        
        @options[:card_number] = nil
        expect {
         RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number)
        }.to raise_error('Invalid credit card number.')
      end
    end                               
    describe "short card number" do     
      it "returns 'Invalid credit card number.'" do                                                        
        @short_card_number = nil
        expect {
         RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number)
        }.to raise_error('Invalid credit card number.')
      end
    end    
    describe "since date" do     
      it "returns 'Invalid credit card number.'" do                                                        
        @options[:since_date] = nil
        expect {
         RefundEligibilityRules::OneCreditCardLatestCimsAndSettlementsSinceDate.new(@options, @short_card_number)
        }.to raise_error('Invalid date.')
      end
    end                     
  end
end
