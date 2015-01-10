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

end
