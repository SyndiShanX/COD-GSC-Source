require("x64:8ffe7c4e01e7052")
require("x64:2dee1d9f1ec4c33")
require("x64:d87d8c56a6a0017")
CoD.ActiveThemeSlot = InheritFrom(LUI.UIElement)
CoD.ActiveThemeSlot.__defaultWidth = 114
CoD.ActiveThemeSlot.__defaultHeight = 260
CoD.ActiveThemeSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ActiveThemeSlot)
	self.id = "ActiveThemeSlot"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CamoSlotWideInternal = CoD.CamoSlotWideInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CamoSlotWideInternal:mergeStateConditions({
		{
			stateName = "WrappedLockedOwned",
			condition = function(menu, element, event)
				local f2_local0 = CoD.WeaponOptionsUtility.IsItemWeaponOptionLootOwned(menu, element, f1_arg1)
				if f2_local0 then
					f2_local0 = CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(menu, element, f1_arg1)
					if f2_local0 then
						f2_local0 = CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, f1_arg1)
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "WrappedLockedNotOwned",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.WeaponOptionsUtility.IsItemWeaponOptionLootOwned(menu, element, f1_arg1) then
					f3_local0 = CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(menu, element, f1_arg1)
					if f3_local0 then
						f3_local0 = CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, f1_arg1)
					end
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "Wrapped",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(menu, element, f1_arg1) and not CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, f1_arg1)
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
	local ItemHintText = CoD.ItemHintText.new(f1_arg0, f1_arg1, 0.5, 0.5, -146, 146, 0, 0, -51, -6)
	ItemHintText:mergeStateConditions({
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrappedOrLocked(menu, self, f1_arg1)
			end,
		},
	})
	ItemHintText:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ItemHintText, f9_arg1)
	end)
	local f1_local3 = ItemHintText
	local NewBreadcrumb = ItemHintText.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	NewBreadcrumb(f1_local3, f1_local5.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(ItemHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
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
	NewBreadcrumb = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0, 0, -21, 135, 0, 0, 112, 148)
	NewBreadcrumb:setAlpha(0)
	self:addElement(NewBreadcrumb)
	self.NewBreadcrumb = NewBreadcrumb
	CamoSlotWideInternal.id = "CamoSlotWideInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ActiveThemeSlot.__resetProperties = function(f12_arg0)
	f12_arg0.CamoSlotWideInternal:completeAnimation()
	f12_arg0.ItemHintText:completeAnimation()
	f12_arg0.NewBreadcrumb:completeAnimation()
	f12_arg0.CamoSlotWideInternal:setScale(1, 1)
	f12_arg0.ItemHintText:setAlpha(0)
	f12_arg0.NewBreadcrumb:setAlpha(0)
end
CoD.ActiveThemeSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.CamoSlotWideInternal:completeAnimation()
			f14_arg0.CamoSlotWideInternal:setScale(1.05, 1.05)
			f14_arg0.clipFinished(f14_arg0.CamoSlotWideInternal)
			f14_arg0.ItemHintText:completeAnimation()
			f14_arg0.ItemHintText:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.ItemHintText)
		end,
		GainChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				f15_arg0.CamoSlotWideInternal:beginAnimation(200)
				f15_arg0.CamoSlotWideInternal:setScale(1.05, 1.05)
				f15_arg0.CamoSlotWideInternal:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.CamoSlotWideInternal:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.CamoSlotWideInternal:completeAnimation()
			f15_arg0.CamoSlotWideInternal:setScale(1, 1)
			f15_local0(f15_arg0.CamoSlotWideInternal)
			local f15_local1 = function(f17_arg0)
				f15_arg0.ItemHintText:beginAnimation(200)
				f15_arg0.ItemHintText:setAlpha(1)
				f15_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.ItemHintText:completeAnimation()
			f15_arg0.ItemHintText:setAlpha(0)
			f15_local1(f15_arg0.ItemHintText)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			local f18_local0 = function(f19_arg0)
				f18_arg0.CamoSlotWideInternal:beginAnimation(200)
				f18_arg0.CamoSlotWideInternal:setScale(1, 1)
				f18_arg0.CamoSlotWideInternal:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.CamoSlotWideInternal:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.CamoSlotWideInternal:completeAnimation()
			f18_arg0.CamoSlotWideInternal:setScale(1.05, 1.05)
			f18_local0(f18_arg0.CamoSlotWideInternal)
			f18_arg0.ItemHintText:completeAnimation()
			f18_arg0.ItemHintText:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ItemHintText)
		end,
	},
	New = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.NewBreadcrumb:completeAnimation()
			f20_arg0.NewBreadcrumb:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.NewBreadcrumb)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.CamoSlotWideInternal:completeAnimation()
			f21_arg0.CamoSlotWideInternal:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.CamoSlotWideInternal)
			f21_arg0.ItemHintText:completeAnimation()
			f21_arg0.ItemHintText:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.ItemHintText)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(200)
					f23_arg0:setAlpha(0)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.NewBreadcrumb:beginAnimation(400)
				f21_arg0.NewBreadcrumb:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.NewBreadcrumb:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.NewBreadcrumb:completeAnimation()
			f21_arg0.NewBreadcrumb:setAlpha(1)
			f21_local0(f21_arg0.NewBreadcrumb)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			local f24_local0 = function(f25_arg0)
				f24_arg0.CamoSlotWideInternal:beginAnimation(200)
				f24_arg0.CamoSlotWideInternal:setScale(1.05, 1.05)
				f24_arg0.CamoSlotWideInternal:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.CamoSlotWideInternal:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.CamoSlotWideInternal:completeAnimation()
			f24_arg0.CamoSlotWideInternal:setScale(1, 1)
			f24_local0(f24_arg0.CamoSlotWideInternal)
			local f24_local1 = function(f26_arg0)
				f24_arg0.ItemHintText:beginAnimation(200)
				f24_arg0.ItemHintText:setAlpha(1)
				f24_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.ItemHintText:completeAnimation()
			f24_arg0.ItemHintText:setAlpha(0)
			f24_local1(f24_arg0.ItemHintText)
			f24_arg0.NewBreadcrumb:completeAnimation()
			f24_arg0.NewBreadcrumb:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.NewBreadcrumb)
		end,
		LoseChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				f27_arg0.CamoSlotWideInternal:beginAnimation(200)
				f27_arg0.CamoSlotWideInternal:setScale(1, 1)
				f27_arg0.CamoSlotWideInternal:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.CamoSlotWideInternal:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.CamoSlotWideInternal:completeAnimation()
			f27_arg0.CamoSlotWideInternal:setScale(1.05, 1.05)
			f27_local0(f27_arg0.CamoSlotWideInternal)
			f27_arg0.ItemHintText:completeAnimation()
			f27_arg0.ItemHintText:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ItemHintText)
		end,
	},
}
CoD.ActiveThemeSlot.__onClose = function(f29_arg0)
	f29_arg0.CamoSlotWideInternal:close()
	f29_arg0.ItemHintText:close()
	f29_arg0.NewBreadcrumb:close()
end
