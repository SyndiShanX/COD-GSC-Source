require("x64:4ceb8e53c9b511d")
CoD.ZMPerkOption = InheritFrom(LUI.UIElement)
CoD.ZMPerkOption.__defaultWidth = 132
CoD.ZMPerkOption.__defaultHeight = 128
CoD.ZMPerkOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMPerkOption)
	self.id = "ZMPerkOption"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ZMPerk = CoD.ZMElixirSlotInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, -80, 80)
	ZMPerk:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ZMPerkUtility.IsPerkLocked(element, f1_arg1, menu)
			end,
		},
		{
			stateName = "NoConsumablesRemainingEquipped",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NoConsumablesRemaining",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMPerkUtility.IsPerkEquipped(self, f1_arg1, menu)
			end,
		},
	})
	local f1_local2 = ZMPerk
	local f1_local3 = ZMPerk.subscribeToModel
	local f1_local4 = DataSources.ZMEquippedPerks.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.updateEquipped, function(f6_arg0)
		f1_arg0:updateElementState(ZMPerk, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "updateEquipped",
		})
	end, false)
	ZMPerk:linkToElementModel(ZMPerk, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(ZMPerk, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	ZMPerk:setScale(0.9, 0.9)
	ZMPerk:linkToElementModel(self, nil, false, function(model)
		ZMPerk:setModel(model, f1_arg1)
	end)
	self:addElement(ZMPerk)
	self.ZMPerk = ZMPerk
	ZMPerk.id = "ZMPerk"
	self.__defaultFocus = ZMPerk
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMPerkOption.__resetProperties = function(f9_arg0)
	f9_arg0.ZMPerk:completeAnimation()
	f9_arg0.ZMPerk:setScale(0.9, 0.9)
end
CoD.ZMPerkOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.ZMPerk:completeAnimation()
			f11_arg0.ZMPerk:setScale(0.93, 0.93)
			f11_arg0.clipFinished(f11_arg0.ZMPerk)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.ZMPerk:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f12_arg0.ZMPerk:setScale(0.93, 0.93)
				f12_arg0.ZMPerk:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ZMPerk:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ZMPerk:completeAnimation()
			f12_arg0.ZMPerk:setScale(0.9, 0.9)
			f12_local0(f12_arg0.ZMPerk)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.ZMPerk:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f14_arg0.ZMPerk:setScale(0.9, 0.9)
				f14_arg0.ZMPerk:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ZMPerk:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.ZMPerk:completeAnimation()
			f14_arg0.ZMPerk:setScale(0.93, 0.93)
			f14_local0(f14_arg0.ZMPerk)
		end,
	},
}
CoD.ZMPerkOption.__onClose = function(f16_arg0)
	f16_arg0.ZMPerk:close()
end
