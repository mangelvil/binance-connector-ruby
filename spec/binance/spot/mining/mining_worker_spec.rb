# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Mining, '#mining_worker' do
  let(:path) { '/sapi/v1/mining/worker/detail' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "algo": 'sha256',
      "userName": 'user1',
      "workerName": 'test.1'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without algo' do
      expect { spot_client_signed.mining_worker(algo: '', userName: 'user1', workerName: 'test.1') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without userName' do
      expect { spot_client_signed.mining_worker(algo: 'sha256', userName: '', workerName: 'test.1') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without workerName' do
      expect { spot_client_signed.mining_worker(algo: 'sha256', userName: 'user1', workerName: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return miner list' do
    spot_client_signed.mining_worker(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
