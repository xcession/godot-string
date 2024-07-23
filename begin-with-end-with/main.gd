extends Control


var sample_string: String = "hello_godot_world"

func _ready():
	if sample_string.begins_with("hello_"):
		print("YES")
	else:
		print("NO")
	
	if sample_string.begins_with("hello"):
		print("YES")
	else:
		print("NO")
	
	if sample_string.begins_with("_hello"):
		print("YES")
	else:
		print("NO")
	
	if sample_string.ends_with("_world"):
		print("YES")
	else:
		print("NO")
	
	if sample_string.ends_with("world"):
		print("YES")
	else:
		print("NO")
	
	if sample_string.ends_with("world_"):
		print("YES")
	else:
		print("NO")
