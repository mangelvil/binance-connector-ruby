# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Futures, '#cross_collateral_repay' do
  let(:path) { '/sapi/v1/futures/loan/repay' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { coin: '', collateralCoin: 'BTC', amount: 1 },
        { coin: 'BUSD', collateralCoin: '', amount: 1 },
        { coin: 'BUSD', collateralCoin: '', amount: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.cross_collateral_repay(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { coin: 'BUSD', collateralCoin: 'BTC', amount: 1 } }
    it 'should do repay' do
      spot_client_signed.cross_collateral_repay(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
