CoD.IcePickHackFlavorTextItem = InheritFrom(LUI.UIElement)
CoD.IcePickHackFlavorTextItem.__defaultWidth = 248
CoD.IcePickHackFlavorTextItem.__defaultHeight = 21
CoD.IcePickHackFlavorTextItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Bottom)
	self:setClass(CoD.IcePickHackFlavorTextItem)
	self.id = "IcePickHackFlavorTextItem"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HackText = LUI.UIText.new(0, 0, 4, 249, 0, 0, 3, 21)
	HackText:setRGB(0.49, 0.85, 1)
	HackText:setTTF("0arame_mono_stencil")
	HackText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	HackText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	HackText:linkToElementModel(self, "hackingText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			HackText:setText(f2_local0)
		end
	end)
	self:addElement(HackText)
	self.HackText = HackText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.IcePickHackFlavorTextItem.__resetProperties = function(f3_arg0)
	f3_arg0.HackText:completeAnimation()
	f3_arg0.HackText:setAlpha(1)
end
CoD.IcePickHackFlavorTextItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.HackText:beginAnimation(100)
				f5_arg0.HackText:setAlpha(1)
				f5_arg0.HackText:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.HackText:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.HackText:completeAnimation()
			f5_arg0.HackText:setAlpha(0)
			f5_local0(f5_arg0.HackText)
		end,
		Expired = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.HackText:beginAnimation(100)
				f7_arg0.HackText:setAlpha(0)
				f7_arg0.HackText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.HackText:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.HackText:completeAnimation()
			f7_arg0.HackText:setAlpha(1)
			f7_local0(f7_arg0.HackText)
		end,
	},
}
CoD.IcePickHackFlavorTextItem.__onClose = function(f9_arg0)
	f9_arg0.HackText:close()
end
