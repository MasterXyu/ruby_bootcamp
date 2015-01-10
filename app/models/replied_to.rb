class RepliedTo
  include Neo4j::ActiveRel
  from_class User
  to_class Story

  after_create :increase_reply_count
  before_destroy :decrease_reply_count

  property :created_at
  property :updated_at
  property :content

  validates_presence_of :content

  def poster
    from_node
  end

  def poster_name
    from_node.valid_name
  end

  private

  def increase_reply_count
    to_node.reply_count += 1
    to_node.save
  end

  def decrease_reply_count
    to_node.reply_count -= 1
    to_node.save
  end
end
