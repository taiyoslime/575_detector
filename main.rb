def syllable_count str
	str.gsub(/ャ|ュ|ョ/,"").size
end

def detect_575 str, phrase = [5,7,5]
	ar = `echo #{str} | mecab`.split(/EOS|\n/).inject([]){ |res, e|
		ln = e.split(/\t|,/);
		res<<[ln[0],ln[1],(ln[9].nil? ? ln[0].size : syllable_count(ln[9]))]
	}
	result = []
	cp = -> (n,ctn,pos,res){
		if ctn == phrase[n]
			next res if n+1 == phrase.size
			next cp.call(n+1,0,pos,res + " ")
		elsif (ctn == 0 && ar[pos][1] == ("助詞"||"助動詞")) || ctn > phrase[n] || pos == ar.size
			next nil
		end
		next cp.call(n,ctn+ar[pos][2],pos+1,res+ar[pos][0])
	}
	ar.size.times{ |e| result << cp.call(0,0,e,"") }

	result.compact
end
