Scriptname CoU_AddHolotape extends ObjectReference

;Properties
Form Property CoU_MinerDiaryHolotape Auto

;Events

Event OnActivate(ObjectReference akActionRef)
	If Game.GetPlayer().GetItemCount(CoU_MinerDiaryHolotape) == 0
		Game.GetPlayer().AddItem(CoU_MinerDiaryHolotape, 1, false)
	EndIf
EndEvent


