module Concerns

  module RenderingHelpers
    extend ActiveSupport::Concern

    included do
      Concerns::RenderingHelpers.instance_methods.each do |method|
        helper_method method
      end
    end

    def hello
      "Hello!"
    end

    def question
      "How are you doing today?"
    end

    def true_bool
      true
    end

    def false_bool
    end
  end
end
