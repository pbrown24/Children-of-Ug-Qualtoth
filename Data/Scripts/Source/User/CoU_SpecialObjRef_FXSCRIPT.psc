Scriptname CoU_SpecialObjRef_FXSCRIPT extends Actor
{FX for ChildrenOfUgQualtoth}

;Armor Property SkinFeralGhoulGlowingGlow Auto
Faction Property UgQualtothAllyFaction Auto
FormList Property CompanionFormlist Auto
Form Property TotemOfUgQualtoth Auto
Form Property Goo Auto
Spell Property crChildofUgQualtothBurst Auto
Spell Property DisintegrationSpell Auto
ObjectReference Marker
ObjectReference Property OriginalMarker Auto
ActorValue Property dtPhyisical Auto
ActorValue Property dtEnergy Auto
ActorValue Property SpeedMult Auto
ActorValue Property AnimationMult Auto
Explosion Property MarkerDamageExplosion Auto
Explosion Property MarkerDamageExplosion2 Auto
Idle Property GhoulStagger Auto
float BaseValueSpeed
float BaseValueAnim

bool isAlive = true
int sleepState =2
int sitState =2

Event OnLoad()
	;wait while 3d loads
	actor selfRef = self
	if  (selfRef as objectReference).WaitFor3DLoad()
		;test to see if xx is in ambush mode
		sleepState = selfRef.GetSleepState()
		sitState = selfRef.GetSitState()
		if (sleepState == 3)
			;Low glow in ambushes...set to 1.0 if you decide you want no glow
			selfRef.SetSubGraphFloatVariable("fToggleBlend", 1.0)
		elseif (sitState == 3)
			;no glow
			selfRef.SetSubGraphFloatVariable("fToggleBlend", 1.0)
		else
			;glow
			selfRef.SetSubGraphFloatVariable("fToggleBlend", 0.0)
		endIf
		;akCaster.SetEssential(true)
		BaseValueAnim = selfRef.GetBaseValue(AnimationMult)
		BaseValueSpeed = selfRef.GetBaseValue(SpeedMult)
		float spawnDelay = Utility.RandomFloat(0.0, 3.5)
		StartTimer(spawnDelay, 2)
	else
		;nothing
	endif
EndEvent

Event ObjectReference.OnDestructionStageChanged(ObjectReference akObject, int aiOldStage, int aiCurrentStage)
	actor selfRef = self
	If aiCurrentStage == 1
		selfRef.PlayIdle(GhoulStagger)
	ElseIf aiCurrentStage == 2
		selfRef.PlayIdle(GhoulStagger)
	ElseIf aiCurrentStage == 3
		;selfRef.SetEssential(false)
		selfRef.PlayIdle(GhoulStagger)
		selfRef.ModValue(dtPhyisical, -1000.0)
		selfRef.ModValue(dtEnergy, -1000.0)
		selfRef.SetValue(SpeedMult, 90.0)
		selfRef.SetValue(AnimationMult, 100.0)
		selfRef.SetSubGraphFloatVariable("fToggleBlend", 0.0)
		int i = 0
		While (i < Game.GetPlayerFollowers().length)
			If Game.GetPlayerFollowers()[i] != None
				Game.GetPlayerFollowers()[i].RemoveFromFaction(UgQualtothAllyFaction)
			EndIf
			i += 1
		EndWhile
	EndIf
EndEvent

Event OnTimer(int aiTimerID)
	actor selfRef = self
	If aiTimerID == 1
		int combatstate = selfRef.GetCombatState()
		EvaluateCombat(combatstate)
	ElseIf aiTimerID == 2
		Marker = OriginalMarker
		RegisterForRemoteEvent(Marker,"OnDestructionStageChanged") 
		int combatstate = selfRef.GetCombatState()
		EvaluateCombat(combatstate)
	ElseIf aiTimerID == 3
		If (!Marker || Marker.isDestroyed() == false)
			;selfRef.PlaceAtMe(MarkerDamageExplosion, 1)
			;selfRef.PlaceAtMe(MarkerDamageExplosion2, 1)
			selfRef.SetAlpha(1.0, false)
			selfRef.Reset()
			selfRef.PlaceAtMe(MarkerDamageExplosion, 1)
			selfRef.PlaceAtMe(MarkerDamageExplosion2, 1)
			selfRef.SetAlpha(1.0, false)
			selfRef.Resurrect()
			int combatstate = selfRef.GetCombatState()
			EvaluateCombat(combatstate)
		Else
			selfRef.PlaceAtMe(MarkerDamageExplosion, 1)
			selfRef.PlaceAtMe(MarkerDamageExplosion2, 1)
			selfRef.AttachAshPile(Goo)
		EndIf
	EndIf
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	EvaluateCombat(aeCombatState)
EndEvent

