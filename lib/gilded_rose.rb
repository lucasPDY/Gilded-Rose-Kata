class GildedRose
	SULFURAS = "Sulfuras, Hand of Ragnaros"
	BRIE = "Aged Brie"
	CONCERT_PASS = "Backstage passes to a TAFKAL80ETC concert"
	MAX_QLTY_LIMIT = 50
	MIN_QLTY_LIMIT = 0
	DAYS_LEFT_TO_DOUBLE_CONCERT_QLTY = 10
	DAYS_LEFT_TO_TRIPLE_CONCERT_QLTY = 5
	CONCERT_EXPIRY_QLTY = 0
	DOUBLE = 2
	TRIPLE = 3
	SINGLE = 1

	def initialize(items)
		@items = items
	end


	#This function takes an item and a qualityLimit, and increments the quality of the item if it hasn't reached the limit 
	def incrementQuality(item, qualityLimit)
		if item.quality < qualityLimit
			item.quality += 1
		end
	end 

	# def incrementDoubleQuality(item, qualityLimit)
	# 	incrementQuality(item, qualityLimit)
	# 	incrementQuality(item, qualityLimit)
	# end

	# increment quality n times
	def incrementQualityMultiple(item, qualityLimit, n)
		i = 0
		while i < n
			incrementQuality(item, qualityLimit)
			i += 1
		end
	end

	def decrementQuality(item, qualityLimit)
		if item.quality > qualityLimit
			item.quality -= 1
		end
	end

	# decrement Quality multiple times
	def decrementQualityMultiple(item, qualityLimit, n)
		i = 0
		while i < n
			decrementQuality(item, qualityLimit)
			i += 1
		end
	end

	# update the sell in value of a particular item
	def decrementSellIn(item)
		item.sell_in -=  1
	end

	# checks if the item's sellin value is still positive
	def hasExpired(item)
		item.sell_in < 0
	end

	def updateBrie(item)
		# if Brie has expired, increment its quality
		if hasExpired(item)
			incrementQualityMultiple(item, MAX_QLTY_LIMIT, DOUBLE)
		else
			incrementQuality(item, MAX_QLTY_LIMIT)
		end
	end
	
	def updateConcertPasses(item)
		# if there are less thatn DAYS_LEFT_TO_TRIPLE_CONCERT_QLTY days to concert, decrement again
		if item.sell_in < DAYS_LEFT_TO_TRIPLE_CONCERT_QLTY
			incrementQualityMultiple(item, MAX_QLTY_LIMIT, TRIPLE)
		# if there are less than DAYS_LEFT_TO_DOUBLE_CONCERT_QLTY days to concert, decrement again
		elsif item.sell_in < DAYS_LEFT_TO_DOUBLE_CONCERT_QLTY
			incrementQualityMultiple(item, MAX_QLTY_LIMIT, DOUBLE)
		# increase normally
		else
			incrementQuality(item, MAX_QLTY_LIMIT)
		end
		
		# if concert passes has expired, its quality is 0
		if hasExpired(item)
			item.quality = CONCERT_EXPIRY_QLTY
		end
	end

	def updateNormalItem(item)
		# if a normal item has expired, quality degrades twice as fast
		if hasExpired(item)
			decrementQualityMultiple(item, MIN_QLTY_LIMIT, DOUBLE)
		else
			decrementQuality(item,MIN_QLTY_LIMIT)
		end
	end

	def update_quality
		@items.each do |item|
			if item.name == SULFURAS
				next
			end
			decrementSellIn(item)
			if item.name == BRIE
				updateBrie(item)
			elsif item.name == CONCERT_PASS
				updateConcertPasses(item)
			else
				updateNormalItem(item)
			end
		end
	end
end
