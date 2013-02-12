#require 'refund_eligibility_rules'

class RefundPolicy
 #include RefundEligibilityRules

 attr_reader :customer, :user
  
 def initialize customer, rule, user
  @customer = customer 
  @number_of_settlements = rule.refundable_settlements_count
  @user = user
 end

 def authorize? amount
  is_valid_refund_amount?( amount ) ? true : false
 end

 def is_valid_refund_amount? amount
  has_paid_more_than_refund_amount?( amount ) ? true : false
 end
 
 def has_paid_more_than_refund_amount? amount
  total_cents_of_recent_settlements > amount*100 ? true : false
 end

 def total_cents_of_recent_settlements 
  refund_against_settlement_transactions.inject(0) { |s, i| s += i.amount }
 end

 def refund_against_settlement_transactions
  @customer.settlements.order('created_at desc').limit(@number_of_settlements).collect{|s| s.transactions.where(:action => 'purchase', :success => true) }.flatten
 end
end
