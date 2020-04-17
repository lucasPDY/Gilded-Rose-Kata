require_relative 'item_wrapper'

class BackstagePasses < ItemWrapper
	DAYS_LEFT_TO_DOUBLE_CONCERT_QLTY = 10
	DAYS_LEFT_TO_TRIPLE_CONCERT_QLTY = 5
	CONCERT_EXPIRY_QLTY = 0
	MAX_QLTY_LIMIT = 50
	MIN_QLTY_LIMIT = 0
	DOUBLE = 2
	TRIPLE = 3

    def initialize(item)
        @item = item
    end

    def update()
		# if there are less thatn DAYS_LEFT_TO_TRIPLE_CONCERT_QLTY days to concert, decrement again
		if @item.sell_in < DAYS_LEFT_TO_TRIPLE_CONCERT_QLTY
			incrementQualityMultiple(MAX_QLTY_LIMIT, TRIPLE)
		# if there are less than DAYS_LEFT_TO_DOUBLE_CONCERT_QLTY days to concert, decrement again
		elsif @item.sell_in < DAYS_LEFT_TO_DOUBLE_CONCERT_QLTY
			incrementQualityMultiple(MAX_QLTY_LIMIT, DOUBLE)
		# increase normally
		else
			incrementQuality(MAX_QLTY_LIMIT)
		end
		
		# if concert passes has expired, its quality is 0
		if hasExpired()
			@item.quality = CONCERT_EXPIRY_QLTY
		end
	end
end