class User
  include Neo4j::ActiveNode

  property :first_name, type: String
  property :last_name, type: String, index: :exact
  property :age, type: Integer
  property :occupation, type: String
  property :email, type: String, constraint: :unique
  property :created_at
  property :updated_at

  [:first_name, :last_name].each { |name| validates_presence_of name }
  validates_numericality_of :age, allow_nil: true

  has_many :both, :friends,    type: 'FRIENDS_WITH', model_class: 'User', unique: true
  has_many :out, :friends_out, type: 'FRIENDS_WITH', model_class: 'User', unique: true
  has_many :in,  :friends_in,  type: 'FRIENDS_WITH', model_class: 'User', unique: true

  has_many :out, :stories, type: 'POSTED', dependent: :destroy, unique: true
  has_many :out, :replies_to, model_class: 'User', rel_class: 'RepliedTo'

  # The more Ruby-ish way to write this would be:
  # {both: :friends, out: :friends_out, in: :friends_with}.each_pair do |direction, association|
  #   has_many direction, association, type: 'FRIENDS_WITH', model_class: 'User', unique: true
  # end

  # Devise things
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  property :username, type:   String, constraint: :unique
  property :encrypted_password
  property :remember_created_at, type: DateTime, index: :exact

  property :reset_password_token
  index :reset_password_token
  property :reset_password_sent_at, type: DateTime

  property :sign_in_count,       type: Integer, default: 0
  property :current_sign_in_at,  type: DateTime
  property :last_sign_in_at,     type: DateTime
  property :current_sign_in_ip,  type: String
  property :last_sign_in_ip,     type: String

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def valid_name
    "#{first_name} #{last_name}".blank? ? email : "#{first_name} #{last_name}"
  end

  def storyfeed
    # stories(:s).optional(:poster, :p).stories(:s).replying_users(:u, :r).pluck(:s, 'collect(r)')
    stories(:story)
  end
end
