/************************************************************************
 * @description Apply dark theme to the built-in MsgBox and InputBox.
 * @file Dark_MsgBox_v2.ahk
 * @link https://gist.github.com/nperovic/0b9a511eda773f9304813a6ad9eec137
 * @author Nikola Perovic
 * @date 2024/04/22
 * @version 1.1.0
 ***********************************************************************/

#Requires AutoHotkey v2
#DllLoad gdi32.dll

/*
; for v2.1.alpha.9 or later 
class POINT {
    x: i32, y: i32
}

class RECT  {
    left: i32, top: i32, right: i32, bottom: i32
}
*/

; for v2.0 or later 
POINT(x := 0, y := 0) {
    NumPut("int", x, "int", y, buf := Buffer(8))
    buf.DefineProp("x", {Get: NumGet.Bind(, 0, "int"), Set: IntPut.Bind(0)})
    buf.DefineProp("y", {Get: NumGet.Bind(, 4, "int"), Set: IntPut.Bind(4)})
    return buf
}

RECT(left := 0, top := 0, right := 0, bottom := 0){
    static ofst := Map("left", 0, "top", 4, "right", 8, "bottom", 12)
    NumPut("int", left, "int", top, "int", right, "int", bottom, buf := Buffer(16))
    for k, v in ofst
        buf.DefineProp(k, {Get: NumGet.Bind(, v, "int"), Set: IntPut.Bind(v)})
    return buf
}

IntPut(ofst, _, v) => NumPut("int", v, _, ofst)

