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
1. Sulfuras, Hand of Ragnaros is a legendary item that never has to be sold or drop in quality, hence we don't need to process it at all and can skip to the next item

