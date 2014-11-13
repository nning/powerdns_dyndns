require 'spec_helper'

describe API do
  def app; API; end

  context 'unauthorized' do
    it '/' do
      get '/'
      expect(last_response.status).to eq(401)
    end

    it '/nic/update' do
      get '/nic/update'
      expect(last_response.status).to eq(401)
    end
  end

  context 'authorized' do
    before { authorize 'test', 'test' }

    context 'no params' do
      it 'get / -> 404' do
        get '/'
        expect(last_response.status).to eq(404)
      end

      it 'get /nic/update -> 400' do
        get '/nic/update'
        expect(last_response.status).to eq(400)
      end
    end

    context 'params' do
      context 'ip' do
        context 'invalid' do
          ['::1', 'ff02::1', 'foo', '0.0.0.0', '127.0.0.1', '127.0.1.1',
           '127.1.0.1', '10.11.1.1', '192.168.0.1', '172.23.1.128',
           '224.0.1.187', '233.252.0.1']
          .each do |ip|
            it "get /nic/update (#{ip}) -> 400" do
              get '/nic/update', myip: ip
              expect(last_response.status).to eq(400)
            end
          end
        end

        context 'valid' do
          it 'get /nic/update (23.23.23.23) -> 200' do
            # Just test, if valid IPv4 address "gets through" IP filter.
            expect { get '/nic/update', myip: '23.23.23.23' }.to \
              raise_error(ActiveRecord::ConnectionNotEstablished)
          end
        end
      end
    end
  end
end
