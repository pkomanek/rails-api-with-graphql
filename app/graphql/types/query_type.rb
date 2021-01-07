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
      res = args[:id] ? User.find(args[:id]) : User.all
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

    # /usersCount
    field :users_count, Integer, null: false

    def users_count
      User.all.size
    end

    # /posts
    field :posts, [Types::PostType], null: false do
      argument :id, ID, required: false
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
    end

    def posts(args)
      res = args[:id] ? Post.find(args[:id]) : Post.all
      res = res.drop(args[:offset]) if args[:offset]
      res = res.take(args[:limit]) if args[:limit]
      res
    end

    # /postsCount
    field :posts_count, Integer, null: false

    def posts_count
      Post.all.size
    end
  end
end
