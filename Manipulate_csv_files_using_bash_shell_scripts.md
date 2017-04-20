# Manipulate csv files using bash shell scripts 

## Explore a csv file

### How to view the entire file contents  

`$ awk '{print $0}' file`  

`$0` stands for the entire line  


### How to view the first column of a csv file   

Will `$ awk '{print $1}' file` work? 
`$1` stands for the first column

It doesn't work, because it reads white space as the delimiter.  

To deal with csv file, we need to specify the delimiter as comma. Use `-F` or `FS`  

`awk -F","  '{print $1}' file`   

Another way to do it is `$ awk  '{print $1}' FS="," file`


## Modify a csv file


### How to add the filename as the first column in a csv file  

`awk '{print FILENAME"," $0}' file`


### How to remove rows from csv file after adding the filename in the prior step  

Use`|` to pipe the steps together

`awk '{print FILENAME"," $0}' file | tail -n +7`


## How to modify many many more csv files

Say we have 100 csv files in a folder, we want to modify each of them in the same way. How can we do it fast?  
We need a pipeline to run a sequence of commands on multiple files


### Start a bash script 

To initiate a empty script named "try.sh" `vi try.sh`  
Bash scripts have the extension .sh


### Edit a bash script in a simple text editor

Type in the editor. Use a `for` loop to repeatly edit every csv file in the current folder
`do` 

Type `i` to insert contents:

`#!/bin/bash
  set -e
  set -u
  set -o pipefail
for each_file in *.csv
do
   awk '{print FILENAME"," $0}' $each_file | tail -n +7 >> results
done`

Notes:
`#!/bin/bash` indicates the path to the interpreter used to execute the script
`set -e` prevents the shell script from proceeding if one of its commands fails
`set -u` aborts a script if an unset variable is encountered
`set -o pipefail` indicates any error in a pipe should cause exit

Type `esc` followed by `:wq` to save and exit

### Running a bash script

`chmod 700 try.sh`
`./try.sh`



### Another script that does the same thing

Make a file that contains all the filenames as a long list, and then, loop through the list.

`ls *.csv >> files.txt`

`cat files.txt` check what we have in the new file named "files.txt"

`#!/bin/bash
  set -e
  set -u
  set -o pipefail
files=files.txt
file_names=($(cut -f1 "$files"))
for each_file in ${file_names[@]}
do
   awk '{print FILENAME"," $0}' $each_file | tail -n +7 >> results
done`