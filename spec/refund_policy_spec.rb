require 'spec_helper'

describe RefundPolicy do
              
  describe "normally" do      
    before do
      cust = double('customer')
      rule = double('rule', :refundable_settlements_count => 2)
      user = double('user')
      @rp = RefundPolicy.new cust, rule, user
    end
    it "returns valid object" do
      @rp.should be_true
    end
    describe "with valid amount, authorize?" do
      it "returns true" do      
        @rp.should_receive(:is_valid_refund_amount?).with(44).and_return(true)
        @rp.authorize?(44).should == true
      end
    end                          
    describe "when payments sum less than refund amount -- has_paid_more_than_refund_amount?" do
      it "returns false" do      
        @rp.should_receive(:total_cents_of_recent_settlements).and_return(2000)
        @rp.has_paid_more_than_refund_amount?(44).should == false
      end
    end
    describe "when payments sum greater than refund amount -- has_paid_more_than_refund_amount?" do
      it "returns true" do      
        @rp.should_receive(:total_cents_of_recent_settlements).and_return(5000)
        @rp.has_paid_more_than_refund_amount?(44).should == true
      end
    end                          
      
    describe "total_cents_of_recent_settlements" do
      it "returns sum of made payments" do
        @rp.should_receive(:refund_against_settlement_transactions).and_return([double(:amount => 5), double(:amount => 5), double(:amount => 5)])
        @rp.total_cents_of_recent_settlements.should == 15
      end
    end 
    describe "refund_against_settlement_transactions" do
      it "returns made payments which refunds can be applied" do
        @rp.customer.stub_chain(:settlements, :order, :limit, :collect, :flatten).and_return('nothing')
        @rp.refund_against_settlement_transactions.should == 'nothing'
      end
    end
  end                       
  

=begin
 context "customer with $150 in 3 most recent paid settlements" do
  before do 
   @bob = FactoryGirl.create(:bob_with_settlements) 
   @joel = FactoryGirl.build(:manager_user)
   @eligible_settlements_rule = ThreeMostRecentSettlements.new
   @authorizer = RefundPolicy.new @bob, @eligible_settlements_rule, @joel
  end

  context "refund amount $75" do 
   context "against refund relevant settlements" do
    it "returns 3 proper 'purchase' settlement transactions" do
     txns = @authorizer.refund_against_settlement_transactions
     txns.length.should == 3
     txns.each do |txn|
      txn.success.should be_true
      txn.action.should == 'purchase' 
      txn.amount.should == 5000
      txn.authorization.should_not be_nil
     end
    end
   end
   context "last-three-settlements paid amount" do
    it "returns 15000 cents (aka $150)" do
     @authorizer.total_cents_of_recent_settlements.should == 15000
    end
   end
   context "has paid more in last-three-settlements?" do
    it "returns true" do
     @authorizer.has_paid_more_than_refund_amount?(75).should be_true
    end
   end
   context "authorize?" do 
    it "returns true" do
     @authorizer.authorize?(75).should be_true
    end
   end
  end

  context "refund amount $151" do 
   context "last-three-settlements paid amount" do
    it "returns 15000 cents (aka $150)" do
     @authorizer.total_cents_of_recent_settlements.should == 15000
    end
   end
   context "has paid more in last-three-settlements?" do
    it "returns false" do
     @authorizer.has_paid_more_than_refund_amount?(151).should be_false
    end
   end
   context "authorize?" do 
    it "returns false" do
     @authorizer.authorize?(151).should be_false
    end
   end
  end
 end
 context "three-most-recent-settlement policy" do
  it "should return 3 eligible settlements" do
   rp = RefundEligibilityRules::ThreeMostRecentSettlements.new
   rp.refundable_settlements_count.should == 3
  end
 end
 context "no-settlement policy" do
  it "should return 0 eligible settlements" do
   rp = RefundEligibilityRules::NoSettlements.new
   rp.refundable_settlements_count.should == 0 
  end
 end
 context "ten-most-recent-cim-and-settlement policy" do
  before { @rp = RefundEligibilityRules::TenMostRecentCimsAndSettlements.new }
  it "should return 10 eligible cims and settlements" do
   @rp.refundable_settlements_count.should == 10 
  end
  it "returns array of both cims and settlements" do
   @rp.most_recent_items.should be_instance_of(Array)
  end
 end
 context "customer who pays via autopay and one-time-payment" do
  it "xxx" do
   @al = FactoryGirl.create(:with_purchase_cim_txn_and_settlement_txn_customer) 
   display_all_records 
   puts "---> cp: #{CimProfile.count}" 
   puts "---> ca: #{CimAccount.count}" 
   puts "---> ct: #{CimTransaction.count}" 
  end
 end
=end
end
