require 'pry'

class Solver
  def initialize
  end


  def main
    set_number_of_digits
    set_initial_array
    set_test_array
    @master_c = 0
    tentativi = 0
    loop do
      statistics
      puts "next guess: #{@guess}"
      tentativi += 1
      puts "Tentativo numbero #{tentativi}"
      puts "guess: "
      print "> "
      guess = gets.chomp
      puts 'Bulls + Cows:'
      print '> '
      combination_value = gets.chomp
      filter_array(guess, combination_value)
    end
  end

  def filter_array(guess, combination_value)
    @master_c += 1
    @permutation_array.reject! do |array|
      array_value = 0
      guess.split('').each do |number|
        if array.include?(number.to_i)
          array_value += 1
        end
      end
      array_value != combination_value.to_i
    end
    return if @master_c < 4
    if @guess
      @permutation_array.reject! {|w| w == @guess }
    end
    calculate_next_guess
  end

  def statistics
    puts "Combinazioni possibili --> #{@permutation_array.count}"
  end

  def set_number_of_digits
    puts 'Sets the number of digits'
    @number_of_digits = gets.chomp.to_i
    puts "The current number of digits is: #{@number_of_digits}"
  end
  
  def set_initial_array
    @permutation_array = [0,1,2,3,4,5,6,7,8,9].permutation(@number_of_digits).to_a
  end

  def set_test_array
    @test_array = [0,1,2,3,4,5,6,7,8,9].permutation(@number_of_digits).to_a
  end

  def calculate_next_guess
    cc = 0
    possible_guesses = @permutation_array.map do |possible_guess|
      cc += 1
      hit_counts = @test_array.each_with_object(Hash.new(0)) do |potential_solution, counts|
        t = 0
        potential_solution.each do |n|
          if possible_guess.include?(n)
            t += 1
          end
        end
        counts[t] += 1
      end
      highest_hit_count = hit_counts.values.max || 0
      if cc % 100 == 0
        puts cc
      end
      [highest_hit_count, possible_guess]
    end
    @guess = possible_guesses.min.last
  end
end


# potential_pattern_count = potential_patterns.length
# possible_guesses = unused_patterns.map do |possible_guess|
#   hit_counts = potential_patterns.each_with_object(Hash.new(0)) do |potential_pattern, counts|
#     counts[@scorer.score(potential_pattern, possible_guess)] += 1
#   end

#   highest_hit_count = hit_counts.values.max || 0

#   membership_value = potential_patterns.include?(possible_guess) ? 0 : 1

#   [highest_hit_count, membership_value, possible_guess]
# end

# guess = possible_guesses.min.last

# guess_count += 1
