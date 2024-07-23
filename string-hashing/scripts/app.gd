extends Control


const HASH_METHOD: Array = [
	"32bit Integer",
	"MD5",
	"SHA1",
	"SHA256",
]

@export var branding: Label
@export var inputText: LineEdit
@export var inputMethod: OptionButton
@export var inputSalt: Button
@export var outputHash: LineEdit
@export var validText: LineEdit
@export var validHash: LineEdit
@export var validMethod: OptionButton
@export var validSalt: Button
@export var status: Label


func _ready():
	# Set branding text
	branding.text = Global.PRODUCT
	
	# Populate OptionButtons
	for i in HASH_METHOD:
		print(i)
		inputMethod.add_item(str(i))
		validMethod.add_item(str(i))



func getHash(string, method):
	var hashed_string: String
	
	match method:
		"32bit Integer":
			hashed_string = str(string.hash())
		"MD5":
			hashed_string = str(string.md5_text())
		"SHA1":
			hashed_string = str(string.sha1_text())
		"SHA256":
			hashed_string = str(string.sha256_text())
	
	return hashed_string


func _on_BTNGenerate_pressed():
	if inputText.get_text() == "":
		status.set_text("Please enter something!")
		inputText.grab_focus()
	else:
		var text: String = inputText.get_text()
		var hash_method: String = inputMethod.get_item_text(inputMethod.get_selected())
		
		if inputSalt.is_pressed():
			text = text + Global.SALT
		
		# Debug message
		print("Text: ", text)
		
		var hash_string: String = getHash(text, hash_method)
		
		# Debug message
		print("Result: ", hash_string)
		
		outputHash.set_text(hash_string)
		status.set_text("DONE!")


func _on_BTNCopy_pressed():
	if outputHash.get_text() != "":
		DisplayServer.clipboard_set(outputHash.get_text())
		status.set_text("Copied to clipboard.")
	else:
		status.set_text("Nothing to copy.")


func _on_BTNPaste_pressed():
	validHash.set_text(DisplayServer.clipboard_get())


func _on_BTNClear_pressed():
	validHash.set_text("")


func _on_BTNValidate_pressed():
	if validText.get_text() == "":
		status.set_text("Enter valid text.")
		validText.grab_focus()
	elif validHash.get_text() == "":
		status.set_text("Enter valid hash.")
		validHash.grab_focus()
	else:
		var text: String = validText.get_text()
		var hash_string: String = validHash.get_text()
		var hash_method: String = validMethod.get_item_text(validMethod.get_selected())
		
		if validSalt.is_pressed():
			text = text + Global.SALT
		
		# Debug message
		print("Text: ", text)
		
		# Get hash from validText input
		var hashed_text = getHash(text, hash_method)
		
		# Debug message
		print("Hashed text: ", hash_string)
		
		# Compare hashed_text with hash_string
		if hashed_text == hash_string:
			status.set_text("VALID text/hash pair.")
		else:
			status.set_text("INVALID text/hash pair.")

