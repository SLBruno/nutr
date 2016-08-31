module Unitwise
  # A prefix can be used with metric atoms to modify their scale.
  class Prefix < Base
    liner :scalar

    # The data loaded from the UCUM spec files
    # @api semipublic
    def self.data
      @data ||= YAML.load File.open(data_file)
    end

    # The location of the UCUM spec prefix data file
    # @api semipublic
    def self.data_file
      Unitwise.data_file 'prefix'
    end

    # Set the scalar value for the prefix, always as a BigDecimal
    # @api semipublic
    def scalar=(value)
      @scalar = BigDecimal(value.to_s)
    end
  end
end
