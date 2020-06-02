Scriptname CoU_DestructibleActivationScript extends ObjectReference

ObjectReference OriginalMarker
ObjectReference Property obj1 Auto
ObjectReference Property obj2 Auto
ObjectReference Property obj3 Auto

Event OnLoad()
	OriginalMarker = self
EndEvent

Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
	If aiCurrentStage == 1
		obj1.Activate(Game.GetPlayer())
	ElseIf aiCurrentStage == 2
		obj2.Activate(Game.GetPlayer())
	ElseIf aiCurrentStage == 3
		obj3.Activate(Game.GetPlayer())
	EndIf
EndEvent
