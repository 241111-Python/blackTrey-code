
#Creates data storage files if not present
if ! [ -e "Failures.md" ]; then
	touch "Failures.md"
fi

if ! [ -e "Successes.md" ]; then
	touch "Successes.md"
fi

if ! [ -e "Rolls.md" ]; then
	touch "Rolls.md"
fi


echo -n "Set a DC: "
read -r DC

echo -n "Set a modifier: "
read -r mod

repeat=1
while(($repeat == 1)); do

	echo -n "Are you a Specialist? (y/n): "
	read -r spec

	if [ $spec == y ]; then
        	spec=1
        	repeat=0
	elif [ $spec == n ]; then
        	spec=0
        	repeat=0
	else
        	echo "Input error, please try again."
	fi
done

# Sets an initial loop to repeat the rolls with the current choices

loop=1
while(($loop == 1)); do

	echo -n "How many times would you like to roll? "
	read -r num

	for ((i = 0 ; i < num ; i++)); do
# If they are a Specialist, roll 3d6 keep high 2
		if [[ %spec == 1 ]]; then
			d1=$(($(($RANDOM%6))+1))
			d2=$(($(($RANDOM%6))+1))
			d3=$(($(($RANDOM%6))+1))


			if [[ $d1 -ge $d2 || $d1 -ge $d3 ]]; then
        			raw+=($d1)
			fi

			if [[ $d2 -gt $d1 || $d2 -ge $d3 ]]; then
        			raw+=($d2)
			fi

			if [[ $d3 -gt $d1 || $d3 -gt $d2 ]]; then
        			raw+=($d3)
			fi
			roll=$((raw[0]+raw[1]+mod))

		else
# Otherwise, roll 2d6
			d1=$(($(($RANDOM%6))+1))
			d2=$(($(($RANDOM%6))+1))

			roll=$((d1+d2+mod))
		fi

# Pulls the total number of failures and successes from their respective files
		fail=$(cat Failures.md)
		success=$(cat Successes.md)


# Checks if you passed the DC and updates successes/failures accordingly
		if [[ roll -ge DC ]]; then
			#echo "You passed the check!"
			success=$(($success+1))
			echo "$success" > Successes.md
		else
			#echo "You failed the check"
			fail=$(($fail+1))
			echo "$fail" > Failures.md
		fi

# Keeps track of all your rolls
		echo "$roll" >> Rolls.md

# Adds all rolls into a sum and keeps a tally of the number of rolls
		sum=0
		count=0 
		while IFS= read -r line; do
			sum=$(($sum+$line))
			count=$(($count+1))
		done < Rolls.md
	done
# Keeps track of your current success rate. If you have yet to succeed on a roll,
# it sets the rate to 0
	

	rate=$((${success:-0}*100/$count))



# Displays the data
	echo ""
	echo "Total number of rolls: $count"
	echo "Sum of all rolls: $sum" 
	echo "average roll: $(($sum/$count))"
	echo "Total number of failures: $fail"
	echo "Total number of successes: $success"
	echo "Your current success rate is $rate%"
	echo ""

# Sets a loop for input validation
	repeat=1
	while(($repeat == 1)); do

		echo -n "Would you like to try again? (y/n) "
		read -r choice

# Either ends or continues the current DC, mod, spec loop
		if [ $choice == y ]; then
			loop=1
			repeat=0
		elif [ $choice == n ]; then
			loop=0
			repeat=0
		else
			echo "Input error, please try again."
		fi
	done
done

# Provides a way to clear the data, using the same input validation as above
bash ClearResults.sh
