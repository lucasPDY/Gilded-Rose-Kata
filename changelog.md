Below are a few issues with the current code:
1. There is far too many nested if conditions in the original code, which makes it difficult to change/updated
Ideally, a flat if-elseif-else structure would be better in the long run
2. The generally flow of the code has numerous overlapping conditionals, hence the logic is everywhere and hard to pinpoint.
Eg. Checking if the item is NOT the "Sulfuras, Hand of Ragnaros" appears numerous times in the code
3. So many magic numbers and strings everywhere o.O
4. There also seems to be a lot of negative conditionals in the code, that are also repeated numerous times.
Eg. Checking if the particular item is not "Aged Brie" nor Concert Tix
In this case, would be better to format it and put each of these code in their own if-elseif-else block

Here are the steps that I've taken to refactor the code:
1. Replaced all incrementation and decrementation with `+=` and `-=` respectively
2. Sulfuras, Hand of Ragnaros is a legendary item that never has to be sold or drop in quality, hence we don't need to process it at all and can skip to the next item
3. The code increment and decrement the item's quality is repeated several times.
e.g. ```
if item.quality < 50
    item.quality += 1
end
```
Refactored it by creating another function `incrementQuality(item, qualityLimit)` that takes an item and a qualityLimit, and increments the quality of the item if it hasn't reached the limit. Did the same for `decrementQuality`
4.