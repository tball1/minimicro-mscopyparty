//copyparty.ms adds copyparty file server support to MiniMicro.

//usage of this library assumes you have knowledge of copyparty
//use is done at your own risk please make backups

copyparty = {}
copyparty.username = "" //copyparty username
copyparty.pw = "" //copyparty password
copyparty.tld = "serverbox:3923" //the end bit of the url ex: blanket.rocks:8080

copyparty.server = "http://"+copyparty.username+":"+copyparty.pw+"@"+copyparty.tld


create_file = function(filepath,content)
	res = http.put(copyparty.server+"/"+filepath,content)
	return res
end function

upload_file = function(filepath,remotepath)
	
	if remotepath == null then
		remotepath = "/"
	end if
	
	if file.exists(filepath) then
		fileInfo = file.info(filepath)
		fileName = file.name(filepath)
		
		if fileInfo.isDirectory then
			print("Uploading of folders isnt supported :(")
			return
		end if
		
		fileHandle = file.open(filepath,"r")
		
		create_file(remotepath+"/"+fileName,fileHandle.read)
		
	end if
end function

read_file = function(filepath)
	if filepath == null then
		filepath = "/"
	end if
	//res = http.get(copyparty.server+path+"?ls")
	res = http.get(copyparty.server+"/"+filepath+"?dl")
	
	print res
end function


//create_file("test.txt","Hello, world")
//read_file("test.txt")
//upload_file("/usr2/test.ms")



