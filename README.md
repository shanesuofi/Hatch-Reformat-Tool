Hatch-Reformat-Tool
===================

The Hatch Reformat Tool (HRT) contains experimental code for the Hatch database to test working with special case file formats and reformatting them for Hatch import.  HRT is a standalone tool written in Ruby for easy merging with Hatch.

Instructions
===================

HRT takes a CSV file and command line flags and attempts to reformat that file into a format that is acceptable for importing into Hatch.  The basic HRT interface is as follows:

ruby hrt_main.rb **filename** [flags]

HRT expects the first argument to be the input file name.

#### Flags

The basic reformatting options available in HRT are:

* **-csvh**  tells HRT to take CSV parsed data and convert it into a hash.
* **-d**  tells HRT that the file contains a “double header”.  HRT will merge the two header lines into a single header line.
* **-q** tells HRT to add quotation marks around the header.
* **-s n**  tells HRT to “skip” (ignore) the first **n** lines of the input file.  This is intended to move past imbedded metadata.

Additional reformatting options for custom file types.

* **-t 1**  custom filter for data where the header lines 1 and 4 are “junk” lines but lines 2 and 3 are a double header (junk lines are discarded).
