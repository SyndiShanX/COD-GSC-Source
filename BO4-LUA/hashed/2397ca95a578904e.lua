require("x64:695c77ccd5cb3a6")
CoD.MainMenuTrialPrompt = InheritFrom(LUI.UIElement)
CoD.MainMenuTrialPrompt.__defaultWidth = 400
CoD.MainMenuTrialPrompt.__defaultHeight = 64
CoD.MainMenuTrialPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MainMenuTrialPrompt)
	self.id = "MainMenuTrialPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TrialPrompt = LUI.UIText.new(0.5, 0.5, -325, 325, 0, 0, 74, 94)
	TrialPrompt:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TrialPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4635AFBDBC9B13C5"))
	TrialPrompt:setTTF("dinnext_regular")
	TrialPrompt:setLetterSpacing(1)
	TrialPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TrialPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TrialPrompt)
	self.TrialPrompt = TrialPrompt
	local TrialVersionCountdownWidget = CoD.TrialVersionCountdownWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -156, 156, 0, 0, 0, 64)
	self:addElement(TrialVersionCountdownWidget)
	self.TrialVersionCountdownWidget = TrialVersionCountdownWidget
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian() and IsPC()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MainMenuTrialPrompt.__resetProperties = function(f3_arg0)
	f3_arg0.TrialPrompt:completeAnimation()
	f3_arg0.TrialPrompt:setTopBottom(0, 0, 74, 94)
end
CoD.MainMenuTrialPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.TrialPrompt:completeAnimation()
			f5_arg0.TrialPrompt:setTopBottom(0, 0, 69, 85)
			f5_arg0.clipFinished(f5_arg0.TrialPrompt)
		end,
	},
}
CoD.MainMenuTrialPrompt.__onClose = function(f6_arg0)
	f6_arg0.TrialVersionCountdownWidget:close()
end
