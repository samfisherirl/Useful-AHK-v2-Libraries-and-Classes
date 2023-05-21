with open ("t.txt", "r") as f:
	lines = f.readlines()
new_lines = []
for line in lines:
	if "**" in line:
		line = line.replace("**", "`")
		new_lines.append(line)
	elif line == "":
		continue
	else:
		new_lines.append(line)

with open("new.txt", "w") as f:
	for line in new_lines:
		f.write(line)