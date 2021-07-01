extends Node2D


# Initialize numbers
var numbers = "1234567890"
# Create an empty array
var number_array = []

func _ready():
	# Debug message
	print(numbers)
	
	if numbers.is_valid_integer():
		print("It is numbers")
	else:
		print("hmm...")
	
	# Interate numbers into array
	for i in numbers.length():
		number_array.append(numbers[i])
	
	# Debug message
	print(number_array)

