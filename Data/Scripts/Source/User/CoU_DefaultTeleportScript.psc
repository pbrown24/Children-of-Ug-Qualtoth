Scriptname CoU_DefaultTeleportScript extends ObjectReference

ObjectReference Property TeleportRef Auto   ;This is the thing you want to teleport to. Don't forget to fill your properties. 

Event OnActivate(ObjectReference akActionRef)
   if game.GetPlayer().IsDead() == False
   
	Game.GetPlayer().MoveTo(TeleportRef)
   
   endif
   
EndEvent
