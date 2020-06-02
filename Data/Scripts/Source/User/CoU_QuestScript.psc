Scriptname CoU_QuestScript extends Quest

QuestStage Property CoU_Stage0 Auto
QuestStage Property CoU_Stage1 Auto
ImageSpaceModifier Property CoU_InstantBlackFade Auto
Sound Property CoU_WhispersStinger Auto
Message Property CoU_QuestMessage Auto
Location property CoU_ForgottenChurchLocation Auto
Form property xMarker Auto
ObjectReference Property TeleportRef Auto
ObjectReference Property ReturnRef Auto
ObjectReference xMarkerRef
CoU_ChildrenOfUgQualtothLeveledActor Property CoU_LL Auto
bool HasPlayedMessage

Event OnInit()
	 RegisterForPlayerSleep()
	 RegisterForRemoteEvent(Game.GetPlayer(),"OnLocationChange")
	 RegisterForRemoteEvent(ReturnRef, "OnActivate")
	 HasPlayedMessage = false
EndEvent

Event OnPlayerSleepStop(bool abInterrupted, ObjectReference akBed)
	If Game.GetPlayer().GetLevel() >= 10
		if abInterrupted
		   RegisterForPlayerSleep()
		else
			xMarkerRef = Game.GetPlayer().PlaceAtMe(xMarker)
			Game.GetPlayer().MoveTo(TeleportRef)
		endIf
	else
		 RegisterForPlayerSleep()
	Endif
EndEvent

Event ObjectReference.OnActivate(ObjectReference akObjRef, ObjectReference akActionRef)
	CoU_InstantBlackFade.Apply()
	Game.GetPlayer().MoveTo(xMarkerRef)
	CoU_QuestMessage.Show()
	Quest.SetQuestStage(CoU_Stage0)
	SetObjectiveDisplayed(0,1)
	CoU_WhispersStinger.play(Game.GetPlayer())
	UnRegisterForPlayerSleep()
	Utility.Wait(0.5)
	CoU_LL.First()
	HasPlayedMessage = true
EndEvent

Event Actor.OnLocationChange(Actor akPlayer, Location akOldLoc, Location akNewLoc)
	If Game.GetPlayer().GetCurrentLocation() == CoU_ForgottenChurchLocation
		CompleteAllObjectives()
		CompleteQuest()
		UnRegisterForRemoteEvent(Game.GetPlayer(),"OnLocationChange")
		UnRegisterForPlayerSleep()
		If HasPlayedMessage == false
			CoU_LL.First()
		EndIf
	EndIf
EndEvent
