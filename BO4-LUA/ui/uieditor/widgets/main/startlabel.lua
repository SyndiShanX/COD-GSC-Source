require("x64:2d361ac3553c22a")
CoD.StartLabel = InheritFrom(LUI.UIElement)
CoD.StartLabel.__defaultWidth = 1920
CoD.StartLabel.__defaultHeight = 1080
CoD.StartLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartLabel)
	self.id = "StartLabel"
	self.soundSet = "FrontendMain"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local lblPressToPlay = LUI.UIText.new(0, 0, 113, 871, 1, 1, -74, -46)
	lblPressToPlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	lblPressToPlay:setText(LocalizeToUpperString(@"platform/press_start"))
	lblPressToPlay:setTTF("ttmussels_regular")
	lblPressToPlay:setLetterSpacing(5)
	lblPressToPlay:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	lblPressToPlay:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(lblPressToPlay)
	self.lblPressToPlay = lblPressToPlay
	local Logo = LUI.UIImage.new(0, 0, 32, 96, 1, 1, -87, -23)
	Logo:setImage(RegisterImage(@"hash_4AD5B9D46C446ED8"))
	self:addElement(Logo)
	self.Logo = Logo
	local ActivisionInc = LUI.UIImage.new(1, 1, -291, -51, 1, 1, -74, -38)
	ActivisionInc:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	ActivisionInc:setAlpha(0.9)
	ActivisionInc:setImage(RegisterImage(@"hash_4F52811A5826066C"))
	self:addElement(ActivisionInc)
	self.ActivisionInc = ActivisionInc
	local BuildInfo2 = LUI.UIText.new(1, 1, -412, -51, 1, 1, -41, -27)
	BuildInfo2:setRGB(0.35, 0.35, 0.35)
	BuildInfo2:setTTF("0arame_mono_stencil")
	BuildInfo2:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	BuildInfo2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	BuildInfo2:linkToElementModel(self, "buildInfo", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BuildInfo2:setText(f2_local0)
		end
	end)
	self:addElement(BuildInfo2)
	self.BuildInfo2 = BuildInfo2
	local TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 0, 30, 98, 0, 0, 990, 1058)
	TrialWidget:setAlpha(0)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	self:mergeStateConditions({
		{
			stateName = "OnlineTrial",
			condition = function(menu, element, event)
				return IsGameTrial()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	SetModelToGlobalDataSource(f1_arg1, self, "GlobalModel")
	return self
end
CoD.StartLabel.__resetProperties = function(f4_arg0)
	f4_arg0.Logo:completeAnimation()
	f4_arg0.TrialWidget:completeAnimation()
	f4_arg0.Logo:setAlpha(1)
	f4_arg0.TrialWidget:setAlpha(0)
end
CoD.StartLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	OnlineTrial = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Logo:completeAnimation()
			f6_arg0.Logo:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Logo)
			f6_arg0.TrialWidget:completeAnimation()
			f6_arg0.TrialWidget:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.TrialWidget)
		end,
	},
}
CoD.StartLabel.__onClose = function(f7_arg0)
	f7_arg0.BuildInfo2:close()
	f7_arg0.TrialWidget:close()
end
