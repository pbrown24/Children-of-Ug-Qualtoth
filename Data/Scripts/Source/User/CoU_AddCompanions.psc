Scriptname CoU_AddCompanions extends ObjectReference

;Properties
Idle Property akIdle Auto
ObjectReference Property marker Auto

;Events
Event OnActivate(ObjectReference akActionRef)
   Actor[] playerFollowers = Game.GetPlayerFollowers()
   int index = 0
   while (index < playerFollowers.Length)
	 playerFollowers[index].MoveTo(Game.GetPlayer())
     playerFollowers[index].AllowCompanion(true)
	 playerFollowers[index].SetCompanion(true)
     index += 1
   endWhile
EndEvent
