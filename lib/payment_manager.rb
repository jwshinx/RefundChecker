class PaymentManager

 attr_reader :cim_count, :settlement_count, :cim_order, :settlement_order

 def initialize params
  valid_count_check_methods_of :cim, params
  valid_count_check_methods_of :settlement, params
  check_valid_attributes params
  params.has_key?(:cim_count) ? @cim_count = params[:cim_count] : @cim_count = 0
  params.has_key?(:settlement_count) ? @settlement_count = params[:settlement_count] : @settlement_count = 0
  (params.has_key?(:cim_order) && params[:cim_order] == :asc) ? @cim_order = :asc : @cim_order = :desc 
  (params.has_key?(:settlement_order) && params[:settlement_order] == :asc) ? @settlement_order = :asc : @settlement_order = :desc 
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

 def check_valid_attributes options
  raise 'Invalid cim count.' unless cim_count_is_undefined_in(options) || cim_count_is_number_in(options)
  raise 'Invalid settlement count.' unless settlement_count_is_undefined_in(options) || settlement_count_is_number_in(options)
 end

end
