FactoryGirl.define do
 factory :cim do
  initialize_with do 
   Cim.new(:txn_date => Date.today, :amount => '50', :type => :auth_capture)
  end                                       
 end
 factory :no_date_cim, class: Cim do initialize_with do Cim.new(:amount => '50', :type => :auth_capture) end end
 factory :bad_date_cim, class: Cim do initialize_with do Cim.new(:txn_date => 'bad-date', :amount => '50', :type => :auth_capture) end end
 factory :no_amount_cim, class: Cim do initialize_with do Cim.new(:txn_date => Date.today, :type => :auth_capture) end end
 factory :bad_amount_cim, class: Cim do initialize_with do Cim.new(:txn_date => Date.today, :amount => 'bad-amount', :type => :auth_capture) end end
 factory :no_type_cim, class: Cim do initialize_with do Cim.new(:txn_date => Date.today, :amount => '50' ) end end
 factory :bad_type_cim, class: Cim do initialize_with do Cim.new(:txn_date => Date.today, :amount => '50', :type => 'bad-type' ) end end
end                                             
                                                     