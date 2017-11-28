require 'optparse'
require 'securerandom'

# Some defaults
dict_path = '/usr/share/dict/words'
max_word_length = 7
power = 5

OptionParser.new do |opts|
  opts.banner = "Usage: ruby #{$0} [options]"

  opts.on("-dPATH", "--dict-path PATH", String, "Path to dictionary file (default: #{dict_path})") do |path|
    dict_path = path
  end

  opts.on("-lLENGTH", "--max-word-length LENGTH", Integer, "Maximum length of each word (default: #{max_word_length})") do |length|
    max_word_length = length
  end

  opts.on("-wCOUNT", "--word-count COUNT", Integer, "Number of words to generate (default: #{power})") do |count|
    power = count
  end
end.parse!

words = File.read(dict_path).split /\n/

puts "Dictionary Word Count: \t#{words.count}"

words.select! do |word|
    word =~ /^[a-z]*$/ and word.length <= max_word_length
end

word_count = words.count
entropy_bits = Math.log2(word_count ** power)

puts "Accepted Word Count: \t#{word_count}"
puts "Bits of Entropy: \t#{entropy_bits}"

puts "\nStronger than password of #{Math.log(2**entropy_bits, 95).floor} random typeable ASCII characters or #{Math.log(2**entropy_bits, 36).floor} random lowercase alphanum characters"

print "\nPassphrase: \t\t"
puts power.times.map { words[SecureRandom.random_number word_count] } * ' '
puts
