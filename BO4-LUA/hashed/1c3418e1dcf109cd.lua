require("x64:c7e896ee4bc3f8")
CoD.BlackMarketTrialInfoBannerWidget = InheritFrom(LUI.UIElement)
CoD.BlackMarketTrialInfoBannerWidget.__defaultWidth = 547
CoD.BlackMarketTrialInfoBannerWidget.__defaultHeight = 35
CoD.BlackMarketTrialInfoBannerWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BlackMarketTrialInfoBannerWidget)
	self.id = "BlackMarketTrialInfoBannerWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TrialWidget = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 547, 0, 0, 0, 35)
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysFalse()
			end,
		},
		{
			stateName = "ShownWrap",
			condition = function(menu, element, event)
				return IsGameTrial()
			end,
		},
	})
	TrialWidget:linkToElementModel(self, nil, false, function(model)
		TrialWidget:setModel(model, f1_arg1)
	end)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	self:mergeStateConditions({
		{
			stateName = "Unlocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
			end,
		},
	})
	self:linkToElementModel(self, "unlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlocked",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BlackMarketTrialInfoBannerWidget.__resetProperties = function(f7_arg0)
	f7_arg0.TrialWidget:completeAnimation()
	f7_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0x62486486346EC3F))
end
CoD.BlackMarketTrialInfoBannerWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.TrialWidget:completeAnimation()
			f8_arg0.TrialWidget.InfoText:completeAnimation()
			f8_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0x8C8E3A75045BE50))
			f8_arg0.clipFinished(f8_arg0.TrialWidget)
		end,
	},
	Unlocked = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.BlackMarketTrialInfoBannerWidget.__onClose = function(f10_arg0)
	f10_arg0.TrialWidget:close()
end
