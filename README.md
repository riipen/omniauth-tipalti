# OmniAuth Tipalti
Strategy to authenticate with Tipalti via OAuth2 in OmniAuth.

## Installation

Add to your `Gemfile`:

```ruby
gem 'omniauth-tipalti'
```

Then `bundle install`.

## Tipalti Setup

Visit the [Tipalti Developer](https://developer.tipalti.com) portal and create your developer application.

Make note of your Client ID and Client Secret.

Make sure you set your Return URL to the full path to your application.

## Usage
For additional information, refer to the [OmniAuth wiki](https://github.com/intridea/omniauth/wiki).

### Rails

#### Standard

Here's an example for adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tipalti, 
  		   ENV['TIPALTI_CLIENT_ID'], 
  		   ENV['TIPALTI_CLIENT_SECRET'],
           redirect_uri: Rails.application.routes.url_helpers.my_integration_response_url
end
```

You can now access the OmniAuth Tipalti OAuth2 URL: `/auth/tipalti`

If you are using a Tipalti sandbox applicaiton, you can optionally set the site:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tipalti, 
  		   ...
  		   client_options: {
             site: ' https://sso.sandbox.tipalti.com',
           },
           ...
end
```

#### Dynamic

If your Rails application needs to support multiple Tipalti applications, you can pass in your configuration dynamically:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  TIPALTI_SETUP_PROC = lambda do |env|
    request = Rack::Request.new(env)

    # Load dynamic content into dynamic_content

    env['omniauth.strategy'].options[:client_id]     = dynamic_content.client_id
    env['omniauth.strategy'].options[:client_secret] = dynamic_content.client_secret
  end

  provider :tipalti,
           redirect_uri: Rails.application.routes.url_helpers.my_integration_response_url
           setup: TIPALTI_SETUP_PROC
end
```

## Configuration

You can configure several options, which you pass in to the `provider` method via a hash:

* `scope`: A space-separated list of permissions you want to request from the user.

* `redirect_uri`: Override the redirect_uri used by the gem. Note this must match exactly what you specified in the WhoPlusYou Developer Portal in your Client Domains setting.


## License

Copyright (C) 2023 Jordan Ell. See [LICENSE](https://github.com/riipen/omniauth-tipalti/blob/master/LICENSE.md) for details.
