# frozen_string_literal: true

require "spec_helper"

describe OmniAuth::Strategies::Tipalti do
  subject(:strategy) do
    described_class.new(app, "id", "secret", @options || {}).tap do |strategy|
      allow(strategy).to receive(:request).and_return(request)
    end
  end

  let(:app) do
    lambda do
      [200, {}, ["Hello."]]
    end
  end

  let(:request) { double("Request", params: {}, cookies: {}, env: {}) }

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe "#client_options" do
    it "has correct site" do
      expect(strategy.options.client_options.site).to eq("https://sso.tipalti.com")
    end

    it "has correct authorize_url" do
      expect(strategy.options.client_options.authorize_url).to eq("/connect/authorize/callback")
    end

    it "has correct token_url" do
      expect(strategy.options.client_options.token_url).to eq("/connect/token")
    end
  end

  describe "#callback_url" do
    let(:base_url) { "https://example.com" }

    it "has the correct default callback path" do
      allow(strategy).to receive(:full_host) { base_url }

      expect(strategy.send(:callback_url)).to eq("#{base_url}/auth/tipalti/callback")
    end

    it "sets the callback_path parameter if present" do
      @options = { callback_path: "/auth/foo/callback" }

      allow(strategy).to receive(:full_host) { base_url }

      expect(strategy.send(:callback_url)).to eq("#{base_url}/auth/foo/callback")
    end

    it "uses the redirect_uri parameter if present" do
      @options = { redirect_uri: "https://example.com/foo" }

      expect(strategy.send(:callback_url)).to eq("https://example.com/foo")
    end
  end

  describe "#info" do
    it "returns empty hash" do
      expect(strategy.info).to eq({})
    end
  end

  describe "#extra" do
    it "returns empty hash" do
      expect(strategy.extra).to eq({ "raw_info" => {} })
    end
  end
end
