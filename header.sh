#!/bin/bash
#Copyright IBM Corp. 2017. All Rights Reserved.
#Licensed under "The MIT License (MIT)"
h_one="// Copyright IBM Corp. 2017. All Rights Reserved."
h_two="// Licensed under \"The MIT License (MIT)\""
for i in $(find  . -type f | grep -v node_modules | grep js$) ; do
  line_one=$(head -n 2  $i | head -n 1)
  line_two=$(head -n 2  $i | tail -n 1)
	# echo if [ [ "$line_one" != "$h_one" ] && [ "$line_two" != "$h_two" ] ] \; then
  if  [ "$line_one" != "$h_one" ] && [ "$line_two" != "$h_two" ]  ; then
		echo "Updating $i"
    echo $h_one >> ${i}_tmp
    echo $h_two >> ${i}_tmp
    cat $i >> ${i}_tmp
		mv ${i}_tmp $i
	elif [ "$line_one" != "$h_one" ] || [ "$line_two" != "$h_two" ] ; then
		echo "header issue for $i "
		exit 1
  fi
done

h_one="#Copyright IBM Corp. 2017. All Rights Reserved."
h_two="#Licensed under \"The MIT License (MIT)\""
for i in $(find  . -type f | grep -v node_modules | grep yaml$) ; do
  line_one=$(head -n 2  $i | head -n 1)
  line_two=$(head -n 2  $i | tail -n 1)
	# echo if [ [ "$line_one" != "$h_one" ] && [ "$line_two" != "$h_two" ] ] \; then
  if  [ "$line_one" != "$h_one" ] && [ "$line_two" != "$h_two" ]  ; then
		echo "Updating $i"
    echo $h_one >> ${i}_tmp
    echo $h_two >> ${i}_tmp
    cat $i >> ${i}_tmp
		mv ${i}_tmp $i
	elif [ "$line_one" != "$h_one" ] || [ "$line_two" != "$h_two" ] ; then
		echo "header issue for $i"
		exit 1
  fi
done

h_one="#!/bin/bash"
h_two="#Copyright IBM Corp. 2017. All Rights Reserved."
h_three="#Licensed under \"The MIT License (MIT)\""
for i in $(find  . -type f | grep -v node_modules | grep sh$) ; do
  line_one=$(head -n 1  $i | tail -n 1)
  line_two=$(head -n 2  $i | tail -n 1)
	line_three=$(head -n 3  $i | tail -n 1)
  if  [ "$line_one" != "$h_one" ] && [ "$line_two" != "$h_two" ] && [ "$line_three" != "$h_three" ]  ; then
		echo "Updating $i"
    echo $h_one >> ${i}_tmp
    echo $h_two >> ${i}_tmp
		echo $h_three >> ${i}_tmp
    cat $i >> ${i}_tmp
		mv ${i}_tmp $i
	elif  [ "$line_one" != "$h_one" ] || [ "$line_two" != "$h_two" ] || [ "$line_three" != "$h_three" ]  ; then
		echo "header issue for $i"
		exit 1
  fi
done
