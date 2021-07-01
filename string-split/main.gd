extends Control


var numbers: String = "abcdefghijklmnopqrstuvwxyz"
var number: Array = []

func _ready():
	print(numbers)
	
	for i in numbers.length():
		number.append(numbers[i])
	
	print(number)

