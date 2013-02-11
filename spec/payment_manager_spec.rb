require 'spec_helper'
#require 'world'

describe "PaymentManager" do
 #include World

 describe "normally" do
  let(:payment_manager) { FactoryGirl.build(:payment_manager) }
  it "should be valid" do
   payment_manager.should be_instance_of( PaymentManager )
  end
  it "should do my-method" do
   payment_manager.my_method('joel').should =~ /hello, joel/
  end
  describe "settlement_count" do
   it "should be 2" do
    payment_manager.cim_count.should == 2
   end
  end
  describe "cim_count" do
   it "should be 2" do
    payment_manager.cim_count.should == 2
   end
  end
  describe "cim_order" do
   it "should be desc" do
    payment_manager.cim_order.should == :desc 
   end
  end
  describe "settlement_order" do
   it "should be desc" do
    payment_manager.settlement_order.should == :asc 
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

   describe "cim-order" do
    describe "not valid" do
     it "should default to *desc*" do
      pm = FactoryGirl.build(:bad_cim_order_payment_manager) 
      pm.cim_order.should == :desc
     end
    end
    describe "not provided" do
     it "should default to *desc*" do
      pm = FactoryGirl.build(:no_cim_order_payment_manager) 
      pm.cim_order.should == :desc
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

   describe "settlement-order" do
    describe "not valid" do
     it "should default to *desc*" do
      pm = FactoryGirl.build(:bad_settlement_order_payment_manager) 
      pm.settlement_order.should == :desc
     end
    end
    describe "not provided" do
     it "should default to *desc*" do
      pm = FactoryGirl.build(:no_settlement_order_payment_manager) 
      pm.settlement_order.should == :desc
     end
    end
   end

  end
 end
end
