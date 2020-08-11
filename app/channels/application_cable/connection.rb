module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect

      access_token = request.headers["access-token"]
      uid = request.headers["uid"]
      client = request.headers["client"]

      self.current_user = find_verified_user access_token, uid, client
      logger.add_tags 'ActionCable', current_user.email
    end

    private

    def find_verified_user access_token, uid, client
      user = User.find_by email: uid
      if user && user.valid_token?(access_token, client)
          user
      else
          reject_unauthorized_connection
      end
    end
  end
end
