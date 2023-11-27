class UserPact < ApplicationRecord
  belongs_to :user
  belongs_to :pact
  belongs_to :beneficiary
end
