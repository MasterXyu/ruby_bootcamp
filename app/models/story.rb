class Story
  include Neo4j::ActiveNode

  property :content
  property :created_at
  property :updated_at
  property :reply_count, type: Integer, default: 0

  has_one :in, :poster, model_class: 'User', origin: :stories
  has_many :in, :replying_users, model_class: 'User', rel_class: 'RepliedTo'

  def poster_name
    poster.valid_name
  end

  def self.replies(node = :u, rel = :r)
    all.replying_users(:u, :r).each_rel
  end

  def replies(node = :u, rel = :r)
    replying_users(node, rel)
  end
end
