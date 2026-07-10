require("x64:7e88de2d7c76449")
CoD.List1ButtonChooseClass = InheritFrom(LUI.UIElement)
CoD.List1ButtonChooseClass.__defaultWidth = 385
CoD.List1ButtonChooseClass.__defaultHeight = 43
CoD.List1ButtonChooseClass.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.List1ButtonChooseClass)
	self.id = "List1ButtonChooseClass"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonGeneric = CoD.CommonListButtonGenericInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 43)
	ButtonGeneric:linkToElementModel(self, "customClassName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ButtonGeneric.Title2:setText(ConvertToUpperString(CoD.BaseUtility.LocalizeIfXHash(f2_local0)))
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
CoD.List1ButtonChooseClass.__resetProperties = function(f3_arg0)
	f3_arg0.ButtonGeneric:completeAnimation()
	f3_arg0.ButtonGeneric:setScale(1, 1)
end
CoD.List1ButtonChooseClass.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.ButtonGeneric:completeAnimation()
			f5_arg0.ButtonGeneric:setScale(1.02, 1.02)
			f5_arg0.clipFinished(f5_arg0.ButtonGeneric)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.ButtonGeneric:beginAnimation(200)
				f6_arg0.ButtonGeneric:setScale(1.02, 1.02)
				f6_arg0.ButtonGeneric:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.ButtonGeneric:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.ButtonGeneric:completeAnimation()
			f6_arg0.ButtonGeneric:setScale(1, 1)
			f6_local0(f6_arg0.ButtonGeneric)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.ButtonGeneric:beginAnimation(200)
				f8_arg0.ButtonGeneric:setScale(1, 1)
				f8_arg0.ButtonGeneric:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ButtonGeneric:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ButtonGeneric:completeAnimation()
			f8_arg0.ButtonGeneric:setScale(1.02, 1.02)
			f8_local0(f8_arg0.ButtonGeneric)
		end,
	},
}
CoD.List1ButtonChooseClass.__onClose = function(f10_arg0)
	f10_arg0.ButtonGeneric:close()
end
