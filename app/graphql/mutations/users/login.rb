# frozen_string_literal: true

module Mutations
  module Users
    class Login < Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: true
      field :message, String, null: true
      field :token, String, null: true

      def resolve(email:, password:)
        return unless email && password

        result = ::Users::Login.call(email: email, password: password)

        {
          user: result.user,
          token: result.token,
          message: result.message
        }
      end
    end
  end
end
