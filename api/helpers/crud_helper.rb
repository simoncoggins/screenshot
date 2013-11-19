require 'json'
class Grape::API
  
  def self.crud(klass, paramname) #eg.: crud User, :user
    
    desc "Returns all #{klass}"
    get do
      klass.all
    end
    
    desc "Displays jQuery Grid for #{klass}. Use .json format, like /grid.json"
    post :grid do
      klass.all.paged_query(klass.get_attributes, params)
    end
    
    desc "CRUD/Create. Creates a new instance of #{klass}", {
      params: { paramname => "Arguments should be passed like #{paramname}[field_name]=..." }
    }
    post do
      klass.create! params[paramname]
    end
    
    resource ':id' do
      before { @id = params[:id] }
  
  # /update, /delete
  
      desc "Updates attributes of existing instance of #{klass}", {
        params: { "id" => "Item ID", paramname => "Arguments should be passed like #{paramname}[field_name]=..." }
      }
      post '/update' do
        klass.find(@id).tap {|u| u.update_attributes! params[paramname]}
      end
      
      desc "Destroys of existing instance of #{klass}", { params: { "id" => "Item ID" } }
      get  '/delete' do
        klass.find(@id).destroy
      end
      
  # RESTful
      
      desc "CRUD/Read. Returns all attributes of an instance of #{klass} by id", { params: { "id" => "Item ID" } }
      get do
        klass.find(@id)
      end
      
      desc "CRUD/Read. Returns all attributes of an instance of #{klass} by id", { 
        params: { "id" => "Item ID", paramname => "Arguments should be passed like #{paramname}[field_name]=..." }
      }
      put do
        klass.find(@id).tap {|u| u.update_attributes! params[paramname]}
      end
      
      desc "CRUD/Delete. Destroys of existing instance of #{klass}", { params: { "id" => "Item ID" } }
      delete do
        klass.find(@id).destroy
      end
    end
    
  end
  
end
