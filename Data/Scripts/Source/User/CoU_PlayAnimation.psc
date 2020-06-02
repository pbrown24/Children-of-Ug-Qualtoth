Scriptname CoU_PlayAnimation extends ObjectReference

;Properties
String Property Animation Auto

;Events
Event OnActivate(ObjectReference akActionRef)
   Animation.PlayAnimation(Animation)
EndEvent
