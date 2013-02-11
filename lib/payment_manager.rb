class PaymentManager
 attr_reader :cim_count, :settlement_count

 def initialize params
  check_valid_attributes params
  params.has_key?(:cim_count) ? @cim_count = params[:cim_count] : @cim_count = 0
  params.has_key?(:settlement_count) ? @settlement_count = params[:settlement_count] : @settlement_count = 0
 end

private

 def check_valid_attributes options
  #raise 'Invalid cim count.' unless !options.has_key?(:cim_count) || (options.has_key?(:cim_count) && options[:cim_count].instance_of?( Fixnum ))
  raise 'Invalid cim count.' unless cim_count_is_undefined_in(options) || cim_count_is_number_in(options)
  raise 'Invalid settlement count.' unless settlement_count_is_undefined_in(options) || settlement_count_is_number_in(options)
  #raise 'Invalid amount.' unless options.has_key?(:amount) && options[:amount].instance_of?( Fixnum )
  #raise 'Invalid transaction type.' unless options.has_key?(:type) && [:auth_capture, :purchase].include?( options[:type] )
 end
 
 def cim_count_is_undefined_in options
  !options.has_key?(:cim_count)
 end
 def cim_count_is_number_in options
  (options.has_key?(:cim_count) && options[:cim_count].instance_of?( Fixnum )) ? true : false
 end
 def settlement_count_is_undefined_in options
  !options.has_key?(:settlement_count)
 end
 def settlement_count_is_number_in options
  (options.has_key?(:settlement_count) && options[:settlement_count].instance_of?( Fixnum )) ? true : false
 end

end
