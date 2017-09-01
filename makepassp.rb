require 'securerandom'

dict_file = '/usr/share/dict/words'
max_word_length = 12
power = 4

words = File.read(dict_file).split /\n/

puts "Dictionary Word Count: \t#{words.count}"

words.select! do |word|
    word =~ /^[a-z]*$/ and word.length <= max_word_length
end

word_count = words.count

puts "Accepted Word Count: \t#{word_count}"
puts "Bits of Entropy: \t#{Math.log2(word_count ** power)}"

print "\nPassphrase: \t\t"
puts power.times.map { words[SecureRandom.random_number word_count] } * ' '
puts