Event OnDeath(Actor akKiller)
	actor selfRef = self
	If (Marker.isDestroyed() == false)
		DisintegrationSpell.Cast(selfRef, selfRef)
		selfRef.SetAlpha(1.0, true)
		;OriginalMarker.PlaceAtMe(MarkerDamageExplosion, 1)
		;OriginalMarker.PlaceAtMe(MarkerDamageExplosion2, 1)
		StartTimer(8.0, 3)
	Else
		isAlive = false
		selfRef.SetSubGraphFloatVariable("fToggleBlend", 1.0)
	EndIf
EndEvent

Function EvaluateCombat(int aeCombatState)
	actor selfRef = self
	If Marker
		If (Marker.isDestroyed() == false)
			If (aeCombatState == 2)
				;Debug.Trace("We have left combat")
				selfRef.SetValue(SpeedMult, 90.0)
				selfRef.SetValue(AnimationMult, 100.0)
				selfRef.SetSubGraphFloatVariable("fToggleBlend", 1.0)
			ElseIf (aeCombatState == 1)
				;Debug.Trace("We have entered combat")
				int i = 0 
				float distance = (Game.GetPlayer() as ObjectReference).GetDistance(selfRef as ObjectReference)
				If Game.GetPlayer().HasDetectionLOS(selfRef)
					;Debug.Trace(distance)
					If distance < 500.0
						;Debug.Trace("Player is close to npc...")
						float glow = distance / 500.0
						selfRef.SetSubGraphFloatVariable("fToggleBlend", glow)
					Else
						selfRef.SetSubGraphFloatVariable("fToggleBlend", 0.9)
					EndIf
					If distance < 100
						;Debug.Trace("Player is super close to npc...")
						selfRef.SetValue(SpeedMult, 90.0)
						selfRef.SetValue(AnimationMult, 100.0)
					Else
						;Debug.Trace("Player is not close to npc...")
						If selfRef.GetValue(SpeedMult) > 1.0
							selfRef.SetValue(SpeedMult, 0.1)
						EndIf
						If selfRef.GetValue(AnimationMult) > 1.0
							selfRef.setValue(AnimationMult, 0.1)
						EndIf
					EndIf
					StartTimer(0.1, 1)
					return
				EndIf
				While (i < Game.GetPlayerFollowers().length)
					If Game.GetPlayerFollowers()[i] != None
						If (Game.GetPlayerFollowers()[i].HasDetectionLOS(selfRef))
							;Debug.Trace("Follower is freezing npc...")
							Game.GetPlayerFollowers()[i].AddToFaction(UgQualtothAllyFaction)
							If selfRef.GetValue(SpeedMult) > 1.0
								selfRef.SetValue(SpeedMult, 0.1)
							EndIf
							If selfRef.GetValue(AnimationMult) > 1.0
								selfRef.setValue(AnimationMult, 0.1)
							EndIf
							selfRef.SetSubGraphFloatVariable("fToggleBlend", 0.9)
							StartTimer(0.1, 1)
							return
						EndIf
					EndIf
					i += 1
				EndWhile
				selfRef.SetValue(SpeedMult, 375.0)
				selfRef.SetValue(AnimationMult, 150.0)
				selfRef.SetSubGraphFloatVariable("fToggleBlend", 0.0)
				StartTimer(0.1, 1)
			ElseIf (aeCombatState == 0)
				;Debug.Trace("We are searching...")
				selfRef.SetValue(SpeedMult, 90.0)
				selfRef.SetValue(AnimationMult, 100.0)
				selfRef.SetSubGraphFloatVariable("fToggleBlend", 0.9)
				StartTimer(0.3, 1)
			EndIf
		EndIf
	EndIf
EndFunction
