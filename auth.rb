module Sinatra
  module NTNAuthExtension
    module Helpers

      def authorized?
        session[:authorized]
      end

      def restrict_auth!
        redirect '/login' unless authorized?
      end

      def logout!
        session[:authorized] = false
      end

      register NTNAuthExtension

    end
  end
end
