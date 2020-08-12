module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :current_admin

    def connect
      puts "HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEERE".red
      puts "HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEERE".red
      puts "HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEERE".red
      puts "HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEERE".red
      puts "HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEERE".red
      puts "HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEERE".red
      puts "HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEERE".red
      p cookies.signed[:admin_id]
      
      if cookies.signed[:admin_id]
        self.current_admin = find_verified_admin cookies.signed[:admin_id]
        logger.add_tags 'ActionCable', current_admin.id
      else        
        access_token = request.headers["access-token"]
        uid = request.headers["uid"]
        client = request.headers["client"]
        self.current_user = find_verified_user access_token, uid, client
        logger.add_tags 'ActionCable', current_user.email
      end      
    end

    private

    def find_verified_user access_token, uid, client
      user = User.find_by telephone: uid
      if user && user.valid_token?(access_token, client)
          user
      else
          reject_unauthorized_connection
      end
    end

    def find_verified_admin admin_id
      if user = Admin.find_by(id: admin_id)
          user
      else
          reject_unauthorized_connection
      end
    end

  end
end
