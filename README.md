# Useful AHK-v2 Libraries and Classes, with added explainers and examples
This repository contains a collection of AutoHotkey (AHK) version 2 classes that provide various functionalities for different purposes. The classes are designed to make it easier to work with arrays, clipboards, files, lists, objects, strings, mathematical operations, dates and times, logging events, networks, and processes.

Sourceds from:
- [AHKv1 to AHKv2 converter](https://github.com/mmikeww/AHK-v2-script-converter)
- [thqby/ahk2_lib](https://github.com/thqby/ahk2_lib)
- [Descolada/UIA-v2](https://github.com/Descolada/UIA-v2)
- [TheArchive](https://github.com/TheArkive?tab=repositories)
- [G33kDude](https://github.com/G33kDude)
- [JNizM/ahk-scripts-v2](https://github.com/jNizM/ahk-scripts-v2)
- [LargestAHKLib](https://github.com/Ixiko/AHK-libs-and-classes-collection/tree/master/AHK_V2)
- among others

My goal is to centralize, as well as add examples, a readme when missing, and english translations for comments. 
Credits are included in each file, and thank you thqby for the original repo above, it is greatly appreciated.

## AHKv2 Scripts and Classes

- [JXON](https://github.com/samfisherirl/Useful-AHK-v2-Libraries-and-Classes#jxonahk)
- [Neutron.ahk](https://github.com/samfisherirl/Useful-AHK-v2-Libraries-and-Classes#neutronahk)
- [UIAutomation](https://github.com/samfisherirl/Useful-AHK-v2-Libraries-and-Classes#uiautomation-v2)
- [JSON.ahk](https://github.com/samfisherirl/Useful-AHK-v2-Libraries-and-Classes#jsonahk)
- [WinHTTPRequest.ahk](https://github.com/samfisherirl/Useful-AHK-v2-Libraries-and-Classes#winhttprequestahk)
- [WinHTTP.ahk](https://github.com/samfisherirl/Useful-AHK-v2-Libraries-and-Classes#winhttpahk)
- [Common Language Runtime CLR.ahk](https://github.com/samfisherirl/Useful-AHK-v2-Libraries-and-Classes#clrahk)
- [DownloadAsync](https://github.com/samfisherirl/Useful-AHK-v2-Libraries-and-Classes#downloadasyncahk)
- [Socket.ahk](https://github.com/samfisherirl/Useful-AHK-v2-Libraries-and-Classes#socketahk)
- [Webview2.ahk](https://github.com/samfisherirl/Useful-AHK-v2-Libraries-and-Classes#webview2ahk)
- [Easy-AutoGUI](https://github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2)

I'm just getting started, expect this to expand soon. 

## Gui Libraries

**Neutron Webview2 ahk** - [viewtopic.php?t=76865](https://www.autohotkey.com/boards/viewtopic.php?t=76865)\
Discover "AutoHotkey Web GUIs on Steroids" with Neutron Webview2 ahk. This forum thread discusses its features and functionalities, now available for version 2 of AutoHotkey.

**Easy AutoGUIv2** - [viewtopic.php?t=116159](https://www.autohotkey.com/boards/viewtopic.php?t=116159)\
Explore Easy AutoGUIv2, a popular GUI library, through this forum thread. Learn about its capabilities and how it can enhance AutoHotkey GUI development.

**Win11<=Darkmode [viewtopic.php?t=115952](https://www.autohotkey.com/boards/viewtopic.php?t=115952)**

**XCGUI** - [GitHub Repository](<https://github.com/thqby/ahk2_lib/tree/master/XCGUI>\
Visit the GitHub repository for XCGUI, an AutoHotkey library that provides extended GUI functionality. Dive into the code and documentation to understand its usage and features.

**CreateImageButton**() - [viewtopic.php?f=83&t=93339](https://www.autohotkey.com/boards/viewtopic.php?f=83&t=93339)\
Learn about creating image buttons using GDI buttons in this forum thread. Explore examples, discussions, and insights from the AutoHotkey community.

**GuiControlIcon**() - [viewtopic.php?f=83&t=115871](https://www.autohotkey.com/boards/viewtopic.php?f=83&t=115871)\
Discover how to set the icon of a GUI control with GuiControlIcon. This forum thread provides details, examples, and discussions on incorporating icons into your AutoHotkey GUIs.

Object Oriented Responsive **GuiResizer**() - [viewtopic.php?f=83&t=113921&hilit=gui](https://www.autohotkey.com/boards/viewtopic.php?f=83&t=113921&hilit=gui)\
Explore an excellent shortcut for creating responsive GUIs with the Object Oriented Responsive GuiResizer. This forum thread offers insights, code snippets, and discussions on making GUIs adaptable to different screen sizes.

**SkinSharpv2** - [viewtopic.php?f=83&t=116251&hilit=gui](https://www.autohotkey.com/boards/viewtopic.php?f=83&t=116251&hilit=gui)\
Discover SkinSharpv2, a GUI theme skinning library, in this AutoHotkey forum thread. Learn how to enhance the visual appeal of your GUIs through skinning techniques and discussions.

**ExampleSwitchControls** - [viewtopic.php?f=83&t=115868&hilit=gui](https://www.autohotkey.com/boards/viewtopic.php?f=83&t=115868&hilit=gui)\
This forum thread provides insights into switching between different GUI controls using ExampleSwitchControls. Explore examples, code snippets, and discussions to improve your AutoHotkey GUI navigation.

**Scrollable Gui** - [viewtopic.php?f=83&t=112708&hilit=gui](https://www.autohotkey.com/boards/viewtopic.php?f=83&t=112708&hilit=gui)\
Learn how to create scrollable GUIs in AutoHotkey through this forum thread. Explore discussions, examples, and insights into implementing scroll functionality for improved user interfaces.

**Template Gui** - [viewtopic.php?f=83&t=123801](https://www.autohotkey.com/boards/viewtopic.php?f=83&t=123801)\
- Added Resize option for main GUI.\
- Added map object to store the GUI values.\
- Added open Main GUI when tray icon is double-clicked.

**`(listview`) LV_Colors **- [viewtopic.php?f=83&t=93922](https://www.autohotkey.com/boards/viewtopic.php?f=83&t=93922)\
- Flexible color pallet for listview GUIs

# Popular and Useful libs

## JXON.ahk 
-  Source - https://github.com/TheArkive/JXON_ahk2

My personal favorite JSON class. This class provides methods for working with JSON data, such as parsing, generating, and manipulating.
- `var := jxon_dump(obj, indent:=0)` -  Output var is the serialized text.

- `obj := jxon_load(&text)` - Input must be properly formatted JSON text. If not properly formatted an error will be thrown. The error message will indicate the character number where parsing failed due to improper format.

## ahkv2 script converter
- Source - [mmikeww/AHK-v2-script-converter](https://github.com/mmikeww/AHK-v2-script-converter)

`QuickConvertorV2.ahk`
This script is a GUI for the AHK v1 -> v2 Script Converter. It allows you to select an AHK v1 script and convert it to AHK v2 with a single click.
Usage
To use the script, simply run it. The script will open a GUI where you can select the AHK v1 script to convert. The converted script will be saved in the same directory as the original script.


## Neutron.ahk 
- Sources - https://github.com/G33kDude/Neutron.ahk/tree/v2

- Create GUIs with HTML, CSS, JS, and AHK all working together.
- Make responsive user interfaces that reflow when you resize the window, and scroll when elements go out of view.
- Full customization of the title bar including fonts and colors.
- Make better looking interfaces easily with web frameworks like Bootstrap.
- Compile resources into your script and access them without extracting. Very useful for including images in the script!


## UIAutomation v2
- Source - https://github.com/Descolada/UIA-v2

This library is a wrapper for the UIAutomation framework, which can be used to automate windows that normally might be difficult or impossible to automate with AHK.

- `Example02_StartingPointElements.ahk`: A file that demonstrates how to find the starting point elements for a UIA-v2 model.

- `Example03_FindElements.ahk`: A file that demonstrates how to find elements in a UIA-v2 model.

- `Example04_TreeWalking.ahk`: A file that demonstrates how to walk the tree of elements in a UIA-v2 model.

- `Example05_Notepad.ahk`: A file that demonstrates how to use the UIA-v2 model to control Notepad.

- `Example06_Calculator.ahk`: A file that demonstrates how to use the UIA-v2 model to control the Windows Calculator.

- `Example07_FocusChangedEvent.ahk`: A file that demonstrates how to listen for the focus changed event in a UIA-v2 model.

- `Example08_SelectionEventHandler.ahk`: A file that demonstrates how to listen for the selection changed event in a UIA-v2 model.

- `UIA_Browser_Example01_Chrome.ahk`: A file that demonstrates how to use the UIA-v2 model to control Google Chrome.

- `UIA_Browser_Example02_EdgeScrolling.ahk`: A file that demonstrates how to use the UIA-v2 model to scroll through a web page in Microsoft Edge.

# Common thqby Classes 

### JSON.ahk 
https://github.com/thqby/ahk2_lib/blob/master/JSON.ahk

This class provides methods for working with JSON data, such as parsing, generating, and manipulating.

Some of the methods include:
- `Parse()` - Parses a JSON string into an object.
- `Generate()` - Generates a JSON string from an object.
- `Manipulate()` - Manipulates a JSON object.

### WinHttpRequest.ahk
https://github.com/thqby/ahk2_lib/blob/master/WinHttpRequest.ahk

This class provides methods for working with Windows HTTP requests, such as sending and receiving data.

Some of the methods include:
- `Send()` - Sends an HTTP request.
- `Receive()` - Receives an HTTP response.
- `ManageConnections()` - Manages HTTP connections.

### Winhttp.ahk
https://github.com/thqby/ahk2_lib/blob/master/Winhttp.ahk

This class provides methods for working with Windows HTTP, such as creating, managing, and closing connections.

Some of the methods include:
- `Create()` - Creates an HTTP connection.
- `Manage()` - Manages an HTTP connection.
- `Close()` - Closes an HTTP connection.

### DownloadAsync.ahk
https://github.com/thqby/ahk2_lib/blob/master/DownloadAsync.ahk

This class provides methods for downloading files asynchronously.

Some of the methods include:
- `Download()` - Downloads a file asynchronously.
- `GetProgress()` - Gets the progress of a download.
- `IsFinished()` - Checks if a download is finished.

## Chrome.ahk
This file contains a collection of AutoHotkey functions for interacting with Google Chrome.

Functions:
- `Chrome_Open()`: Opens a new instance of Google Chrome.
- `Chrome_Close()`: Closes the current instance of Google Chrome.
- `Chrome_GoToURL()`: Opens the specified URL in Google Chrome.
- `Chrome_GetTitle()`: Gets the title of the current tab in Google Chrome.
- `Chrome_GetURL()`: Gets the URL of the current tab in Google Chrome.
- `Chrome_GetActiveTab()`: Gets the handle of the active tab in Google Chrome.
- `Chrome_GetTabs()`: Gets a list of all the tabs in Google Chrome.
- `Chrome_NewTab()`: Opens a new tab in Google Chrome.
- `Chrome_CloseTab()`: Closes the specified tab in Google Chrome.
- `Chrome_ReloadTab()`: Reloads the specified tab in Google Chrome.
- `Chrome_GoBack()`: Goes back one page in Google Chrome.
- `Chrome_GoForward()`: Goes forward one page in Google Chrome.
- `Chrome_Refresh()`: Refreshes the current page in Google Chrome.
- `Chrome_Find()`: Finds the specified text on the current page in Google Chrome.
- `Chrome_SavePage()`: Saves the current page to a file.
- `Chrome_PrintPage()`: Prints the current page.
- `Chrome_Quit()`: Quits Google Chrome.
### Usage
To use these functions, you will need to first install AutoHotkey. Once you have installed AutoHotkey, you can load the Chrome.ahk file by double-clicking on it.

Once the file is loaded, you can use the functions by typing their names followed by the arguments. For example, to open a new instance of Google Chrome, you would type the following:

### Chrome_Open()  

To get the title of the current tab, you would type the following:
Chrome_GetTitle()
To get the URL of the current tab, you would type the following:
Chrome_GetURL()

## CLR.ahk
https://www.autohotkey.com/boards/viewtopic.php?t=4633

Microsoft Common Language Runtime / .NET Framework Interop
Run C# Framework DLLs from Autohotkey
License: public domain / CC0

Key Features:
- Load the Common Language Runtime into the script's process.
- Load .NET assemblies (dll files) by full name, partial name, or path.
- Instantiate objects and call instance methods or properties.
- Compile C# or VB code on the fly or to file.

### Functions

`CLR_Start( [ RuntimeVersion ] )`

Loads the Common Language Runtime. RuntimeVersion specifies the exact version to load - for example, "v2.0.50727" or "v4.0.30319". If omitted, the latest version is loaded. If this function is not called and another CLR function requires the runtime to be loaded, the latest version will be loaded.

`CLR_StartDomain( ByRef AppDomain [, BaseDirectory ] )`

Starts a new AppDomain and stores a pointer or reference to it in AppDomain. This can be passed to CLR_LoadLibrary() to load an assembly into the AppDomain. BaseDirectory defines the base search path used when loading assemblies into the AppDomain.

`CLR_StopDomain( AppDomain )`

Stops the specified AppDomain and attempts to unload any assemblies that were loaded into it.

`CLR_LoadLibrary( AssemblyName [, AppDomain ] )`

Loads an assembly, where AssemblyName is its full name, partial name or path. Optionally loads the assembly into the given AppDomain instead of the default AppDomain. Returns a pointer or reference to the Assembly, which can be used with CLR_CreateObject.
Note: Once an assembly is loaded, it can only be unloaded by stopping the AppDomain which contains it.

`CLR_CreateObject( Assembly, sType [, Arg1, Arg2 ... ] )`

Instantiates an object of the specified type from the specified assembly. Optionally accepts a list of arguments to pass to the object's constructor. Use ComObject(Type, Arg) to pass a typed value. A list of type codes can be found here. Alternatively, you can call Assembly.CreateInstance(sType) directly if you do not need to pass parameters.

`CLR_CompileC#( Code, References [, AppDomain, FileName, CompilerOptions ] )`

`CLR_CompileVB( Code, References [, AppDomain, FileName, CompilerOptions ] )`

Compile the specified C# or VB code. If FileName is omitted, the assembly is compiled "in-memory" and automatically loaded. DLL and EXE files may be generated. Specify for References a pipe (|) delimited list of assemblies that the code requires. If FileName is omitted and compilation is successful, returns a pointer or reference to the compiled Assembly, which can be used with CLR_CreateObject; otherwise returns FileName on success or 0 on failure.
Note: Some versions of .NET may require an explicit reference to the appropriate language dll, such as Microsoft.CSharp.dll.



## Socket.ahk

[GitHub Repository](https://github.com/thqby/ahk2_lib/Socket.ahk)

Simple implementation of a socket Server and Client. Handles asynchronous messages by implementing the `on%EventName%(err)` method of the class.

`Socket.create:` Creates a new socket.

`Socket.connect:` Connects the socket to the specified host and port.

`Socket.send:` Sends data to the socket.

`Socket.receive:` Receives data from the socket.

`Socket.close:` Closes the socket.

`Socket.bind:` Binds the socket to the specified port.

`Socket.listen:` Listens for connections on the socket.

`Socket.accept:` Accepts a connection on the socket.

`Socket.getpeername:` Gets the name of the peer connected to the socket.

`Socket.getsockname:` Gets the name of the socket.

`Socket.getpeerport:` Gets the port of the peer connected to the socket.

`Socket.getsockport:` Gets the port of the socket.

`Socket.setoption:` Sets an option for the socket.

`Socket.getoption:` Gets an option for the socket.

`Socket.geterror:` Gets the error code for the last operation on the socket.

`Socket.clearerror:` Clears the error code for the socket.

`Socket.shutdown:` Shutdowns the socket.

`Socket.ioctl:` Performs an I/O control operation on the socket.

`Socket.select:` Waits for a socket to become ready for reading, writing, or both.

`Socket.wsastartup:` Initializes the Windows socket API.

`Socket.wsacleanup:` Cleans up the Windows socket API.



## Webview2.ahk

[GitHub Repository](https://github.com/thqby/ahk2_lib/WebView2)

The Microsoft Edge WebView2 control enables you to host web content in your application using Microsoft Edge (Chromium) as the rendering engine. For more information, see Overview of Microsoft Edge WebView2 and Getting Started with WebView2.

The WebView2 Runtime is built into Win10(latest version) and Win11 and can be easily used in AHK.

`WebView2.create:` Creates a new WebView2 control.

`WebView2.navigate:` Navigates the WebView2 control to the specified URL.

`WebView2.loadHtml:` Loads the specified HTML into the WebView2 control.

`WebView2.evaluateScript:` Evaluates the specified JavaScript in the WebView2 control.

`WebView2.getHtml:` Gets the HTML of the current page in the WebView2 control.

`WebView2.getTitle:` Gets the title of the current page in the WebView2 control.

`WebView2.getUrl:` Gets the URL of the current page in the WebView2 control.

`WebView2.getSettings:` Gets the settings for the WebView2 control.

`WebView2.setSettings:` Sets the settings for the WebView2 control.

`WebView2.addScript:` Adds a script to the WebView2 control.

`WebView2.removeScript:` Removes a script from the WebView2 control.

`WebView2.getScripts:` Gets the scripts in the WebView2 control.

`WebView2.addStyle:` Adds a style to the WebView2 control.

`WebView2.removeStyle:` Removes a style from the WebView2 control.

`WebView2.getStyles:` Gets the styles in the WebView2 control.

`WebView2.getDocument:` Gets the document for the current page in the WebView2 control.

`WebView2.getWindow:` Gets the window for the current page in the WebView2 control.

`WebView2.getFrame:` Gets the frame for the current page in the WebView2 control.

`WebView2.getFrames:` Gets the frames for the current page in the WebView2 control.

`WebView2.getCookies:` Gets the cookies for the current page in the WebView2 control.

`WebView2.setCookies:` Sets the cookies for the current page in the WebView2 control.

`WebView2.clearCookies:` Clears the cookies for the current page in the WebView2 control.

`WebView2.getHistory:` Gets the history for the current page in the WebView2 control.

`WebView2.goBack:` Goes back one page in the history for the current page in the WebView2 control.

`WebView2.goForward:` Goes forward one page in the history for the current page in the WebView2 control.

`WebView2.reload:` Reloads the current page in the WebView2 control.

`WebView2.stop:` Stops loading the current page in the WebView2 control.

`WebView2.zoomIn:` Zooms in on the current page in the WebView2 control.

`WebView2.zoomOut:` Zooms out on the current page in the WebView2 control.

`WebView2.resetZoom:` Resets the zoom level for the current page in the WebView2 control.

`WebView2.fullScreen:` Enters full screen mode for the current page in the WebView2 control.

`WebView2.exitFullScreen:` Exits full screen mode for the current page in the WebView2 control.

`WebView2.print:` Prints the current page in the WebView2 control.

`WebView2.dispose:` Disposes of the WebView2 control.


