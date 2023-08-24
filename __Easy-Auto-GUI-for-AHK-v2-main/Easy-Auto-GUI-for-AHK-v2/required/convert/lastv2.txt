
#Requires Autohotkey v2
;AutoGUI 2.5.8 creator: Alguimist autohotkey.com/boards/viewtopic.php?f=64&t=89901
;AHKv2converter creator: github.com/mmikeww/AHK-v2-script-converter
;Easy_AutoGUI_for_AHKv2 github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2

myGui := Gui()
ogcButtonOK := myGui.Add("Button", "x177 y86 w80 h23", "&OK")
DateTime1 := myGui.Add("DateTime", "x151 y259 w100 h24")
DropDownList1 := myGui.Add("DropDownList", "x389 y77 w120", ["DropDownList", "", ""])
myGui.Add("Hotkey", "x104 y35 w120 h21")
ogcButtonOK.OnEvent("Click", OnEventHandler)
DateTime1.OnEvent("Change", OnEventHandler)
DropDownList1.OnEvent("Change", OnEventHandler)
myGui.OnEvent('Close', (*) => ExitApp())
myGui.Title := "Window"
myGui.Show("w620 h420")

OnEventHandler(*)
{
	ToolTip("Click! This is a sample action.`n"
	. "Active GUI element values include:`n"  
	. "ogcButtonOK => " ogcButtonOK.Value "`n" 
	. "DateTime1 => " DateTime1.Value "`n" 
	. "DropDownList1 => " DropDownList1.Value "`n", 77, 277)
	SetTimer () => ToolTip(), -3000 ; tooltip timer
}
