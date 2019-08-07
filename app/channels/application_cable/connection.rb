module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = generate_user_name
      logger.add_tags 'ActionCable', current_user
    end

    private

    def generate_user_name
      "#{Faker::Creature::Animal.name}_#{rand(10000)}@hotmail.com"
    end
  end
end
