Scriptname CoU_DefaultMoveToSlowScript extends ObjectReference

ObjectReference Property TeleportRef Auto   ;This is the thing you want to teleport to. Don't forget to fill your properties. 
Spell Property Cou_Invulnerability_Spell Auto

Event OnActivate(ObjectReference akActionRef)
   if game.GetPlayer().IsDead() == False
	Cou_Invulnerability_Spell.Cast(Game.GetPlayer(),Game.GetPlayer())
	Game.GetPlayer().TranslateToRef(TeleportRef, 400.0, 10000.0)  
   endif
   
EndEvent
