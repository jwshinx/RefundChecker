require 'spec_helper'
#require 'world'

describe "Cim" do
 #include World

 describe "normally" do
  let(:cim) { FactoryGirl.build(:cim) }
  it "should be valid" do
   cim.should be_instance_of( Cim )
  end
  subject { cim }
  its(:txn_date) { should be_instance_of( Date ) }
  its(:amount) { should be_true }
  its(:type) { should be_true }
  
  describe "when validating" do

   describe "txn-date" do
    describe "not provided" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:no_date_cim) 
      }.to raise_error(Exception, /Invalid date/)
     end
    end
    describe "not date" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:bad_date_cim) 
      }.to raise_error(Exception, /Invalid date/)
     end
    end
   end 

   describe "amount" do
    describe "not provided" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:no_amount_cim) 
      }.to raise_error(Exception, /Invalid amount/)
     end
    end
    describe "not number" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:bad_amount_cim) 
      }.to raise_error(Exception, /Invalid amount/)
     end
    end
   end 

   describe "type" do
    describe "not provided" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:no_type_cim) 
      }.to raise_error(Exception, /Invalid transaction type/)
     end
    end
    describe "not number" do
     it "should raise exception" do
      expect { 
       s = FactoryGirl.build(:bad_type_cim) 
      }.to raise_error(Exception, /Invalid transaction type/)
     end
    end
   end 

  end
 end
end
