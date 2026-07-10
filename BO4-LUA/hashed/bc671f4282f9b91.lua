require("x64:1f846296f1a1b81")
CoD.ItemShopButton = InheritFrom(LUI.UIElement)
CoD.ItemShopButton.__defaultWidth = 460
CoD.ItemShopButton.__defaultHeight = 60
CoD.ItemShopButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopButton)
	self.id = "ItemShopButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorSelectButtonMiniInternal = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0.01, 1.01, 0, 0, 0, 1, 0, 0)
	DirectorSelectButtonMiniInternal.MiddleText:setTTF("ttmussels_regular")
	DirectorSelectButtonMiniInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	DirectorSelectButtonMiniInternal:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	DirectorSelectButtonMiniInternal:linkToElementModel(self, "displayText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(f3_local0))
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
CoD.ItemShopButton.__resetProperties = function(f4_arg0)
	f4_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
	f4_arg0.DirectorSelectButtonMiniInternal:setAlpha(1)
	f4_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
end
CoD.ItemShopButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f6_arg0.DirectorSelectButtonMiniInternal:setScale(1.04, 1.04)
			f6_arg0.clipFinished(f6_arg0.DirectorSelectButtonMiniInternal)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f7_arg0.DirectorSelectButtonMiniInternal:setScale(1.04, 1.04)
				f7_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f7_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
			f7_local0(f7_arg0.DirectorSelectButtonMiniInternal)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f9_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
				f9_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f9_arg0.DirectorSelectButtonMiniInternal:setScale(1.04, 1.04)
			f9_local0(f9_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
	Hidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f11_arg0.DirectorSelectButtonMiniInternal:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
}
CoD.ItemShopButton.__onClose = function(f12_arg0)
	f12_arg0.DirectorSelectButtonMiniInternal:close()
end
