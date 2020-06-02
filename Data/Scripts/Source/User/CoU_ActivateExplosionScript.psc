Scriptname CoU_ActivateExplosionScript extends ObjectReference 
 
ObjectReference property  akObjRef auto
Explosion Property akExplosion auto


auto State Waiting
	Event OnActivate(ObjectReference akActionRef)
		ObjectReference explosionMarker = akObjRef.PlaceAtMe(akExplosion, 1)
		explosionMarker.MoveTo(akObjRef)
		utility.wait(1)
		gotoState("Done")
	EndEvent
endstate


state Done
endState

