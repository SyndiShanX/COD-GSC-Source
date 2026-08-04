require("ui/uieditor/widgets/commonlistbuttongenericlonginternal")
CoD.CommonListButtonGenericLong = InheritFrom(LUI.UIElement)
CoD.CommonListButtonGenericLong.__defaultWidth = 400
CoD.CommonListButtonGenericLong.__defaultHeight = 43
CoD.CommonListButtonGenericLong.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonListButtonGenericLong)
	self.id = "CommonListButtonGenericLong"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonListButtonGenericInternal = CoD.CommonListButtonGenericLongInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0.5, 0.5, -21.5, 21.5)
	CommonListButtonGenericInternal:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonListButtonGenericInternal.Title:setText(ConvertToUpperString(CoD.BaseUtility.LocalizeIfXHash(f2_local0)))
		end
	end)
	self:addElement(CommonListButtonGenericInternal)
	self.CommonListButtonGenericInternal = CommonListButtonGenericInternal
	CommonListButtonGenericInternal.id = "CommonListButtonGenericInternal"
	self.__defaultFocus = CommonListButtonGenericInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonListButtonGenericLong.__resetProperties = function(f3_arg0)
	f3_arg0.CommonListButtonGenericInternal:completeAnimation()
	f3_arg0.CommonListButtonGenericInternal:setScale(1, 1)
end
CoD.CommonListButtonGenericLong.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CommonListButtonGenericInternal:completeAnimation()
			f5_arg0.CommonListButtonGenericInternal:setScale(1.03, 1.03)
			f5_arg0.clipFinished(f5_arg0.CommonListButtonGenericInternal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.CommonListButtonGenericInternal:beginAnimation(200)
				f6_arg0.CommonListButtonGenericInternal:setScale(1.03, 1.03)
				f6_arg0.CommonListButtonGenericInternal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.CommonListButtonGenericInternal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.CommonListButtonGenericInternal:completeAnimation()
			f6_arg0.CommonListButtonGenericInternal:setScale(1, 1)
			f6_local0(f6_arg0.CommonListButtonGenericInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CommonListButtonGenericInternal:beginAnimation(200)
				f8_arg0.CommonListButtonGenericInternal:setScale(1, 1)
				f8_arg0.CommonListButtonGenericInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CommonListButtonGenericInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CommonListButtonGenericInternal:completeAnimation()
			f8_arg0.CommonListButtonGenericInternal:setScale(1.03, 1.03)
			f8_local0(f8_arg0.CommonListButtonGenericInternal)
		end,
	},
}
CoD.CommonListButtonGenericLong.__onClose = function(f10_arg0)
	f10_arg0.CommonListButtonGenericInternal:close()
end
