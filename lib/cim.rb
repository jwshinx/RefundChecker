class Cim 
 attr_reader :txn_date, :type, :amount

 def initialize params
  check_valid_attributes params
  @txn_date = params[:txn_date]
  @amount = params[:amount]
  @type = params[:type]
 end
 
private

 def check_valid_attributes options
  raise 'Invalid date.' unless options.has_key?(:txn_date) && options[:txn_date].instance_of?( Date ) 
  raise 'Invalid amount.' unless options.has_key?(:amount) && options[:amount] =~ /^\$?(?=\(.*\)|[^()]*$)\(?\d{1,3}(,?\d{3})?(\.\d\d?)?\)?$/ #currency
  raise 'Invalid transaction type.' unless options.has_key?(:type) && [:auth_capture, :purchase].include?( options[:type] )
 end
end
