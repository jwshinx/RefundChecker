class PaymentManager

 attr_reader :cim_count, :settlement_count, :cim_order, :settlement_order

 def initialize params
  valid_count_check_methods_of :cim, params
  valid_count_check_methods_of :settlement, params
  check_valid_attributes params
  set_count_defaults params 
  set_order_defaults params 
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

 def set_order_defaults options 
  (options.has_key?(:cim_order) && options[:cim_order] == :asc) ? @cim_order = :asc : @cim_order = :desc 
  (options.has_key?(:settlement_order) && options[:settlement_order] == :asc) ? @settlement_order = :asc : @settlement_order = :desc 
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
