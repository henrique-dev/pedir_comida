class AdminChannel < ApplicationCable::Channel
    def subscribed
        stream_from "admin_#{current_admin.id}"
    end
end