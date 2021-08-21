# CS-161-Unit-Tester
A quickly hacked together unit tester in bash for UChicago's CS 161 Class.


## Usage
The script expects a newline(`\n`) delimited list of alternating inputs and outputs, with the intended use of pipes redirecting files into the script.


### Example
```
$ cat test_cases.txt
input
output
input
output
input
output
$ ./unit_tester.sh -p ./Main -v 2 < test_cases.txt`
```


## Flags

### -v | --verbosity
How verbosely the script should report the unit tests

`0`: Suppress all input and output and only display whether a test passed or failed

`1`: Only show I/O for failed tests

`2`: Show I/O for failed and successful tests

Note that whenever a test fails, the script will always print the expected and actual output.

### -p | --program
Where the script should look for the program executable to test.
This can be either an absolute or relative path.

### -h | --help
Exactly what it says on the tin.
Also doesn't work yet.

### Default
```
-v 2
-p ./Main
```
