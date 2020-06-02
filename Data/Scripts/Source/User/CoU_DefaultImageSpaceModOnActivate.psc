Scriptname CoU_DefaultImageSpaceModOnActivate extends ObjectReference  
{Applies an imagespace modifier when activated}

ImageSpaceModifier Property ImageSpaceModToApply Auto 
Float Property ModIntensity Auto


Event OnActivate(ObjectReference akActionRef)

	ImageSpaceModToApply.Apply(ModIntensity)
	
EndEvent

