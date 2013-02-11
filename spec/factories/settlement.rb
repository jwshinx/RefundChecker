FactoryGirl.define do
 factory :settlement do
  initialize_with do 
   Settlement.new(:txn_date => Date.today, :amount => 50, :type => :auth_capture)
  end
 end
 factory :no_date_settlement, class: Settlement do initialize_with do Settlement.new(:amount => 50, :type => :auth_capture) end end
 factory :bad_date_settlement, class: Settlement do initialize_with do Settlement.new(:txn_date => 'bad-date', :amount => 50, :type => :auth_capture) end end
 factory :no_amount_settlement, class: Settlement do initialize_with do Settlement.new(:txn_date => Date.today, :type => :auth_capture) end end
 factory :bad_amount_settlement, class: Settlement do initialize_with do Settlement.new(:txn_date => Date.today, :amount => 'bad-amount', :type => :auth_capture) end end
 factory :no_type_settlement, class: Settlement do initialize_with do Settlement.new(:txn_date => Date.today, :amount => 50 ) end end
 factory :bad_type_settlement, class: Settlement do initialize_with do Settlement.new(:txn_date => Date.today, :amount => 50, :type => 'bad-type' ) end end
end
