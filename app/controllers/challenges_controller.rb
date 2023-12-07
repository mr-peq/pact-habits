class ChallengesController < ApplicationController
  def index
    # UserPacts for which the user_id is not current_user_id
    # not_user_pacts = UserPact.where.not(user_id: current_user.id)
    # + only the ones for which the pact is a challenge
    # @not_user_challenges = not_user_pacts.includes(:pact).where(pacts: { challenge: true }).uniq(&:pact_id)
    @challenges = Pact.where(challenge: true).reject { |challenge| challenge.users.include?(current_user) }
    @challenges_1w = @challenges.select { |pact| pact.completion_duration == 1 }
    @challenges_2w = @challenges.select { |pact| pact.completion_duration == 2 }
    @challenges_3w = @challenges.select { |pact| pact.completion_duration == 3 }
    @beneficiaries = Beneficiary.all
    @user = current_user
  end
end
