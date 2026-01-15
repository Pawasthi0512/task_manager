class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # database_authenticatable: It handles the password hashing (using bycrypt) and the logic for verifying a user's credentials during sign-in.
  # registerable: It manages user registration, allowing users to sign up, edit their account details, and delete their accounts.
  # recoverable: It provides the functionality for users to reset their passwords if they forget them, typically by sending a reset link via email.
  # rememberable: It manages generating and clearing token for remembering the user from a saved cookie.
  # validatable: It adds validations for email and password. By default, it checks for the presence of an email and password, the uniqueness of the email, and the length of the password.\
  # jwt_authenticatable: It integrates JWT (JSON Web Token) authentication into the Devise framework, allowing for stateless authentication in APIs.
  # The jwt_revocation_strategy option specifies the strategy for handling token revocation. In this case, it uses the JTI (JWT ID) strategy, which involves storing a unique identifier (JTI) for each token in the database to track and revoke tokens as needed.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JtiMatcher
  has_many :tasks, dependent: :destroy

  # This callback ensures every new user gets a unique JTI
  # so their first login works perfectly.
  before_create :set_jti

  private

  def set_jti
    self.jti = SecureRandom.uuid
  end
end
