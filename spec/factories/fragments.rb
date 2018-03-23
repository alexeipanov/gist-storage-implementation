require 'faker'

FactoryBot.define do
  factory :fragment do
    value Faker::HitchhikersGuideToTheGalaxy.marvin_quote
    private false
  end
end
