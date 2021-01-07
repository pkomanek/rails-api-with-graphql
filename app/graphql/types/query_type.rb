module Types
  class QueryType < Types::BaseObject
    # /users
    field :users, [Types::UserType], null: false do
      argument :id, ID, required: false
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
      #argument :filter
      #argument :sort_by
    end

    def users(args)
      res = User.all
      res = res.drop(args[:offset]) if args[:offset]
      res = res.take(args[:limit]) if args[:limit]
      res
    end

    # /user
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    # /users
    field :posts, [Types::PostType], null: false

    def posts
      Post.all
    end
  end
end
