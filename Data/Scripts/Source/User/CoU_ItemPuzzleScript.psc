Scriptname CoU_ItemPuzzleScript extends ObjectReference

ObjectReference[] Property ActivateObjects Auto
Form[] Property KeyObjects Auto

Event OnActivate(ObjectReference akActionRef)
   int i = 0
   int j = ActivateObjects.length
   While i < ActivateObjects.length
		If Game.GetPlayer().GetItemCount(KeyObjects[i])
			Game.GetPlayer().RemoveItem(KeyObjects[i],1, false)
			ActivateObjects[i].Activate(Game.GetPlayer())
			j -= 1
			If j <= 0
				self.BlockActivation(true, true)
			EndIf
		EndIf
		Utility.Wait(0.1)
		i += 1
   EndWhile
EndEvent