class __MsgBox
{
    static __New()
    {
        /** Thanks to geekdude & Mr Doge for providing this method to rewrite built-in functions. */
        static nativeMsgbox   := MsgBox.Call.Bind(MsgBox)
        static nativeInputBox := InputBox.Call.Bind(InputBox)
        
        MsgBox.DefineProp("Call", {Call: BoxEx})
        InputBox.DefineProp("Call", {Call: BoxEx})

        BoxEx(_this, params*)
        {
            static WM_COMMNOTIFY := 0x44
            static WM_INITDIALOG := 0x0110
            
            iconNumber := 1
            iconFile   := ""
            
            if (params.length = (_this.MaxParams + 2))
                iconNumber := params.Pop()
            
            if (params.length = (_this.MaxParams + 1)) 
                iconFile := params.Pop()
            
            SetThreadDpiAwarenessContext(-4)

            if (_this.Name = "MsgBox")
                OnMessage(WM_COMMNOTIFY, ON_WM_COMMNOTIFY, -1)
            else
                OnMessage(WM_INITDIALOG, ON_WM_INITDIALOG, -1)

            return native%_this.Name%(params*)

            ON_WM_INITDIALOG(wParam, lParam, msg, hwnd)
            {
                OnMessage(WM_INITDIALOG, ON_WM_INITDIALOG, 0)
                WNDENUMPROC(hwnd)
            }
            
            ON_WM_COMMNOTIFY(wParam, lParam, msg, hwnd)
            {
                DetectHiddenWindows(true)

                if (msg = 68 && wParam = 1027)
                    OnMessage(0x44, ON_WM_COMMNOTIFY, 0),                    
                    EnumThreadWindows(GetCurrentThreadId(), CallbackCreate(WNDENUMPROC), 0)
            }

            WNDENUMPROC(hwnd, *)
            {
                static SM_CICON         := "W" SysGet(11) " H" SysGet(12)
                static SM_CSMICON       := "W" SysGet(49) " H" SysGet(50)
                static ICON_BIG         := 1
                static ICON_SMALL       := 0
                static WM_SETICON       := 0x80
                static WS_CLIPCHILDREN  := 0x02000000
                static WS_CLIPSIBLINGS  := 0x04000000
                static WS_EX_COMPOSITED := 0x02000000
                static WS_VSCROLL       := 0x00200000
                static winAttrMap       := Map(2, 2, 4, 0, 10, true, 17, true, 20, true, 38, 2, 35, 0x2b2b2b) ; 34, 0xFFFFFFFE,

                Critical()
                SetWinDelay(-1)
                SetControlDelay(-1)
                DetectHiddenWindows(true)

                if !WinExist("ahk_class #32770 ahk_id" hwnd)
                    return 1

                WinSetStyle("+" (WS_CLIPCHILDREN | WS_CLIPSIBLINGS))
                WinSetExStyle("+" (WS_EX_COMPOSITED))
                SetWindowTheme(hwnd, "DarkMode_Explorer")

                if iconFile {
                    hICON_SMALL := LoadPicture(iconFile, SM_CSMICON " Icon" iconNumber, &handleType)
                    hICON_BIG   := LoadPicture(iconFile, SM_CICON " Icon" iconNumber, &handleType)
                    PostMessage(WM_SETICON, ICON_SMALL, hICON_SMALL)
                    PostMessage(WM_SETICON, ICON_BIG, hICON_BIG)
                }

                for dwAttribute, pvAttribute in winAttrMap
                    DwmSetWindowAttribute(hwnd, dwAttribute, pvAttribute)
                
                GWL_WNDPROC(hwnd, hICON_SMALL?, hICON_BIG?)
                return 0
            }
            
            GWL_WNDPROC(winId := "", hIcons*)
            {
                static SetWindowLong     := DllCall.Bind(A_PtrSize = 8 ? "SetWindowLongPtr" : "SetWindowLong", "ptr",, "int",, "ptr",, "ptr")
                static BS_FLAT           := 0x8000
                static BS_BITMAP         := 0x0080
                static DPI               := (A_ScreenDPI / 96)
                static WM_CLOSE          := 0x0010
                static WM_CTLCOLORBTN    := 0x0135
                static WM_CTLCOLORDLG    := 0x0136
                static WM_CTLCOLOREDIT   := 0x0133
                static WM_CTLCOLORSTATIC := 0x0138
                static WM_DESTROY        := 0x0002
                static WM_SETREDRAW      := 0x000B

                DetectHiddenWindows(true)
                SetControlDelay(-1)
    
                btns    := []
                btnHwnd := hbrush1 := hbrush2 := ""

                for ctrl in WinGetControlsHwnd(winId)
                {
                    classNN := ControlGetClassNN(ctrl)
                    SetWindowTheme(ctrl, !InStr(classNN, "Edit") ? "DarkMode_Explorer" : "DarkMode_CFD")

                    if !InStr(classNN, "B")
                        continue
                    
                    ControlSetStyle("+" (BS_FLAT | BS_BITMAP), ctrl)
                    btns.Push(btnHwnd := ctrl)
                }
    
                WindowProcOld := SetWindowLong(winId, -4, CallbackCreate(WNDPROC))
                
                WNDPROC(hwnd, uMsg, wParam, lParam)
                {
                    Critical(-1)
                    DetectHiddenWindows(true)
                    SetWinDelay(-1)
                    SetControlDelay(-1)
                    
                    if !hbrush1 
                        hbrush1 := CreateSolidBrush(0x202020)
    
                    if !hbrush2
                        hbrush2 := CreateSolidBrush(0x2b2b2b)
    
                    switch uMsg {
                    case WM_CTLCOLORSTATIC: 
                    {
                        SelectObject(wParam, hbrush2)
                        SetBkMode(wParam, 0)
                        SetTextColor(wParam, 0xFFFFFF)
                        SetBkColor(wParam, 0x2b2b2b)
    
                        for _hwnd in btns
                            PostMessage(WM_SETREDRAW,,,_hwnd)
    
                        GetWindowRect(winId, rcW := RECT())
                        GetClientRect(winId, rcC := RECT())
                        GetWindowRect(btnHwnd, rcBtn := RECT())

                        pt   := POINT()
                        pt.y := rcW.bottom - rcBtn.bottom
                        ScreenToClient(winId, pt)

                        hdc        := GetWindowDC(winId)
                        rcC.top    := rcBtn.top + pt.y -2
                        rcC.bottom *= 2
                        rcC.right  *= 2
                        
                        SetBkMode(hdc, 0)
                        FillRect(hdc, rcC, hbrush1)
                        ReleaseDC(winId, hdc)
    
                        for _hwnd in btns
                            PostMessage(WM_SETREDRAW, 1,,_hwnd)
    
                        return hbrush2
                    }
                    case WM_CTLCOLORDLG, WM_CTLCOLOREDIT: 
                    {         
                        SelectObject(wParam, hbrush2)
                        SetBkMode(wParam, 0)
                        SetTextColor(wParam, 0xFFFFFF)
                        SetBkColor(wParam, 0x2b2b2b)
                        return hbrush2
                    }
                    case WM_CTLCOLORBTN: 
                    {
                        SelectObject(wParam, hbrush1)
                        SetBkMode(wParam, 0)
                        SetTextColor(wParam, 0xFFFFFF)
                        SetBkColor(wParam, 0x202020)
                        return hbrush2
                    }
                    case WM_DESTROY: 
                    {
                        for v in [hbrush1, hbrush2]
                            (v && DeleteObject(v))
    
                        for v in hIcons
                            (v??0) && DestroyIcon(v)
                    }}
    
                    return CallWindowProc(WindowProcOld, hwnd, uMsg, wParam, lParam) 
                }
            }
        }

        CallWindowProc(lpPrevWndFunc, hWnd, uMsg, wParam, lParam) => DllCall("CallWindowProc", "Ptr", lpPrevWndFunc, "Ptr", hwnd, "UInt", uMsg, "Ptr", wParam, "Ptr", lParam)

        ClientToScreen(hWnd, lpPoint) => DllCall("User32\ClientToScreen", "ptr", hWnd, "ptr", lpPoint, "int")

        CreateSolidBrush(crColor) => DllCall('Gdi32\CreateSolidBrush', 'uint', crColor, 'ptr')
        
        DestroyIcon(hIcon) => DllCall("DestroyIcon", "ptr", hIcon)

        /** @see — https://learn.microsoft.com/en-us/windows/win32/api/dwmapi/ne-dwmapi-dwmwindowattribute */
        DWMSetWindowAttribute(hwnd, dwAttribute, pvAttribute, cbAttribute := 4) => DllCall("Dwmapi\DwmSetWindowAttribute", "Ptr" , hwnd, "UInt", dwAttribute, "Ptr*", &pvAttribute, "UInt", cbAttribute)
        
        DeleteObject(hObject) => DllCall('Gdi32\DeleteObject', 'ptr', hObject, 'int')
        
        EnumThreadWindows(dwThreadId, lpfn, lParam) => DllCall("User32\EnumThreadWindows", "uint", dwThreadId, "ptr", lpfn, "uptr", lParam, "int")
        
        FillRect(hDC, lprc, hbr) => DllCall("User32\FillRect", "ptr", hDC, "ptr", lprc, "ptr", hbr, "int")
        
        GetClientRect(hWnd, lpRect) => DllCall("User32\GetClientRect", "ptr", hWnd, "ptr", lpRect, "int")
        
        GetCurrentThreadId() => DllCall("Kernel32\GetCurrentThreadId", "uint")
        
        GetWindowDC(hwnd) => DllCall("User32\GetWindowDC", "ptr", hwnd, "ptr")
        
        GetWindowRect(hWnd, lpRect) => DllCall("User32\GetWindowRect", "ptr", hWnd, "ptr", lpRect, "uptr")

        GetWindowRgn(hWnd, hRgn) => DllCall("User32\GetWindowRgn", "ptr", hWnd, "ptr", hRgn, "int")

        GetWindowRgnBox(hWnd, hRgn) => DllCall("User32\GetWindowRgnBox", "ptr", hWnd, "ptr", hRgn, "int")

        ReleaseDC(hWnd, hDC) => DllCall("User32\ReleaseDC", "ptr", hWnd, "ptr", hDC, "int")
        
        ScreenToClient(hWnd, lpPoint) => DllCall("User32\ScreenToClient", "ptr", hWnd, "ptr", lpPoint, "int")

        SelectObject(hdc, hgdiobj) => DllCall('Gdi32\SelectObject', 'ptr', hdc, 'ptr', hgdiobj, 'ptr')
        
        SetBkColor(hdc, crColor) => DllCall('Gdi32\SetBkColor', 'ptr', hdc, 'uint', crColor, 'uint')
        
        SetBkMode(hdc, iBkMode) => DllCall('Gdi32\SetBkMode', 'ptr', hdc, 'int', iBkMode, 'int')
        
        SetTextColor(hdc, crColor) => DllCall('Gdi32\SetTextColor', 'ptr', hdc, 'uint', crColor, 'uint')
        
        SetThreadDpiAwarenessContext(dpiContext) => DllCall("SetThreadDpiAwarenessContext", "ptr", dpiContext, "ptr")

        SetWindowTheme(hwnd, pszSubAppName, pszSubIdList := "") => (!DllCall("uxtheme\SetWindowTheme", "ptr", hwnd, "ptr", StrPtr(pszSubAppName), "ptr", pszSubIdList ? StrPtr(pszSubIdList) : 0) ? true : false)
    }
}