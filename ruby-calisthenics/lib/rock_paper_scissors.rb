class RockPaperScissors

  # Exceptions this class can raise:
  class NoSuchStrategyError < StandardError ; end

  def self.winner(player1, player2)
    player1_choice = player1[1]
    player2_choice = player2[1]

    legal_choices = ['R', 'P', 'S']

    raise NoSuchStrategyError.new, "Strategy must be one of R,P,S" unless legal_choices.include? player1_choice
    raise NoSuchStrategyError, "Strategy must be one of R,P,S" unless legal_choices.include? player2_choice

    # We now know that the choices are all legal
    # Declare player1 the winner if player choices are equal
    return player1 if player1_choice == player2_choice

    # We now know that the choices are legal and different
    case player1_choice
      when 'P'
         case player2_choice
          when 'R' then return player1
          when 'S' then return player2
        end
      when 'R'
        case player2_choice
          when 'P' then return player2
          when 'S' then return player1
        end
      when 'S'
        case player2_choice
          when 'P' then return player1
          when 'R' then return player2
        end
    end
  end

  def self.tournament_winner(tournament)
    # how do you determine that you are seeing the base case
    if basic_tournament(tournament)
      winner(tournament[0], tournament[1])
    else
      left_winner = tournament_winner(tournament[0])
      right_winner = tournament_winner(tournament[1])
      winner(left_winner, right_winner)
    end
  end

  private
  def self.basic_tournament(tournament)
    tournament[0][0].kind_of?(String)
  end
end

def test_RPS_Class
# the same choice test
  puts "Same choice #1 test" unless RockPaperScissors.winner(['P1', 'P'], ['P2', 'P']) == ['P1', 'P']
  puts "Same choice #1 test" unless RockPaperScissors.winner(['R1', 'R'], ['R2', 'R']) == ['R1', 'R']
  puts "Same choice #1 test" unless RockPaperScissors.winner(['S1', 'S'], ['S2', 'S']) == ['S1', 'S']

# Symmetry tests
  puts "Symmetry test #1 fails" unless RockPaperScissors.winner(['Armando', 'R'], ['Dave', 'P']) == RockPaperScissors.winner(['Dave', 'P'], ['Armando', 'R'])
  puts "Symmetry test #2 fails" unless RockPaperScissors.winner(['Dave', 'R'], ['Armando', 'S']) == RockPaperScissors.winner(['Armando', 'S'], ['Dave', 'R'])


  # bad choices test
  begin
    RockPaperScissors.winner(['P1', 'p'], ['P2', 'P'])
    puts "Exception test: No exception raised"
  rescue RockPaperScissors::NoSuchStrategyError
  rescue Exception => ex
    puts "Exception test: Unexpected exception #{ex.class}"
  end
  begin
    RockPaperScissors.winner(['P1', 'P'], ['P2', 'r'])
    puts "Exception test: No exception raised"
  rescue RockPaperScissors::NoSuchStrategyError
  rescue Exception => ex
    puts "Exception test: Unexpected exception #{ex.class}"
  end

  begin
    RockPaperScissors.winner(['P1', 's'], ['P2', 's'])
    puts "Exception test: No exception raised"
  rescue RockPaperScissors::NoSuchStrategyError
  rescue Exception => ex
    puts "Exception test: Unexpected exception #{ex.class}"
  end

  begin
    RockPaperScissors.winner(['P1', '!!!'], ['P2', 'fff'])
    puts "Exception test: No exception raised"
  rescue RockPaperScissors::NoSuchStrategyError
  rescue Exception => ex
    puts "Exception test: Unexpected exception #{ex.class}"
  end

    begin
    RockPaperScissors.winner(['Armando', 'R'], ['Dave', 'w'])
    puts "Exception test: No exception raised"
  rescue RockPaperScissors::NoSuchStrategyError
  rescue Exception => ex
    puts "Exception test: Unexpected exception #{ex.class}"
  end

end

test_RPS_Class

puts RockPaperScissors.tournament_winner([['Armando', 'R'], ['Dave', 'P']])


