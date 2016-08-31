module Unitwise
  module Expression
    # The decomposer is used to turn string expressions into collections of
    # terms. It is responsible for executing the parsing and transformation
    # of a string, as well as caching the results.
    class Decomposer

      MODES = [:primary_code, :secondary_code, :names, :slugs, :symbol]

      PARSERS = MODES.reduce({}) do |hash, mode|
        hash[mode] = Parser.new(mode); hash
      end

      TRANSFORMER = Transformer.new

      class << self

        # Parse an expression to an array of terms and cache the results
        def parse(expression)
          expression = expression.to_s
          if cache.key?(expression)
            cache[expression]
          elsif decomposer = new(expression)
            cache[expression] = decomposer
          end
        end

        private

        # A simple cache to prevent re-decomposing the same units
        # api private
        def cache
          @cache ||= {}
        end
      end

      attr_reader :expression, :mode

      def initialize(expression)
        @expression = expression.to_s
        if expression.empty? || terms.nil? || terms.empty?
          fail(ExpressionError, "Could not evaluate '#{ expression }'.")
        end
      end

      def parse
        PARSERS.reduce(nil) do |_, (mode, parser)|
          parsed = parser.parse(expression) rescue next
          @mode = mode
          break parsed
        end
      end

      def transform
        @transform ||= TRANSFORMER.apply(parse, :mode => mode)
      end

      def terms
        @terms ||= if transform.respond_to?(:terms)
          transform.terms
        else
          Array(transform)
        end
      end

    end
  end
end
