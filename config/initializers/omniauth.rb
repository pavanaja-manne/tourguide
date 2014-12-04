Rails.application.config.middleware.use OmniAuth::Builder do  
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
  provider :facebook, '379963175440496', 'c5b09d4d2189e1c3691c80ba9ee45f9e'
  #provider :facebook, '371633809663004', '88ee21c79668407935e67b4205393568'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
end  

