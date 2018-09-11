require 'acts_as_hoc_avatarable/version'
require 'acts_as_hoc_avatarable/configuration'
require 'acts_as_hoc_avatarable/acts_as_hoc_avatarable'
module ActsAsHocAvatarable
  LOCK = Mutex.new
  class << self
    def configure(config_hash=nil)
      if config_hash
        config_hash.each do |k,v|
          configuration.send("#{k}=", v) rescue nil if configuration.respond_to?("#{k}=")
        end
      end

      yield(configuration) if block_given?
    end

    def configuration
      @configuration = nil unless defined?(@configuration)
      @configuration || LOCK.synchronize { @configuration ||= ActsAsHocAvatarable::Configuration.new }
    end
  end
end
