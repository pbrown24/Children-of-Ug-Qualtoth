Scriptname CoU_ModifyCompanions extends ObjectReference
{Starts by Removing companions, then flips to adding them back}

;Properties
ObjectReference Property marker Auto
ObjectReference Property marker2 Auto
Actor[] playerFollowers
InputEnableLayer Property myLayer Auto Hidden

;Events

auto State RemoveCompanions

	Event OnActivate(ObjectReference akActionRef)
	   playerFollowers = Game.GetPlayerFollowers()
	   int index = 0
	   while (index < playerFollowers.Length)
		 playerFollowers[index].MoveTo(marker)
		 playerFollowers[index].DisallowCompanion(true)
		 index += 1
	   endWhile
	   GoToState("AddCompanions")
	EndEvent

EndState

State AddCompanions
	
	
	Event OnActivate(ObjectReference akActionRef)
	   int index = 0
	   while (index < playerFollowers.Length)
		 playerFollowers[index].MoveTo(marker2)
		 playerFollowers[index].AllowCompanion(true)
		 playerFollowers[index].SetCompanion(true)
		 index += 1
	   endWhile
	   GoToState("RemoveCompanion")
	EndEvent
	
EndState


