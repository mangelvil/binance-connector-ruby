# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#open_order_list' do
  let(:path) { '/api/v3/openOrderList' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return all open oco orders' do
    spot_client_signed.open_order_list(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        recvWindow: 10_000
      }
    end

    it 'should return open oco orders' do
      spot_client_signed.open_order_list(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
