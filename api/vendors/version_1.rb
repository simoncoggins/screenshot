Grape::API.logger Padrino.logger

module APIS
  module Vendors
    
      class API_v1 < Grape::API
        format :json
        default_format :json
        version 'v1', :using => :header, :vendor => 'global'
        
        before do
          header['Access-Control-Allow-Origin'] = '*'
          header['Access-Control-Request-Method'] = '*'
        end
        
        rescue_from :all do |error|
          logger.error "API << #{env['REQUEST_METHOD']} #{env['PATH_INFO']} -- #{error.class.name} -- #{error.message}"
          logger.info "API << Last error's backtrace:\n#{error.backtrace.join("\n")}"
          
          json = { error: error.class.name, message: error.message }.to_json
          code = 500
          
          headers = 
          {
            'Content-Type' => 'application/json',
            'Access-Control-Allow-Origin' => '*',
            'Access-Control-Request-Method' => '*'
          }
          
          rack_response(json, code, headers)
        end
        
        resource :screenshots do
          crud Screenshot, :screenshot
        end

        get :any do
          logger.error "API << #{env['REQUEST_METHOD']} #{env['PATH_INFO']}; errors: Not Found!"
          error!({message: "#{env['REQUEST_METHOD']} #{env['PATH_INFO']}", errors: "Not Found!"},404)
        end
        
      end
  end
end
