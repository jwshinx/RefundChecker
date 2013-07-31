Half-baked basic module for handling Authorize.net (AN) refund processing. It 
needs to handle AN restrictions: made-payment must exist; must be within x-days 
of payment date, last 4-digits of corresponding credit card must be provided.

Other business process requirements exist: recurring vs. one-time payment; 
internal refund policy (e.g. amount limits, eligible date window, etc.);
known 4-digit credit card number.
