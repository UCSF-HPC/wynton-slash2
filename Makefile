SHELL=bash

all: wynton-bench/dev1 wynton-bench/dev2 wynton-bench/dev3

wynton-bench/%:
	date
	git pull
	host=$(@F).wynton.ucsf.edu path=wynton-bench cron-scripts/extract-total_time.sh
	git commit wynton-bench/ -m "Update wynton-bench data" || true
	git push || true
