FactoryGirl.define do
 factory :payment_manager do
  initialize_with do 
   PaymentManager.new( {:cim_count => 2, :cim_order => :most_recent, :settlement_count => 2, :settlement_order => :most_recent } )
  end
 end

 factory :no_cim_count_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_order => :most_recent, :settlement_count => 2, :settlement_order => :most_recent } )
  end
 end
 factory :bad_cim_count_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => 'bad', :cim_order => :most_recent, :settlement_count => 2, :settlement_order => :most_recent } )
  end
 end

 factory :no_settlement_count_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => 2, :cim_order => :most_recent, :settlement_order => :most_recent } )
  end
 end
 factory :bad_settlement_count_payment_manager, class: PaymentManager do
  initialize_with do 
   PaymentManager.new( {:cim_count => 2, :cim_order => :most_recent, :settlement_count => 'bad', :settlement_order => :most_recent } )
  end
 end

end
