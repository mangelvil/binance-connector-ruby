# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Futures, '#cross_collateral_wallet' do
  let(:path) { '/sapi/v2/futures/loan/wallet' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return cross-collateral wallet data' do
    spot_client_signed.cross_collateral_wallet
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end

  context 'with params' do
    let(:params) { { recvWindow: 10_000 } }

    it 'should return cross-collateral wallet data' do
      spot_client_signed.cross_collateral_wallet(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
