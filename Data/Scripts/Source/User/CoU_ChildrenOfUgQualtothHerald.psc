Scriptname CoU_ChildrenOfUgQualtothHerald extends Actor

Explosion Property MarkerDamageExplosion Auto
Explosion Property MarkerDamageExplosion2 Auto
Float Property alpha Auto
{The initial alpha value of the boss}
Float Property alphaIncrement Auto
{The amount to increment the bosses alpha by | if the alpha is 1.0 then it removes ghost}
ObjectReference[] Property Markers Auto
ObjectReference[] Property Totems Auto
EffectShader Property MagicEffectShader Auto
Sound Property CoU_HeraldDamage Auto

Event OnLoad()
	Self.SetAlpha(alpha, true)
	int i = 0
	While i < Totems.length
		RegisterForRemoteEvent(Totems[i],"OnDestructionStageChanged")
		i += 1
	EndWhile
EndEvent

Event ObjectReference.OnDestructionStageChanged(ObjectReference akObjRef, int aiOldStage, int aiCurrentStage)
    If aiCurrentStage == 3
		self.PlaceAtMe(MarkerDamageExplosion, 1)
		self.PlaceAtMe(MarkerDamageExplosion2, 1)
		alpha += alphaIncrement
		Self.SetAlpha(alpha, true)
		CoU_HeraldDamage.Play(self)
		If alpha >= 1.0
			self.SetGhost(false)
		EndIf
	EndIf
EndEvent

Event OnDeath(Actor akKiller)
	StartTimer(4,1)
EndEvent

Event OnTimer(int aiTimerID)
	If aiTimerID == 1
		MagicEffectShader.play(self, 4.0)
		StartTimer(2.5, 2)
	ElseIf aiTimerID == 2
		MagicEffectShader.stop(self)
		self.Delete()
	EndIf
EndEvent


