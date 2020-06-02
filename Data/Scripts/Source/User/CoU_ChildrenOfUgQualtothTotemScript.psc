Scriptname CoU_ChildrenOfUgQualtothTotemScript extends ObjectReference

Hazard Property RadiationHazard Auto
Explosion Property MarkerDeathExplosion Auto
Explosion Property MarkerDeathExplosion2 Auto
Explosion Property MarkerDeathExplosion3 Auto
Explosion Property MarkerDamageExplosion Auto
Explosion Property MarkerDamageExplosion2 Auto
EffectShader Property MagicEffectShader Auto
Form Property CoU_ObeliskRemains Auto
ObjectReference OriginalMarker
ObjectReference RadHazard


Event OnLoad()
	OriginalMarker = self
	float[] safeLocationArray = OriginalMarker.GetSafePosition(1500.0,100.0)
	If safeLocationArray != None
		OriginalMarker.MoveTo(OriginalMarker, (OriginalMarker.GetPositionX() * -1) + safeLocationArray[0], (OriginalMarker.GetPositionY() * -1) + safeLocationArray[1], (OriginalMarker.GetPositionZ() * -1) + safeLocationArray[2])
	EndIf
	RadHazard = OriginalMarker.PlaceAtMe(RadiationHazard, 1)
	RadHazard.MoveTo(OriginalMarker)
EndEvent

Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
	If aiCurrentStage == 1
		If OriginalMarker
			OriginalMarker.PlaceAtMe(MarkerDamageExplosion, 1)
			OriginalMarker.PlaceAtMe(MarkerDamageExplosion2, 1)
		EndIf
	ElseIf aiCurrentStage == 2
		If OriginalMarker
			OriginalMarker.PlaceAtMe(MarkerDamageExplosion, 1)
			OriginalMarker.PlaceAtMe(MarkerDamageExplosion2, 1)
		EndIf
	ElseIf aiCurrentStage == 3
		RadHazard.Delete()
		If OriginalMarker
			OriginalMarker.PlaceAtMe(MarkerDeathExplosion, 1)
			OriginalMarker.PlaceAtMe(MarkerDeathExplosion2, 1)
			OriginalMarker.PlaceAtMe(MarkerDeathExplosion3, 1)
			OriginalMarker.PlaceAtMe(CoU_ObeliskRemains, 1)
			OriginalMarker = None
			Game.RewardPlayerXP(110)
			StartTimer(9.0,1)
		EndIf
	EndIf
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

