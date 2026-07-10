CoD.AmmoWidget_OverheatMeter = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_OverheatMeter.__defaultWidth = 143
CoD.AmmoWidget_OverheatMeter.__defaultHeight = 112
CoD.AmmoWidget_OverheatMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_OverheatMeter)
	self.id = "AmmoWidget_OverheatMeter"
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
	Fill:setImage(RegisterImage(@"uie_ui_hud_core_overheat_meter"))
	Fill:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_75EBE8D6E802F0F5"))
	Fill:setShaderVector(1, 0, 0, 0, 0)
	Fill:setShaderVector(2, 1, 0, 0, 0)
	Fill:setShaderVector(3, 0, 0, 0, 0)
	Fill:setShaderVector(4, 0, 0, 0, 0)
	Fill:linkToElementModel(self, "weaponOverheatPercent", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Fill:setShaderVector(0, ScaleVector(0.01, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	self:addElement(Fill)
	self.Fill = Fill
	local OverheatingPulse = LUI.UIText.new(0, 0, 17, 102, 0, 0, 48.5, 63.5)
	OverheatingPulse:setRGB(0.27, 0.01, 0.01)
	OverheatingPulse:setText(LocalizeToUpperString(@"weapon/overheated"))
	OverheatingPulse:setTTF("0arame_mono_stencil")
	OverheatingPulse:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OverheatingPulse:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(OverheatingPulse)
	self.OverheatingPulse = OverheatingPulse
	local Overheating = LUI.UIText.new(0, 0, 17, 102, 0, 0, 48.5, 63.5)
	Overheating:setRGB(0.67, 0.11, 0.11)
	Overheating:setText(LocalizeToUpperString(@"weapon/overheated"))
	Overheating:setTTF("0arame_mono_stencil")
	Overheating:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Overheating:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Overheating)
	self.Overheating = Overheating
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
			stateName = "Overheating",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "weaponOverheating") and not CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
		{
			stateName = "OverheatingAsianLang",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "weaponOverheating") and CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	self:linkToElementModel(self, "weaponOverheating", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponOverheating",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_OverheatMeter.__resetProperties = function(f6_arg0)
	f6_arg0.Overheating:completeAnimation()
	f6_arg0.Backing:completeAnimation()
	f6_arg0.OverheatingPulse:completeAnimation()
	f6_arg0.Overheating:setTopBottom(0, 0, 48.5, 63.5)
	f6_arg0.Overheating:setAlpha(1)
	f6_arg0.Backing:setAlpha(1)
	f6_arg0.Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	f6_arg0.OverheatingPulse:setTopBottom(0, 0, 48.5, 63.5)
	f6_arg0.OverheatingPulse:setAlpha(1)
end
CoD.AmmoWidget_OverheatMeter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.Backing:completeAnimation()
			f7_arg0.Backing:setAlpha(1)
			f7_arg0.Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f7_arg0.clipFinished(f7_arg0.Backing)
			f7_arg0.OverheatingPulse:completeAnimation()
			f7_arg0.OverheatingPulse:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.OverheatingPulse)
			f7_arg0.Overheating:completeAnimation()
			f7_arg0.Overheating:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Overheating)
		end,
	},
	Overheating = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Backing:completeAnimation()
			f8_arg0.Backing:setAlpha(1)
			f8_arg0.Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f8_arg0.clipFinished(f8_arg0.Backing)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(500)
					f10_arg0:setAlpha(0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.OverheatingPulse:beginAnimation(500)
				f8_arg0.OverheatingPulse:setAlpha(1)
				f8_arg0.OverheatingPulse:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.OverheatingPulse:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.OverheatingPulse:completeAnimation()
			f8_arg0.OverheatingPulse:setAlpha(0)
			f8_local0(f8_arg0.OverheatingPulse)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
	OverheatingAsianLang = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setAlpha(1)
			f11_arg0.Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f11_arg0.clipFinished(f11_arg0.Backing)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(500)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.OverheatingPulse:beginAnimation(500)
				f11_arg0.OverheatingPulse:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.OverheatingPulse:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.OverheatingPulse:completeAnimation()
			f11_arg0.OverheatingPulse:setTopBottom(0, 0, 52.5, 63.5)
			f11_arg0.OverheatingPulse:setAlpha(0)
			f11_local0(f11_arg0.OverheatingPulse)
			f11_arg0.Overheating:completeAnimation()
			f11_arg0.Overheating:setTopBottom(0, 0, 52.5, 63.5)
			f11_arg0.clipFinished(f11_arg0.Overheating)
			f11_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.AmmoWidget_OverheatMeter.__onClose = function(f14_arg0)
	f14_arg0.Fill:close()
end
