#! /bin/bash

re='^[0-9]+$'

month_in_year () {
	if [[ "$#" -ne 2 ]]; then
		echo "Invalid numbers of arguments"
		exit 1
	elif [[ ! "$1" =~ $re ]]; then
		echo "Error: invalid year" >&2
		exit 1
	elif [[ ! "$2" =~ $re ]] || (( $2 > 12 || $2<1  )); then
		echo "Error: invalid month" >&2
		exit 1
	else
		
		case $2 in 
			1|3|5|7|8|10|12)
				echo 31 ;;
			4|6|9|11)
				echo 30 ;;
			2)
				is_leap=$(leap_year $1)
				if [[ "$is_leap" == "Common year" ]]; then
					echo 28
				elif [[ "$is_leap" == "Leap year" ]]; then
					echo 29
				else
					echo $is_leap
					exit 1
				fi ;;
			*)
				echo "your month is not in the right range (1 - 12)" ;;
		esac
	fi
}

#Ella
###################################################################
#check parameters
leap_year () {
	# check input validation
	if [[ "$#" -ne 1 ]] || [[ ! "$1" =~ $re ]]; then
	echo "Invalid numbers of arguments"
	exit 1
	fi

	year=$1
	#check if the year is bigger than 1582
	if [ $year -lt 1582 ]; then 
		echo "Not within the Gregorian calendar period"
	else
	#check if the year number is divisible 4
		if [ $(($year % 4)) -ne 0 ]; then
			echo "Common year"
			
		#check if the year number divisible 100
		elif [ $(($year % 100)) -ne 0 ]; then
			echo  "Leap year"
			
		#check if the year number divisble 400
		elif [ $(($year % 400)) -ne 0 ]; then
			echo "Common year"

		else 
			echo  "Leap year"
		fi 
	fi
}
###############################################################

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
			#echo $i
			days_in_month=$(month_in_year $year $i)
			#echo "days param: $days_in_month"
			counter=$((counter + days_in_month))
		done
		counter=$((counter + day))
		is_leap=$(leap_year $year)
		if [[ "$is_leap" == "Leap year" ]]; then
    			total_days="366"
		else
    			total_days="365"
		fi
		echo -n "the $counter"; echo "th out of $total_days"
	fi

}

main () {
	read -p "enter the year, month and day seperated by space : " -a calendar
	#echo ${#calendar[@]}
	if [[ "${#calendar[@]}" -eq "3" ]]; then

		year=${calendar[0]}
		month=${calendar[1]}
		day=${calendar[2]}
		day_of_the_year $year $month $day
	else
		echo "Error: You didnt provide 3 valid numbers seperated by space"
	fi

}	

#start main
main
