require("x64:7f836f40e2b97b5")
CoD.StickerSetDecal = InheritFrom(LUI.UIElement)
CoD.StickerSetDecal.__defaultWidth = 144
CoD.StickerSetDecal.__defaultHeight = 144
CoD.StickerSetDecal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StickerSetDecal)
	self.id = "StickerSetDecal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrontendFrame = CoD.StickerSetDecal_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -72, 72, 0.5, 0.5, -72, 72)
	FrontendFrame:linkToElementModel(self, nil, false, function(model)
		FrontendFrame:setModel(model, f1_arg1)
	end)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	FrontendFrame.id = "FrontendFrame"
	self.__defaultFocus = FrontendFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StickerSetDecal.__resetProperties = function(f3_arg0)
	f3_arg0.FrontendFrame:completeAnimation()
	f3_arg0.FrontendFrame:setScale(1, 1)
end
CoD.StickerSetDecal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.FrontendFrame:completeAnimation()
			f5_arg0.FrontendFrame:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.FrontendFrame)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.FrontendFrame:beginAnimation(200)
				f6_arg0.FrontendFrame:setScale(1.05, 1.05)
				f6_arg0.FrontendFrame:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.FrontendFrame:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.FrontendFrame:completeAnimation()
			f6_arg0.FrontendFrame:setScale(1, 1)
			f6_local0(f6_arg0.FrontendFrame)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.FrontendFrame:beginAnimation(200)
				f8_arg0.FrontendFrame:setScale(1, 1)
				f8_arg0.FrontendFrame:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FrontendFrame:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FrontendFrame:completeAnimation()
			f8_arg0.FrontendFrame:setScale(1.05, 1.05)
			f8_local0(f8_arg0.FrontendFrame)
		end,
	},
}
CoD.StickerSetDecal.__onClose = function(f10_arg0)
	f10_arg0.FrontendFrame:close()
end
