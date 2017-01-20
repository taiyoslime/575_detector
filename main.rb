def syllable_count str
	str.gsub(/[ャュョ]/,"").size
end

def detect_575 str, phrase = [5,7,5]
	ar = `echo #{str} | mecab`.split(/EOS|\n/).inject([]){ |res, e|
		ln = e.split(/\t|,/);
		res<<[ln[0],ln[1],ln[2],(ln[9].nil? ? ln[0].size : syllable_count(ln[9]))]
	}
	result = []
	cp = -> (n,ctn,pos,res){
		if pos == ar.size || (ctn == 0 && (ar[pos][1] == ("助詞"||"助動詞") || (ar[pos][1] != ("動詞") && ar[pos][2] == ("非自立"||"接尾")))) || ctn > phrase[n]+1
			next nil
		elsif [*phrase[n]-1..phrase[n]+1].include?(ctn)
			next res if n+1 == phrase.size
			next cp.call(n+1,0,pos,res + " ") || cp.call(n,ctn+ar[pos][3],pos+1,res+ar[pos][0])
		end
		next cp.call(n,ctn+ar[pos][3],pos+1,res+ar[pos][0])
	}
	ar.size.times{ |e| result << cp.call(0,0,e,"") }

	result.compact
end
