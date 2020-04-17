require_relative 'item_wrapper'
require_relative 'aged_brie'
require_relative 'backstage_passes'

class GildedRose
	SULFURAS = "Sulfuras, Hand of Ragnaros"
	BRIE = "Aged Brie"
	CONCERT_PASS = "Backstage passes to a TAFKAL80ETC concert"
	# MAX_QLTY_LIMIT = 50
	# MIN_QLTY_LIMIT = 0
	# DAYS_LEFT_TO_DOUBLE_CONCERT_QLTY = 10
	# DAYS_LEFT_TO_TRIPLE_CONCERT_QLTY = 5
	# CONCERT_EXPIRY_QLTY = 0
	# DOUBLE = 2
	# TRIPLE = 3
	# SINGLE = 1

	def initialize(items)
		@items = items
	end

	# update the sell in value of a particular item
	def decrementSellIn(item)
		item.sell_in -=  1
	end

	

	def update_quality
		@items.each do |item|
			if item.name == SULFURAS
				next
			end
			decrementSellIn(item)
			if item.name == BRIE
				brie = AgedBrie.new(item)
				brie.update
				# updateBrie(item)
			elsif item.name == CONCERT_PASS
				# updateConcertPasses(item)
				backstagePasses = BackstagePasses.new(item)
				backstagePasses.update
			else
				normalItem = ItemWrapper.new(item)
				normalItem.update
			end
		end
	end
end
