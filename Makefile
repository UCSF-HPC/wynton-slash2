SHELL=bash

all: wynton-bench/dev1 wynton-bench/dev2 wynton-bench/dev3

release-lock:
	file=.git/index.lock; \
	if [[ -f "$${file}" ]]; then \
	  now=$$(date +%s); \
	  mtime=$$(stat -c %Y "$${file}"); \
	  if (( now - mtime > 600 )); then \
	    rm "$${file}"; \
	  fi; \
	fi

wynton-bench/%: release-lock
	date
	git pull
	host=$(@F).wynton.ucsf.edu path=wynton-bench cron-scripts/extract-total_time.sh
	git commit wynton-bench/ -m "Update wynton-bench data on $(@F) (from '$(HOSTNAME)' by '$(USER)')" || true

push:
	git push || true
