require 'spec_helper'
#require 'world'

describe "Settlement" do
 #include World

 describe "normally" do
  let(:settlement) { FactoryGirl.build(:settlement) }
  it "should be valid" do
   settlement.should be_instance_of( Settlement )
  end
  subject { settlement }
  its(:txn_date) { should be_instance_of( Date ) }
  its(:amount) { should be_true }
  its(:type) { should be_true }

  describe "when initializing" do

   describe "txn-date" do
    describe "not provided" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:no_date_settlement) 
      }.to raise_error(Exception, /Invalid date/)
     end
    end
    describe "not date" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:bad_date_settlement) 
      }.to raise_error(Exception, /Invalid date/)
     end
    end
   end 

   describe "amount" do
    describe "not provided" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:no_amount_settlement) 
      }.to raise_error(Exception, /Invalid amount/)
     end
    end
    describe "not number" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:bad_amount_settlement) 
      }.to raise_error(Exception, /Invalid amount/)
     end
    end
   end 

   describe "type" do
    describe "not provided" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:no_type_settlement) 
      }.to raise_error(Exception, /Invalid transaction type/)
     end
    end
    describe "not number" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:bad_type_settlement) 
      }.to raise_error(Exception, /Invalid transaction type/)
     end
    end
   end 

  end
 end
end
