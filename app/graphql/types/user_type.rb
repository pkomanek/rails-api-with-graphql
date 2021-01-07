module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: true
    field :name, String, null: true
    field :posts, [Types::PostType], null: true do
      argument :id, ID, required: false
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
    end
    field :posts_count, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  
    def posts(args)
      res = args[:id] ? Post.find(args[:id]) : Post.all
      res = res.drop(args[:offset]) if args[:offset]
      res = res.take(args[:limit]) if args[:limit]
      res
    end

    def posts_count
      object.posts.size
    end
  end
end
