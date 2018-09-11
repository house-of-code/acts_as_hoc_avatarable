module ActsAsHocAvatarable
  class Configuration
    attr_accessor :resize_on_create
    attr_accessor :resize_size
    attr_accessor :fallback_to_gravatar
    attr_accessor :default_host
    def initialize
      @resize_on_create = true
      @resize_size = "400x400>"
      @fallback_to_gravatar = true
      @default_host = "localhost:3000"
    end
  end
end
