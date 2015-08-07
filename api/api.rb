class API < Grape::API
    version 'v1', using: :header, vendor: 'samantha'
    format :json
    prefix :api

    # helpers do
    #   def current_user
    #     @current_user ||= User.authorize!(env)
    #   end

    #   def authenticate!
    #     error!('401 Unauthorized', 401) unless current_user
    #   end
    # end

    resource :integrations do
      desc "Returns the list of the integrations"
      get  do
        [
          {id: 1, name: "Trello"},
          {id: 2, name: "Google Apps"},
        ]
      end
    end
end
