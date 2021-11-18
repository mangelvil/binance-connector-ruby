# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_enable_blvt' do
  let(:path) { '/sapi/v1/sub-account/blvt/enable' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { email: '', enableBlvt: true },
        { email: 'alice@test.com', enableBlvt: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.sub_account_enable_blvt(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { email: 'alice@test.com', enableBlvt: true } }
    it 'should enable blvt' do
      spot_client_signed.sub_account_enable_blvt(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
