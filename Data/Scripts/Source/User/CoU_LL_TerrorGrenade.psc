Scriptname CoU_LL_TerrorGrenade extends Quest

Function PlayMessage()
	int aibutton = CoU_StartMessageGrenade.show()
	If aibutton == 0 ;No Spawns until after dungeon is cleared
		AddToList()
	Else
	
	EndIf
	Game.GetPlayer().AddItem(CoU_SettingsHolotape, 1, false)
EndFunction

Function First()
	int aibutton = CoU_First_LL_GrenadeMessage.show()
	If aibutton == 0 ;No Spawns until after dungeon is cleared
		RegisterForRemoteEvent(TriggerBox,"OnActivate")
	ElseIf aibutton == 1
		int aibutton2 = CoU_AreYouSure.show()
		if aibutton2 == 0
			AddToList()
			Game.GetPlayer().AddItem(CoU_SettingsHolotape, 1, false)
		else
			First()
		endif
	EndIf
EndFunction

Event ObjectReference.OnActivate(ObjectReference akObjRef, ObjectReference akActionRef)
	AddToList()
EndEvent

Function RevertList()
	LLI_Grenade_frag_15.Revert()
	LLS_Grenade_Molotov.Revert()
	LL_Grenades_15.Revert()
	LL_Grenades_25.Revert()
	LL_Grenades_50.Revert()
	LLI_Vendor_Grenades_Basic.Revert()
	LL_Vendor_Grenades_50.Revert()
	LL_Vendor_Grenades.Revert()
	LLI_Raider_Grenade_frag_15.Revert()
EndFunction

Function AddToList()
	LLI_Grenade_frag_15.AddForm(CoU_TerrorGrenadeForm, 1, 1)
	LLS_Grenade_Molotov.AddForm(CoU_TerrorGrenadeForm, 1, 1)
	LL_Grenades_15.AddForm(CoU_TerrorGrenadeForm, 1, 1)
	LL_Grenades_25.AddForm(CoU_TerrorGrenadeForm, 1, 1)
	LL_Grenades_50.AddForm(CoU_TerrorGrenadeForm, 1, 1)
	LLI_Vendor_Grenades_Basic.AddForm(CoU_TerrorGrenadeForm, 1, 1)
	LL_Vendor_Grenades_50.AddForm(CoU_TerrorGrenadeForm, 1, 1)
	LL_Vendor_Grenades.AddForm(CoU_TerrorGrenadeForm, 1, 1)
	LLI_Raider_Grenade_frag_15.AddForm(CoU_TerrorGrenadeForm, 1, 1)
EndFunction

Group Lists
	ObjectReference Property TriggerBox Auto
	Form Property CoU_TerrorGrenadeForm Auto
	LeveledItem Property LLI_Grenade_frag_15 Auto
	LeveledItem Property LLS_Grenade_Molotov Auto
	LeveledItem Property LL_Grenades_15 Auto
	LeveledItem Property LL_Grenades_25 Auto
	LeveledItem Property LL_Grenades_50 Auto
	LeveledItem Property LLI_Vendor_Grenades_Basic Auto
	LeveledItem Property LL_Vendor_Grenades_50 Auto
	LeveledItem Property LL_Vendor_Grenades Auto
	LeveledItem Property LLI_Raider_Grenade_frag_15 Auto
	Message Property CoU_StartMessageGrenade Auto
	Message Property CoU_First_LL_GrenadeMessage Auto
	Message Property CoU_AreYouSure Auto
	Holotape Property CoU_SettingsHolotape Auto
EndGroup
