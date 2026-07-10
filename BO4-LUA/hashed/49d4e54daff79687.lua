require("x64:a43ce2da2f8157d")
require("x64:5bf4b6f49c15a4c")
CoD.WarzoneInventoryMenuItem = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryMenuItem.__defaultWidth = 92
CoD.WarzoneInventoryMenuItem.__defaultHeight = 90
CoD.WarzoneInventoryMenuItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryMenuItem)
	self.id = "WarzoneInventoryMenuItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Button = CoD.WarzoneInventoryMenuItem_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -46, 46, 0, 0, 0, 90)
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	self:addElement(Button)
	self.Button = Button
	local NotAvailable = LUI.UIImage.new(0.5, 0.5, -44, 44, 0.5, 0.5, -44, 44)
	NotAvailable:setAlpha(0)
	NotAvailable:setImage(RegisterImage(0xB1FCC7EA3552F5A))
	NotAvailable:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(NotAvailable)
	self.NotAvailable = NotAvailable
	local PickupPulse = CoD.WarzoneInventoryPickupPulse.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	self:addElement(PickupPulse)
	self.PickupPulse = PickupPulse
	self:mergeStateConditions({
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
		{
			stateName = "FocusTarget",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "focusTarget", 1)
			end,
		},
	})
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
	self:linkToElementModel(self, "focusTarget", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "focusTarget",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if CoD.BaseUtility.IsSelfInState(self, "FocusTarget") and IsPC() then
			SetElementState(self, self.PickupPulse, controller, "PickUpPC")
		elseif CoD.BaseUtility.IsSelfInState(self, "FocusTarget") then
			SetElementState(self, self.PickupPulse, controller, "PickUp")
		else
			SetElementState(self, self.PickupPulse, controller, "DefaultState")
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "WarzoneInventory", "currentWeaponIndex", function(model)
		local f10_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	Button.id = "Button"
	self.__defaultFocus = Button
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryMenuItem.__resetProperties = function(f11_arg0)
	f11_arg0.Button:completeAnimation()
	f11_arg0.NotAvailable:completeAnimation()
	f11_arg0.Button:setAlpha(1)
	f11_arg0.Button:setScale(1, 1)
	f11_arg0.NotAvailable:setAlpha(0)
end
CoD.WarzoneInventoryMenuItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Button:completeAnimation()
			f12_arg0.Button:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Button)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Button:completeAnimation()
			f13_arg0.Button:setScale(1.14, 1.14)
			f13_arg0.clipFinished(f13_arg0.Button)
		end,
		GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.Button:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f14_arg0.Button:setScale(1.14, 1.14)
				f14_arg0.Button:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Button:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Button:completeAnimation()
			f14_arg0.Button:setScale(1, 1)
			f14_local0(f14_arg0.Button)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Button:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f16_arg0.Button:setScale(1, 1)
				f16_arg0.Button:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Button:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Button:completeAnimation()
			f16_arg0.Button:setScale(1.14, 1.14)
			f16_local0(f16_arg0.Button)
		end,
	},
	Disabled = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.Button:completeAnimation()
			f18_arg0.Button:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Button)
		end,
	},
	NotAvailable = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.Button:completeAnimation()
			f19_arg0.Button:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.Button)
			f19_arg0.NotAvailable:completeAnimation()
			f19_arg0.NotAvailable:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.NotAvailable)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.Button:completeAnimation()
			f20_arg0.Button:setScale(1.14, 1.14)
			f20_arg0.clipFinished(f20_arg0.Button)
			f20_arg0.NotAvailable:completeAnimation()
			f20_arg0.NotAvailable:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.NotAvailable)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				f21_arg0.Button:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f21_arg0.Button:setScale(1.14, 1.14)
				f21_arg0.Button:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Button:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.Button:completeAnimation()
			f21_arg0.Button:setScale(1, 1)
			f21_local0(f21_arg0.Button)
			f21_arg0.NotAvailable:completeAnimation()
			f21_arg0.NotAvailable:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.NotAvailable)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			local f23_local0 = function(f24_arg0)
				f23_arg0.Button:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f23_arg0.Button:setScale(1, 1)
				f23_arg0.Button:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.Button:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.Button:completeAnimation()
			f23_arg0.Button:setScale(1.14, 1.14)
			f23_local0(f23_arg0.Button)
			f23_arg0.NotAvailable:completeAnimation()
			f23_arg0.NotAvailable:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.NotAvailable)
		end,
	},
	FocusTarget = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.Button:completeAnimation()
			f25_arg0.Button:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.Button)
		end,
		ChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.Button:completeAnimation()
			f26_arg0.Button:setScale(1.14, 1.14)
			f26_arg0.clipFinished(f26_arg0.Button)
		end,
		GainChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			local f27_local0 = function(f28_arg0)
				f27_arg0.Button:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f27_arg0.Button:setScale(1.14, 1.14)
				f27_arg0.Button:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.Button:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.Button:completeAnimation()
			f27_arg0.Button:setScale(1, 1)
			f27_local0(f27_arg0.Button)
		end,
		LoseChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.Button:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f29_arg0.Button:setScale(1, 1)
				f29_arg0.Button:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.Button:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.Button:completeAnimation()
			f29_arg0.Button:setScale(1.14, 1.14)
			f29_local0(f29_arg0.Button)
		end,
	},
}
CoD.WarzoneInventoryMenuItem.__onClose = function(f31_arg0)
	f31_arg0.Button:close()
	f31_arg0.PickupPulse:close()
end
