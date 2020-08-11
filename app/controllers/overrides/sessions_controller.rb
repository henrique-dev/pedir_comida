module Overrides
    class SessionsController < DeviseTokenAuth::SessionsController

        def provider
            super
            "telephone"
        end
    end
end