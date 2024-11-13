
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
