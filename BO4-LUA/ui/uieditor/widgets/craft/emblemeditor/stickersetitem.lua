require("x64:809c0509ebb6598")
CoD.StickerSetItem = InheritFrom(LUI.UIElement)
CoD.StickerSetItem.__defaultWidth = 152
CoD.StickerSetItem.__defaultHeight = 152
CoD.StickerSetItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StickerSetItem)
	self.id = "StickerSetItem"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StickerSetItemInternal = CoD.StickerSetItemInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	StickerSetItemInternal:linkToElementModel(self, nil, false, function(model)
		StickerSetItemInternal:setModel(model, f1_arg1)
	end)
	self:addElement(StickerSetItemInternal)
	self.StickerSetItemInternal = StickerSetItemInternal
	StickerSetItemInternal.id = "StickerSetItemInternal"
	self.__defaultFocus = StickerSetItemInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StickerSetItem.__resetProperties = function(f3_arg0)
	f3_arg0.StickerSetItemInternal:completeAnimation()
	f3_arg0.StickerSetItemInternal:setScale(1, 1)
end
CoD.StickerSetItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.StickerSetItemInternal:completeAnimation()
			f5_arg0.StickerSetItemInternal:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.StickerSetItemInternal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.StickerSetItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f6_arg0.StickerSetItemInternal:setScale(1.05, 1.05)
				f6_arg0.StickerSetItemInternal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.StickerSetItemInternal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.StickerSetItemInternal:completeAnimation()
			f6_arg0.StickerSetItemInternal:setScale(1, 1)
			f6_local0(f6_arg0.StickerSetItemInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.StickerSetItemInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f8_arg0.StickerSetItemInternal:setScale(1, 1)
				f8_arg0.StickerSetItemInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.StickerSetItemInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.StickerSetItemInternal:completeAnimation()
			f8_arg0.StickerSetItemInternal:setScale(1.05, 1.05)
			f8_local0(f8_arg0.StickerSetItemInternal)
		end,
	},
}
CoD.StickerSetItem.__onClose = function(f10_arg0)
	f10_arg0.StickerSetItemInternal:close()
end
