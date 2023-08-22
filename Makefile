SHELL=bash

all: wynton-bench/dev1

wynton-bench/dev1:
	host=dev1.wynton.ucsf.edu path=wynton-bench cron-scripts/extract-total_time.sh
