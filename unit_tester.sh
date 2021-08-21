#!/bin/bash

#Color constants!
R='\033[0;31m' # Red
N='\033[0m'    # No Color
G='\033[0;32m' # Green


process_cases()
{
    numCases=0
    #compare test cases against expected output
    while IFS= read -r inputCommand; IFS= read -r expectedOutput
    do
	 #It's assumed that the program outputs in terms of strings
	 programOutput=$(echo "$inputCommand" | $programPath 2> /dev/null)

	 if [[ $programOutput == $expectedOutput ]]; then

		 #write color codes only if STDOUT is attached to an interactive terminal
		 if [[ -t 1 ]]; then
		 	printf "${G}Test $numCases passed!${N}\n"
		 else
			printf "Test $numCases passed!\n"
		 fi

		 if [[ $verbosity -ge 2 ]]; then
		 	printf "Test Input:     \"$inputCommand\"\n"
			printf "Program Output: \"$programOutput\"\n"
			printf '%s\n' "-----------------"
		 fi
	 else

		 if [[ -t 1 ]]; then
		 	printf "${R}Test $numCases failed!${N}\n"
		 else
			printf "Test $numCases failed!\n"
		 fi

		 if [[ $verbosity -ge 1 ]]; then
			printf "Test Input:      \"$inputCommand\"\n"
		 	printf "Program Output:  \"$programOutput\"\n"
		 	printf "Expected Output: \"$expectedOutput\"\n"
			printf '%s\n' "-----------------"
		 fi
	 fi

	 numCases=$((numCases+1))
    done
}

# 0 | Least verbose: suppress printing I/O for both successful and failed case
# 1 | Suppress printing I/O for successful cases only
# 2 | Most verbose: Do not suppress printing I/O
verbosity=2
programPath=./Main

while [ "$1" != "" ]; do
    case $1 in
	-v | --verbosity )	shift
				verbosity=$1
				;;
	-p | --program )        shift
				programPath=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

process_cases
exit
