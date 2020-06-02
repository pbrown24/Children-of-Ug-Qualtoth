Scriptname CoU_ChildrenOfUgQualtothLeveledActor extends Quest

CoU_LL_TerrorGrenade Property GrenadeLeveledList Auto

Event OnInIt()
	LCharFeralGhoul.AddForm(CoU_LL_Elder, 1)
	LCharFeralGhoul.AddForm(CoU_LL_Elder, 9)
	LCharFeralGhoul.AddForm(CoU_LL_Elder, 15)
	LCharFeralGhoul.AddForm(CoU_LL_Elder, 22)
	LCharFeralGhoul.AddForm(CoU_LL_Elder, 32)
	LCharFeralGhoul.AddForm(CoU_LL_Elder, 52)
	LCharFeralGhoul.AddForm(CoU_LL_Elder, 62)
EndEvent


Function PlayMessage()
	int aibutton = CoU_StartMessage.show()
	If aibutton == 0 ;No Spawns until after dungeon is cleared
		AddToList()
	Else
	
	EndIf
	GrenadeLeveledList.PlayMessage()
EndFunction

Event ObjectReference.OnActivate(ObjectReference akObjRef, ObjectReference akActionRef)
	PlayMessage()
EndEvent

Function First()
	int aibutton = CoU_First_LL_CharMessage.show()
	If aibutton == 0 ;No Spawns until after dungeon is cleared
		RegisterForRemoteEvent(TriggerBox,"OnActivate")
	ElseIf aibutton == 1 ;Spawns immedietely
		int aibutton2 = CoU_AreYouSure.show()
		if aibutton2 == 0
			AddToList()
			Game.GetPlayer().AddItem(CoU_SettingsHolotape, 1, false)
		else
			First()
		endif
	EndIf
	GrenadeLeveledList.First()
EndFunction

Function AddToList()
	CoU_LL_Elder.AddForm(encElderOfUgQualtoth, 1)
	CoU_LL_Elder.AddForm(encElderOfUgQualtoth, 9)
	CoU_LL_Elder.AddForm(encElderOfUgQualtoth, 15)
	CoU_LL_Elder.AddForm(encElderOfUgQualtoth, 22)
	CoU_LL_Elder.AddForm(encElderOfUgQualtoth, 32)
	CoU_LL_Elder.AddForm(encElderOfUgQualtoth, 52)
	CoU_LL_Elder.AddForm(encElderOfUgQualtoth, 62)
EndFunction

Function RevertList()
	CoU_LL_Elder.Revert()
EndFunction

Group Actors
	ObjectReference Property TriggerBox Auto
	Form Property encElderOfUgQualtoth Auto
	LeveledActor Property CoU_LL_Elder Auto
	LeveledActor Property LCharFeralGhoul Auto
	Message Property CoU_StartMessage Auto
	Message Property CoU_First_LL_CharMessage Auto
	Message Property CoU_AreYouSure Auto
	Holotape Property CoU_SettingsHolotape Auto
EndGroup


