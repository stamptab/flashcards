module Flashcards
  class Application
    def initialize
      @decks = []
    end
    
    def << deck
      @decks << deck
    end
    
    def play
      display_decks
      puts "Pick a deck: "
      deck = get_deck
      deck.play
    end
    
    def display_decks
      @decks.each { |deck| puts deck.name }
    end
    
    def get_deck
      name = gets.chomp
      @decks.detect { |deck| deck.name == name }
    end
    
  end
  
  class Card
    attr_accessor :front, :back
  
    def initialize front, back
      @front = front
      @back = back
    end
    
    def correct? guess
      guess == @back
    end
    
    def play
      puts "#{front} > "
      guess = gets.chomp
      if correct?(guess)
        puts "Correct"
      else
        puts "Incorrect. The answer was #{back}"
      end
    end
    
  end
  
  class MultipleAnswerCard < Card
    def correct? guess
      answers = @back.split(",")
      answers.any? { |answer| answer == guess }
    end
  end
  
  
  class Deck
    attr_reader :cards, :name
    def initialize name
      @name = name
      @cards = []
    end
    
    def << card
      @cards << card
    end
    
    def play
      shuffle
      @cards.each(&:play)
    end
    
    def shuffle
      @cards.shuffle!
    end
  end
end

card = Flashcards::MultipleAnswerCard.new("Violin", "baiorin,vuuorin")

deck = Flashcards::Deck.new("Japanese")
deck << card

deck2 = Flashcards::Deck.new("Russian")

app = Flashcards::Application.new
app << deck
app << deck2
app.play

# deck.cards.each do |card|
#   front = card.front
#   back = card.back
  
#   print "#{front} > "
#   guess = gets.chomp
  
#   if card.correct?(guess)
#     puts "Correct"
#   else
#     puts "Incorrect. The answer was #{back}."
#   end
# end