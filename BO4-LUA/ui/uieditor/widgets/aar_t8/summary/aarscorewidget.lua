require("x64:3c71a587b3212e8")
CoD.AARScoreWidget = InheritFrom(LUI.UIElement)
CoD.AARScoreWidget.__defaultWidth = 340
CoD.AARScoreWidget.__defaultHeight = 132
CoD.AARScoreWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARScoreWidget)
	self.id = "AARScoreWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerformBg = CoD.AARPerformanceBg.new(f1_arg0, f1_arg1, 0, 0, -7, 347, 0, 0, 0, 140)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local ScoreLabel = LUI.UIText.new(0, 0, 18, 318, 0, 0, 12, 33)
	ScoreLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ScoreLabel:setAlpha(0.2)
	ScoreLabel:setText(LocalizeToUpperString(@"hash_50C861EA97BB6F5"))
	ScoreLabel:setTTF("dinnext_regular")
	ScoreLabel:setLetterSpacing(2)
	ScoreLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ScoreLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ScoreLabel)
	self.ScoreLabel = ScoreLabel
	local ScoreGlow = LUI.UIText.new(0, 0, 18, 318, 0, 0, 42, 122)
	ScoreGlow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ScoreGlow:setAlpha(0.4)
	ScoreGlow:setTTF("ttmussels_regular")
	ScoreGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	ScoreGlow:setShaderVector(0, 0.3, 0, 0, 0)
	ScoreGlow:setShaderVector(1, 0, 0, 0, 0)
	ScoreGlow:setShaderVector(2, 1, 0, 0, 0.8)
	ScoreGlow:setLetterSpacing(2)
	ScoreGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ScoreGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ScoreGlow:linkToElementModel(self, "score", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ScoreGlow:setText(f2_local0)
		end
	end)
	self:addElement(ScoreGlow)
	self.ScoreGlow = ScoreGlow
	local Score = LUI.UIText.new(0, 0, 18, 318, 0, 0, 42, 122)
	Score:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Score:setAlpha(0.8)
	Score:setTTF("ttmussels_regular")
	Score:setLetterSpacing(2)
	Score:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Score:linkToElementModel(self, "score", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Score:setText(f3_local0)
		end
	end)
	self:addElement(Score)
	self.Score = Score
	self:mergeStateConditions({
		{
			stateName = "Cash",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("bounty", f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARScoreWidget.__resetProperties = function(f5_arg0)
	f5_arg0.ScoreGlow:completeAnimation()
	f5_arg0.ScoreLabel:completeAnimation()
	f5_arg0.ScoreGlow:setAlpha(0.4)
	f5_arg0.ScoreLabel:setText(LocalizeToUpperString(@"hash_50C861EA97BB6F5"))
end
CoD.AARScoreWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(500)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f8_arg0:setAlpha(0.4)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f6_arg0.ScoreGlow:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f6_arg0.ScoreGlow:setAlpha(0.55)
				f6_arg0.ScoreGlow:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.ScoreGlow:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.ScoreGlow:completeAnimation()
			f6_arg0.ScoreGlow:setAlpha(0.4)
			f6_local0(f6_arg0.ScoreGlow)
			f6_arg0.nextClip = "DefaultClip"
		end,
	},
	Cash = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ScoreLabel:completeAnimation()
			f10_arg0.ScoreLabel:setText(LocalizeToUpperString(@"mpui/cash"))
			f10_arg0.clipFinished(f10_arg0.ScoreLabel)
		end,
	},
}
CoD.AARScoreWidget.__onClose = function(f11_arg0)
	f11_arg0.PerformBg:close()
	f11_arg0.ScoreGlow:close()
	f11_arg0.Score:close()
end
