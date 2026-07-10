require("x64:8ffe7c4e01e7052")
require("x64:5f03a7cad3f6de0")
CoD.CamoSlot = InheritFrom(LUI.UIElement)
CoD.CamoSlot.__defaultWidth = 110
CoD.CamoSlot.__defaultHeight = 80
CoD.CamoSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CamoSlot)
	self.id = "CamoSlot"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CamoSlotInternal = CoD.CamoSlotInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CamoSlotInternal:mergeStateConditions({
		{
			stateName = "LootLocked",
			condition = function(menu, element, event)
				return not CoD.WeaponOptionsUtility.IsItemWeaponOptionLootOwned(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "PaintCanLocked",
			condition = function(menu, element, event)
				local f3_local0
				if not IsCustomLobby() then
					f3_local0 = CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, f1_arg1)
					if f3_local0 then
						f3_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "unlockSessionMode", Enum[@"emodes"][@"mode_warzone"])
						if f3_local0 then
							if not CoD.WeaponOptionsUtility.ShouldHideWeaponOptionProgress(menu, element, f1_arg1) then
								f3_local0 = not IsLocal()
							else
								f3_local0 = false
							end
						end
					end
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsProgressionWithWarzoneEnabledForMenu(menu) and CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, f1_arg1)
			end,
		},
	})
	local f1_local2 = CamoSlotInternal
	local NewBreadcrumb = CamoSlotInternal.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	NewBreadcrumb(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(CamoSlotInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CamoSlotInternal:linkToElementModel(CamoSlotInternal, "itemIndex", true, function(model)
		f1_arg0:updateElementState(CamoSlotInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	CamoSlotInternal:linkToElementModel(CamoSlotInternal, "unlockSessionMode", true, function(model)
		f1_arg0:updateElementState(CamoSlotInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlockSessionMode",
		})
	end)
	f1_local2 = CamoSlotInternal
	NewBreadcrumb = CamoSlotInternal.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	NewBreadcrumb(f1_local2, f1_local4["lobbyRoot.lobbyNetworkMode"], function(f8_arg0)
		f1_arg0:updateElementState(CamoSlotInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	CamoSlotInternal:linkToElementModel(self, nil, false, function(model)
		CamoSlotInternal:setModel(model, f1_arg1)
	end)
	self:addElement(CamoSlotInternal)
	self.CamoSlotInternal = CamoSlotInternal
	NewBreadcrumb = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0, 0, -23, 133, 0, 0, 22, 58)
	NewBreadcrumb:setAlpha(0)
	self:addElement(NewBreadcrumb)
	self.NewBreadcrumb = NewBreadcrumb
	CamoSlotInternal.id = "CamoSlotInternal"
	self.__defaultFocus = CamoSlotInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CamoSlot.__resetProperties = function(f10_arg0)
	f10_arg0.CamoSlotInternal:completeAnimation()
	f10_arg0.NewBreadcrumb:completeAnimation()
	f10_arg0.CamoSlotInternal:setAlpha(1)
	f10_arg0.CamoSlotInternal:setScale(1, 1)
	f10_arg0.CamoSlotInternal.EquippedMarkerBG:setAlpha(0)
	f10_arg0.CamoSlotInternal.EquippedMarkerTick:setAlpha(0)
	f10_arg0.NewBreadcrumb:setAlpha(0)
end
CoD.CamoSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.CamoSlotInternal:completeAnimation()
			f12_arg0.CamoSlotInternal:setScale(1.05, 1.05)
			f12_arg0.clipFinished(f12_arg0.CamoSlotInternal)
		end,
		GainChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.CamoSlotInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f13_arg0.CamoSlotInternal:setScale(1.05, 1.05)
				f13_arg0.CamoSlotInternal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.CamoSlotInternal:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.CamoSlotInternal:completeAnimation()
			f13_arg0.CamoSlotInternal:setScale(1, 1)
			f13_local0(f13_arg0.CamoSlotInternal)
		end,
		LoseChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.CamoSlotInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f15_arg0.CamoSlotInternal:setScale(1, 1)
				f15_arg0.CamoSlotInternal:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.CamoSlotInternal:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.CamoSlotInternal:completeAnimation()
			f15_arg0.CamoSlotInternal:setScale(1.05, 1.05)
			f15_local0(f15_arg0.CamoSlotInternal)
		end,
	},
	Equipped = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.CamoSlotInternal:completeAnimation()
			f17_arg0.CamoSlotInternal.EquippedMarkerBG:completeAnimation()
			f17_arg0.CamoSlotInternal.EquippedMarkerTick:completeAnimation()
			f17_arg0.CamoSlotInternal.EquippedMarkerBG:setAlpha(1)
			f17_arg0.CamoSlotInternal.EquippedMarkerTick:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.CamoSlotInternal)
		end,
		ChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.CamoSlotInternal:completeAnimation()
			f18_arg0.CamoSlotInternal.EquippedMarkerBG:completeAnimation()
			f18_arg0.CamoSlotInternal.EquippedMarkerTick:completeAnimation()
			f18_arg0.CamoSlotInternal:setScale(1.05, 1.05)
			f18_arg0.CamoSlotInternal.EquippedMarkerBG:setAlpha(1)
			f18_arg0.CamoSlotInternal.EquippedMarkerTick:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.CamoSlotInternal)
		end,
		GainChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.CamoSlotInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f19_arg0.CamoSlotInternal:setScale(1.05, 1.05)
				f19_arg0.CamoSlotInternal:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.CamoSlotInternal:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.CamoSlotInternal:completeAnimation()
			f19_arg0.CamoSlotInternal.EquippedMarkerBG:completeAnimation()
			f19_arg0.CamoSlotInternal.EquippedMarkerTick:completeAnimation()
			f19_arg0.CamoSlotInternal:setScale(1, 1)
			f19_arg0.CamoSlotInternal.EquippedMarkerBG:setAlpha(1)
			f19_arg0.CamoSlotInternal.EquippedMarkerTick:setAlpha(1)
			f19_local0(f19_arg0.CamoSlotInternal)
		end,
		LoseChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.CamoSlotInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f21_arg0.CamoSlotInternal:setScale(1, 1)
				f21_arg0.CamoSlotInternal:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.CamoSlotInternal:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.CamoSlotInternal:completeAnimation()
			f21_arg0.CamoSlotInternal.EquippedMarkerBG:completeAnimation()
			f21_arg0.CamoSlotInternal.EquippedMarkerTick:completeAnimation()
			f21_arg0.CamoSlotInternal:setScale(1.05, 1.05)
			f21_arg0.CamoSlotInternal.EquippedMarkerBG:setAlpha(1)
			f21_arg0.CamoSlotInternal.EquippedMarkerTick:setAlpha(1)
			f21_local0(f21_arg0.CamoSlotInternal)
		end,
	},
	New = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.NewBreadcrumb:completeAnimation()
			f23_arg0.NewBreadcrumb:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.NewBreadcrumb)
		end,
		ChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.CamoSlotInternal:completeAnimation()
			f24_arg0.CamoSlotInternal:setScale(1.05, 1.05)
			f24_arg0.clipFinished(f24_arg0.CamoSlotInternal)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(200)
					f26_arg0:setAlpha(0)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.NewBreadcrumb:beginAnimation(400)
				f24_arg0.NewBreadcrumb:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.NewBreadcrumb:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.NewBreadcrumb:completeAnimation()
			f24_arg0.NewBreadcrumb:setAlpha(1)
			f24_local0(f24_arg0.NewBreadcrumb)
		end,
		GainChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				f27_arg0.CamoSlotInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f27_arg0.CamoSlotInternal:setScale(1.05, 1.05)
				f27_arg0.CamoSlotInternal:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.CamoSlotInternal:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.CamoSlotInternal:completeAnimation()
			f27_arg0.CamoSlotInternal:setAlpha(1)
			f27_arg0.CamoSlotInternal:setScale(1, 1)
			f27_local0(f27_arg0.CamoSlotInternal)
			f27_arg0.NewBreadcrumb:completeAnimation()
			f27_arg0.NewBreadcrumb:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.NewBreadcrumb)
		end,
		LoseChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.CamoSlotInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f29_arg0.CamoSlotInternal:setScale(1, 1)
				f29_arg0.CamoSlotInternal:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.CamoSlotInternal:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.CamoSlotInternal:completeAnimation()
			f29_arg0.CamoSlotInternal:setScale(1.05, 1.05)
			f29_local0(f29_arg0.CamoSlotInternal)
		end,
	},
}
CoD.CamoSlot.__onClose = function(f31_arg0)
	f31_arg0.CamoSlotInternal:close()
	f31_arg0.NewBreadcrumb:close()
end
