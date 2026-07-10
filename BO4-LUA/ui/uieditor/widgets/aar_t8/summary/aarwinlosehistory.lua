CoD.AARWinLoseHistory = InheritFrom(LUI.UIElement)
CoD.AARWinLoseHistory.__defaultWidth = 124
CoD.AARWinLoseHistory.__defaultHeight = 236
CoD.AARWinLoseHistory.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARWinLoseHistory)
	self.id = "AARWinLoseHistory"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bar = LUI.UIImage.new(0, 0, 0, 124, 0, 0, -0.5, 117.5)
	Bar:setZRot(180)
	Bar:setImage(RegisterImage(@"uie_ui_menu_aar_stat_bar_grad"))
	self:addElement(Bar)
	self.Bar = Bar
	local BarAdd = LUI.UIImage.new(0, 0, 0, 124, 0, 0, -0.5, 117.5)
	BarAdd:setAlpha(0.5)
	BarAdd:setZRot(180)
	BarAdd:setImage(RegisterImage(@"uie_ui_menu_aar_stat_bar_grad"))
	BarAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BarAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BarAdd)
	self.BarAdd = BarAdd
	local Text = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -66.5, -51.5)
	Text:setRGB(0, 0.7, 0.85)
	Text:setText(LocalizeToUpperString(@"aar/win"))
	Text:setTTF("dinnext_regular")
	Text:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Text:setLetterSpacing(4)
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Text)
	self.Text = Text
	local TextAdd = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -66.5, -51.5)
	TextAdd:setRGB(0, 0.7, 0.85)
	TextAdd:setText(LocalizeToUpperString(@"aar/win"))
	TextAdd:setTTF("dinnext_regular")
	TextAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3336C1AE82B1520A"))
	TextAdd:setLetterSpacing(4)
	TextAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextAdd)
	self.TextAdd = TextAdd
	local InValidNormal = LUI.UIImage.new(0, 0, 14, 110, 0, 0, 22, 214)
	InValidNormal:setAlpha(0)
	InValidNormal:setImage(RegisterImage(@"uie_ui_menu_aar_perform_nodata"))
	self:addElement(InValidNormal)
	self.InValidNormal = InValidNormal
	local InValidAdd = LUI.UIImage.new(0, 0, 14, 110, 0, 0, 22, 214)
	InValidAdd:setAlpha(0)
	InValidAdd:setImage(RegisterImage(@"uie_ui_menu_aar_perform_nodata"))
	InValidAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InValidAdd)
	self.InValidAdd = InValidAdd
	self:mergeStateConditions({
		{
			stateName = "InValid",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "valid", 0)
			end,
		},
		{
			stateName = "Lose",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "outcome", @"loss")
			end,
		},
		{
			stateName = "Draw",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "outcome", @"draw")
			end,
		},
	})
	self:linkToElementModel(self, "valid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "valid",
		})
	end)
	self:linkToElementModel(self, "outcome", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "outcome",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARWinLoseHistory.__resetProperties = function(f7_arg0)
	f7_arg0.InValidAdd:completeAnimation()
	f7_arg0.InValidNormal:completeAnimation()
	f7_arg0.TextAdd:completeAnimation()
	f7_arg0.BarAdd:completeAnimation()
	f7_arg0.Bar:completeAnimation()
	f7_arg0.Text:completeAnimation()
	f7_arg0.InValidAdd:setAlpha(0)
	f7_arg0.InValidNormal:setAlpha(0)
	f7_arg0.TextAdd:setTopBottom(0.5, 0.5, -66.5, -51.5)
	f7_arg0.TextAdd:setAlpha(1)
	f7_arg0.TextAdd:setText(LocalizeToUpperString(@"aar/win"))
	f7_arg0.BarAdd:setAlpha(0.5)
	f7_arg0.Bar:setTopBottom(0, 0, -0.5, 117.5)
	f7_arg0.Bar:setRGB(1, 1, 1)
	f7_arg0.Bar:setAlpha(1)
	f7_arg0.Bar:setZRot(180)
	f7_arg0.Text:setTopBottom(0.5, 0.5, -66.5, -51.5)
	f7_arg0.Text:setAlpha(1)
	f7_arg0.Text:setText(LocalizeToUpperString(@"aar/win"))
end
CoD.AARWinLoseHistory.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			f8_arg0.Bar:completeAnimation()
			f8_arg0.Bar:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Bar)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						f11_arg0:beginAnimation(500)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f10_arg0:beginAnimation(1000)
					f10_arg0:setAlpha(0.5)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f8_arg0.BarAdd:beginAnimation(1000)
				f8_arg0.BarAdd:setAlpha(0.9)
				f8_arg0.BarAdd:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.BarAdd:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.BarAdd:completeAnimation()
			f8_arg0.BarAdd:setAlpha(0.5)
			f8_local0(f8_arg0.BarAdd)
			local f8_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						f14_arg0:beginAnimation(500)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f13_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f13_arg0:setAlpha(0.9)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f8_arg0.TextAdd:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f8_arg0.TextAdd:setAlpha(1)
				f8_arg0.TextAdd:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.TextAdd:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f8_arg0.TextAdd:completeAnimation()
			f8_arg0.TextAdd:setAlpha(0.9)
			f8_local1(f8_arg0.TextAdd)
			f8_arg0.InValidNormal:completeAnimation()
			f8_arg0.InValidNormal:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.InValidNormal)
			f8_arg0.InValidAdd:completeAnimation()
			f8_arg0.InValidAdd:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.InValidAdd)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
	InValid = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(6)
			f15_arg0.Bar:completeAnimation()
			f15_arg0.Bar:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Bar)
			f15_arg0.BarAdd:completeAnimation()
			f15_arg0.BarAdd:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.BarAdd)
			f15_arg0.Text:completeAnimation()
			f15_arg0.Text:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Text)
			f15_arg0.TextAdd:completeAnimation()
			f15_arg0.TextAdd:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TextAdd)
			f15_arg0.InValidNormal:completeAnimation()
			f15_arg0.InValidNormal:setAlpha(0.05)
			f15_arg0.clipFinished(f15_arg0.InValidNormal)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(2000, Enum[@"luitween"][@"luitween_ease_both"])
					f17_arg0:setAlpha(0)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.InValidAdd:beginAnimation(2000, Enum[@"luitween"][@"luitween_ease_both"])
				f15_arg0.InValidAdd:setAlpha(0.05)
				f15_arg0.InValidAdd:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.InValidAdd:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.InValidAdd:completeAnimation()
			f15_arg0.InValidAdd:setAlpha(0)
			f15_local0(f15_arg0.InValidAdd)
			f15_arg0.nextClip = "DefaultClip"
		end,
	},
	Lose = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			f18_arg0.Bar:completeAnimation()
			f18_arg0.Bar:setTopBottom(0, 0, 116.5, 234.5)
			f18_arg0.Bar:setRGB(1, 1, 1)
			f18_arg0.Bar:setAlpha(0.2)
			f18_arg0.Bar:setZRot(0)
			f18_arg0.clipFinished(f18_arg0.Bar)
			f18_arg0.BarAdd:completeAnimation()
			f18_arg0.BarAdd:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.BarAdd)
			f18_arg0.Text:completeAnimation()
			f18_arg0.Text:setTopBottom(0.5, 0.5, 52.5, 67.5)
			f18_arg0.Text:setAlpha(0.3)
			f18_arg0.Text:setText(LocalizeToUpperString(@"aar/lose"))
			f18_arg0.clipFinished(f18_arg0.Text)
			f18_arg0.TextAdd:completeAnimation()
			f18_arg0.TextAdd:setTopBottom(0.5, 0.5, 52.5, 67.5)
			f18_arg0.TextAdd:setAlpha(0)
			f18_arg0.TextAdd:setText(LocalizeToUpperString(@"aar/lose"))
			f18_arg0.clipFinished(f18_arg0.TextAdd)
		end,
	},
	Draw = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.Bar:completeAnimation()
			f19_arg0.Bar:setTopBottom(0, 0, 116.5, 234.5)
			f19_arg0.Bar:setRGB(1, 1, 1)
			f19_arg0.Bar:setAlpha(0.2)
			f19_arg0.Bar:setZRot(0)
			f19_arg0.clipFinished(f19_arg0.Bar)
			f19_arg0.BarAdd:completeAnimation()
			f19_arg0.BarAdd:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.BarAdd)
			f19_arg0.Text:completeAnimation()
			f19_arg0.Text:setTopBottom(0.5, 0.5, 52.5, 67.5)
			f19_arg0.Text:setAlpha(0.3)
			f19_arg0.Text:setText(LocalizeToUpperString(@"aar/draw"))
			f19_arg0.clipFinished(f19_arg0.Text)
			f19_arg0.TextAdd:completeAnimation()
			f19_arg0.TextAdd:setTopBottom(0.5, 0.5, 52.5, 67.5)
			f19_arg0.TextAdd:setAlpha(0)
			f19_arg0.TextAdd:setText(LocalizeToUpperString(@"aar/draw"))
			f19_arg0.clipFinished(f19_arg0.TextAdd)
		end,
	},
}
