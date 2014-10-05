module FeedHelper
#####################
#API KEYS & RSS URLS
#####################
  SARTORIALIST_RSS_URL = 'http://www.nyartbeat.com/list/event_opening.en.xml'
  REALIST_RSS_URL = 'http://feeds.feedburner.com/nymag/grubstreet?format=xml'
  ESCAPE_ARTIST_URL = 'http://www.redbullskydiveteam.com/rss.xml'
  INTELLIGENTSIA_URL = 'http://www.strandbooks.com/index.cfm/fuseaction/event.index/nodeID/a35c34a6-bda5-4733-9f7d-fa7187e8c2e3/?view=rss'
  WUNDERGROUND_API_KEY = ENV['a825d927a8d698d3']
  NYT_API_KEY = 'a4a129410af3be7a2fedd9101879acf9:1:67095397'
  NYT_BESTSELLER_QUERY = {
    escape_artist_query:"trade-fiction-paperback",
    sartorialist_query:"hardcover-fiction",
    intelligentsia_query:"hardcover-nonfiction",
    realist_query:"paperback-nonfiction",
    techie:"e-book-fiction"
  }

  INSTAGRAM_QUERY = {
    eat_query:"foodieadventures",
    shop_query:"streetstyle",
    go_query:"travelandlife"
  }

  # CLIENT ID = '0f47fa507b9d4040905722a4637ab3ed'
  # CLIENT SECRET = 'fdbaab036f4c431da072f2a201c67774'


  def rss_feed_get(url)
    open(url) do |rss|
      @feed = RSS::Parser.parse(rss)
    end
  end

  def rss_feed_view
     "<ul><%= @feed.channel.title %></ul>
      <% @feed.items.each do |item| %>
    <ul><%= item.title %></ul>
   <% end %>"
  end

  def nyt_api(key)
    @response = HTTParty.get('http://api.nytimes.com/svc/books/v2/lists.json?list-name=#{NYT_BESTSELLER_QUERY[#{key}]}&api-key=a4a129410af3be7a2fedd9101879acf9%3A1%3A67095397')
  end

  def nyt_api_view
    "<% @response[\"results\"].each do |book| %>
      <% book[\"book_details\"].each do |info| %>
      <ul>
      <%= info[\"title\"] %>
      <br></br>
      <%= info[\"author\"] %>
      <br></br>
      <%= info[\"description\"] %>
      <br></br>
      <%= info[\"publisher\"] %>
      </ul>
      <% end %>
    <% end %>"
  end


  def wunderground_api
    @city = "new_york"
    @state = "ny"
    @weather = HTTParty.get("http://api.wunderground.com/api/8df98bbf67d1296c/conditions/q/#{@state}/#{@city}.json")
    @temp_in_farh = @weather["current_observation"]["temp_f"]
  end

  # def meetup_api

  # end

  def instagram_api(key)
    HTTParty.get('https://api.instagram.com/v1/tags/#{INSTAGRAM_QUERY[#{key}]}/media/recent?access_token=36703057.0f47fa5.e7416325ba284d5f9477d3e7e401b1bf')
  end

  def instagram_api_view
    "<% @instagram_go_realist_response[\"data\"].each do |image| %>
    <ul>
    <%= image[\"link\"] %>
    <% end %>"
  end
end







