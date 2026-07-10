CoD.SubtitleEntry = InheritFrom(LUI.UIElement)
CoD.SubtitleEntry.__defaultWidth = 1110
CoD.SubtitleEntry.__defaultHeight = 33
CoD.SubtitleEntry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SubtitleEntry)
	self.id = "SubtitleEntry"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local glow = LUI.UIText.new(0, 0, 0, 1110, 0, 0, 0, 33)
	glow:setRGB(0, 0, 0)
	glow:setTTF("default")
	glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	glow:setShaderVector(0, 0.4, 0, 0, 0)
	glow:setShaderVector(1, -0.7, 0, 0, 0)
	glow:setShaderVector(2, 1, 0, 0, 0)
	glow:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	glow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	glow:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			glow:setText(f2_local0)
		end
	end)
	self:addElement(glow)
	self.glow = glow
	local TextBox = LUI.UIText.new(0, 0, 0, 1110, 0, 0, 0, 33)
	TextBox:setTTF("default")
	TextBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	TextBox:setShaderVector(0, 0, 0, 0, 0)
	TextBox:setShaderVector(1, 0, 0, 0, 0)
	TextBox:setShaderVector(2, 1, 0, 0, 0)
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TextBox:linkToElementModel(self, "text", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TextBox:setText(f3_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(TextBox, "setText", function(element, controller)
		UpdateWidgetHeightToMultilineText(self, element, 5)
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SubtitleEntry.__resetProperties = function(f5_arg0)
	f5_arg0.TextBox:completeAnimation()
	f5_arg0.glow:completeAnimation()
	f5_arg0.TextBox:setAlpha(1)
	f5_arg0.glow:setAlpha(1)
end
CoD.SubtitleEntry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		FadeOut = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.glow:beginAnimation(280, Enum[@"luitween"][@"luitween_bounce"])
				f7_arg0.glow:setAlpha(0)
				f7_arg0.glow:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.glow:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.glow:completeAnimation()
			f7_arg0.glow:setAlpha(1)
			f7_local0(f7_arg0.glow)
			local f7_local1 = function(f9_arg0)
				f7_arg0.TextBox:beginAnimation(280, Enum[@"luitween"][@"luitween_bounce"])
				f7_arg0.TextBox:setAlpha(0)
				f7_arg0.TextBox:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.TextBox:completeAnimation()
			f7_arg0.TextBox:setAlpha(1)
			f7_local1(f7_arg0.TextBox)
		end,
		FadeIn = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				f10_arg0.glow:beginAnimation(200, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"])
				f10_arg0.glow:setAlpha(1)
				f10_arg0.glow:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.glow:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.glow:completeAnimation()
			f10_arg0.glow:setAlpha(0)
			f10_local0(f10_arg0.glow)
			local f10_local1 = function(f12_arg0)
				f10_arg0.TextBox:beginAnimation(200, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"])
				f10_arg0.TextBox:setAlpha(1)
				f10_arg0.TextBox:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.TextBox:completeAnimation()
			f10_arg0.TextBox:setAlpha(0)
			f10_local1(f10_arg0.TextBox)
		end,
		Hide = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.glow:completeAnimation()
			f13_arg0.glow:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.glow)
			f13_arg0.TextBox:completeAnimation()
			f13_arg0.TextBox:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.TextBox)
		end,
	},
}
CoD.SubtitleEntry.__onClose = function(f14_arg0)
	f14_arg0.glow:close()
	f14_arg0.TextBox:close()
end
