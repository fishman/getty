require 'faraday'
require 'faraday_middleware'

directory = File.expand_path(File.dirname(__FILE__))

module Getty
  class << self

    FIELDS = [ :system_id, :system_pwd, :user_name,
               :user_pwd, :connection_middleware ]
    attr_accessor(*FIELDS)

    def filter tips, term
      tip = []
      unless tips.nil?
        tips.items.each do |check_tip|
          tip << check_tip if check_tip.text.downcase.include? term.downcase
        end
      end
      Hashie::Mash.new({:count => tip.count, :items => tip })
    end

    def configure
      yield self
      true
    end

  end

  require 'getty/sessions'
  require 'getty/images'
  require 'getty/client'
  require 'getty/api_error'


end
