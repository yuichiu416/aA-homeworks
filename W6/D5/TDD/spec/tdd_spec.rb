require "tdd"

describe "TDD" do
    describe "#my_uniq" do
        arr = [1,2,1,3,3] 

        it "should return a list of ordered unique pairs" do
            expect(my_uniq(arr)).to eq([1,2,3])
        end
    end

    describe "#two_sum" do
        arr = [-1, 0 , 2, -2, 1]
        it "should find all pairs of positons where elements at those positions sum to zero" do
            expect(two_sum(arr)).to eq([[0,4], [2,3]])
        end
    end

    describe "#my_transpose" do
        rows = [[0, 1, 2],
                [3, 4, 5],
                [6, 7, 8]]
        it "should switch the value of rows and columns" do
            expect(my_transpose(rows)).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
        end
    end

    describe "#stock_picker" do

    end
end


# Stock Picker
# Write a method that takes an array of stock prices (prices on days 0, 1, ...), and outputs the most profitable pair of days on which to first buy the stock and then sell the stock. Remember, you can't sell stock before you buy it!

#[5,4,3,2,1,0] => 0
#[0,1,2,3,4,5] => 5

# Towers of Hanoi
# Write a Towers of Hanoi game.

# Keep three arrays, which represents the piles of discs. Pick a representation of the discs to store in the arrays; maybe just a number representing their size. Don't worry too much about making the user interface pretty.

# In a loop, prompt the user (using gets) and ask what pile to select a disc from, and where to put it.

# After each move, check to see if they have succeeded in moving all the discs, to the final pile. If so, they win!

# Note: don't worry about testing the UI. Testing console I/O is tricky (don't bother checking gets or puts). Focus on:

# #move
# #won?