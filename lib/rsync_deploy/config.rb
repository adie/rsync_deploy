module RsyncDeploy
  class Config
    attr_accessor :config

    class MissingConfigError < StandardError ; end

    def initialize(file)
      if File.exists? file
        @config = {}
        instance_eval File.read(file)
      else
        raise MissingConfigError, "Missing config file - #{file}"
      end
    end

    def set(key, value)
      @config[key] = value
    end

    def method_missing(method_sym, *arguments, &block)
      if @config.has_key?(method_sym)
        self.class.send(:define_method, method_sym) do
          @config[method_sym]
        end
        @config[method_sym]
      else
        super
      end
    end
  end
end
