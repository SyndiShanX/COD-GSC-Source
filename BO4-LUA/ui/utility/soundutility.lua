CoD.SoundUtility = {}
CoD.SoundUtility.PlayVO = function(f1_arg0, f1_arg1, f1_arg2)
	if f1_arg0.___voSoundAlias then
		StopSoundAlias(f1_arg0.__voSoundAlias)
	end
	PlaySoundAlias(f1_arg1)
	f1_arg0.__voSoundAlias = f1_arg1
	if f1_arg2 == true and not f1_arg0.__stopVoOnCloseCallback then
		f1_arg0.__stopVoOnCloseCallback = true
		LUI.OverrideFunction_CallOriginalFirst(f1_arg0, "close", function()
			CoD.SoundUtility.StopVO(f1_arg0)
		end)
	end
end
CoD.SoundUtility.StopVO = function(f3_arg0)
	if f3_arg0.__voSoundAlias then
		StopSoundAlias(f3_arg0.__voSoundAlias)
		f3_arg0.__voSoundAlias = nil
	end
end
CoD.SoundUtility.PlaySoundOnceForController = function(f4_arg0, f4_arg1)
	if not CoD.perController[f4_arg0]._playOnceAliases then
		CoD.perController[f4_arg0]._playOnceAliases = {}
	end
	if CoD.perController[f4_arg0]._playOnceAliases[f4_arg1] then
		return
	else
		CoD.perController[f4_arg0]._playOnceAliases[f4_arg1] = true
		Engine[0xC4146BA76D0F982](f4_arg1)
	end
end
CoD.SoundUtility.StopPlayOnceSoundForController = function(f5_arg0, f5_arg1)
	if CoD.perController[f5_arg0]._playOnceAliases then
		CoD.perController[f5_arg0]._playOnceAliases[f5_arg1] = nil
	end
	Engine[0xC738A7A46EDBB34](f5_arg1)
end
