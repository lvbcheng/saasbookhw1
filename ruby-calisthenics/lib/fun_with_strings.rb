module FunWithStrings
  # method: palindrome?
  # returns: true if and only if its receiver is a palindrome.
  def palindrome?
    canonical = self.upcase.scan(/\w/)

    return true if canonical == canonical.reverse
    false
  end

  # method: count_words
  # returns: a hash whose keys are words in the string and whose
  # values are the number of times each word appears
  def count_words
    token_hash = Hash.new(0)

    # we take the string and remove all characters that are not space or
    # \w (i.e., punctuation, etc.). Then we tokenize the string. This is
    # our tokenized stream
    tokenized = self.gsub(/[^\w ]/, '').split(' ')

    tokenized.each do |token|
      # generate the key. By choice, the canonical key is a downcased string.
      key = token.downcase

      # update the hash
      if token_hash.has_key?(key)
        token_hash[key] += 1
      else
        token_hash[key] = 1
      end
    end
    token_hash
  end

  # method: anagram_groups
  # returns: groups words in the string into anagram groups and returns
  # the array of groups. Case doesn't matter in classifying string as
  # anagrams (but case should be preserved in the output), and the
  # order of the anagrams in the groups doesn't matter.
 def anagram_groups
    anagram_hash = Hash.new(0)

    # we take the string and remove all characters that are not space or
    # \w (i.e., punctuation, etc.). Then we tokenize the string. This is
    # our tokenized stream
    tokenized = self.gsub(/[^\w ]/, '').split(' ')

    tokenized.each do |token|
      # initialize the key to the empty string
      key = ''

      # By choice the key is a downcased and sorted string.
      #
      # To build the key, split each character and then sort.
      token.downcase.scan(/\w/).sort.each { |x| key = key + x }

      # update the hash
      if anagram_hash.has_key?(key)
        anagram_hash[key] << token
      else
        anagram_hash[key] = [token]
      end
    end

    # all done. Return the anagram's values
    anagram_hash.values
  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end
