class User
  include Mongoid::Document
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  
  ## Username field
  field :username,           type: String

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time
  
  validates :username, presence: true, uniqueness: true

  ## Trackable (commented out for now)
  # field :sign_in_count,      type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

  ## Confirmable (commented out for now)
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable (commented out for now)
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  
  include Mongoid::Timestamps

  field :name, type: String

  has_many :messages
  has_and_belongs_to_many :chat_rooms
  
  # Avatar attachment (using CarrierWave)
  mount_uploader :avatar, AvatarUploader

  # Validation for avatar format
  validate :avatar_format

  private

  def avatar_format
    # Check if avatar is present (CarrierWave provides a `file` method on the mounted uploader)
    return unless avatar.file.present?

    # Check if the content type starts with 'image/'
    return if avatar.file.content_type.start_with?('image/')

    errors.add(:avatar, 'needs to be an image')
  end
end
