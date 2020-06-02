Scriptname CoU_BossRef_FXSCRIPT extends Actor
{FX for ChildrenOfUgQualtoth}

;Armor Property SkinFeralGhoulGlowingGlow Auto
Faction Property UgQualtothAllyFaction Auto
FormList Property CompanionFormlist Auto
Form Property TotemOfUgQualtoth Auto
Spell Property DisintegrationSpell Auto
ObjectReference Marker
ObjectReference Property OriginalMarker Auto
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
			selfRef.SetSubGraphFloatVariable("fToggleBlend", 1.0)
		endIf
		;akCaster.SetEssential(true)
		float spawnDelay = Utility.RandomFloat(0.0, 3.5)
		StartTimer(spawnDelay, 2)
	else
		;nothing
	endif
EndEvent

Event OnTimer(int aiTimerID)
	actor selfRef = self
	If aiTimerID == 1
		int combatstate = selfRef.GetCombatState()
	ElseIf aiTimerID == 2
		Marker = OriginalMarker 
		int combatstate = selfRef.GetCombatState()
	ElseIf aiTimerID == 3
		If (Marker.isDestroyed() == false)
			;selfRef.PlaceAtMe(MarkerDamageExplosion, 1)
			;selfRef.PlaceAtMe(MarkerDamageExplosion2, 1)
			selfRef.Reset()
			selfRef.PlaceAtMe(MarkerDamageExplosion, 1)
			selfRef.PlaceAtMe(MarkerDamageExplosion2, 1)
			selfRef.Resurrect()
			int combatstate = selfRef.GetCombatState()
		Else
			selfRef.PlaceAtMe(MarkerDamageExplosion, 1)
			selfRef.PlaceAtMe(MarkerDamageExplosion2, 1)
		EndIf
	EndIf
EndEvent

Event OnDeath(Actor akKiller)
	actor selfRef = self
	If (Marker.isDestroyed() == false)
		DisintegrationSpell.Cast(selfRef, selfRef)
		;OriginalMarker.PlaceAtMe(MarkerDamageExplosion, 1)
		;OriginalMarker.PlaceAtMe(MarkerDamageExplosion2, 1)
		StartTimer(5.0, 3)
	Else
		isAlive = false
		selfRef.SetSubGraphFloatVariable("fToggleBlend", 1.0)
	EndIf
EndEvent
