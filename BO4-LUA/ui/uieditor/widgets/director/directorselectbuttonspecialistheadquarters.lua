require("x64:b20339e832dc8eb")
CoD.DirectorSelectButtonSpecialistHeadquarters = InheritFrom(LUI.UIElement)
CoD.DirectorSelectButtonSpecialistHeadquarters.__defaultWidth = 412
CoD.DirectorSelectButtonSpecialistHeadquarters.__defaultHeight = 67
CoD.DirectorSelectButtonSpecialistHeadquarters.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorSelectButtonSpecialistHeadquarters)
	self.id = "DirectorSelectButtonSpecialistHeadquarters"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpecialistPersonalizationButtonOptionInternal = CoD.SpecialistPersonalizationButtonOptionInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	SpecialistPersonalizationButtonOptionInternal.Header:setText("")
	self:addElement(SpecialistPersonalizationButtonOptionInternal)
	self.SpecialistPersonalizationButtonOptionInternal = SpecialistPersonalizationButtonOptionInternal
	local Image = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	self:addElement(Image)
	self.Image = Image
	local Header = LUI.UIText.new(0, 1, 0, 0, 0, 0, -33, -6)
	Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Header:setTTF("ttmussels_regular")
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Header)
	self.Header = Header
	SpecialistPersonalizationButtonOptionInternal.id = "SpecialistPersonalizationButtonOptionInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorSelectButtonSpecialistHeadquarters.__resetProperties = function(f2_arg0)
	f2_arg0.Image:completeAnimation()
	f2_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
	f2_arg0.Image:setScale(1, 1)
	f2_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1, 1)
end
CoD.DirectorSelectButtonSpecialistHeadquarters.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
			f4_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1.05, 1.05)
			f4_arg0.clipFinished(f4_arg0.SpecialistPersonalizationButtonOptionInternal)
			f4_arg0.Image:completeAnimation()
			f4_arg0.Image:setScale(1.05, 1.05)
			f4_arg0.clipFinished(f4_arg0.Image)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.SpecialistPersonalizationButtonOptionInternal:beginAnimation(200)
				f5_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1.05, 1.05)
				f5_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
			f5_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1, 1)
			f5_local0(f5_arg0.SpecialistPersonalizationButtonOptionInternal)
			local f5_local1 = function(f7_arg0)
				f5_arg0.Image:beginAnimation(200)
				f5_arg0.Image:setScale(1.05, 1.05)
				f5_arg0.Image:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Image:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Image:completeAnimation()
			f5_arg0.Image:setScale(1, 1)
			f5_local1(f5_arg0.Image)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.SpecialistPersonalizationButtonOptionInternal:beginAnimation(200)
				f8_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1, 1)
				f8_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
			f8_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1.05, 1.05)
			f8_local0(f8_arg0.SpecialistPersonalizationButtonOptionInternal)
			local f8_local1 = function(f10_arg0)
				f8_arg0.Image:beginAnimation(200)
				f8_arg0.Image:setScale(1, 1)
				f8_arg0.Image:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Image:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Image:completeAnimation()
			f8_arg0.Image:setScale(1.05, 1.05)
			f8_local1(f8_arg0.Image)
		end,
	},
}
CoD.DirectorSelectButtonSpecialistHeadquarters.__onClose = function(f11_arg0)
	f11_arg0.SpecialistPersonalizationButtonOptionInternal:close()
end
