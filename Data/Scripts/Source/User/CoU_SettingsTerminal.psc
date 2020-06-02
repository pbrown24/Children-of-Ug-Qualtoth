ScriptName CoU_SettingsTerminal extends Terminal

; Events
;---------------------------------------------


Event OnMenuItemRun(int auiMenuItemID, ObjectReference akTerminalRef)
    If (auiMenuItemID == 1)
		CoU_LL.AddToList()
	ElseIf (auiMenuItemID == 2)
		CoU_LL.RevertList()
	ElseIf (auiMenuItemID == 3)
		GrenadeLeveledList.AddToList()
	ElseIf (auiMenuItemID == 4)
		GrenadeLeveledList.RevertList()
    EndIf
EndEvent


; Properties
;---------------------------------------------

CoU_ChildrenOfUgQualtothLeveledActor Property CoU_LL Auto
CoU_LL_TerrorGrenade Property GrenadeLeveledList Auto