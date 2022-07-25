class ScrapeAllrecipesService
  USER_AGENT = "Mozilla/5.0 (Windows NT x.y; rv:10.0) Gecko/20100101 Firefox/10.0"

  def initialize(keyword)
    @keyword = keyword
  end

  def call_recipe(base_url)
    url = "#{base_url}#{@keyword}"
    html_file = URI.open(url, "User-Agent" => USER_AGENT).read
    html_doc = Nokogiri::HTML(html_file)
    title_list = []
    description_list = []
    rating_list = []
    cards = html_doc.search(".card__detailsContainer")
    cards.each do |card|
      title = card.search(".card__title.elementFont__resetHeading").text.strip
      title_list << title
      description = card.search(".card__summary.elementFont__details--paragraphWithin.margin-8-tb").text.strip
      description_list << description
      rating = card.search("span.review-star-text.visually-hidden").text.strip.scan(/\d/)
      rating_list << rating[0].to_f
    end
    return { titles: title_list, descriptions: description_list, ratings: rating_list }
  end

  def call_preptime(base_url)
    html_file = URI.open("#{base_url}#{@keyword}", "User-Agent" => USER_AGENT).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search(".recipe-meta-item-body.elementFont__subtitle").text.strip.scan(/\d+/)
  end
end
