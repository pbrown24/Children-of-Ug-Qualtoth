Scriptname CoU_TerrorGrenade extends ActiveMagicEffect

;Properties
Form Property CoU_Shade Auto
ImageSpaceModifier Property CoU_TerrorIS Auto
ImageSpaceModifier Property CoU_StartTerrorIS Auto
ImageSpaceModifier Property CoU_FinishTerrorIS Auto
Form Property MistProp Auto
Form Property MistProp2 Auto
Sound Property Whispers Auto
VisualEffect Property CameraAttachFogFX Auto
Actor[] Companions
Actor shade00
Actor shade01
Actor shade02
int SoundID
ObjectReference mist
ObjectReference mist2
Actor player

;Events
Event OnEffectStart(Actor akTarget, Actor akCaster)
	player = Game.GetPlayer()
	Companions = Game.GetPlayerFollowers()
	CoU_StartTerrorIS.Apply(1.0)	
	;If player.HasMagicEffect(CoU_TerrorEffect) == false
		CoU_TerrorIS.ApplyCrossFade(1.0)
	;EndIf
	CameraAttachFogFX.Play(Game.GetPlayer())
	SoundID = Whispers.Play(Game.GetPlayer())
	mist = player.PlaceAtMe(MistProp, 1)
	mist2 = player.PlaceAtMe(MistProp2, 1)
	shade00 = player.PlaceAtMe(CoU_Shade, 1) as Actor
	shade00.MoveTo(Game.GetPlayer(), 700, 700, 0, false)
	shade00.MoveToNearestNavMeshLocation()
	shade00.StartCombat(Game.GetPlayer())
	shade01 = player.PlaceAtMe(CoU_Shade, 1) as Actor
	shade01.MoveTo(Game.GetPlayer(), -700, -700, 0, false)
	shade01.MoveToNearestNavMeshLocation()
	shade01.StartCombat(Game.GetPlayer())
	shade02 = player.PlaceAtMe(CoU_Shade, 1) as Actor
	shade02.MoveTo(Game.GetPlayer(), 0, 700, 0, false)
	shade02.MoveToNearestNavMeshLocation()
	shade02.StartCombat(Game.GetPlayer())
	int i = 0
	While (i < Companions.length)
		Companions[i].setAlpha(0.0, true)
		i += 1
	EndWhile
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ImageSpaceModifier.RemoveCrossFade(1.0)
	CoU_FinishTerrorIS.Apply(1.0)
	CameraAttachFogFX.Stop(Game.GetPlayer())
	shade00.setAlpha(0.0, true)
	shade01.setAlpha(0.0, true)
	shade02.setAlpha(0.0, true)
	shade00.Delete()
	shade01.Delete()
	shade02.Delete()
	Sound.StopInstance(SoundID)
	mist.delete()
	mist2.delete()
	int i = 0
	While (i < Companions.length)
		Companions[i].setAlpha(1.0, true)
		i += 1
	EndWhile	
EndEvent
