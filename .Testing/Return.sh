d1=$(($(($RANDOM%6))+1))
			d2=$(($(($RANDOM%6))+1))
			d3=$(($(($RANDOM%6))+1))

			declare -a raw

			if [[ $d1 -ge $d2 || $d1 -ge $d3 ]]; then
        			raw+=($d1)
			fi

			if [[ $d2 -gt $d1 || $d2 -ge $d3 ]]; then
        			raw+=($d2)
			fi

			if [[ $d3 -gt $d1 || $d3 -gt $d2 ]]; then
        			raw+=($d3)
			fi
			roll=$((raw[0]+raw[1]))
			echo "$d1 $d2 $d3 ${raw[0]} ${raw[1]} $roll"
