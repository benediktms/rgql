# frozen_string_literal: true

module Mutations
  module Users
    class Update < Mutations::BaseMutation
      argument :user_id, ID, required: true
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :email, String, required: false

      field :user, Types::UserType, null: true
      field :errors, [String], null: true

      def resolve(user_id:, **args)
        user = ::Users::Get.call(id: user_id).user

        result = ::Users::Update.call(user: user, attributes: args)

        {
          user: result.user,
          errors: result.messages
        }
      end
    end
  end
end
