CoD.AmmoWidget_CurrentClipPip = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_CurrentClipPip.__defaultWidth = 30
CoD.AmmoWidget_CurrentClipPip.__defaultHeight = 112
CoD.AmmoWidget_CurrentClipPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_CurrentClipPip)
	self.id = "AmmoWidget_CurrentClipPip"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowLeak = LUI.UIImage.new(0, 0, -3.5, 33.5, 0, 0, 14, 122)
	GlowLeak:setRGB(0.76, 0.76, 0.73)
	GlowLeak:setAlpha(0.2)
	GlowLeak:setImage(RegisterImage(@"hash_1DA3FD465AC2534"))
	GlowLeak:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowLeak:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GlowLeak)
	self.GlowLeak = GlowLeak
	local backing = LUI.UIImage.new(0, 0, 0, 28, 0.46, 0.46, -10.5, 45.5)
	backing:setRGB(0.81, 0.79, 0.69)
	backing:setImage(RegisterImage(@"hash_6FCD1D5879D11559"))
	self:addElement(backing)
	self.backing = backing
	local GlowOuter = LUI.UIImage.new(0, 0, 0, 28, 0, 0, 24, 78)
	GlowOuter:setRGB(0.76, 0.76, 0.73)
	GlowOuter:setAlpha(0.2)
	GlowOuter:setImage(RegisterImage(@"hash_1949918ED1F03E4F"))
	GlowOuter:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GlowOuter)
	self.GlowOuter = GlowOuter
	local slots = LUI.UIImage.new(0, 0, 0, 28, 0.46, 0.46, -9.5, 44.5)
	slots:setRGB(0, 0, 0)
	slots:setImage(RegisterImage(@"hash_5F6D4695EB6ADF24"))
	self:addElement(slots)
	self.slots = slots
	local fill = LUI.UIImage.new(0.1, 0.1, -2, 26, 0.5, 0.5, -11.5, 34.5)
	fill:setAlpha(0.85)
	fill:setZRot(180)
	fill:setImage(RegisterImage(0x5768316A400E7D))
	fill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	fill:setShaderVector(0, 1, 0, 0, 0)
	fill:setShaderVector(1, 0, 0, 0, 0)
	fill.__Y_Fraction = function()
		fill:setShaderVector(2, AdjustStartEnd(0.09, 0.84, CoD.HUDUtility.GetCurrentAmmoPipWipeValue(f1_arg1, 0.7, 0, 0, 0)))
	end
	fill.__Y_Fraction()
	fill:setShaderVector(3, 0, 0, 0, 0)
	fill:setShaderVector(4, 1, 0, 1, 0.01)
	self:addElement(fill)
	self.fill = fill
	local f1_local6 = fill
	local f1_local7 = fill.subscribeToModel
	local f1_local8 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.ammoInClip, fill.__Y_Fraction)
	f1_local6 = fill
	f1_local7 = fill.subscribeToModel
	f1_local8 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.clipMaxAmmo, fill.__Y_Fraction)
	self:mergeStateConditions({
		{
			stateName = "LowAmmo",
			condition = function(menu, element, event)
				return IsLowAmmoClip(f1_arg1)
			end,
		},
	})
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.ammoLow, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "ammoLow",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_CurrentClipPip.__resetProperties = function(f5_arg0)
	f5_arg0.fill:completeAnimation()
	f5_arg0.fill:setRGB(1, 1, 1)
	f5_arg0.fill:setAlpha(0.85)
end
CoD.AmmoWidget_CurrentClipPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.fill:completeAnimation()
			f6_arg0.fill:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f6_arg0.clipFinished(f6_arg0.fill)
		end,
	},
	LowAmmo = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(1100)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(399, Enum[@"luitween"][@"luitween_ease_both"])
						f10_arg0:setAlpha(1)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(90)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f7_arg0.fill:beginAnimation(410, Enum[@"luitween"][@"luitween_ease_both"])
				f7_arg0.fill:setAlpha(0.3)
				f7_arg0.fill:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.fill:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.fill:completeAnimation()
			f7_arg0.fill:setRGB(1, 0, 0)
			f7_arg0.fill:setAlpha(1)
			f7_local0(f7_arg0.fill)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.AmmoWidget_CurrentClipPip.__onClose = function(f12_arg0)
	f12_arg0.fill:close()
end
