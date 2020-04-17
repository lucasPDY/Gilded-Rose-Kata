class GildedRose
	SULFURAS = "Sulfuras, Hand of Ragnaros"
	BRIE = "Aged Brie"
	CONCERT_PASS = "Backstage passes to a TAFKAL80ETC concert"
	UPPER_QLTY_LIMIT = 50
	LOWER_QLTY_LIMIT = 0
	CONCERT_QUALITY_DOUBLE_LIMIT = 10
	CONCERT_QUALITY_TRIPLE_LIMIT = 5
	CONCERT_EXPIRY_VALUE = 0

	def initialize(items)
		@items = items
	end

=begin
This function takes an item and a qualityLimit, and increments the quality of the item if it hasn't reached the limit 
=end
	def incrementQuality(item, qualityLimit)
		if item.quality < qualityLimit
			item.quality += 1
		end
	end 

	def decrementQuality(item, qualityLimit)
		if item.quality > qualityLimit
			item.quality -= 1
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

	def update_quality
		@items.each do |item|
			if item.name == SULFURAS
				next
			end

			decrementSellIn(item)
			if item.name == BRIE
				incrementQuality(item, UPPER_QLTY_LIMIT)
				# if Brie has expired, increment its quality
				if hasExpired(item)
					incrementQuality(item, UPPER_QLTY_LIMIT)
				end
			elsif item.name == CONCERT_PASS
				incrementQuality(item, UPPER_QLTY_LIMIT)
				# if there are less than CONCERT_QUALITY_DOUBLE_LIMIT days to concert, decrement again
				if item.sell_in < CONCERT_QUALITY_DOUBLE_LIMIT
					incrementQuality(item, UPPER_QLTY_LIMIT)
				end
				# if there are less thatn CONCERT_QUALITY_TRIPLE_LIMIT days to concert, decrement again
				if item.sell_in < CONCERT_QUALITY_TRIPLE_LIMIT
					incrementQuality(item, UPPER_QLTY_LIMIT)
				end
				# if concert passes has expired, its quality is 0
				if hasExpired(item)
					item.quality = CONCERT_EXPIRY_VALUE
				end
			else
				decrementQuality(item,LOWER_QLTY_LIMIT)
				# if it is a normal item, decrement twice as fast
				if hasExpired(item)
					decrementQuality(item,LOWER_QLTY_LIMIT)
				end
			end
		end
	end
end
