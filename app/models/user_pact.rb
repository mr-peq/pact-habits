class UserPact < ApplicationRecord
  belongs_to :user
  belongs_to :pact
  belongs_to :beneficiary

  enum :status, { ongoing: 0, achieved: 1, failed: 2 }
end
