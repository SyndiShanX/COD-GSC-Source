CoD.AmmoWidgetVehicleReloadMeter = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetVehicleReloadMeter.__defaultWidth = 143
CoD.AmmoWidgetVehicleReloadMeter.__defaultHeight = 112
CoD.AmmoWidgetVehicleReloadMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetVehicleReloadMeter)
	self.id = "AmmoWidgetVehicleReloadMeter"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0.12, 1, -2, -2, 0.37, 0.6, 1, 1)
	Backing:setImage(RegisterImage(@"uie_ui_hud_core_overheat_backplate"))
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	Backing:setShaderVector(0, 0, 0.05, 0, 0.05)
	self:addElement(Backing)
	self.Backing = Backing
	local BGDotPatternLarge = LUI.UIImage.new(0.1, 0.88, 5, 5, 0.42, 0.55, 1, 1)
	BGDotPatternLarge:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BGDotPatternLarge:setAlpha(0.05)
	BGDotPatternLarge:setImage(RegisterImage(@"hash_7FC21A8215EA012B"))
	BGDotPatternLarge:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BGDotPatternLarge:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternLarge)
	self.BGDotPatternLarge = BGDotPatternLarge
	local Fill = LUI.UIImage.new(0.11, 1.01, -2, -2, 0.31, 0.6, 4, 4)
	Fill:setRGB(0.07, 1, 0)
	Fill:setImage(RegisterImage(@"uie_ui_hud_core_overheat_meter"))
	Fill:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_75EBE8D6E802F0F5"))
	Fill:setShaderVector(1, 0, 0, 0, 0)
	Fill:setShaderVector(2, 1, 0, 0, 0)
	Fill:setShaderVector(3, 0, 0, 0, 0)
	Fill:setShaderVector(4, 0, 0, 0, 0)
	Fill:subscribeToGlobalModel(f1_arg1, "PerController", "vehicle.ammoReady", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Fill:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(Fill)
	self.Fill = Fill
	local ReloadingText = LUI.UIText.new(0, 0, 23, 134, 0, 0, 48, 63)
	ReloadingText:setRGB(0.61, 0.61, 0.61)
	ReloadingText:setAlpha(0)
	ReloadingText:setText(LocalizeToUpperString(@"hash_73C4EEC8614F780F"))
	ReloadingText:setTTF("0arame_mono_stencil")
	ReloadingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ReloadingText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(ReloadingText)
	self.ReloadingText = ReloadingText
	local CornerDot1 = LUI.UIImage.new(0, 0, 12, 13, 0, 0, 44, 45)
	CornerDot1:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CornerDot1:setAlpha(0.3)
	self:addElement(CornerDot1)
	self.CornerDot1 = CornerDot1
	local CornerDot2 = LUI.UIImage.new(0, 0, 12, 13, 0, 0, 65, 66)
	CornerDot2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CornerDot2:setAlpha(0.3)
	self:addElement(CornerDot2)
	self.CornerDot2 = CornerDot2
	local CornerDot3 = LUI.UIImage.new(0, 0, 108, 109, 0, 0, 44, 45)
	CornerDot3:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CornerDot3:setAlpha(0.3)
	self:addElement(CornerDot3)
	self.CornerDot3 = CornerDot3
	local CornerDot4 = LUI.UIImage.new(0, 0, 108, 109, 0, 0, 65, 66)
	CornerDot4:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CornerDot4:setAlpha(0.3)
	self:addElement(CornerDot4)
	self.CornerDot4 = CornerDot4
	self:mergeStateConditions({
		{
			stateName = "ReloadingAsianLang",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian() and CoD.ModelUtility.IsModelValueLessThan(f1_arg1, "vehicle.ammoReady", 1)
			end,
		},
		{
			stateName = "Reloading",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueLessThan(f1_arg1, "vehicle.ammoReady", 1)
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["vehicle.ammoReady"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "vehicle.ammoReady",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetVehicleReloadMeter.__resetProperties = function(f6_arg0)
	f6_arg0.ReloadingText:completeAnimation()
	f6_arg0.Backing:completeAnimation()
	f6_arg0.Fill:completeAnimation()
	f6_arg0.CornerDot1:completeAnimation()
	f6_arg0.CornerDot4:completeAnimation()
	f6_arg0.CornerDot3:completeAnimation()
	f6_arg0.CornerDot2:completeAnimation()
	f6_arg0.ReloadingText:setTopBottom(0, 0, 48, 63)
	f6_arg0.ReloadingText:setAlpha(0)
	f6_arg0.Backing:setAlpha(1)
	f6_arg0.Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	f6_arg0.Fill:setAlpha(1)
	f6_arg0.CornerDot1:setAlpha(0.3)
	f6_arg0.CornerDot4:setAlpha(0.3)
	f6_arg0.CornerDot3:setAlpha(0.3)
	f6_arg0.CornerDot2:setAlpha(0.3)
end
CoD.AmmoWidgetVehicleReloadMeter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(7)
			f7_arg0.Backing:completeAnimation()
			f7_arg0.Backing:setAlpha(0)
			f7_arg0.Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f7_arg0.clipFinished(f7_arg0.Backing)
			f7_arg0.Fill:completeAnimation()
			f7_arg0.Fill:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Fill)
			f7_arg0.ReloadingText:completeAnimation()
			f7_arg0.ReloadingText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ReloadingText)
			f7_arg0.CornerDot1:completeAnimation()
			f7_arg0.CornerDot1:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CornerDot1)
			f7_arg0.CornerDot2:completeAnimation()
			f7_arg0.CornerDot2:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CornerDot2)
			f7_arg0.CornerDot3:completeAnimation()
			f7_arg0.CornerDot3:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CornerDot3)
			f7_arg0.CornerDot4:completeAnimation()
			f7_arg0.CornerDot4:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CornerDot4)
		end,
	},
	ReloadingAsianLang = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Backing:completeAnimation()
			f8_arg0.Backing:setAlpha(1)
			f8_arg0.Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f8_arg0.clipFinished(f8_arg0.Backing)
			f8_arg0.ReloadingText:completeAnimation()
			f8_arg0.ReloadingText:setTopBottom(0, 0, 52.5, 63.5)
			f8_arg0.ReloadingText:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.ReloadingText)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
	Reloading = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ReloadingText:completeAnimation()
			f9_arg0.ReloadingText:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.ReloadingText)
		end,
	},
}
CoD.AmmoWidgetVehicleReloadMeter.__onClose = function(f10_arg0)
	f10_arg0.Fill:close()
end
