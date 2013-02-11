require 'spec_helper'
#require 'world'

describe "PaymentManager" do
 #include World

 describe "normally" do
  let(:payment_manager) { FactoryGirl.build(:payment_manager) }
  it "should be valid" do
   payment_manager.should be_instance_of( PaymentManager )
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

  end
 end
end

=begin
   describe "amount" do
    describe "not provided" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:no_amount_payment_manager) 
      }.to raise_error(Exception, /Invalid amount/)
     end
    end
    describe "not number" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:bad_amount_payment_manager) 
      }.to raise_error(Exception, /Invalid amount/)
     end
    end
   end 

   describe "type" do
    describe "not provided" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:no_type_payment_manager) 
      }.to raise_error(Exception, /Invalid transaction type/)
     end
    end
    describe "not number" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:bad_type_payment_manager) 
      }.to raise_error(Exception, /Invalid transaction type/)
     end
    end
   end 

  end
 end
end
=end
