def syllable_count str
	str.gsub(/[ャュョ]/,"").size
end

def detect_575 str, phrase:[5,7,5], amari:true, tarazu:false
	ar = `echo #{str} | mecab`.split(/EOS|\n/).inject([]){ |res, e|
		ln = e.split(/\t|,/);
		res<<[ln[0],ln[1],ln[2],(ln[9].nil? ? ln[0].size : syllable_count(ln[9]))]
	}
	result = []
	cp = -> (n,ctn,pos,res){
		#p n,ctn,pos,res
		qu = [phrase[n]];qu << phrase[n] + 1 if amari;qu << phrase[n] - 1 if tarazu
		if qu.include?(ctn)
			if n+1 == phrase.size
				p res
				next res
			elsif pos < ar.size
				next cp.call(n+1,0,pos,res + " ") || cp.call(n,ctn+ar[pos][3],pos+1,res+ar[pos][0])
			else
				next cp.call(n+1,0,pos,res + " ") 
			end
		elsif pos == ar.size || (ctn == 0 && (["助詞","助動詞"].include?(ar[pos][1]) || (ar[pos][1] != "動詞") && ["非自立"||"接尾"].include?(ar[pos][2]))) || ctn > phrase[n]+1
			next nil
		end
		next cp.call(n,ctn+ar[pos][3],pos+1,res+ar[pos][0])
	}
	ar.size.times{ |e| result << cp.call(0,0,e,"") }

	result.compact
end
