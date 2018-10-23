# a

puts "\na\n"

100.times do |i|
    if i % 2 == 0 || i % 3 == 0 then next end
    printf("%d\n", i)
end

# b

puts "\nb\n"

100.times do |i|
    if i % 15 == 0
        print("fizzbuzz\n")
    elsif i % 3 == 0
        print("fizz\n")
    elsif i % 5 == 0
        print("buzz\n")
    else
        printf("%d\n", i)
    end
end

# c

puts "\nc\n"

100.times do |i|
    if i % 3 == 0 or i.to_s.include?("3")
        printf("aho\n")
    else
        printf("%d\n", i)
    end
end

__END__

b
fizzbuzz
1
2
fizz
4
buzz
fizz
7
8
fizz
buzz
11
fizz
13
14
fizzbuzz
16
17
fizz
19
buzz
fizz
22
23
fizz
buzz
26
fizz
28
29
fizzbuzz
31
32
fizz
34
buzz
fizz
37
38
fizz
buzz
41
fizz
43
44
fizzbuzz
46
47
fizz
49
buzz
fizz
52
53
fizz
buzz
56
fizz
58
59
fizzbuzz
61
62
fizz
64
buzz
fizz
67
68
fizz
buzz
71
fizz
73
74
fizzbuzz
76
77
fizz
79
buzz
fizz
82
83
fizz
buzz
86
fizz
88
89
fizzbuzz
91
92
fizz
94
buzz
fizz
97
98
fizz

c
aho
1
2
aho
4
5
aho
7
8
aho
10
11
aho
aho
14
aho
16
17
aho
19
20
aho
22
aho
aho
25
26
aho
28
29
aho
aho
aho
aho
aho
aho
aho
aho
aho
aho
40
41
aho
aho
44
aho
46
47
aho
49
50
aho
52
aho
aho
55
56
aho
58
59
aho
61
62
aho
64
65
aho
67
68
aho
70
71
aho
aho
74
aho
76
77
aho
79
80
aho
82
aho
aho
85
86
aho
88
89
aho
91
92
aho
94
95
aho
97
98
aho