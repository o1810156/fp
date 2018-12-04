# じゃんけんゲームを作成した(英語でrock-paper-scissors)

$hand_kind = {r: "ぐー", p: "ぱー", s: "ちょき"}

$judge_kind = ["まけ", "あいこ", "かち"]

$judge_man = { # $judge_man[hand][cpu]
    r: {r: 1, p: 0, s: 2},
    p: {r: 2, p: 1, s: 0},
    s: {r: 0, p: 2, s: 1}
}

def rps_game(hand)
    cpu = [:r, :p, :s].sample
    judge = $judge_man[hand][cpu]
    return cpu, judge
end

def rps_game_main
    puts "じゃんけんげ～む！！"
    print("ぐー0, ちょき:1, ぱー:2 : ")
    hand = readline
    hand = [:r, :s, :p][hand.sub(/\n/, "").to_i]
    cpu, judge = rps_game(hand)
    puts "あなた: #{$hand_kind[hand]}\nあいて: #{$hand_kind[cpu]}\nはんてい: #{$judge_kind[judge]}"
end

rps_game_main

# =>
# $ ruby prac5.rb
# じゃんけんげ～む！！
# ぐー:0, ちょき:1, ぱー:2 : 0
# あなた: ぐー
# あいて: ぱー
# はんてい: まけ

# $ ruby prac5.rb
# じゃんけんげ～む！！
# ぐー:0, ちょき:1, ぱー:2 : 1
# あなた: ちょき
# あいて: ちょき
# はんてい: あいこ

# $ ruby prac5.rb
# じゃんけんげ～む！！
# ぐー:0, ちょき:1, ぱー:2 : 2
# あなた: ぱー
# あいて: ぐー
# はんてい: かち