require("x64:1f846296f1a1b81")
CoD.PurchaseReservesItemButton = InheritFrom(LUI.UIElement)
CoD.PurchaseReservesItemButton.__defaultWidth = 460
CoD.PurchaseReservesItemButton.__defaultHeight = 60
CoD.PurchaseReservesItemButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PurchaseReservesItemButton)
	self.id = "PurchaseReservesItemButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorSelectButtonMiniInternal = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0.01, 1.01, 0, 0, 0, 1, 0, 0)
	DirectorSelectButtonMiniInternal:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f1_arg1, "canPurchase")
			end,
		},
	})
	DirectorSelectButtonMiniInternal:linkToElementModel(DirectorSelectButtonMiniInternal, "canPurchase", true, function(model)
		f1_arg0:updateElementState(DirectorSelectButtonMiniInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "canPurchase",
		})
	end)
	DirectorSelectButtonMiniInternal.LeaderActivityText:setText("")
	DirectorSelectButtonMiniInternal.MiddleText:setTTF("ttmussels_regular")
	DirectorSelectButtonMiniInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	DirectorSelectButtonMiniInternal:linkToElementModel(self, nil, false, function(model)
		DirectorSelectButtonMiniInternal:setModel(model, f1_arg1)
	end)
	DirectorSelectButtonMiniInternal:linkToElementModel(self, "displayText", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DirectorSelectButtonMiniInternal.MiddleText:setText(ToUpper(f5_local0))
		end
	end)
	DirectorSelectButtonMiniInternal:linkToElementModel(self, "displayText", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(ToUpper(f6_local0))
		end
	end)
	self:addElement(DirectorSelectButtonMiniInternal)
	self.DirectorSelectButtonMiniInternal = DirectorSelectButtonMiniInternal
	DirectorSelectButtonMiniInternal.id = "DirectorSelectButtonMiniInternal"
	self.__defaultFocus = DirectorSelectButtonMiniInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PurchaseReservesItemButton.__resetProperties = function(f7_arg0)
	f7_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
	f7_arg0.DirectorSelectButtonMiniInternal:setAlpha(1)
	f7_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
end
CoD.PurchaseReservesItemButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f9_arg0.DirectorSelectButtonMiniInternal:setScale(1.04, 1.04)
			f9_arg0.clipFinished(f9_arg0.DirectorSelectButtonMiniInternal)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f10_arg0.DirectorSelectButtonMiniInternal:setScale(1.04, 1.04)
				f10_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f10_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
			f10_local0(f10_arg0.DirectorSelectButtonMiniInternal)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f12_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
				f12_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f12_arg0.DirectorSelectButtonMiniInternal:setScale(1.04, 1.04)
			f12_local0(f12_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
	Hidden = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f14_arg0.DirectorSelectButtonMiniInternal:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
}
CoD.PurchaseReservesItemButton.__onClose = function(f15_arg0)
	f15_arg0.DirectorSelectButtonMiniInternal:close()
end
