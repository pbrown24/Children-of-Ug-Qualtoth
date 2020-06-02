Scriptname CoU_ElderOfUgQualtothScript extends ActiveMagicEffect

ActorBase Property CoU_Reject Auto
ActorBase Property CoU_encChildofUgQualtoh Auto
ActorBase Property CoU_Stone Auto
Explosion Property MarkerDeathExplosion Auto
Explosion Property MarkerDeathExplosion2 Auto
Explosion Property MarkerDeathExplosion3 Auto
Explosion Property MarkerDamageExplosion Auto
EffectShader Property MagicEffectShader Auto
EffectShader Property pFXS Auto Const
Form Property CoU_ObeliskRemains Auto
Sound Property CoU_HeraldDamage Auto
Sound Property CoU_Whispers Auto
int soundInstance
Actor shade00
Actor shade01
Actor child00
Actor child01
Actor frozen00
Actor frozen01
Actor selfRef

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if  (akCaster as objectReference).WaitFor3DLoad()
		selfRef = self.GetTargetActor()
		akCaster.SetSubGraphFloatVariable("fToggleBlend", 1.0)
		shade00 = selfRef.PlaceAtMe(CoU_Reject, 1) as Actor
		shade00.MoveTo(selfRef, 700, 700, 0, false)
		shade00.MoveToNearestNavMeshLocation()
		shade00.Activate(selfRef as ObjectReference)
		shade01 = selfRef.PlaceAtMe(CoU_Reject, 1) as Actor
		shade01.MoveTo(selfRef, -700, -700, 0, false)
		shade01.MoveToNearestNavMeshLocation()
		shade01.Activate(selfRef as ObjectReference)
		
		child00 = selfRef.PlaceAtMe(CoU_encChildofUgQualtoh, 1) as Actor
		child00.MoveTo(selfRef, 700, -700, 0, false)
		child00.MoveToNearestNavMeshLocation()
		child00.Activate(selfRef as ObjectReference)
		child01 = selfRef.PlaceAtMe(CoU_encChildofUgQualtoh, 1) as Actor
		child01.MoveTo(selfRef, -700, 700, 0, false)
		child01.MoveToNearestNavMeshLocation()
		child01.Activate(selfRef as ObjectReference)
		
		frozen00 = selfRef.PlaceAtMe(CoU_Stone, 1) as Actor
		frozen00.MoveTo(selfRef, 1000, 0, 0, false)
		frozen00.MoveToNearestNavMeshLocation()
		frozen01 = selfRef.PlaceAtMe(CoU_Stone, 1) as Actor
		frozen01.MoveTo(selfRef, -1000, 0, 0, false)
		frozen01.MoveToNearestNavMeshLocation()
		pFXS.Play(selfRef)
		
		soundInstance = CoU_Whispers.Play(selfRef)
	Endif
EndEvent	

Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
	If aiCurrentStage == 1
		If selfRef
			selfRef.PlaceAtMe(MarkerDamageExplosion, 1)
		EndIf
	ElseIf aiCurrentStage == 2
		If selfRef
			selfRef.PlaceAtMe(MarkerDamageExplosion, 1)
		EndIf
	ElseIf aiCurrentStage == 3
		If selfRef
			selfRef.PlaceAtMe(MarkerDeathExplosion, 1)
			selfRef.PlaceAtMe(MarkerDeathExplosion2, 1)
			selfRef.PlaceAtMe(MarkerDeathExplosion3, 1)
			selfRef.PlaceAtMe(CoU_ObeliskRemains, 2)
			Game.RewardPlayerXP(110)
			MagicEffectShader.play(selfRef, 4.0)
			MagicEffectShader.play(frozen00, 4.0)
			MagicEffectShader.play(frozen01, 4.0)
			StartTimer(2.5, 2)
		EndIf
	EndIf
EndEvent

Event OnDeath(Actor akKiller)
	Sound.StopInstance(soundInstance)
EndEvent

Event OnTimer(int aiTimerID)
	If aiTimerID == 2
		MagicEffectShader.stop(frozen00)
		MagicEffectShader.stop(frozen01)
		frozen00.kill()
		frozen01.kill()
		frozen00.Delete()
		frozen01.Delete()
		selfRef.Delete()
	EndIf
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	If (aeCombatState == 1)
		;Debug.Trace("We have entered combat")
		selfRef.SetSubGraphFloatVariable("fToggleBlend", 0.0)
		CoU_HeraldDamage.Play(selfRef)
	Endif
EndEvent

