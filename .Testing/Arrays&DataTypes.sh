array=(two 34684621684352468451 "five" 7 11)

#displaying code on the consol
echo "array=(two 34684621684352468451 'five' 7 11)"
echo

echo "array[0]=two"
echo "array[1]=3"
echo "array[2]=five"
echo

echo "declare -a array"
echo "array+=(two)"
echo "array+=(3)"
echo "array+=(five)"

read #pause


#display code
echo "for i in "$ {array[@]}"; do"

echo "        if [[ $ i =~ ^[0-9]+$ ]]; then"
echo "                echo $ i"
echo "        else"
echo "                echo '$ i is not an integer'"
echo "        fi"


read #pause

for i in "${array[@]}"; do

	if [[ $i =~ ^[0-9]+$ ]]; then
		echo $i
	else
		echo "$i is not an integer"
	fi
read #pause
done

#this was used as we were testing the script
#echo -n "Please enter an input: "

#read -r in

#if [[ $in =~ ^[0-9]+$ ]]; then
#       echo $in
#else
#       echo "$in is not an integer"
#fi

#echo -n "Please enter an input: "

#read -r in

#if [[ $in =~ ^[0-9]+$ ]]; then
#       echo $in
#else
#       echo "$in is not an integer"
#fi

#read

#displays code
echo "name='trey'"
echo "name=$ name+1"


name="trey"
name=$name+1
read #pause
echo $name


echo "name+=1"
name+=1
echo $name
read #pause

echo "$ ((name+1))"
name=$((name+1))
read #pause
echo $name
