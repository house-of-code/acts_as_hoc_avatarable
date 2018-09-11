module ActsAsHocAvatarable
  class Configuration
    attr_accessor :resize_on_create
    attr_accessor :resize_size
    attr_accessor :fallback_to_gravatar
    attr_accessor :default_host
    def initialize
    end
  end
end
