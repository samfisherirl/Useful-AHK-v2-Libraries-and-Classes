﻿#Requires Autohotkey v2
;AutoGUI 2.5.8 creator: Alguimist autohotkey.com/boards/viewtopic.php?f=64&t=89901
;AHKv2converter creator: github.com/mmikeww/AHK-v2-script-converter
;Easy_AutoGUI_for_AHKv2 github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2
 
myGuiObj := myClass.UI()
; myGuiObj.Destroy()
 
class myClass
{
    static UI()
    {
        myGUI := Gui()
        ogcButtonOK := myGui.Add("Button", "x8 y8 w80 h23", "&OK")
        ogcButtonOK.OnEvent("Click", OnEventHandler)
        myGui.OnEvent('Close', (*) => ExitApp())
        myGui.Title := "Window"
        myGui.Show("w120 h46")
                    
        OnEventHandler(*)
        {
            ToolTip("Click! This is a sample action.`n"
            . "Active GUI element values include:`n"  
            . "ogcButtonOK => " ogcButtonOK.Text "`n", 77, 277)
            SetTimer () => ToolTip(), -3000 ; tooltip timer
        }
        return myGui
    }
}
 
