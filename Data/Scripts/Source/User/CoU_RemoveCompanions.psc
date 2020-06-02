Scriptname CoU_RemoveCompanions extends ObjectReference

;Properties
Action Property akIdle Auto
ObjectReference Property marker Auto

;Events
Event OnActivate(ObjectReference akActionRef)
   Game.ForceFirstPerson()
   Actor[] playerFollowers = Game.GetPlayerFollowers()
   int index = 0
   while (index < playerFollowers.Length)
	 playerFollowers[index].MoveTo(marker)
     playerFollowers[index].DisallowCompanion(true)
     index += 1
   endWhile
   Game.GetPlayer().PlayIdleAction(akIdle)
EndEvent
