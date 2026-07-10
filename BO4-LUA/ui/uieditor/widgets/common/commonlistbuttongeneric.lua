require("x64:7e88de2d7c76449")
CoD.CommonListButtonGeneric = InheritFrom(LUI.UIElement)
CoD.CommonListButtonGeneric.__defaultWidth = 385
CoD.CommonListButtonGeneric.__defaultHeight = 43
CoD.CommonListButtonGeneric.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonListButtonGeneric)
	self.id = "CommonListButtonGeneric"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonGeneric = CoD.CommonListButtonGenericInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 43)
	ButtonGeneric:linkToElementModel(self, nil, false, function(model)
		ButtonGeneric:setModel(model, f1_arg1)
	end)
	ButtonGeneric:linkToElementModel(self, "displayText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ButtonGeneric.Title2:setText(ConvertToUpperString(CoD.BaseUtility.LocalizeIfXHash(f3_local0)))
		end
	end)
	self:addElement(ButtonGeneric)
	self.ButtonGeneric = ButtonGeneric
	ButtonGeneric.id = "ButtonGeneric"
	self.__defaultFocus = ButtonGeneric
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonListButtonGeneric.__resetProperties = function(f4_arg0)
	f4_arg0.ButtonGeneric:completeAnimation()
	f4_arg0.ButtonGeneric:setScale(1, 1)
end
CoD.CommonListButtonGeneric.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ButtonGeneric:completeAnimation()
			f6_arg0.ButtonGeneric:setScale(1.02, 1.02)
			f6_arg0.clipFinished(f6_arg0.ButtonGeneric)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ButtonGeneric:beginAnimation(200)
				f7_arg0.ButtonGeneric:setScale(1.02, 1.02)
				f7_arg0.ButtonGeneric:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ButtonGeneric:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ButtonGeneric:completeAnimation()
			f7_arg0.ButtonGeneric:setScale(1, 1)
			f7_local0(f7_arg0.ButtonGeneric)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.ButtonGeneric:beginAnimation(200)
				f9_arg0.ButtonGeneric:setScale(1, 1)
				f9_arg0.ButtonGeneric:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ButtonGeneric:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.ButtonGeneric:completeAnimation()
			f9_arg0.ButtonGeneric:setScale(1.02, 1.02)
			f9_local0(f9_arg0.ButtonGeneric)
		end,
	},
}
CoD.CommonListButtonGeneric.__onClose = function(f11_arg0)
	f11_arg0.ButtonGeneric:close()
end
