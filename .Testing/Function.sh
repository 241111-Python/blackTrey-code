
d1=$(($(($RANDOM%6))+1))
d2=$(($(($RANDOM%6))+1))
d3=$(($(($RANDOM%6))+1))


if [[ $d1 -ge $d2 || $d1 -ge $d3 ]]; then
	roll+=($d1)
fi

if [[ $d2 -gt $d1 || $d2 -ge $d3 ]]; then
	roll+=($d2)
fi

if [[ $d3 -gt $d1 || $d3 -gt $d2 ]]; then
	roll+=($d3)
fi

for i in "${roll[@]}"; do
	echo $i
done


