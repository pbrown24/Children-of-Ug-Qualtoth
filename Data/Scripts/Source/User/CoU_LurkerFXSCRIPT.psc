Scriptname CoU_LurkerFXSCRIPT extends ActiveMagicEffect
{FX for Lurker}

ActorValue Property SpeedMult Auto
ActorValue Property AnimationMult Auto
Idle Property IdleSpasm Auto
Idle Property IdleSit Auto
float Property GlowAmount Auto ;1.0 No Glow, 0.0 Full Glow
float BaseValueSpeed
float BaseValueAnim

bool isAlive = true
int sleepState =2
int sitState =2

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;wait while 3d loads
	if  (akCaster as objectReference).WaitFor3DLoad()
		;test to see if xx is in ambush mode
		akCaster.SetEssential(true) 
		BaseValueAnim = akCaster.GetBaseValue(AnimationMult)
		BaseValueSpeed = akCaster.GetBaseValue(SpeedMult)
		akCaster.SetSubGraphFloatVariable("fToggleBlend", 1.0) 
		float time = utility.randomfloat(1.0, 1.0) 
		StartTimer(time, 1)
	else
		;nothing
	endif
EndEvent

Event OnTimer(int aiTimerID)
	actor selfRef = self.GetTargetActor()
	If aiTimerID == 1
		selfRef.enableAI(false)
		selfRef.SetValue(SpeedMult, 0.01)
		selfRef.setValue(AnimationMult, 0.01)
		StartTimer(GetDelay(), 2)
		
		
	ElseIf aiTimerId == 2
		selfRef.enableAI(true)
		selfRef.SetValue(SpeedMult, 400)
		selfRef.setValue(AnimationMult, 400)
		int IdleAction = utility.randomInt(0, 2)
		If IdleAction == 0 
			selfRef.SetLookAt(Game.GetPlayer(), true)
		ElseIf IdleAction == 1
			If selfRef.PlayIdle(IdleSit)
			EndIf
		Else
			If selfRef.PlayIdle(IdleSpasm)
			EndIf
		EndIf
		StartTimer(0.3, 1)
		
		
	ElseIf aiTimerId == 3
		float distance = (Game.GetPlayer() as ObjectReference).GetDistance(selfRef as ObjectReference)
		If Game.GetPlayer().HasDetectionLOS(selfRef)
				;Debug.Trace(distance)
				If selfRef.GetValue(SpeedMult) > 1.0
					selfRef.SetValue(SpeedMult, 0.01)
				EndIf
				If selfRef.GetValue(AnimationMult) > 1.0
					selfRef.setValue(AnimationMult, 0.01)
				EndIf
				StartTimer(0.1, 3)
		ElseIf distance < 2000
			selfRef.SetValue(SpeedMult, 90.0)
			selfRef.SetValue(AnimationMult, 100.0)
			selfRef.PathToReference(Game.GetPlayer(), 0.3)
			StartTimer(0.1, 3)
		Else
			RegisterForDistanceLessThanEvent(Game.GetPlayer(), selfRef, 1000)
			StartTimer(0.1, 1)
		EndIf
	EndIf
EndEvent

Event OnDistanceLessThan(ObjectReference akObj1, ObjectReference akObj2, float afDistance)
	actor selfRef = self.GetTargetActor()
	int Follow = utility.randomInt(0, 1)
	If Follow == 1
		CancelTimer(1)
		CancelTimer(2)
		selfRef.SetLookAt(Game.GetPlayer(), true)
		StartTimer(0.1, 3)
	EndIf
EndEvent

Float Function GetDelay()
	float time = utility.randomfloat(10.0, 50.0) 
	return(time)
EndFunction

