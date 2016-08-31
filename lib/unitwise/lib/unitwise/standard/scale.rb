module Unitwise::Standard
  class Scale
    attr_accessor :nori

    def initialize(nori)
      @nori = nori
    end

    def value
      nori.attributes["value"].to_f
    end

    def primary_unit_code
      nori.attributes["Unit"]
    end

    def secondary_unit_code
      nori.attributes["UNIT"]
    end

    def to_hash
      {:value => value, :unit_code => primary_unit_code}
    end
  end
end