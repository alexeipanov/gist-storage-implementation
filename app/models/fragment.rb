class Fragment < ApplicationRecord
  validates :value, presence: true
  validates :value, length: { maximum: 8192 }
  validates :url, uniqueness: true
  scope :public_fragments, -> { where(private: false) }
  scope :recent, ->(limit) { public_fragments.limit(limit) }

  def self.total_count
    Rails.cache.fetch('fragments/total_count', expires_in: 12.hours) do
      self.count
    end
  end

  def preview_value
    self.value.truncate_words(5)
  end

end
