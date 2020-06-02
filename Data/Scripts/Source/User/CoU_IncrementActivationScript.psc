Scriptname CoU_IncrementActivationScript extends Objectreference
{Used to call Increment on CoU_HolotapeEntriesScript to make new holotape entries available.}

CoU_HolotapeEntriesScript Property Entries Auto
GlobalVariable Property CoU_TerminalGlobal Auto

Event OnActivate(Objectreference akObjRef)
	Entries.Increment()
	float newvalue = CoU_TerminalGlobal.GetValue() + 1.0
	CoU_TerminalGlobal.SetValue(newvalue)
EndEvent
