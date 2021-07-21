require "suitecrm/configuration"
require "suitecrm/api_exception"
require "suitecrm/connection"
require "suitecrm/modules"
require "suitecrm/module"
require "suitecrm/relationship"
require "suitecrm/meta"

module SuiteCRM
  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
