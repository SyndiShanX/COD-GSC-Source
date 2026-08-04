require("ui/uieditor/widgets/commonlistbuttongenericinternal")
CoD.CommonListButtonGenericShort = InheritFrom(LUI.UIElement)
CoD.CommonListButtonGenericShort.__defaultWidth = 205
CoD.CommonListButtonGenericShort.__defaultHeight = 43
CoD.CommonListButtonGenericShort.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonListButtonGenericShort)
	self.id = "CommonListButtonGenericShort"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DotLeft = CoD.CommonListButtonGenericInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 43)
	DotLeft:linkToElementModel(self, nil, false, function(model)
		DotLeft:setModel(model, f1_arg1)
	end)
	DotLeft:linkToElementModel(self, "displayText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DotLeft.Title2:setText(ConvertToUpperString(CoD.BaseUtility.LocalizeIfXHash(f3_local0)))
		end
	end)
	self:addElement(DotLeft)
	self.DotLeft = DotLeft
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1) and not PropertyIsTrue(self, "hideHelpItemLabel")
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	DotLeft.id = "DotLeft"
	self.__defaultFocus = DotLeft
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonListButtonGenericShort.__resetProperties = function(f6_arg0)
	f6_arg0.DotLeft:completeAnimation()
	f6_arg0.DotLeft:setScale(1, 1)
end
CoD.CommonListButtonGenericShort.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.DotLeft:completeAnimation()
			f8_arg0.DotLeft:setScale(1.02, 1.02)
			f8_arg0.clipFinished(f8_arg0.DotLeft)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.DotLeft:beginAnimation(150)
				f9_arg0.DotLeft:setScale(1.02, 1.02)
				f9_arg0.DotLeft:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.DotLeft:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.DotLeft:completeAnimation()
			f9_arg0.DotLeft:setScale(1, 1)
			f9_local0(f9_arg0.DotLeft)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.DotLeft:beginAnimation(100)
				f11_arg0.DotLeft:setScale(1, 1)
				f11_arg0.DotLeft:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DotLeft:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.DotLeft:completeAnimation()
			f11_arg0.DotLeft:setScale(1.02, 1.02)
			f11_local0(f11_arg0.DotLeft)
		end,
	},
	Disabled = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CommonListButtonGenericShort.__onClose = function(f14_arg0)
	f14_arg0.DotLeft:close()
end
