require 'spec_helper'

describe API do
  def app; API; end

  context 'unauthorized' do
    it 'get / -> 401' do
      get '/'
      expect(last_response.status).to eq(401)
    end

    it 'get /nic/update -> 401' do
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
          before do
            Database.connect!

            @domain = DB::Domain.create!(name: 'example.org')
            @record = @domain.records.create! \
              name: 'example.org',
              content: '23.23.23.23'
          end

          after do
            @domain.destroy!
          end

          it 'get /nic/update (23.23.23.23) -> 400' do
            get '/nic/update', myip: '23.23.23.23'
            expect(last_response.status).to eq(400)
          end

          it 'get /nic/update (23.23.23.23, example.com) -> 400' do
            get '/nic/update', myip: '23.23.23.23', hostname: 'example.com'
            expect(last_response.status).to eq(400)
          end

          it 'get /nic/update (23.23.23.23, example.org) -> 400' do
            get '/nic/update', myip: '23.23.23.23', hostname: 'example.org'
            expect(last_response.status).to eq(400)
          end

          it 'get /nic/update (23.23.23.24, example.org) -> 200' do
            get '/nic/update', myip: '23.23.23.24', hostname: 'example.org'

            @record.reload

            expect(last_response.status).to eq(200)
            expect(@record.content).to eq('23.23.23.24')
          end
        end
      end
    end
  end
end
