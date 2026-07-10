require("x64:e8514dee0f6b117")
CoD.SupportSelectionOption = InheritFrom(LUI.UIElement)
CoD.SupportSelectionOption.__defaultWidth = 278
CoD.SupportSelectionOption.__defaultHeight = 109
CoD.SupportSelectionOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupportSelectionOption)
	self.id = "SupportSelectionOption"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponSelectGridItemInternal = CoD.SupportSelectionOptionInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 284, 0, 0, 0, 118)
	WeaponSelectGridItemInternal:linkToElementModel(self, nil, false, function(model)
		WeaponSelectGridItemInternal:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponSelectGridItemInternal)
	self.WeaponSelectGridItemInternal = WeaponSelectGridItemInternal
	self:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ScorestreakSelectUtility.IsScorestreakEquipped(element, menu, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["ScorestreakSelect.UpdateEquipped"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "ScorestreakSelect.UpdateEquipped",
		})
	end, false)
	self:AddContextualMenuAction(f1_arg0, f1_arg1, 0x679ACA6FFC6C8F3, function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		if CoD.ScorestreakSelectUtility.IsScorestreakEquipped(f6_arg0, f6_arg1, f6_arg2) and not CoD.ScorestreakSelectUtility.IsScorestreakLocked(f6_arg0, f6_arg1, f6_arg2) then
			return function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
				CoD.ScorestreakSelectUtility.RemoveScorestreakOption(self, f7_arg1, f7_arg2)
				PlaySoundAlias("cac_equipment_remove")
			end
		else
		end
	end)
	WeaponSelectGridItemInternal.id = "WeaponSelectGridItemInternal"
	self.__defaultFocus = WeaponSelectGridItemInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local3, f1_arg1, "name", "", "")
	end
	return self
end
CoD.SupportSelectionOption.__resetProperties = function(f8_arg0)
	f8_arg0.WeaponSelectGridItemInternal:completeAnimation()
	f8_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
end
CoD.SupportSelectionOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f10_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.WeaponSelectGridItemInternal)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.WeaponSelectGridItemInternal:beginAnimation(150)
				f11_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
				f11_arg0.WeaponSelectGridItemInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.WeaponSelectGridItemInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f11_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
			f11_local0(f11_arg0.WeaponSelectGridItemInternal)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.WeaponSelectGridItemInternal:beginAnimation(150)
				f13_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
				f13_arg0.WeaponSelectGridItemInternal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.WeaponSelectGridItemInternal:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f13_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
			f13_local0(f13_arg0.WeaponSelectGridItemInternal)
		end,
	},
	Equipped = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f16_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.WeaponSelectGridItemInternal)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.WeaponSelectGridItemInternal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f17_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
				f17_arg0.WeaponSelectGridItemInternal:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.WeaponSelectGridItemInternal:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f17_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
			f17_local0(f17_arg0.WeaponSelectGridItemInternal)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.WeaponSelectGridItemInternal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f19_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
				f19_arg0.WeaponSelectGridItemInternal:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.WeaponSelectGridItemInternal:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f19_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
			f19_local0(f19_arg0.WeaponSelectGridItemInternal)
		end,
	},
}
CoD.SupportSelectionOption.__onClose = function(f21_arg0)
	f21_arg0.WeaponSelectGridItemInternal:close()
end
