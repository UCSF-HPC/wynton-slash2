SHELL=bash

all: wynton-bench/dev1

wynton-bench/dev1:
	git pull
	host=dev1.wynton.ucsf.edu path=wynton-bench cron-scripts/extract-total_time.sh
	git commit wynton-bench/ -m "Update wynton-bench data"
	git push --force
