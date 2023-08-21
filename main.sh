#! /bin/bash


re='^[0-9]+$'
# a function to calculate the number of the day in a given year (out of 365 or 366)
day_of_the_year () { # $1 = year; $2 = month; $3 = day

if [[ "$#" -ne 3 ]]; then
	echo "Error: Invalid number of arguments (must be 3)" >&2
	exit 1
elif [[ ! "$1" =~ $re ]]; then
	echo "Error: $1 is not a valid year"
	exit 1
elif [[ ! "$2" =~ $re ]]; then
	echo "Error: $2 is not a valid month"
	exit 1
elif [[ ! "$3" =~ $re ]]; then
        echo "Error: $3 is not a valid day"
        exit 1
else
	counter=0
	year=$1
	month=$2
	day=$3
	for (( i=1; i<$month; i++ )); do
		days_in_month=$(number_of_days_in_month $year $month)
		let counter=counter+days_in_month
	done
	
	let counter=$counter+$day
	echo $counter
fi

}





#start main
read -p "enter the year, month and day seperated by space : " -a calendar
echo ${#calendar[@]}
if [[ "${#calendar[@]}" -eq "3" ]]; then

	year=${calendar[0]}
	month=${calendar[1]}
	day=${calendar[2]}
	day_of_the_year $year $month $day
else
	echo "Error: You didnt provide 3 valid numbers seperated by space"
fi
