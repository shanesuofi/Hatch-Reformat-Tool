#Hatch Reformat Tool: Main File

load 'hrt_lib.rb'

in_file = ARGV[0]
puts "### Opening \"#{in_file}\" ..."
ins = File.open(in_file, "r:iso-8859-1")
#-----------------------------------------------------------------------

#Write reformated data to file
def write_file(metadata, csv_doc, in_file)
  #outs = File.open("temp/#{in_file}", "w:iso-8859-1")
  outs = File.open("NEW_#{in_file}", "w:iso-8859-1") #default output filename
  if (!metadata.empty?)
    outs.puts(metadata) # write data to file
    #outs.puts("\r\n")
  end
  
  outs.puts(csv_doc) # write data to file
end
#-----------------------------------------------------------------------

########################################################################

doc = convert_to_string(ins) #Converts file obj to string
#p "input string...", doc
#puts

comm = ARGV
retval = process_comm(comm, doc) #returns array [metadata,data]
metadata = retval[0]
doc = retval[1]

#p "metadata", metadata
#puts
#puts "doc", doc, ""

iterator = metadata << doc
puts "iterator", iterator

#-----------------------------------------------------------------------
if ( comm.include?("csv") )
  retval_arr = hrt_filter_data_columns_csv(doc) #CSV filter
  csv_doc = retval_arr[1]
  #puts "### Message", retval_arr[0]
end
#show_doc(retval_arr)  #p csv_doc

#puts "### Writing data..."
#write_file(metadata, csv_doc, in_file) #Save to file
#puts "### finished writing."

#detect_err(csv_doc)
