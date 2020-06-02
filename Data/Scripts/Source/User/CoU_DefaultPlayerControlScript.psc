Scriptname CoU_DefaultPlayerControlScript extends ObjectReference

int property disablePlayer auto
{If true: disable player activation controls, combat, menus If false: enable all player controls}

InputEnableLayer Property myLayer Auto

Event OnInit()
	  myLayer = InputEnableLayer.Create()
EndEvent

Event OnActivate(ObjectReference akActionRef)
   if game.GetPlayer().IsDead() == False
	if disablePlayer == 1
		disablePlayer = 0
		myLayer.DisablePlayerControls(false,true,false,false,true,true,true,true,true,true,false) 
		myLayer.EnableSprinting(false) 
	elseif disablePlayer == 0
		disablePlayer = 1
		myLayer.Reset()
	endif
   endif
EndEvent

