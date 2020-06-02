Scriptname CoU_ActivateWithItem extends ObjectReference

;Properties
Form Property Item Auto
ObjectReference Property Object Auto
int property minNeeded Auto
{The number of Item needed to activate the Object}

;Events
Event OnActivate(ObjectReference akActionRef)
   If Game.GetPlayer().GetItemCount(Item) >= minNeeded
		Object.Activate(Game.GetPlayer())
   EndIf
EndEvent
