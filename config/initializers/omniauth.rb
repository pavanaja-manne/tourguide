Rails.application.config.middleware.use OmniAuth::Builder do  
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
  provider :facebook, '371633809663004', '88ee21c79668407935e67b4205393568'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
end  

