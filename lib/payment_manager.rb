require 'sortable'

class PaymentManager
 include Sortable

 attr_reader :cim_count, :settlement_count, :order_in, :order_by, :sorted_transactions

 def initialize params
  @sorted_transactions = []
  @transactions = []
  valid_count_check_methods_of :cim, params
  valid_count_check_methods_of :settlement, params
  check_valid_attributes params
  set_defaults params
  
  cim_count.times do |i|
   object = new_object(:cim, {:txn_date => Date.today-i, :type => :purchase, :amount => 49 })
   @transactions << object 
  end
  settlement_count.times do |i|
   object = new_object(:settlement, {:txn_date => Date.today-i, :type => :auth_capture, :amount => 50 })
   @transactions << object 
  end
  @sorted_transactions = sort_array( @transactions, order_in, order_by )
 end

 def new_object(type, name)
  if type == :cim
   Cim.new(name)
  elsif type == :settlement
   Settlement.new(name)
  else
   raise "Unknown organism type: #{type}"
  end
 end

 def valid_count_check_methods_of attribute, arg
  self.class.send(:define_method, "#{attribute}_count_is_undefined_in") do |options|
   !options.has_key?("#{attribute}_count".to_sym)
  end
  self.class.send(:define_method, "#{attribute}_count_is_number_in") do |options|
   (options.has_key?("#{attribute}_count".to_sym) && options["#{attribute}_count".to_sym].instance_of?( Fixnum )) ? true : false
  end
 end

private

 def set_defaults options
  set_count_defaults options 
  set_order_defaults options 
 end
 def set_order_defaults options 
  (options.has_key?(:order_in) && options[:order_in] == :asc) ? @order_in = :asc : @order_in = :desc 
  (options.has_key?(:order_by) && options[:order_by] == :txn_date) ? @order_by = :txn_date : @order_by = :txn_date
 end
 def set_count_defaults options
  options.has_key?(:cim_count) ? @cim_count = options[:cim_count] : @cim_count = 0
  options.has_key?(:settlement_count) ? @settlement_count = options[:settlement_count] : @settlement_count = 0
 end
 def check_valid_attributes options
  raise 'Invalid cim count.' unless cim_count_is_undefined_in(options) || cim_count_is_number_in(options)
  raise 'Invalid settlement count.' unless settlement_count_is_undefined_in(options) || settlement_count_is_number_in(options)
 end

end
