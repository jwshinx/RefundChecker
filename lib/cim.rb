class Cim 

 def initialize params
  check_valid_attributes params
  @txn_date = params[:txn_date]
  @amount = params[:amount]
  @type = params[:type]
 end
 
private

 def check_valid_attributes options
  raise 'Invalid date.' unless options.has_key?(:txn_date) && options[:txn_date].instance_of?( Date ) 
  raise 'Invalid amount.' unless options.has_key?(:amount) && options[:amount].instance_of?( Fixnum ) 
  raise 'Invalid transaction type.' unless options.has_key?(:type) && [:auth_capture, :purchase].include?( options[:type] )
 end
end
