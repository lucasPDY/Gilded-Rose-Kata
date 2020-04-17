class GildedRose
	SULFURAS = "Sulfuras, Hand of Ragnaros"
	BRIE = "Aged Brie"
	CONCERT_PASS = "Backstage passes to a TAFKAL80ETC concert"
	UPPER_QLTY_LIMIT = 50
	LOWER_QLTY_LIMIT = 0
	CONCERT_QUALITY_DOUBLE_LIMIT = 10
	CONCERT_QUALITY_TRIPLE_LIMIT = 5

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
	def updateSellIn(item)
		item.sell_in -=  1
	end

	def update_quality
		@items.each do |item|
			if item.name == SULFURAS
				next
			end
			updateSellIn(item)

			if item.name == BRIE || item.name == CONCERT_PASS
				incrementQuality(item, UPPER_QLTY_LIMIT)
				if item.name == CONCERT_PASS
					if item.sell_in < CONCERT_QUALITY_DOUBLE_LIMIT
						incrementQuality(item, UPPER_QLTY_LIMIT)
					end
					if item.sell_in < CONCERT_QUALITY_TRIPLE_LIMIT
						incrementQuality(item, UPPER_QLTY_LIMIT)
					end
				end
			else
				decrementQuality(item,LOWER_QLTY_LIMIT)
			end
			if item.sell_in < LOWER_QLTY_LIMIT
				if item.name == BRIE
					incrementQuality(item, UPPER_QLTY_LIMIT)
				elsif item.name == CONCERT_PASS
					item.quality -=  item.quality
				else
					decrementQuality(item,LOWER_QLTY_LIMIT)
				end
			end
		end
	end
end
