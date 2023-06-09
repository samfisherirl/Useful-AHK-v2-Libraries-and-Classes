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


### Socket.ahk

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



### Webview2.ahk

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


