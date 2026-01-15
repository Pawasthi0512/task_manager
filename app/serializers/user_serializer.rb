class UserSerializer
  def self.new(user)
    {
      id: user.id,
      email: user.email,
      name: user.name,
      created_at: user.created_at,
      updated_at: user.updated_at
    }
  end
end

