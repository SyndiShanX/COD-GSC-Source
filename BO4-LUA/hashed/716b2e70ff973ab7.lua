require("x64:325eec9c0fe7758")
require("x64:caea96c5773ca4d")
CoD.WarzoneQuickInventoryMenuItemSmall = InheritFrom(LUI.UIElement)
CoD.WarzoneQuickInventoryMenuItemSmall.__defaultWidth = 70
CoD.WarzoneQuickInventoryMenuItemSmall.__defaultHeight = 70
CoD.WarzoneQuickInventoryMenuItemSmall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneQuickInventoryMenuItemSmall)
	self.id = "WarzoneQuickInventoryMenuItemSmall"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ActiveBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ActiveBG:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	ActiveBG:setAlpha(0)
	ActiveBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ActiveBG)
	self.ActiveBG = ActiveBG
	local internal = CoD.WarzoneQuickInventoryMenuItemSmall_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -46, 46, 0.5, 0.5, -45, 45)
	internal:setScale(0.9, 0.9)
	internal:linkToElementModel(self, nil, false, function(model)
		internal:setModel(model, f1_arg1)
	end)
	self:addElement(internal)
	self.internal = internal
	local ConsumedProgress = LUI.UIImage.new(0.5, 0.5, -48, 44, 0.5, 0.5, -45, 45)
	ConsumedProgress:setRGB(0, 0, 0)
	ConsumedProgress:setAlpha(0.8)
	ConsumedProgress:setScale(0.66, 0.66)
	ConsumedProgress:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	ConsumedProgress:setShaderVector(1, 0.5, 0, 0, 0)
	ConsumedProgress:setShaderVector(2, 0.5, 0, 0, 0)
	ConsumedProgress:setShaderVector(3, 0, 0, 0, 0)
	ConsumedProgress:setShaderVector(4, 0, 0, 0, 0)
	ConsumedProgress:linkToElementModel(self, "endStartFraction", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ConsumedProgress:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(ConsumedProgress)
	self.ConsumedProgress = ConsumedProgress
	local castTimer = nil
	castTimer = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -16, 16)
	castTimer:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	castTimer:setImage(RegisterImage(0xC2785B5FC0B6F18))
	castTimer:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	castTimer:setShaderVector(1, 0.5, 0, 0, 0)
	castTimer:setShaderVector(2, 0.5, 0, 0, 0)
	castTimer:setShaderVector(3, 0, 0, 0, 0)
	castTimer:setShaderVector(4, 0, 0, 0, 0)
	castTimer:linkToElementModel(self, "castTimeFraction", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			castTimer:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(castTimer)
	self.castTimer = castTimer
	local NotAvailable = LUI.UIImage.new(0, 0, 2, 90, 0, 0, 1, 89)
	NotAvailable:setAlpha(0)
	NotAvailable:setImage(RegisterImage(0xB1FCC7EA3552F5A))
	NotAvailable:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(NotAvailable)
	self.NotAvailable = NotAvailable
	local EMP = CoD.Warzone_EMP_QuickEquip.new(f1_arg0, f1_arg1, 0, 0, -13, 75, 0, 0, -6.5, 77.5)
	self:addElement(EMP)
	self.EMP = EMP
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				local f5_local0 = IsPC()
				if f5_local0 then
					f5_local0 = AlwaysFalse()
					if f5_local0 then
						f5_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "endStartFraction", 0)
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "disabled", 1)
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "notAvailable", 1)
			end,
		},
	})
	self:linkToElementModel(self, "endStartFraction", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "endStartFraction",
		})
	end)
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	self:linkToElementModel(self, "notAvailable", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "notAvailable",
		})
	end)
	internal.id = "internal"
	self.__defaultFocus = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneQuickInventoryMenuItemSmall.__resetProperties = function(f11_arg0)
	f11_arg0.internal:completeAnimation()
	f11_arg0.ConsumedProgress:completeAnimation()
	f11_arg0.castTimer:completeAnimation()
	f11_arg0.NotAvailable:completeAnimation()
	f11_arg0.internal:setRGB(1, 1, 1)
	f11_arg0.internal:setAlpha(1)
	f11_arg0.internal:setScale(0.9, 0.9)
	f11_arg0.ConsumedProgress:setAlpha(0.8)
	f11_arg0.castTimer:setAlpha(1)
	f11_arg0.NotAvailable:setAlpha(0)
end
CoD.WarzoneQuickInventoryMenuItemSmall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.internal:completeAnimation()
			f13_arg0.internal:setScale(1.08, 1.08)
			f13_arg0.clipFinished(f13_arg0.internal)
		end,
		GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.internal:beginAnimation(140)
				f14_arg0.internal:setScale(1.08, 1.08)
				f14_arg0.internal:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.internal:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.internal:completeAnimation()
			f14_arg0.internal:setScale(1, 1)
			f14_local0(f14_arg0.internal)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.internal:beginAnimation(140)
				f16_arg0.internal:setScale(1, 1)
				f16_arg0.internal:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.internal:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.internal:completeAnimation()
			f16_arg0.internal:setScale(1.08, 1.08)
			f16_local0(f16_arg0.internal)
		end,
	},
	Invisible = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.internal:completeAnimation()
			f18_arg0.internal:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.internal)
			f18_arg0.ConsumedProgress:completeAnimation()
			f18_arg0.ConsumedProgress:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ConsumedProgress)
			f18_arg0.castTimer:completeAnimation()
			f18_arg0.castTimer:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.castTimer)
		end,
	},
	Disabled = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.internal:completeAnimation()
			f19_arg0.internal:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.internal)
			f19_arg0.ConsumedProgress:completeAnimation()
			f19_arg0.ConsumedProgress:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ConsumedProgress)
			f19_arg0.castTimer:completeAnimation()
			f19_arg0.castTimer:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.castTimer)
		end,
	},
	NotAvailable = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.NotAvailable:completeAnimation()
			f20_arg0.NotAvailable:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.NotAvailable)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.internal:completeAnimation()
			f21_arg0.internal:setRGB(1, 1, 1)
			f21_arg0.internal:setScale(1.14, 1.14)
			f21_arg0.clipFinished(f21_arg0.internal)
			f21_arg0.NotAvailable:completeAnimation()
			f21_arg0.NotAvailable:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.NotAvailable)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				f22_arg0.internal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f22_arg0.internal:setScale(1.14, 1.14)
				f22_arg0.internal:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.internal:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.internal:completeAnimation()
			f22_arg0.internal:setScale(1, 1)
			f22_local0(f22_arg0.internal)
			f22_arg0.NotAvailable:completeAnimation()
			f22_arg0.NotAvailable:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.NotAvailable)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.internal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f24_arg0.internal:setScale(1, 1)
				f24_arg0.internal:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.internal:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.internal:completeAnimation()
			f24_arg0.internal:setScale(1.14, 1.14)
			f24_local0(f24_arg0.internal)
			f24_arg0.NotAvailable:completeAnimation()
			f24_arg0.NotAvailable:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.NotAvailable)
		end,
	},
}
CoD.WarzoneQuickInventoryMenuItemSmall.__onClose = function(f26_arg0)
	f26_arg0.internal:close()
	f26_arg0.ConsumedProgress:close()
	f26_arg0.castTimer:close()
	f26_arg0.EMP:close()
end
