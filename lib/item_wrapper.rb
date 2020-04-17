require_relative 'item'
class ItemWrapper
	MAX_QLTY_LIMIT = 50
	MIN_QLTY_LIMIT = 0
	DOUBLE = 2
    def initialize(item)
        @item = item
    end

    def update()
        # if a normal item has expired, quality degrades twice as fast
		if hasExpired()
			decrementQualityMultiple(MIN_QLTY_LIMIT, DOUBLE)
		else
			decrementQuality(MIN_QLTY_LIMIT)
		end
	end
    
    # checks if the item's sellin value is still positive
	def hasExpired()
		@item.sell_in < 0
    end
    
    def decrementQuality(qualityLimit)
		if @item.quality > qualityLimit
			@item.quality -= 1
		end
    end

    # decrement Quality multiple times
	def decrementQualityMultiple(qualityLimit, n)
		i = 0
		while i < n
			decrementQuality(qualityLimit)
			i += 1
		end
    end
    
	#This function takes an item and a qualityLimit, and increments the quality of the item if it hasn't reached the limit 
	def incrementQuality(qualityLimit)
		if @item.quality < qualityLimit
			@item.quality += 1
		end
	end 
    
    # increment quality n times
	def incrementQualityMultiple(qualityLimit, n)
		i = 0
		while i < n
			incrementQuality(qualityLimit)
			i += 1
		end
	end
end