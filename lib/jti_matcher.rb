class JtiMatcher
  def self.jwt_revoked?(payload, user)
    !user || user.jti != payload['jti']
  end

  def self.revoke_jwt(payload, user)
    # JTI is stored in the user model, so we update it to revoke all tokens
    user.update_column(:jti, SecureRandom.uuid) if user
  end
end

