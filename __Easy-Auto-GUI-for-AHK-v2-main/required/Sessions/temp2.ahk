#Warn All, Off

#Requires Autohotkey v2
;AutoGUI 2.5.8 creator: Alguimist autohotkey.com/boards/viewtopic.php?f=64&t=89901
;AHKv2converter creator: github.com/mmikeww/AHK-v2-script-converter
;Easy_AutoGUI_for_AHKv2 github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2

myGui := Gui()
myGui.SetFont("s20 c0xBBE9FF", "Segoe UI")
myGui.BackColor := "0x232323"
ogcButtonCONFIRM := myGui.Add("Button", "x40 y312 w205 h67", "CONFIRM")
ogcButtonCANCEL := myGui.Add("Button", "x296 y312 w205 h67", "CANCEL")
myGui.SetFont("s20 cBlack")
Edit1 := myGui.Add("Edit", "x576 y32 w235 h48", "FARM 123")
myGui.SetFont("s20 c0xBBE9FF", "Segoe UI")
myGui.SetFont("s20 cBlack")
Edit2 := myGui.Add("Edit", "x576 y112 w461 h48", "CUSTOMER ID 12312312")
myGui.SetFont("s20 c0xBBE9FF", "Segoe UI")
myGui.SetFont("s20 cBlack")
Edit3 := myGui.Add("Edit", "x576 y184 w461 h48", "EVENT ID 321323")
myGui.SetFont("s20 c0xBBE9FF", "Segoe UI")
myGui.SetFont("s20 cBlack")
Edit4 := myGui.Add("Edit", "x824 y32 w213 h48", "FARM 123")
myGui.SetFont("s20 c0xBBE9FF", "Segoe UI")
myGui.SetFont("s16 c0xC1EBFF")
ogcNotesnhEdtValue5 := myGui.Add("Edit", "x576 y280 w459 h96", "Notes`n")
myGui.SetFont("s20 c0xBBE9FF", "Segoe UI")
ogcNotesnhEdtValue5.Opt("Background171717")
ogc1hEdtValue9 := myGui.Add("Edit", "x272 y32 w211 h49", "1")
ogc1hEdtValue9.Opt("Background171717")
myGui.Add("UpDown", "x480 y32 w18 h49", "1")
myGui.SetFont("s20 c0xD5F1FF")
ogcAnimalshEdtValue10 := myGui.Add("Edit", "x272 y112 w211 h48", "Animals")
myGui.SetFont("s20 c0xBBE9FF", "Segoe UI")
ogcAnimalshEdtValue10.Opt("Background171717")
myGui.Add("UpDown", "x481 y112 w18 h48", "1")
myGui.SetFont("s20 c0xD5F1FF")
ogcAnimalshEdtValue11 := myGui.Add("Edit", "x272 y192 w209 h48", "Animals")
myGui.SetFont("s20 c0xBBE9FF", "Segoe UI")
ogcAnimalshEdtValue11.Opt("Background171717")
myGui.Add("UpDown", "x480 y192 w18 h48", "1")
myGui.SetFont("s20 c0xFDFEFF")
DropDownList1 := myGui.Add("DropDownList", "x40 y32 w218", ["DropDownList", "", ""])
myGui.SetFont("s20 c0xBBE9FF", "Segoe UI")
DropDownList2 := myGui.Add("DropDownList", "x40 y116 w218", ["DropDownList", "", ""])
DropDownList3 := myGui.Add("DropDownList", "x40 y192 w218", ["DropDownList", "", ""])
ogcButtonCONFIRM.OnEvent("Click", OnEventHandler)
ogcButtonCANCEL.OnEvent("Click", OnEventHandler)
Edit1.OnEvent("Change", OnEventHandler)
Edit2.OnEvent("Change", OnEventHandler)
Edit3.OnEvent("Change", OnEventHandler)
Edit4.OnEvent("Change", OnEventHandler)
ogcNotesnhEdtValue5.OnEvent("Change", OnEventHandler)
ogc1hEdtValue9.OnEvent("Change", OnEventHandler)
ogcAnimalshEdtValue10.OnEvent("Change", OnEventHandler)
ogcAnimalshEdtValue11.OnEvent("Change", OnEventHandler)
DropDownList1.OnEvent("Change", OnEventHandler)
DropDownList2.OnEvent("Change", OnEventHandler)
DropDownList3.OnEvent("Change", OnEventHandler)
myGui.OnEvent('Close', (*) => ExitApp())
myGui.Title := "calendarSimple.ahk (Clone)"
myGui.Show("w1300 h600")

OnEventHandler(*)
{
	ToolTip("Click! This is a sample action.`n"
	. "Active GUI element values include:`n"  
	. "ogcButtonCONFIRM => " ogcButtonCONFIRM.Text "`n" 
	. "ogcButtonCANCEL => " ogcButtonCANCEL.Text "`n" 
	. "Edit1 => " Edit1.Value "`n" 
	. "Edit2 => " Edit2.Value "`n" 
	. "Edit3 => " Edit3.Value "`n" 
	. "Edit4 => " Edit4.Value "`n" 
	. "ogcNotesnhEdtValue5 => " ogcNotesnhEdtValue5.Value "`n" 
	. "ogc1hEdtValue9 => " ogc1hEdtValue9.Value "`n" 
	. "ogcAnimalshEdtValue10 => " ogcAnimalshEdtValue10.Value "`n" 
	. "ogcAnimalshEdtValue11 => " ogcAnimalshEdtValue11.Value "`n" 
	. "DropDownList1 => " DropDownList1.Text "`n" 
	. "DropDownList2 => " DropDownList2.Text "`n" 
	. "DropDownList3 => " DropDownList3.Text "`n", 77, 277)
	SetTimer () => ToolTip(), -3000 ; tooltip timer
}
