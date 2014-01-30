# Author: Nikhil Gupta <me@nikhgupta.com>
# Easily display beautiful timelines on your blog.
#
#

require 'pry'
require 'json'
require 'nokogiri'

module Jekyll
  module TimeLineFilter

    def to_timeline input
      data = {}
      content = markdownify(input).gsub(/(\r|\n|\r\n)*/, '')
      events  = content.split(/<hr.*?\/>/)
      events.each_with_index do |event, index|
        event = Nokogiri::HTML event
        if index > 0
          data[:timeline][:date].push({
            headline: event.search('h1')[0].text,
            text:     event.search('li')[-1].inner_html,
            startDate: "2013,3",
            endDate: "2013,5",
          })
        else
          data[:timeline] = {
            headline: event.search('h1')[0].text,
            text:     event.search('li')[-1].inner_html,
            startDate: "2013",
            type: "default",
            date: [],
            era: []
          }
        end
      end
      data.to_json
    end
  end
end

Liquid::Template.register_filter(Jekyll::TimeLineFilter)
