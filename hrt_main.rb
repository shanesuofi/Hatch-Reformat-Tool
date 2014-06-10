#Hatch Reformat Tool: Main File
$csv_hash = false
$add_quotes = false
load 'hrt_lib.rb'

in_file = ARGV[0]
puts "### Opening \"#{in_file}\" ..."
ins = File.open(in_file, "r:iso-8859-1")
#-----------------------------------------------------------------------
#Type 1; Custom filter for Sonde data like the following
#"========","========"
#"    Date","    Time"
#"   m/d/y","hh:mm:ss"
#"--------","--------"
def sonde_data_filter(iterator)
  cut_line(iterator)
  head1 = cut_line(iterator)
  head1_csv = CSV.parse(head1).flatten
  head1_csv.collect!{|str| str.strip}
  
  head2 = cut_line(iterator)
  head2_csv = CSV.parse(head2).flatten
  head2_csv.collect!{|str| str.strip}
  cut_line(iterator)
  
  merged_str = merge_headers(head1_csv, head2_csv, " ", "[", "]")
  
  new_head = merged_str.join(',')
  new_head << "\r\n"
  new_iterator = new_head << iterator
  #puts new_iterator
  return new_iterator
end
#-----------------------------------------------------------------------

doc = convert_to_string(ins) #Converts file obj to string
#p "input string...", doc
#puts

#-----------------------------------------------------------------------
#Command line flag processing.

#Adds quotes to header
if ( ARGV.include?("-q") )
  $add_quotes = true
end

#Parse metadata slice flag
metadata = ""
if ( ARGV.include?("-s") )
  skip_index = ARGV.index("-s") + 1
  skip_lines = ARGV[skip_index].to_i
  metadata = md_slice(doc, skip_lines) #Remove metadata
  #cut_line(doc) #remove line between metadata and header
end

#Parse double header flag
if ( ARGV.include?("-d") )
  doc = double_header(doc) #Merge two row headers
end

#Parse special formats by "types"
if ( ARGV.include?("-t") )
  type_index = ARGV.index("-t") + 1
  type = ARGV[type_index].to_i
  
  if (type == 1)
    doc = sonde_data_filter(doc) #Custom header reformat
  end
end

#Use CSV parsing to convert input string into hash
if ( ARGV.include?("-csvh") )
  $csv_hash = true
end
#-----------------------------------------------------------------------
#puts "doc...", doc, ""
retval_arr = filter_data_columns_csv(doc) #CSV filter
csv_doc = retval_arr[1]
puts "### Message", retval_arr[0]
#show_doc(retval_arr)  #p csv_doc

puts "### Writing data..."
write_file(metadata, csv_doc, in_file) #Save to file
puts "### finished writing."

#detect_err(csv_doc)
