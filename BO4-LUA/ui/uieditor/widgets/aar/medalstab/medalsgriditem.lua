require("x64:bbd674483239ff3")
CoD.MedalsGridItem = InheritFrom(LUI.UIElement)
CoD.MedalsGridItem.__defaultWidth = 265
CoD.MedalsGridItem.__defaultHeight = 225
CoD.MedalsGridItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MedalsGridItem)
	self.id = "MedalsGridItem"
	self.soundSet = "HUD"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Medal = CoD.MedalsGridItemInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 265, 0, 0, 0, 225)
	Medal:linkToElementModel(self, nil, false, function(model)
		Medal:setModel(model, f1_arg1)
	end)
	self:addElement(Medal)
	self.Medal = Medal
	Medal.id = "Medal"
	self.__defaultFocus = Medal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MedalsGridItem.__resetProperties = function(f3_arg0)
	f3_arg0.Medal:completeAnimation()
	f3_arg0.Medal:setScale(1, 1)
end
CoD.MedalsGridItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Medal:completeAnimation()
			f5_arg0.Medal:setScale(1.02, 1.02)
			f5_arg0.clipFinished(f5_arg0.Medal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Medal:beginAnimation(200)
				f6_arg0.Medal:setScale(1.02, 1.02)
				f6_arg0.Medal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Medal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Medal:completeAnimation()
			f6_arg0.Medal:setScale(1, 1)
			f6_local0(f6_arg0.Medal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Medal:beginAnimation(200)
				f8_arg0.Medal:setScale(1, 1)
				f8_arg0.Medal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Medal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Medal:completeAnimation()
			f8_arg0.Medal:setScale(1.02, 1.02)
			f8_local0(f8_arg0.Medal)
		end,
	},
}
CoD.MedalsGridItem.__onClose = function(f10_arg0)
	f10_arg0.Medal:close()
end
