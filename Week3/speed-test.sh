#! /bin/bash

testLocal() {
	echo "Testing local compression time..."
	localTemp=$(mktemp -d)
	testCommand="tar -xjf lost24-monitor-temps-and-fans-v2.tar.bz2 -C $localTemp"
	time $testCommand
	echo "Done, cleaning up temp files..."
	rm -r $localTemp
}

testRemote() {
	echo "Testing remote compression time..."
	#localTemp=$(mktemp -d)
	ukko="jirihamb@ukko005.hpc.cs.helsinki.fi"
	uncompress="bzip2 -d < lost24-monitor-temps-and-fans-v2.tar.bz2"
	testCommand="ssh $ukko $uncompress | tar --extract"
	#"ssh $ukko $uncompress | tar --extract --directory=$localTemp" does not work for some reason
	time $testCommand
	echo "Done, cleaning up temp files..."
	#rm -r $localTemp
}

testLocal
testRemote