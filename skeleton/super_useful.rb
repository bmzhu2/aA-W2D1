# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue
    nil
  end
end

# PHASE 3
class CoffeeError < StandardError

end

FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise StandardError 
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  begin
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue CoffeeError => e
    puts "That's not a fruit but because I'm a friendly monster, I'll let you try again :D"
    retry
  rescue 
    puts "That's not a fruit D:"
  end
end  

# PHASE 4
class NotEnoughYearsError < StandardError
end

class BlankInputError < StandardError
end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise NotEnoughYearsError if yrs_known < 5
    raise BlankInputError  if name.length <= 0 || fav_pastime.length <= 0

    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


