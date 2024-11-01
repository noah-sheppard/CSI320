[ $# -ne 1 ] && { echo "Usage: $0 <Prefix>"; exit 1; }

prefix=$1

[ ${#prefix} -lt 5 ] && { printf "Prefix length is too short\n Prefix example: 10.0.17\n"; exit 1; }

for i in $(seq 1 254); do

	if ping -c 1 -W 1 "$prefix.$i" &>/dev/null; then echo $prefix.$i
	fi
done
