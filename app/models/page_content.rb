class PageContent < ApplicationRecord
  validates :url, presence: true
  validate :validate_url_is_indexable, on: :create
  before_create :store_content!

  # Nokogiri to store a JSON blob of all h1, h2, h3 & a[href] contents.
  def store_content!
    self.content = {
      h1: parsed_response.search('h1').collect(&:text),
      h2: parsed_response.search('h2').collect(&:text),
      h3: parsed_response.search('h3').collect(&:text),
      a: parsed_response.search('a[href]').collect { |link| link.attributes['href'].value }
    }
  end

  private
  def url_response
    @url_response ||= Net::HTTP.get_response(URI(url))
  end

  def parsed_response
    @parsed_response ||= Nokogiri::HTML(url_response.body)
  end

  def validate_url_is_indexable
    return unless url.present?

    # Lookup if the URL is accessible and is a suitable format
    return if url_response.code == '200' && url_response.content_type == 'text/html'

    # Otherwise add an error
    errors.add(:url, :invalid)
  end
end
