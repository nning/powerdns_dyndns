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
      it '404 on /' do
        get '/'
        expect(last_response.status).to eq(404)
      end

      it '400 on /nic/update' do
        get '/nic/update'
        expect(last_response.status).to eq(400)
      end
    end

    context 'params' do
    end
  end
end
