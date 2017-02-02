# Overview
*"Haiku"* is a form of Japanese poetry , which consist in three phrases of "5", "7", and "5" on respectively.

Using this program, you can easily detect whether the sentence contains *"Haiku"*.

# Examples

```ruby
>> detect_575 "古池や蛙飛び込む水の音だね"
=> ["古池や 蛙飛び込む 水の音"]

>> detect_575 "やっぱりね、僕は古池こそ蛙飛び込む水の音だと思うんだよね"
=> ["古池こそ 蛙飛び込む 水の音"]

>> detect_575 "進捗を進捗をだせ進捗をいいからさっさと進捗をだせ", phrase:[5,7,5,7,7]
=> ["進捗を 進捗をだせ 進捗を いいからさっさと 進捗をだせ"]

>> detect_575 "柿くへば鐘が鳴るなり法隆寺も、いくたびも雪の深さを尋ねけりも、有名な正岡子規の俳句です"
=> ["柿くへば 鐘が鳴るなり 法隆寺", "いくたびも 雪の深さを 尋ねけり", "有名な 正岡子規の 俳句です"]
```
# Dependencies

- Ruby (developing with v2.4)
- [mecab](http://taku910.github.io/mecab/#download)

```
# Homebrew :
$ brew install mecab mecab-ipadic

# apt-get :
$ sudo apt-get install mecab libmecab-dev mecab-ipadic

# yum :
$ sudo rpm -ivh http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm
$ sudo yum install mecab mecab-ipadic -y
```

# TODO

- [x] count Japanese syllable accurately. (like *チャ,チュ,チョ etc..)*
- [x] exclude if each phrases start from *"付属語"*.
- [x] support *"字余り"* and *"字足らず"*.
- [ ] support symbols
	- [x] 読点、空白
	- [x] 句点
	- [ ] 括弧
- [ ] support alphabet letters
