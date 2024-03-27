require 'active_support'
require 'active_support/core_ext'
require_relative 'power_school/client'
require_relative 'power_school/power_query'

HTTParty::ConnectionAdapter::OPTION_DEFAULTS[:verify] = false if ENV['HTTPS_NO_VERIFY'] == '1'

module PowerSchool
  POWERQUERY_QUERY_STRING_PARAMETERS = [:pagesize, :page, :order, :count, :dofor].freeze

  def self.powerquery(path:, body: {}, **options)
    options = (options || {}).symbolize_keys.merge(body: body.to_json)
    query_string = options.slice(*POWERQUERY_QUERY_STRING_PARAMETERS).compact.to_query
    options = options.except(*POWERQUERY_QUERY_STRING_PARAMETERS)

    api_path = [
      "/ws/schema/query/#{ENV['POWERSCHOOL_CLIENT_PLUGIN_NAMESPACE']}.#{path}",
      query_string.presence
    ].compact.join('?')

    response = client.run command: :post, api_path: api_path, options: options

    ::PowerSchool::PowerQuery::Response.new response
  end

  def self.client
    @client ||= PowerSchool::Client.new(
      base_uri: ENV['POWERSCHOOL_BASE_URI'],
      client_id: ENV['POWERSCHOOL_CLIENT_ID'],
      client_secret: ENV['POWERSCHOOL_CLIENT_SECRET']
    )
  end

  ## Create a new PowerSchool Model
  ##
  ##   Example:
  ##
  ##     module PowerSchool
  ##       ExampleModel = new_model(
  ##         :foo,
  ##         :bar
  ##       )
  ##     end
  ##
  def self.new_model(*args)
    Struct.new(*args, keyword_init: true) do
      def initialize(*args, **kwargs)
        raise ArgumentError, 'only keyword arguments are allowed' if args.present?

        kwargs.each do |(k, v)|
          self[k] = v
        end
      end

      args.each do |k|
        define_method :"#{k}=" do |v|
          self[k] = v
        end
      end

      def []=(k, v)
        super k, __string_value__(v)
      end

      def attributes=(hash)
        hash.each do |key, value|
          send("#{key}=", value)
        end
      end

      def attributes
        to_h
      end

      private

      def __string_value__(v)
        v&.to_s
      end
    end
  end
end
