
echo -n "Set a DC: "
read -r DC

echo -n "Set a modifier: "
read -r mod

# Sets an initial loop to repeat the rolls on a specific DC with a specific mod
loop=1
while(($loop == 1)); do

# Simulates rolling 2d6
d1=$(($(($RANDOM%6))+1))
d2=$(($(($RANDOM%6))+1))

# Pulls the total number of failures and successes from their respective files
fail=$(cat Failures.md)
success=$(cat Successes.md)

# Adds the 2d6 and your modifier to get your total roll
roll=$((d1+d2+mod))

echo ""
echo "You rolled a $roll"

# Checks if you passed the DC and updates successes/failures accordingly
if [[ roll -ge DC ]]; then
	echo "You passed the check!"
	success=$(($success+1))
	echo "$success" > Successes.md
else
	echo "You failed the check"
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

# Keeps track of your current success rate. If you have yet to succeed on a roll,
# it sets the rate to 0

if [[ -z $success ]]; then 
	rate=0
else 
	rate=$(($success*100/$count))
fi

# Displays the data
echo "Total number of rolls: $count"
echo "Sum of all rolls: $sum" 
echo "average roll = $(($sum/$count))"
echo "Total number of failures: $fail"
echo "Total number of successes: $success"
echo "Your current success rate is $rate%"
echo""

# Sets a loop for input validation
repeat=1
while(($repeat == 1)); do

echo -n "Would you like to try again? (y/n) "
read -r choice

# Either ends or continues the current DC & mod loop
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
repeat=1
while(($repeat == 1)); do

echo -n "Would you like to clear your results? (y/n) "
read -r choice

if [ $choice == y ]; then
        bash ClearResults.sh
	echo "Results have been cleared"
        repeat=0
elif [ $choice == n ]; then
        repeat=0
else
        echo "Input error, please try again."
fi
done

