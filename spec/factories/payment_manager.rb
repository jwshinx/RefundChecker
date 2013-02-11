FactoryGirl.define do
 factory :payment_manager do
  initialize_with do 
   PaymentManager.new( {:cim_count => 2, :cim_order => :desc, :settlement_count => 2, :settlement_order => :asc } )
  end
 end

 factory :no_cim_count_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_order => :desc, :settlement_count => 2, :settlement_order => :desc } )
  end
 end
 factory :bad_cim_count_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => 'bad', :cim_order => :desc, :settlement_count => 2, :settlement_order => :desc } )
  end
 end

 factory :no_settlement_count_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => 2, :cim_order => :desc, :settlement_order => :desc } )
  end
 end
 factory :bad_settlement_count_payment_manager, class: PaymentManager do
  initialize_with do 
   PaymentManager.new( {:cim_count => 2, :cim_order => :desc, :settlement_count => 'bad', :settlement_order => :desc } )
  end
 end

 factory :no_cim_order_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => 2, :settlement_order => 2, :settlement_order => :desc } )
  end
 end
 factory :bad_cim_order_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => 2, :cim_order => 'bad', :settlement_count => 2, :settlement_order => :desc } )
  end
 end

 factory :no_settlement_order_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => 2, :cim_order => :desc, :settlement_count => 2 } )
  end
 end
 factory :bad_settlement_order_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :settlement_count => 2, :settlement_order => 'bad', :cim_count => 2, :cim_order => :desc } )
  end
 end

end
