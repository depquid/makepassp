require 'optparse'
require 'securerandom'

# Some defaults
dict_file = '/usr/share/dict/words'
max_word_length = 7
power = 5

OptionParser.new do |opts|
  opts.banner = "Usage: ruby $0 [options]"

  opts.on("-lLENGTH", "--max-word-length LENGTH", Integer, "Maximum length of each word") do |length|
    max_word_length = length
  end

  opts.on("-wCOUNT", "--word-count COUNT", Integer, "Number of words to generate") do |count|
    power = count
  end
end.parse!

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
