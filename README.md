# Overview
*"Haiku"* is a form of Japanese poetry , which consist in three phrases of "5", "7", and "5" on respectively.

Using this program, you can easily detect whether the sentence contains *"Haiku"*.

# TODO

- [x] count Japanese syllable accurately. (like *チャ,チュ,チョ etc..)*
- [x] exclude if each phrases start from *"付属語"*.
- [ ] support *"字余り"* and *"字足らず"*.
- [ ] support symbols
- [ ] support alphabet letters

# Dependencies

- Ruby (developing with v2.4)
- [mecab](http://taku910.github.io/mecab/#download)

```
# Homebrew :
$ brew install mecab mecab-ipadic

# apt-get
$ sudo apt-get install mecab libmecab-dev mecab-ipadic

# yum :
$ sudo rpm -ivh http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm
$ sudo yum install mecab mecab-ipadic -y
```
