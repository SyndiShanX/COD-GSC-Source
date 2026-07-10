require("x64:2dee1d9f1ec4c33")
require("x64:d87d8c56a6a0017")
CoD.CamoSlotWide = InheritFrom(LUI.UIElement)
CoD.CamoSlotWide.__defaultWidth = 165
CoD.CamoSlotWide.__defaultHeight = 80
CoD.CamoSlotWide.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CamoSlotWide)
	self.id = "CamoSlotWide"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CamoSlotWideInternal = CoD.CamoSlotWideInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CamoSlotWideInternal:mergeStateConditions({
		{
			stateName = "Wrapped",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, f1_arg1)
			end,
		},
	})
	CamoSlotWideInternal:linkToElementModel(CamoSlotWideInternal, "itemIndex", true, function(model)
		f1_arg0:updateElementState(CamoSlotWideInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	CamoSlotWideInternal:linkToElementModel(self, nil, false, function(model)
		CamoSlotWideInternal:setModel(model, f1_arg1)
	end)
	self:addElement(CamoSlotWideInternal)
	self.CamoSlotWideInternal = CamoSlotWideInternal
	local ItemHintText = CoD.ItemHintText.new(f1_arg0, f1_arg1, 0.5, 0.5, -146, 146, 0, 0, -70, -25)
	ItemHintText:mergeStateConditions({
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, self, f1_arg1)
			end,
		},
	})
	ItemHintText:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ItemHintText, f7_arg1)
	end)
	local f1_local3 = ItemHintText
	local f1_local4 = ItemHintText.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f8_arg0)
		f1_arg0:updateElementState(ItemHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ItemHintText:linkToElementModel(ItemHintText, "itemIndex", true, function(model)
		f1_arg0:updateElementState(ItemHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	ItemHintText:setAlpha(0)
	ItemHintText.textCenterAlign:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/details_button"))
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	CamoSlotWideInternal.id = "CamoSlotWideInternal"
	self.__defaultFocus = CamoSlotWideInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CamoSlotWide.__resetProperties = function(f10_arg0)
	f10_arg0.CamoSlotWideInternal:completeAnimation()
	f10_arg0.ItemHintText:completeAnimation()
	f10_arg0.CamoSlotWideInternal:setScale(1, 1)
	f10_arg0.ItemHintText:setAlpha(0)
end
CoD.CamoSlotWide.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.CamoSlotWideInternal:completeAnimation()
			f12_arg0.CamoSlotWideInternal:setScale(1.05, 1.05)
			f12_arg0.clipFinished(f12_arg0.CamoSlotWideInternal)
			f12_arg0.ItemHintText:completeAnimation()
			f12_arg0.ItemHintText:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.ItemHintText)
		end,
		GainChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				f13_arg0.CamoSlotWideInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f13_arg0.CamoSlotWideInternal:setScale(1.05, 1.05)
				f13_arg0.CamoSlotWideInternal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.CamoSlotWideInternal:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.CamoSlotWideInternal:completeAnimation()
			f13_arg0.CamoSlotWideInternal:setScale(1, 1)
			f13_local0(f13_arg0.CamoSlotWideInternal)
			local f13_local1 = function(f15_arg0)
				f13_arg0.ItemHintText:beginAnimation(200)
				f13_arg0.ItemHintText:setAlpha(1)
				f13_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.ItemHintText:completeAnimation()
			f13_arg0.ItemHintText:setAlpha(0)
			f13_local1(f13_arg0.ItemHintText)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			local f16_local0 = function(f17_arg0)
				f16_arg0.CamoSlotWideInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f16_arg0.CamoSlotWideInternal:setScale(1, 1)
				f16_arg0.CamoSlotWideInternal:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.CamoSlotWideInternal:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.CamoSlotWideInternal:completeAnimation()
			f16_arg0.CamoSlotWideInternal:setScale(1.05, 1.05)
			f16_local0(f16_arg0.CamoSlotWideInternal)
			f16_arg0.ItemHintText:completeAnimation()
			f16_arg0.ItemHintText:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ItemHintText)
		end,
	},
}
CoD.CamoSlotWide.__onClose = function(f18_arg0)
	f18_arg0.CamoSlotWideInternal:close()
	f18_arg0.ItemHintText:close()
end
