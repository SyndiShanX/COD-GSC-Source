CoD.ZMInvChallengeProgress = InheritFrom(LUI.UIElement)
CoD.ZMInvChallengeProgress.__defaultWidth = 320
CoD.ZMInvChallengeProgress.__defaultHeight = 20
CoD.ZMInvChallengeProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ZMInvChallengeProgress)
	self.id = "ZMInvChallengeProgress"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CurrentProgress = LUI.UIText.new(0, 0, 0, 98, 0, 0, 0, 21)
	CurrentProgress:setTTF("dinnext_regular")
	CurrentProgress:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CurrentProgress:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CurrentProgress:linkToElementModel(self, "currentProgress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CurrentProgress:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(CurrentProgress)
	self.CurrentProgress = CurrentProgress
	local CurrentProgressTime = LUI.UIText.new(0, 0, 0, 98, 0, 0, 0, 21)
	CurrentProgressTime:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CurrentProgressTime:setAlpha(0)
	CurrentProgressTime:setTTF("dinnext_regular")
	CurrentProgressTime:setLetterSpacing(1)
	CurrentProgressTime:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CurrentProgressTime:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CurrentProgressTime:linkToElementModel(self, "currentProgress", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CurrentProgressTime:setText(CoD.BaseUtility.AlreadyLocalized(SecondsAsTime(f3_local0)))
		end
	end)
	self:addElement(CurrentProgressTime)
	self.CurrentProgressTime = CurrentProgressTime
	local Divider = LUI.UIText.new(0, 0, 98, 127, 0, 0, 0, 19)
	Divider:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Divider:setText(CoD.BaseUtility.AlreadyLocalized("/"))
	Divider:setTTF("ttmussels_demibold")
	Divider:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Divider:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Divider)
	self.Divider = Divider
	local NumNeeded = LUI.UIText.new(0, 0, 127, 215, 0, 0, 0, 21)
	NumNeeded:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	NumNeeded:setTTF("dinnext_regular")
	NumNeeded:setLetterSpacing(1)
	NumNeeded:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	NumNeeded:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	NumNeeded:linkToElementModel(self, "numNeeded", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			NumNeeded:setText(CoD.BaseUtility.AlreadyLocalized(f4_local0))
		end
	end)
	self:addElement(NumNeeded)
	self.NumNeeded = NumNeeded
	self:mergeStateConditions({
		{
			stateName = "TimeBasedChallenge",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "numNeeded", 0)
			end,
		},
	})
	self:linkToElementModel(self, "numNeeded", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "numNeeded",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvChallengeProgress.__resetProperties = function(f7_arg0)
	f7_arg0.Divider:completeAnimation()
	f7_arg0.NumNeeded:completeAnimation()
	f7_arg0.CurrentProgressTime:completeAnimation()
	f7_arg0.CurrentProgress:completeAnimation()
	f7_arg0.Divider:setAlpha(1)
	f7_arg0.NumNeeded:setAlpha(1)
	f7_arg0.CurrentProgressTime:setAlpha(0)
	f7_arg0.CurrentProgress:setAlpha(1)
end
CoD.ZMInvChallengeProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	TimeBasedChallenge = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.CurrentProgress:completeAnimation()
			f9_arg0.CurrentProgress:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CurrentProgress)
			f9_arg0.CurrentProgressTime:completeAnimation()
			f9_arg0.CurrentProgressTime:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.CurrentProgressTime)
			f9_arg0.Divider:completeAnimation()
			f9_arg0.Divider:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Divider)
			f9_arg0.NumNeeded:completeAnimation()
			f9_arg0.NumNeeded:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.NumNeeded)
		end,
	},
}
CoD.ZMInvChallengeProgress.__onClose = function(f10_arg0)
	f10_arg0.CurrentProgress:close()
	f10_arg0.CurrentProgressTime:close()
	f10_arg0.NumNeeded:close()
end
