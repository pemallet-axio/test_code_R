# plumber0.R

library(readr)

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  list(msg = paste0("The message is : '", msg, "'"))
}

#* Plot a histogram
#* @serializer png
#* @get /plot
function() {
  rand <- rnorm(100)
  hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
  as.numeric(a) + as.numeric(b)
}


#* Read a csv file and print it as a df
#* @post /load
function(req, res) {
	if(missing(req)){
		stop("Pas de fichier uploadé !")
	}
    mp <- mime::parse_multipart(req)
	print(mp)
    df <- readr::read_csv(mp$file$datapath)
	print("Fichier reçu !")
	print(df)
	#write.csv(df, "dummy_data_out2.csv")
	#print("Fichier écrit !")
}



############### Reponse

#* Return a txt
#* @get /sendtxt
function(req, res){
  include_file("test.txt", res)
}

#* Return a html
#* @get /sendhtml
function(req, res){
  include_file("test.html", res)
}

#* Return a csv
#* @get /sendcsv
function(req, res){
  include_file("dummy_data.csv", res)
}

#* Return a xlsx
#* @get /sendxlsx
function(req, res){
  include_file("test.xlsx", res, content_type = getContentType(tools::file_ext("test.xlsx")))
}
