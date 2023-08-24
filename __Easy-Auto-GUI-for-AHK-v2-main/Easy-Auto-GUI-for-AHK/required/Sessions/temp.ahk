#Warn All, Off

#Requires Autohotkey v2
;AutoGUI 2.5.8 creator: Alguimist autohotkey.com/boards/viewtopic.php?f=64&t=89901
;AHKv2converter creator: github.com/mmikeww/AHK-v2-script-converter
;Easy_AutoGUI_for_AHKv2 github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2

myGui := Gui()
ogcButtonOK := myGui.Add("Button", "x22 y17 w80 h23", "&OK")
DropDownList1 := myGui.Add("DropDownList", "x188 y16 w120", ["DropDownList", "", ""])
ogcButtonOK.OnEvent("Click", OnEventHandler)
DropDownList1.OnEvent("Change", OnEventHandler)
myGui.OnEvent('Close', (*) => ExitApp())
myGui.Title := "Window"
myGui.Show("w620 h420")

OnEventHandler(*)
{
	ToolTip("Click! This is a sample action.`n"
	. "Active GUI element values include:`n"  
	. "ogcButtonOK => " ogcButtonOK.Text "`n" 
	. "DropDownList1 => " DropDownList1.Text "`n", 77, 277)
	SetTimer () => ToolTip(), -3000 ; tooltip timer
}
