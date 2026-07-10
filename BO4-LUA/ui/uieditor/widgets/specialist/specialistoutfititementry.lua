require("x64:4753e4c4133046d")
CoD.SpecialistOutfitItemEntry = InheritFrom(LUI.UIElement)
CoD.SpecialistOutfitItemEntry.__defaultWidth = 69
CoD.SpecialistOutfitItemEntry.__defaultHeight = 69
CoD.SpecialistOutfitItemEntry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistOutfitItemEntry)
	self.id = "SpecialistOutfitItemEntry"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrontendFrameGlow = CoD.SpecialistOutfitItemEntry_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 69, 0, 0, 0, 69)
	FrontendFrameGlow:linkToElementModel(self, nil, false, function(model)
		FrontendFrameGlow:setModel(model, f1_arg1)
	end)
	self:addElement(FrontendFrameGlow)
	self.FrontendFrameGlow = FrontendFrameGlow
	FrontendFrameGlow.id = "FrontendFrameGlow"
	self.__defaultFocus = FrontendFrameGlow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistOutfitItemEntry.__resetProperties = function(f3_arg0)
	f3_arg0.FrontendFrameGlow:completeAnimation()
	f3_arg0.FrontendFrameGlow:setScale(1, 1)
end
CoD.SpecialistOutfitItemEntry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.FrontendFrameGlow:completeAnimation()
			f4_arg0.FrontendFrameGlow:setScale(0.95, 0.95)
			f4_arg0.clipFinished(f4_arg0.FrontendFrameGlow)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.FrontendFrameGlow:completeAnimation()
			f5_arg0.FrontendFrameGlow:setScale(1.03, 1.03)
			f5_arg0.clipFinished(f5_arg0.FrontendFrameGlow)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.FrontendFrameGlow:beginAnimation(150)
				f6_arg0.FrontendFrameGlow:setScale(1.03, 1.03)
				f6_arg0.FrontendFrameGlow:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.FrontendFrameGlow:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.FrontendFrameGlow:completeAnimation()
			f6_arg0.FrontendFrameGlow:setScale(0.95, 0.95)
			f6_local0(f6_arg0.FrontendFrameGlow)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.FrontendFrameGlow:beginAnimation(100)
				f8_arg0.FrontendFrameGlow:setScale(0.95, 0.95)
				f8_arg0.FrontendFrameGlow:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FrontendFrameGlow:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FrontendFrameGlow:completeAnimation()
			f8_arg0.FrontendFrameGlow:setScale(1.03, 1.03)
			f8_local0(f8_arg0.FrontendFrameGlow)
		end,
	},
}
CoD.SpecialistOutfitItemEntry.__onClose = function(f10_arg0)
	f10_arg0.FrontendFrameGlow:close()
end
