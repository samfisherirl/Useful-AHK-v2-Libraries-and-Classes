# Useful-AHK-v2-Libraries-and-Classes
Useful AHK-v2 Libraries and Classes, forked from https://github.com/thqby/ahk2_lib to add readme and examples
# AHK Class Reference

This repository contains a collection of AutoHotkey (AHK) classes that provide various functionalities for different purposes. The classes are designed to make it easier to work with arrays, clipboards, files, lists, objects, strings, mathematical operations, dates and times, logging events, networks, and processes.

# ArrayObject.ahk
This class provides a number of methods for working with arrays, such as sorting, searching, and merging.

Some of the methods include:

`Sort()` - Sorts the array in ascending order.
`Search(value)` - Searches the array for a specified value and returns the index of the value if found.
`Merge(array)` - Merges two arrays into a single array.
`ClipboardObject.ahk`
This class provides methods for accessing and manipulating the clipboard.

- Some of the methods include:

`GetText()` - Gets the text that is currently on the clipboard.
`SetText(value)` - Sets the text on the clipboard to a specified value.
`Clear()` - Clears the clipboard.
`FileObject.ahk`
This class provides methods for working with files, such as reading, writing, and deleting.

- Some of the methods include:

`Read(path)` - Reads the contents of a file into a string.
`Write(path, content)` - Writes a string to a file.
`Delete(path)` - Deletes a file.
`ListObject.ahk`
This class provides a number of methods for working with lists, such as sorting, searching, and merging.

Some of the methods include:

`Sort()` - Sorts the list in ascending order.
`Search(value)` - Searches the list for a specified value and returns the index of the value if found.
`Merge(list)` - Merges two lists into a single list.
`Object.ahk`
This class is the base class for all other classes in this repository. It provides a number of methods for working with objects, such as getting and setting properties.

- Some of the methods include:

`GetProperty(propertyName)` - Gets the value of a property.
`SetProperty(propertyName, value)` - Sets the value of a property.
`Exists(propertyName)` - Checks if a property exists.
`StringObject.ahk`
This class provides a number of methods for working with strings, such as searching, replacing, and formatting.

- Some of the methods include:

`Search(value)` - Searches a string for a specified value and returns the index of the value if found.
`Replace(oldValue, newValue)` - Replaces all occurrences of a specified value in a string with a new value.
`Format(formatString)` - Formats a string according to a specified format.
`Specialty_Classes`
This section contains specialized classes for specific purposes.

`Calculator.ahk`
This class provides a number of methods for performing mathematical operations, such as addition, subtraction, multiplication, and division.

- Some of the methods include:

`Add(a, b)` - Adds two numbers together.
`Subtract(a, b)` - Subtracts one number from another number.
`Multiply(a, b)` - Multiplies two numbers together.
`Divide(a, b)` - Divides one number by another number.
`DateTimeObject.ahk`
This class provides methods for working with dates and times, such as getting the current date and time, formatting dates and times, and calculating the difference between two dates and times.

- Some of the methods include:

`GetNow()` - Gets the current date and time.
`Format(date, formatString)` - Formats a date or time according to a specified format.
`Diff(startDate, endDate)` - Calculates the difference between two dates and times.

`Logger.ahk`
This class provides methods for logging events to a file.

- Some of the methods include:

`Log(event)` - Logs an event to a file.
`Clear()` - Clears the log file.
`NetworkObject.ahk`
This class provides methods for working with networks, such as connecting to a network, sending and receiving data, and managing network connections.

- Some of the methods include:

`Connect(network)` - Connects to a network.
`Send(data)` - Sends data to a network.
`Receive()` - Receives data from a network.
`ManageConnections()` - Manages network connections.
`ProcessObject.ahk`
This class provides methods for working with processes, such as creating, killing, and suspending processes.

- Some of the methods include:

`Create(processName)` - Creates a process.
`Kill(processName)` - Kills a process.
`Suspend(processName)` - Suspends a process.
Please refer to the individual class files for detailed documentation and usage examples.




