Scriptname CoU_STATUE_FXSCRIPT extends ActiveMagicEffect
{FX for ChildrenOfUgQualtoth}

;Armor Property SkinFeralGhoulGlowingGlow Auto
ActorValue Property SpeedMult Auto
ActorValue Property AnimationMult Auto
float Property GlowAmount Auto ;1.0 No Glow, 0.0 Full Glow
float BaseValueSpeed
float BaseValueAnim

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;wait while 3d loads
	if  (akCaster as objectReference).WaitFor3DLoad()
		;test to see if xx is in ambush mode
		akCaster.SetEssential(true) 
		BaseValueAnim = akCaster.GetBaseValue(AnimationMult)
		BaseValueSpeed = akCaster.GetBaseValue(SpeedMult)
		akCaster.SetSubGraphFloatVariable("fToggleBlend", 1.0) 
		float time = utility.randomfloat(1.0, 1.0) 
		StartTimer(time, 3)
	else
		;nothing
	endif
EndEvent

Event OnTimer(int aiTimerID)
	actor selfRef = self.GetTargetActor()
	selfRef.enableAI(false)
	selfRef.SetValue(SpeedMult, 0.01)
	selfRef.setValue(AnimationMult, 0.01)
EndEvent



