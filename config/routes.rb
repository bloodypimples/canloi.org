Rails.application.routes.draw do
  resources :posts

  root 'posts#index'

  constraints(host: /^www\.(?!cute\.)/i) do

    match '(*any)', via: :all, to: redirect { |params, request|

      # parse the current request url
      # tap in and remove www.
      URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s

    }

  end
end
