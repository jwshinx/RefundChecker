require 'spec_helper'
#require 'world'

describe "PaymentManager" do
 #include World

 describe "normally" do
  let(:payment_manager) { FactoryGirl.build(:payment_manager) }
  it "should be valid" do
   payment_manager.should be_instance_of( PaymentManager )
  end
  describe "settlement_count" do
   it "should be 2" do
    payment_manager.settlement_count.should == 2
   end
  end
  describe "cim_count" do
   it "should be 2" do
    payment_manager.cim_count.should == 2
   end
  end
  describe "order in" do
   it "should be desc" do
    payment_manager.order_in.should == :desc 
   end
  end
  describe "order by attribute" do
   it "should be *txn date*" do
    payment_manager.order_by.should == :txn_date
   end
  end 
  describe "the cim_count" do
    it "is affirmed that it's not defined" do 
      pm = FactoryGirl.build(:payment_manager)
      pm.cim_count_is_undefined_in({}).should be_true      
    end
    it "is affirmed that it is defined" do 
      pm = FactoryGirl.build(:payment_manager)
      pm.cim_count_is_undefined_in({:cim_count => 44}).should be_false      
    end
  end
  describe "the cim_count" do
    it "is affirmed that it's not defined" do 
      pm = FactoryGirl.build(:payment_manager)
      pm.cim_count_is_number_in({}).should be_false      
    end
    it "is affirmed that it is defined" do 
      pm = FactoryGirl.build(:payment_manager)
      pm.cim_count_is_number_in({:cim_count => 44}).should be_false      
    end
  end


  describe "when validating" do

   describe "cim-count" do
    describe "not provided" do
     it "should default to 0" do
      pm = FactoryGirl.build(:no_cim_count_payment_manager) 
      pm.cim_count.should == 0 
     end
    end
    describe "not number" do
     it "should raise exception" do
      expect { 
       pm = FactoryGirl.build(:bad_cim_count_payment_manager) 
      }.to raise_error(Exception, /Invalid cim count/)
     end
    end
   end

   describe "order in" do
    describe "not valid" do
     it "should default to *desc*" do
      pm = FactoryGirl.build(:bad_order_in_payment_manager) 
      pm.order_in.should == :desc
     end
    end
    describe "not provided" do
     it "should default to *desc*" do
      pm = FactoryGirl.build(:no_order_in_payment_manager) 
      pm.order_in.should == :desc
     end
    end
   end

   describe "settlement-count" do
    describe "not provided" do
     it "should default to 0" do
      pm = FactoryGirl.build(:no_settlement_count_payment_manager) 
      pm.settlement_count.should == 0 
     end
    end
    describe "not number" do
     it "should raise exception" do
      expect { 
       pm = FactoryGirl.build(:bad_settlement_count_payment_manager) 
      }.to raise_error(Exception, /Invalid settlement count/)
     end
    end
   end 

   describe "order by" do
    describe "not valid" do
     it "should default to *txn date*" do
      pm = FactoryGirl.build(:bad_order_by_payment_manager) 
      pm.order_by.should == :txn_date
     end
    end
    describe "not provided" do
     it "should default to *txn date*" do
      pm = FactoryGirl.build(:no_order_by_payment_manager) 
      pm.order_by.should == :txn_date
     end
    end
   end

  end
  describe "sorted cims and settlements" do
   let(:payment_manager) { FactoryGirl.build(:payment_manager) }
   it "should be saved in an array" do
    payment_manager.sorted_transactions.should be_instance_of( Array )
   end
   it "should be sorted with most recent txn-date first" do
    sorted_txns = payment_manager.sorted_transactions
    sorted_txns.length.should == 4        
    sorted_txns.map{|t|t.txn_date}.should == sorted_txns.sort_by{ |a| a.txn_date }.reverse.map{|t| t.txn_date}
   end
  end
 end
end
