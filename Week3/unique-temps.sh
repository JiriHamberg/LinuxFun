#! /bin/bash
grep -R --exclude=hp-fans.txt "PROCESSOR_ZONE" lost24/monitor/2011.12.25 | sed 's/\ \+/ /g' | cut -d ' ' -f3 | cut -d '/' -f1 | sort | uniq