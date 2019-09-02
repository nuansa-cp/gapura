class Ticket < ApplicationRecord
  belongs_to :user, inverse_of: :tickets
  has_secure_token :claim_token

  def claimed?
    return !claimed_at.nil?
  end
end