class PageContent < ApplicationRecord
  validates :url, presence: true
  validate :validate_url_is_indexable, on: :create

  before_create :store_content!

  def store_content!
    # Use nokogiri to store JSON blob of all h1, h2, h3 & a[href] contents.
  end

  private

  def validate_url_is_indexable
    return unless url.present?

    # TODO: Lookup if the URL is accessible and is a suitable format
    if false
      errors.add(:url, :invalid)
    end
  end
end
