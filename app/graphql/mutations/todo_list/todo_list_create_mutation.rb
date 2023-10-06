module Mutations
  module TodoList
    class TodoListCreateMutation < Mutations::BaseMutation
      argument :token, String, required: true
      argument :title, String, required: true
      argument :content, String, required: true

      field :todo_list, [Types::TodoListType]
      field :success, Boolean, null: false
      field :message, String

      def resolve(token:, title:, content:)
        decoded_token = JWT.decode token, Settings.jwt_hmac_secret, true, { algorithm: 'HS256' }
        user = ::User.find_by(email: decoded_token[0]['email'])
        user.todo_lists.create(assign_id: user.id, title: title, content: content)
        { success: true, todo_list: user.todo_lists.where(status: 'pending') }
      end
    end
  end
end
