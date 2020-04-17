require_relative 'item_wrapper'
MAX_QLTY_LIMIT = 50
DOUBLE = 2

class AgedBrie < ItemWrapper
    def initialize(item)
        @item = item
    end

    def update()
        # if Brie has expired, increment its quality
		if hasExpired()
			incrementQualityMultiple(MAX_QLTY_LIMIT, DOUBLE)
		else
			incrementQuality(MAX_QLTY_LIMIT)
		end
    end
end    


