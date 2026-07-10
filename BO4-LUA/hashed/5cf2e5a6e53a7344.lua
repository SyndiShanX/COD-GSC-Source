require("x64:2d361ac3553c22a")
CoD.TrialInfoBannerWidget = InheritFrom(LUI.UIElement)
CoD.TrialInfoBannerWidget.__defaultWidth = 300
CoD.TrialInfoBannerWidget.__defaultHeight = 35
CoD.TrialInfoBannerWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TrialInfoBannerWidget)
	self.id = "TrialInfoBannerWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local InfoText = LUI.UIText.new(0, 0, 35, 535, 0, 0, 8, 28)
	InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_262486486346EC3F"))
	InfoText:setTTF("dinnext_regular")
	InfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	InfoText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(InfoText)
	self.InfoText = InfoText
	local TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 0, 5, 30, 0.5, 0.5, -12.5, 12.5)
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	self:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial()
			end,
		},
		{
			stateName = "ShownLarge",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysFalse()
			end,
		},
		{
			stateName = "ShownWrap",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysFalse()
			end,
		},
		{
			stateName = "ShownLargeWrap",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TrialInfoBannerWidget.__resetProperties = function(f7_arg0)
	f7_arg0.InfoText:completeAnimation()
	f7_arg0.TrialWidget:completeAnimation()
	f7_arg0.Backing:completeAnimation()
	f7_arg0.InfoText:setLeftRight(0, 0, 35, 535)
	f7_arg0.InfoText:setAlpha(1)
	f7_arg0.InfoText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	f7_arg0.TrialWidget:setAlpha(1)
	f7_arg0.Backing:setAlpha(0)
end
CoD.TrialInfoBannerWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.Backing:completeAnimation()
			f8_arg0.Backing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Backing)
			f8_arg0.InfoText:completeAnimation()
			f8_arg0.InfoText:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.InfoText)
			f8_arg0.TrialWidget:completeAnimation()
			f8_arg0.TrialWidget:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TrialWidget)
		end,
	},
	Shown = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	ShownLarge = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.InfoText:completeAnimation()
			f10_arg0.InfoText:setLeftRight(0, 0, 35, 807)
			f10_arg0.clipFinished(f10_arg0.InfoText)
		end,
	},
	ShownWrap = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.InfoText:completeAnimation()
			f11_arg0.InfoText:setLeftRight(0, 0, 35, 547)
			f11_arg0.InfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
			f11_arg0.clipFinished(f11_arg0.InfoText)
		end,
	},
	ShownLargeWrap = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.InfoText:completeAnimation()
			f12_arg0.InfoText:setLeftRight(0, 0, 35, 807)
			f12_arg0.InfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
			f12_arg0.clipFinished(f12_arg0.InfoText)
		end,
	},
}
CoD.TrialInfoBannerWidget.__onClose = function(f13_arg0)
	f13_arg0.TrialWidget:close()
end
