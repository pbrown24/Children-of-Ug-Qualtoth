ScriptName CoU_CompanionDefaultActivateSelf extends ObjectReference Default
{Default script that simply activates itself once when player enters trigger, can optionally triggered by specific refs, aliases, or factions.}

import CommonArrayFunctions
import debug

Group Optional_Properties
	bool property PlayerOnly = TRUE auto Const
	{Only Player Triggers?  Default: TRUE
	Must be FALSE if you put anything in the arrays.}

	int property PlayerMinLevel auto Const
	{If set, player must be >= PlayerMinLevel to activate this}

	ObjectReference[] Property TriggeredByReferences Auto Const
	{Activation will occur if Triggered by any of these references.
	If ALL arrays are empty then stage is set if Triggered by anybody.}

	ReferenceAlias[] Property TriggeredByAliases Auto Const
	{Activation will occur if Triggered by any of these aliases.
	If ALL arrays are empty then stage is set if Triggered by anybody.}

	Faction[] Property TriggeredByFactions Auto Const
	{Activation will occur if Triggered by any of these factions.
	If ALL arrays are empty then stage is set if Triggered by anybody.}
EndGroup


;************************************

auto STATE Waiting
	Event onTriggerEnter(objectReference triggerRef)
		if PlayerOnly
			if triggerRef == Game.GetPlayer() && (Game.GetPlayerFollowers().Length > 0)
				if(PlayerMinLevel == 0 || game.getPlayer().getLevel() >= PlayerMinLevel)
						; We only care about the player, it is the player, and he either matches the min level or there isn't one. ACTIVATE!
					debug.Trace(self + "OnTriggerEnter()| We only care about the player, it is the player, and he either matches the min level or there isn't one. ACTIVATE!")
					GoToState("DoneWaiting")
					activate(self)
				endif
			endif
		else
			if TriggeredByReferences.Length == 0 && TriggeredByAliases.Length == 0 && TriggeredByFactions.Length == 0
					; We don't care about the player, and the arrays are empty.  Doesn't matter what triggers us, ACTIVATE!
				debug.Trace(self + "OnTriggerEnter()| We don't care about the player, and the arrays are empty.  Doesn't matter what triggers us, ACTIVATE! " + TriggeredByReferences.length + TriggeredByAliases.length + TriggeredByFactions.length)
				GoToState("DoneWaiting")
				activate(self)
			else
				if CheckObjectReferenceAgainstArray(triggerRef, TriggeredByReferences) || CheckObjectReferenceAgainstReferenceAliasArray(triggerRef, TriggeredByAliases) || CheckActorAgainstFactionArray(triggerRef as Actor, TriggeredByFactions)
					if(PlayerMinLevel == 0 || game.getPlayer().getLevel() >= PlayerMinLevel)
							; We only care about the arrays, something in them triggered us, and the player matches the min level or there isn't one. ACTIVATE!
						debug.Trace(self + "OnTriggerEnter()| We only care about the arrays, something in them triggered us, and the player matches the min level or there isn't one. ACTIVATE!")
						GoToState("DoneWaiting")
						activate(self)
					endif
				endif
			endif
		endif


	endEvent
endSTATE

;************************************

STATE DoneWaiting
	;do nothing
endSTATE

;************************************