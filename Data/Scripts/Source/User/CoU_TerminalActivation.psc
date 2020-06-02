ScriptName CoU_TerminalActivation extends Terminal

; Events
;---------------------------------------------


Event OnMenuItemRun(int auiMenuItemID, ObjectReference akTerminalRef)
    If (auiMenuItemID == 1)
		akActivator.Activate(Game.GetPlayer())
    EndIf
EndEvent


; Properties
;---------------------------------------------

ObjectReference Property akActivator Auto
