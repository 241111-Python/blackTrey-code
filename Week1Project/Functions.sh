#!/usr/bin/bash
ClearResults()
{

repeat=1
while(($repeat == 1)); do

echo -n "Would you like to clear your results? (y/n) "
read -r choice

if [ $choice == y ]; then
        > Rolls.md
	> Failures.md
	> Successes.md
        echo "Results have been cleared"
        repeat=0
elif [ $choice == n ]; then
        repeat=0
else
        echo "Input error, please try again."
fi
done

}

DisplayResults()
{

# input number of fails, successes, the current DC, mod, and spec
fail=$1
success=$2
DC=$3
mod=$4
spec=$5



# Adds all rolls into a sum
sum=0
while IFS= read -r line; do
	sum=$((sum+line))
done < Rolls.md

count=$((fail+success))

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

#Stores stats into GlobalStats
echo "  $DC     $mod     $count       $(($sum/$count))    $rate%     $spec   $(date)" >> GlobalStats.md

}