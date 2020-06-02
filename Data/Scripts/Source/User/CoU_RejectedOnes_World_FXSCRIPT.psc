Scriptname CoU_RejectedOnes_World_FXSCRIPT extends ActiveMagicEffect
{FX for RejectedOnes}

;Armor Property SkinFeralGhoulGlowingGlow Auto
ActorValue Property SpeedMult Auto
ActorValue Property AnimationMult Auto
Sound Property akSound Auto
{Sound played when the actor breaks out}
float Property GlowAmount Auto ;1.0 No Glow, 0.0 Full Glow
EffectShader Property DustEffect Auto
Faction Property PlayerFaction Auto
Faction Property PlayerAllyFaction Auto
Faction Property PlayerFriendFaction Auto
EffectShader Property MagicEffectShader Auto
ActorBase Property CoU_encElderofUgQualtoh Auto
Actor Marker
float BaseValueSpeed
float BaseValueAnim

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;wait while 3d loads
	if  (akTarget as objectReference).WaitFor3DLoad()
		;test to see if xx is in ambush mode
		actor selfRef = self.GetTargetActor()
		BaseValueAnim = selfRef.GetBaseValue(AnimationMult)
		BaseValueSpeed = selfRef.GetBaseValue(SpeedMult)
		selfRef.SetSubGraphFloatVariable("fToggleBlend", 1.0)
	else
		;nothing
	endif
EndEvent

Event OnDying(Actor AkKiller)
    actor selfRef = self.GetTargetActor()
	MagicEffectShader.Play(selfRef,2.5)
	Utility.Wait(2.5)
	selfRef.Delete()
EndEvent

Event OnActivate(ObjectReference akActivator)
	actor selfRef = self.GetTargetActor()
	Marker = akActivator as Actor
	RegisterForRemoteEvent(Marker, "OnCombatStateChanged")
	RegisterForRemoteEvent(Marker, "OnDeath")
	selfRef.SetGhost(true) 
	float spawnDelay = Utility.RandomFloat(1.0, 3.5)
	StartTimer(spawnDelay, 1)
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

Event Actor.OnDeath(Actor akKilled, Actor akKiller)
		actor selfRef = self.GetTargetActor()
		akSound.play(selfRef)
		selfRef.RemoveFromFaction(PlayerFaction)
		selfRef.RemoveFromFaction(PlayerAllyFaction)
		selfRef.RemoveFromFaction(PlayerFriendFaction)
		DustEffect.play(selfRef, 2)
		float random = Utility.RandomFloat(0.5, 10.0)
		StartTimer(random, 2)
EndEvent

Event Actor.OnCombatStateChanged(Actor akActor, Actor akTarget, int aeCombatState)
	If (aeCombatState == 1)
		actor selfRef = self.GetTargetActor()
		akSound.play(selfRef)
		selfRef.RemoveFromFaction(PlayerFaction)
		selfRef.RemoveFromFaction(PlayerAllyFaction)
		selfRef.RemoveFromFaction(PlayerFriendFaction)
		DustEffect.play(selfRef, 2)
		float random = Utility.RandomFloat(0.5, 10.0)
		StartTimer(random, 2)
	Else
		StartTimer(0.1, 1)
	Endif
EndEvent


