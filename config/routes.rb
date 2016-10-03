Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit' 

  root                                'users#new'  

  get   'signup'                  => 'users#new'

  get   'about'                   => 'staticpages#about'

  get   'contact'                 => 'staticpages#contact'

  get   'termsofservice'          => 'staticpages#termsofservice'

  get   'privacypolicy'           => 'staticpages#privacypolicy'

  get   'faq'                     => 'staticpages#faqpage'

  get   'help'                    => 'staticpages#help'

  get   'moneybackguarantee'      => 'staticpages#moneybackguarantee'

  get   'confidentialitypolicy'   => 'staticpages#confidentialitypolicy'

  get   'freepapers'              => 'papers#showfreepapers'

  get   'completepapers'          => 'papers#showcompletedpapers'

  get   'pay_fully'                => 'answers#pay_fully'

  get   'finishpayment'           => 'purchases#finishpayment'
    
#Sessions routes
  
  get      'login'       => 'sessions#new'
  
  post      'login'      => 'sessions#create'

  delete    'logout'     => 'sessions#destroy'

  #Payment routes
  #Papers
  post "/purchases/:id"   => "purchases#show" #show invoice
  post "/papershook"      => "purchases#papershook" # get the payment status

  #Orders
  post "/orders/:id"   => "orders#show" #show invoice
  post "/ordershook"   => "orders#ordershook" # get the payment status

  #Answer
  post "/answershook"      => "purchases#papershook" # get the payment status

  concern :downloadable do
    get 'download',           on: :member
    get 'downloadsample',     on: :member
    get 'downloadanswer',     on: :member
  end

  resources     :users
  resources     :password_resets,     only: [:new, :create, :edit, :update] 
  resources     :papers,              only: [:show, :new, :create, :destroy],      concerns: :downloadable
  resources     :materials,           only: [:create]   
  resources     :extras,              only: [:create],                             concerns: :downloadable              
  resources     :purchases,           only: [:create, :show]
  resources     :answers,             only: [:create],                              concerns: :downloadable
  resources     :orders,              only: [:new, :create, :destroy, :show]
  resources     :messages


end
