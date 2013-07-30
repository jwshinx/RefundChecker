FactoryGirl.define do
 factory :payment_manager do
  initialize_with do 
   PaymentManager.new( {:cim_count => '2', :order_in => :desc, :settlement_count => '2', :order_by => :txn_date } )
  end
 end

 factory :no_cim_count_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :order_in => :desc, :settlement_count => '2', :order_by => :txn_date } )
  end
 end
 factory :bad_cim_count_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => 'bad', :order_in => :desc, :settlement_count => '2', :order_by => :txn_date } )
  end
 end

 factory :no_settlement_count_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => '2', :order_in => :desc, :order_by => :txn_date } )
  end
 end
 factory :bad_settlement_count_payment_manager, class: PaymentManager do
  initialize_with do 
   PaymentManager.new( {:cim_count => '2', :order_in => :desc, :settlement_count => 'bad', :order_by => :txn_date } )
  end
 end

 factory :no_order_by_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => '2', :settlement_order => '2', :order_in => :desc } )
  end
 end
 factory :bad_order_by_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => '2', :order_by => 'bad', :settlement_count => '2', :order_in => :desc } )
  end
 end

 factory :no_order_in_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :cim_count => '2', :order_by => :txn_date, :settlement_count => '2' } )
  end
 end
 factory :bad_order_in_payment_manager, class: PaymentManager do 
  initialize_with do 
   PaymentManager.new( { :settlement_count => '2', :order_by => :txn_date, :cim_count => '2', :order_in => 'bad' } )
  end
 end

end
