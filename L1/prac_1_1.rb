load 'text_1_2_2.rb'
puts triarea 8, 5
# => 20.0
puts triarea 7, 3
# => 10.5
puts triarea "hoge", "fuga"
# =>
# text_1_2_2.rb:2:in `*': no implicit conversion of String into Integer (TypeError)
#         from text_1_2_2.rb:2:in `triarea'
#         from prac_1_1.rb:6:in `<main>'
puts triarea [2], [3]
# =>
# text_1_2_2.rb:2:in `*': no implicit conversion of Array into Integer (TypeError)
#         from text_1_2_2.rb:2:in `triarea'
#         from prac_1_1.rb:11:in `<main>'
puts triarea :hoge, :fuga
# =>
# text_1_2_2.rb:2:in `triarea': undefined method `*' for :hoge:Symbol (NoMethodError)
#         from prac_1_1.rb:16:in `<main>'

# 定義がなされていればよい...?

class String
    def *(other)
        return self.length * other.length
    end
end

puts triarea "hoge", "fuga"
# => 8.0