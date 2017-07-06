require "shellwords"

def parse str
	`echo #{Shellwords.escape(str)} | mecab`.split(/EOS|\n/).inject([]){ |res, e|
		ln = e.split(/\t|,/);
		res<<[ln[0],ln[1],ln[2],(ln[9].nil? ? ln[0].size : ln[9].gsub(/[ャュョ]/,"").size)]
	}.delete_if{|it|
		it[1] == "記号" && ["読点","空白","一般"].include?(it[2])
	}
end

def detect_575 str, phrase:[5,7,5], amari:true, tarazu:false
	cp = -> (n,ctn,pos,res,ar){
		qu = [phrase[n]];qu<<phrase[n]+1 if amari;qu<<phrase[n]-1 if tarazu
		if qu.include?(ctn)
			if n+1 == phrase.size
				next res
			else
				next cp.call(n+1,0,pos,res + " ",ar) || ( pos < ar.size ? cp.call(n,ctn+ar[pos][3],pos+1,res+ar[pos][0],ar) : nil)
			end
		elsif pos == ar.size || (ctn == 0 && (["助詞","助動詞"].include?(ar[pos][1]) || (ar[pos][1] != "動詞") && ["非自立","接尾"].include?(ar[pos][2]))) || ctn > phrase[n]+1
			next nil
		end
		next cp.call(n,ctn+ar[pos][3],pos+1,res+ar[pos][0],ar)
	}
	str.gsub(/,/,"、").gsub(/\./,"。").split("。").reduce([]){ |res,e| res<<parse(e)
	}.reduce([]){ |res,_ar|
		_ar.size.times{ |e| res << cp.call(0,0,e,"",_ar) };res
	}.compact
end
