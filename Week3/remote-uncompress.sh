#! /bin/bash

ukko="jirihamb@ukko005.hpc.cs.helsinki.fi"
#writes to stdout
uncompress="bzip2 -d < lost24-monitor-temps-and-fans-v2.tar.bz2"
ssh $ukko $uncompress | tar -x