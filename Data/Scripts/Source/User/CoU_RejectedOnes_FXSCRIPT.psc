Scriptname CoU_RejectedOnes_FXSCRIPT extends ActiveMagicEffect
{FX for RejectedOnes}

;Armor Property SkinFeralGhoulGlowingGlow Auto
ActorValue Property SpeedMult Auto
ActorValue Property AnimationMult Auto
Sound Property akSound Auto
{Sound played when the actor breaks out}
float Property activationTime Auto
{Amount of time to activate}
float Property GlowAmount Auto ;1.0 No Glow, 0.0 Full Glow
EffectShader Property DustEffect Auto
Faction Property PlayerFaction Auto
Faction Property PlayerAllyFaction Auto
Faction Property PlayerFriendFaction Auto
Spell Property CoU_RejectDeathSpell Auto
float BaseValueSpeed
float BaseValueAnim

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;wait while 3d loads
	if  (akCaster as objectReference).WaitFor3DLoad()
		;test to see if xx is in ambush mode
		akCaster.SetGhost(true) 
		BaseValueAnim = akCaster.GetBaseValue(AnimationMult)
		BaseValueSpeed = akCaster.GetBaseValue(SpeedMult)
		akCaster.SetSubGraphFloatVariable("fToggleBlend", 1.0) 
		StartTimer(0.1, 1)
		RegisterForRemoteEvent(akCaster, "OnActivate")
	else
		;nothing
	endif
EndEvent

Event ObjectReference.OnActivate(ObjectReference akObjRef, ObjectReference akActionRef)
	actor selfRef = self.GetTargetActor()
	akSound.play(selfRef)
	selfRef.RemoveFromFaction(PlayerFaction)
	selfRef.RemoveFromFaction(PlayerAllyFaction)
	selfRef.RemoveFromFaction(PlayerFriendFaction)
	DustEffect.play(selfRef, 2)
	StartTimer(activationTime, 2)
EndEvent

Event OnDying(Actor AkKiller)
    actor selfRef = self.GetTargetActor()
	CoU_RejectDeathSpell.Cast(selfRef, selfRef)
EndEvent

Event OnTimer(int aiTimerID)
	If aiTimerID == 1
		actor selfRef = self.GetTargetActor()
		selfRef.enableAI(false)
		selfRef.SetValue(SpeedMult, 0.1)
		selfRef.setValue(AnimationMult, 0.1)
	ElseIf aiTimerID == 2
		actor selfRef = self.GetTargetActor()
		selfRef.SetValue(SpeedMult, BaseValueSpeed)
		selfRef.setValue(AnimationMult, BaseValueAnim)
		selfRef.SetGhost(false)
		selfRef.enableAI(true)
		selfRef.StartCombat(Game.GetPlayer())
		
	EndIf
EndEvent


