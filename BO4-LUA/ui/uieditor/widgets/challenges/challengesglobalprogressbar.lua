require("x64:19c1945d2e472b0")
CoD.ChallengesGlobalProgressBar = InheritFrom(LUI.UIElement)
CoD.ChallengesGlobalProgressBar.__defaultWidth = 495
CoD.ChallengesGlobalProgressBar.__defaultHeight = 24
CoD.ChallengesGlobalProgressBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengesGlobalProgressBar)
	self.id = "ChallengesGlobalProgressBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBarBase = LUI.UIImage.new(0.5, 0.5, -247.5, 247.5, 0, 0, 0.5, 23.5)
	ProgressBarBase:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	ProgressBarBase:setAlpha(0.02)
	self:addElement(ProgressBarBase)
	self.ProgressBarBase = ProgressBarBase
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DotTiledBacking:setAlpha(0.15)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local ProgressBar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBar:setRGB(1, 0.36, 0)
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	ProgressBar:linkToElementModel(self, "percent", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ProgressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local ProgressFraction = LUI.UIText.new(1, 1, -43, -4, 0, 0, 4.5, 22.5)
	ProgressFraction:setTTF("default")
	ProgressFraction:setLetterSpacing(2)
	ProgressFraction:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	ProgressFraction:linkToElementModel(self, "statFractionText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressFraction:setText(f3_local0)
		end
	end)
	self:addElement(ProgressFraction)
	self.ProgressFraction = ProgressFraction
	self:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "percent", 1)
			end,
		},
	})
	self:linkToElementModel(self, "percent", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "percent",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesGlobalProgressBar.__resetProperties = function(f6_arg0)
	f6_arg0.ProgressBar:completeAnimation()
	f6_arg0.ProgressBar:setRGB(1, 0.36, 0)
end
CoD.ChallengesGlobalProgressBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Complete = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.ProgressBar:completeAnimation()
			f8_arg0.ProgressBar:setRGB(0, 0.38, 0.02)
			f8_arg0.clipFinished(f8_arg0.ProgressBar)
		end,
	},
}
CoD.ChallengesGlobalProgressBar.__onClose = function(f9_arg0)
	f9_arg0.DotTiledBacking:close()
	f9_arg0.ProgressBar:close()
	f9_arg0.ProgressFraction:close()
end
