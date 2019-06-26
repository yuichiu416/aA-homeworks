require_relative "game"

game = Game.new
game.grid.render
sleep(3)
game.grid.flipAll
while !game.grid.won?
    game.play
end