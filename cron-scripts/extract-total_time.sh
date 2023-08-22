#! /usr/bin/env bash

host=${host:-${HOSTNAME:?}}
home=${home:-${HOME:?}}
user=${user:-${USER:?}}
path=${path:-${PWD:?}}

[[ -d "$path" ]] || { >&2 echo "ERROR: No such path: ${path}"; exit 1; }

# shellcheck disable=SC2034
export BENCH_LOGPATH=$home/wynton-bench-logs/$host

# Default drives to be tested
dirs=("/wynton/scratch/$user" "$home" "/wynton/group/cbi/$user")

echo "Number of dirs: ${#dirs[@]}"

for dir in "${dirs[@]}"; do
    drive="${dir//\//_}"
    src="${BENCH_LOGPATH}/bench-files-tarball_${drive}.tsv"
    dst="${path}/wynton-bench_${host}_${drive}.tsv"
    echo "[INFO] Considering ${host}:${dir} == ${src}"
    if [[ -f "$src" ]]; then
        echo "[INFO] Processing ${src} -> ${dst}"
        printf "timestamp\tduration\n" > "$dst"
        grep total_time= "$src" | cut -d $'\t' -f 1,21 | sed -E 's/(echo total_time=| seconds)//g' >> "$dst"
    fi
done
