# frozen_string_literal: true

require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Tipalti < OmniAuth::Strategies::OAuth2
      option :name, "tipalti"

      option :client_options,
             site: "https://sso.tipalti.com",
             authorize_url: "/connect/authorize/callback",
             token_url: "/connect/token"

      option :pkce, true

      uid { nil }

      info do
        {}
      end

      extra do
        { "raw_info" => raw_info }
      end

      def callback_url
        options[:redirect_uri] || (full_host + callback_path)
      end

      def raw_info
        @raw_info ||= {}
      end
    end
  end
end

OmniAuth.config.add_camelization "tipalti", "Tipalti"
