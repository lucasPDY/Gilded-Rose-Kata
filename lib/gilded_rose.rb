class GildedRose
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

	
	def update_quality
		@items.each do |item|
			if item.name == "Sulfuras, Hand of Ragnaros"
				next
			end
			if item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert"
				decrementQuality(item,0)
			else
				if item.quality < 50
					item.quality += 1
					if item.name == "Backstage passes to a TAFKAL80ETC concert"
						if item.sell_in < 11
							incrementQuality(item, 50)
						end
						if item.sell_in < 6
							incrementQuality(item, 50)
						end
					end
				end
			end
			item.sell_in -=  1
			if item.sell_in < 0
				if item.name != "Aged Brie"
					if item.name != "Backstage passes to a TAFKAL80ETC concert"
						decrementQuality(item,0)
					else
						item.quality -=  item.quality
					end
				else
					incrementQuality(item, 50)
				end
			end
		end
	end
end
