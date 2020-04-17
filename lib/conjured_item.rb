require_relative 'item_wrapper'

class ConjuredItem < ItemWrapper
    MAX_QLTY_LIMIT = 50
	MIN_QLTY_LIMIT = 0
	DOUBLE = 2
    def initialize(item)
        @item = item
    end

    def update()
        #conjured items degrade quality twice as fast as normal items
        super()
        super()
        # if hasExpired()
		# 	decrementQualityMultiple(MIN_QLTY_LIMIT, DOUBLE)
		# else
		# 	decrementQuality(MIN_QLTY_LIMIT)
		# end
    end
end