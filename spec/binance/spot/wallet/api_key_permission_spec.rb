# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#api_key_permission' do
  let(:path) { '/sapi/v1/account/apiRestrictions' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return api key permission' do
    spot_client_signed.api_key_permission
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end

  context 'with params' do
    let(:params) { { recvWindow: 10_000 } }

    it 'should return api key permission' do
      spot_client_signed.api_key_permission(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
