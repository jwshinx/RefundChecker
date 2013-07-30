module RefundEligibilityRules
 
  module RetrieveCimsAndSettlements
    def initialize_other_variables options
      @customer = options[:customer]
      @since_date = options[:since_date]
      (options.has_key?(:order_by) && options[:order_by] == :created_at) ? @order_by = :created_at : @order_by = :created_at
      (options.has_key?(:order_in) && options[:order_in] == :desc) ? @order_in = :desc : @order_in = :desc
    end
    def find_recent_auth_capture_cim_transactions_of_customer
      CimTransaction
        .joins(:cim_account => {:cim_profile => :customer})
        .where("cim_transactions.created_at >= ? and cim_transactions.action = ? " +
               "and cim_transactions.success = ? and cim_transactions.authorization is not null " +
               "and customer.Name = ?",
               @since_date, 'auth_capture', true, @customer.Name)
    end
    def find_recent_purchase_settlement_transactions_of_customer
      SettlementTransaction
        .joins(:settlement => :customer)
        .where("settlement_transactions.created_at >= ? and settlement_transactions.action = ? " +
               "and settlement_transactions.success = ? and settlement_transactions.authorization is not null " +
               "and customer.Name = ?",
               @since_date, 'purchase', true, @customer.Name)
    end
    def eligible_authnet_records
      array = find_cim_transactions_by_desc_created_at + find_settlement_transactions_by_desc_created_at
      @sorted_transactions = sort_array( array, @order_in, @order_by )
    end
    def refundable_amount
      eligible_authnet_records.inject(0) { |sum, i| sum + i.amount_in_cents }
    end
  end    


  class ThreeMostRecentSettlements
    attr_reader :customer
    def initialize customer
      @customer = customer
    end
    def refundable_amount
     eligible_authnet_records.inject(0) { |sum, i| sum + i.amount_in_cents }
    end
    def eligible_authnet_records
     @customer.settlements.order('created_at desc').limit(3).collect{|s| s.transactions.where(:action => 'purchase', :success => true) }.flatten
    end
  end
      
  class NoSettlements
    attr_reader :customer
    def initialize  customer
      @customer = customer
    end
    def refundable_amount
      eligible_authnet_records.inject(0) { |sum, i| sum + i.amount_in_cents }
    end
    def eligible_authnet_records
      []
    end
  end    
    
  class LatestCimsAndSettlementsSinceDate
    include Sortable
    include RetrieveCimsAndSettlements
    
    attr_reader :customer, :since_date, :short_card_number, :order_in, :order_by, :sorted_transactions
    
    def initialize options
      check_valid_attributes options
      options.has_key?(:card_number) ? @short_card_number = options[:card_number] : @short_card_number = nil
      initialize_other_variables options
    end
    def find_cim_transactions_by_desc_created_at
      find_recent_auth_capture_cim_transactions_of_customer.order('cim_transactions.created_at desc').all
    end
    def find_settlement_transactions_by_desc_created_at
      find_recent_purchase_settlement_transactions_of_customer.order('settlement_transactions.created_at desc').all
    end
  private
    def check_valid_attributes options
      raise 'Invalid credit card number.' if options.has_key?(:card_number) && (!(options[:card_number] =~ /^\d+$/) || !(options[:card_number].length == 4))
      raise 'Invalid date.' unless options.has_key?(:since_date) && options[:since_date].instance_of?( Date )
      raise 'Invalid customer.' unless options.has_key?(:customer) && options[:customer].instance_of?( Customer )
    end
  end  

  class OneCreditCardLatestCimsAndSettlementsSinceDate
   include Sortable
   include RetrieveCimsAndSettlements

   attr_reader :customer, :since_date, :short_card_number, :order_in, :order_by, :sorted_transactions

   def initialize options, short_card_number
    check_valid_attributes options, short_card_number
    options.has_key?(:card_number) ? @short_card_number = options[:card_number] : @short_card_number = short_card_number
    initialize_other_variables options
   end
   def find_cim_transactions_by_desc_created_at
    find_cim_transactions_of_short_card_number.order('cim_transactions.created_at desc').all
   end

   def find_cim_transactions_of_short_card_number
    find_recent_auth_capture_cim_transactions_of_customer.where("cim_accounts.card_number like ?", "%#{@short_card_number}")
   end
  
   def find_settlement_transactions_by_desc_created_at
    find_settlement_transactions_of_short_card_number.order('settlement_transactions.created_at desc').all
   end
   def find_settlement_transactions_of_short_card_number
    find_recent_purchase_settlement_transactions_of_customer.where("settlements.short_card_number like ?", "%#{@short_card_number}")
   end
  private
   def check_valid_attributes options, short_card_number
    raise 'Invalid credit card number.' if short_card_number.nil? || !(short_card_number =~ /^\d+$/) || !(short_card_number.length == 4)
    raise 'Invalid credit card number.' if options.has_key?(:card_number) && (!(options[:card_number] =~ /^\d+$/) || !(options[:card_number].length == 4))
    #raise 'Invalid credit card number.' if(!options.has_key?(:card_number) || !options[:card_number] =~ /^\d+$/ || !options[:card_number].length == 4)
    raise 'Invalid date.' unless options.has_key?(:since_date) && options[:since_date].instance_of?( Date )
    raise 'Invalid customer.' unless options.has_key?(:customer) && options[:customer].instance_of?( Customer )
   end
  end
end