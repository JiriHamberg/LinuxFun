#! /bin/bash
find ~tkt_cam/public_html/2011/$(date +%m)/ -type f -regex '.*\.jpg' | wc -l

