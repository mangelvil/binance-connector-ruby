# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#coin_info' do
  let(:path) { '/sapi/v1/capital/config/getall ' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return account info' do
    spot_client_signed.coin_info
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
