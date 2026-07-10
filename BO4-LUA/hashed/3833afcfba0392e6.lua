require("x64:d4955d888afd063")
CoD.PaintjobPersonalizationSlot = InheritFrom(LUI.UIElement)
CoD.PaintjobPersonalizationSlot.__defaultWidth = 110
CoD.PaintjobPersonalizationSlot.__defaultHeight = 80
CoD.PaintjobPersonalizationSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintjobPersonalizationSlot)
	self.id = "PaintjobPersonalizationSlot"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorSelectButtonLines = CoD.PaintjobPersonalizationSlotInternal.new(f1_arg0, f1_arg1, 0, 0, -1, 111, 0, 0, 0, 80)
	DirectorSelectButtonLines:linkToElementModel(self, nil, false, function(model)
		DirectorSelectButtonLines:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorSelectButtonLines)
	self.DirectorSelectButtonLines = DirectorSelectButtonLines
	DirectorSelectButtonLines.id = "DirectorSelectButtonLines"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintjobPersonalizationSlot.__resetProperties = function(f3_arg0)
	f3_arg0.DirectorSelectButtonLines:completeAnimation()
	f3_arg0.DirectorSelectButtonLines:setScale(1, 1)
end
CoD.PaintjobPersonalizationSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.DirectorSelectButtonLines:completeAnimation()
			f5_arg0.DirectorSelectButtonLines:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.DirectorSelectButtonLines)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.DirectorSelectButtonLines:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f6_arg0.DirectorSelectButtonLines:setScale(1.05, 1.05)
				f6_arg0.DirectorSelectButtonLines:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.DirectorSelectButtonLines:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.DirectorSelectButtonLines:completeAnimation()
			f6_arg0.DirectorSelectButtonLines:setScale(1, 1)
			f6_local0(f6_arg0.DirectorSelectButtonLines)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.DirectorSelectButtonLines:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f8_arg0.DirectorSelectButtonLines:setScale(1, 1)
				f8_arg0.DirectorSelectButtonLines:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.DirectorSelectButtonLines:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.DirectorSelectButtonLines:completeAnimation()
			f8_arg0.DirectorSelectButtonLines:setScale(1.05, 1.05)
			f8_local0(f8_arg0.DirectorSelectButtonLines)
		end,
	},
}
CoD.PaintjobPersonalizationSlot.__onClose = function(f10_arg0)
	f10_arg0.DirectorSelectButtonLines:close()
end
