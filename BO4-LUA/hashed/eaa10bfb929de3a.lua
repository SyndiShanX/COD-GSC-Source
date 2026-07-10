require("x64:470b85501e5f24a")
CoD.ZMPerkSlot = InheritFrom(LUI.UIElement)
CoD.ZMPerkSlot.__defaultWidth = 230
CoD.ZMPerkSlot.__defaultHeight = 450
CoD.ZMPerkSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMPerkSlot)
	self.id = "ZMPerkSlot"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ModifierName = CoD.ZMPerkSlotInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 225, 0, 0, 7, 511)
	ModifierName:mergeStateConditions({
		{
			stateName = "ModifierActive",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "ZMEquippedPerks", "currentSlot", "slotIndex")
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "ZMEquippedPerks", "inEditMenu")
					if f2_local0 then
						f2_local0 = IsSelfInState(self, "Modifier")
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Modifier",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Modifier")
			end,
		},
	})
	local f1_local2 = ModifierName
	local f1_local3 = ModifierName.subscribeToModel
	local f1_local4 = DataSources.ZMEquippedPerks.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.currentSlot, function(f4_arg0)
		f1_arg0:updateElementState(ModifierName, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "currentSlot",
		})
	end, false)
	ModifierName:linkToElementModel(ModifierName, "slotIndex", true, function(model)
		f1_arg0:updateElementState(ModifierName, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "slotIndex",
		})
	end)
	f1_local2 = ModifierName
	f1_local3 = ModifierName.subscribeToModel
	f1_local4 = DataSources.ZMEquippedPerks.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.inEditMenu, function(f6_arg0)
		f1_arg0:updateElementState(ModifierName, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "inEditMenu",
		})
	end, false)
	ModifierName:linkToElementModel(self, nil, false, function(model)
		ModifierName:setModel(model, f1_arg1)
	end)
	self:addElement(ModifierName)
	self.ModifierName = ModifierName
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.ZMPerkUtility.PerkSlotFocused(f1_arg0, element, f1_arg1)
	end)
	ModifierName.id = "ModifierName"
	self.__defaultFocus = ModifierName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMPerkSlot.__resetProperties = function(f9_arg0)
	f9_arg0.ModifierName:completeAnimation()
	f9_arg0.ModifierName:setScale(1, 1)
end
CoD.ZMPerkSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.ModifierName:completeAnimation()
			f11_arg0.ModifierName:setScale(1.02, 1.02)
			f11_arg0.clipFinished(f11_arg0.ModifierName)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.ModifierName:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f12_arg0.ModifierName:setScale(1.02, 1.02)
				f12_arg0.ModifierName:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ModifierName:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ModifierName:completeAnimation()
			f12_arg0.ModifierName:setScale(1, 1)
			f12_local0(f12_arg0.ModifierName)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.ModifierName:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f14_arg0.ModifierName:setScale(1, 1)
				f14_arg0.ModifierName:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ModifierName:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.ModifierName:completeAnimation()
			f14_arg0.ModifierName:setScale(1.02, 1.02)
			f14_local0(f14_arg0.ModifierName)
		end,
		Active = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.ModifierName:completeAnimation()
			f16_arg0.ModifierName:setScale(1.02, 1.02)
			f16_arg0.clipFinished(f16_arg0.ModifierName)
		end,
	},
	Modifier = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.ModifierName:completeAnimation()
			f18_arg0.ModifierName:setScale(1.02, 1.02)
			f18_arg0.clipFinished(f18_arg0.ModifierName)
		end,
		GainChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.ModifierName:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f19_arg0.ModifierName:setScale(1.02, 1.02)
				f19_arg0.ModifierName:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ModifierName:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ModifierName:completeAnimation()
			f19_arg0.ModifierName:setScale(1, 1)
			f19_local0(f19_arg0.ModifierName)
		end,
		LoseChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.ModifierName:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f21_arg0.ModifierName:setScale(1, 1)
				f21_arg0.ModifierName:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ModifierName:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.ModifierName:completeAnimation()
			f21_arg0.ModifierName:setScale(1.02, 1.02)
			f21_local0(f21_arg0.ModifierName)
		end,
		Active = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.ModifierName:completeAnimation()
			f23_arg0.ModifierName:setScale(1.02, 1.02)
			f23_arg0.clipFinished(f23_arg0.ModifierName)
		end,
	},
}
CoD.ZMPerkSlot.__onClose = function(f24_arg0)
	f24_arg0.ModifierName:close()
end
