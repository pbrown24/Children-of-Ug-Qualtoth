Scriptname CoU_RockfallSequence extends ObjectReference

;Properties
Idle Property akIdle Auto
Idle Property akIdle2 Auto
ImageSpaceModifier Property CoU_RockfallImod Auto
InputEnableLayer Property myLayer Auto Hidden
Message Property CoU_CompanionSeperated Auto

;Events

Event OnActivate(ObjectReference akActionRef)
   myLayer = InputEnableLayer.Create()
   Game.ForceFirstPerson()
   myLayer.DisablePlayerControls(true,true,true,true,true,true,true,true,true,true,true) 
   CoU_RockfallImod.Apply(1.0)
   StartTimer(10.0, 1)
    StartTimer(14.0, 2)
   Game.GetPlayer().PlayIdle(akIdle)
EndEvent

Event OnTimer(int aiTimerID)
	if aiTimerID == 1
		myLayer.Reset()
		Game.GetPlayer().PlayIdle(akIdle2)
	Elseif aiTimerID == 2
		CoU_CompanionSeperated.show()
	EndIf
EndEvent


