CoD.genericVHUDProgressBar = InheritFrom(LUI.UIElement)
CoD.genericVHUDProgressBar.__defaultWidth = 130
CoD.genericVHUDProgressBar.__defaultHeight = 39
CoD.genericVHUDProgressBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.genericVHUDProgressBar)
	self.id = "genericVHUDProgressBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local flashingText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 4.5, 19.5)
	flashingText:setAlpha(0)
	flashingText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_73C4EEC8614F780F"))
	flashingText:setTTF("ttmussels_demibold")
	flashingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	flashingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(flashingText)
	self.flashingText = flashingText
	local SignalText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 24)
	SignalText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_774F45BCDE2B3C58"))
	SignalText:setTTF("default")
	SignalText:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	SignalText:setShaderVector(0, 0, 1, 0, 0)
	SignalText:setShaderVector(1, 0, 0, 0, 0)
	SignalText:setShaderVector(2, 0, 0, 0, 0)
	SignalText:setShaderVector(3, 0, 0, 0, 0)
	SignalText:setShaderVector(4, 0, 0, 0, 0)
	SignalText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SignalText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SignalText)
	self.SignalText = SignalText
	local backing = LUI.UIImage.new(0, 0, 0, 130, 0, 0, 24, 39)
	backing:setRGB(0.17, 0.17, 0.17)
	self:addElement(backing)
	self.backing = backing
	local fill = LUI.UIImage.new(0, 1, 2, -2, 0, 0, 26, 37)
	fill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	fill:setShaderVector(0, 1, 0, 0, 0)
	fill:setShaderVector(1, 0, 0, 0, 0)
	fill:setShaderVector(2, 1, 0, 0, 0)
	fill:setShaderVector(3, 0, 0, 0, 0)
	fill:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(fill)
	self.fill = fill
	local rechargeMeter = LUI.UIImage.new(0, 1, 2, -2, 0, 0, 26, 37)
	rechargeMeter:setRGB(0.56, 0.56, 0.56)
	rechargeMeter:setAlpha(0)
	rechargeMeter:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	rechargeMeter:setShaderVector(0, 1, 0, 0, 0)
	rechargeMeter:setShaderVector(1, 0, 0, 0, 0)
	rechargeMeter:setShaderVector(2, 1, 0, 0, 0)
	rechargeMeter:setShaderVector(3, 0, 0, 0, 0)
	rechargeMeter:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(rechargeMeter)
	self.rechargeMeter = rechargeMeter
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "FlashText",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Recharging",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if IsSelfInState(self, "Hidden") then
			SetHeight(self, 0)
		else
			RestoreWidgetHeight(self)
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.genericVHUDProgressBar.__resetProperties = function(f6_arg0)
	f6_arg0.SignalText:completeAnimation()
	f6_arg0.backing:completeAnimation()
	f6_arg0.fill:completeAnimation()
	f6_arg0.flashingText:completeAnimation()
	f6_arg0.rechargeMeter:completeAnimation()
	f6_arg0.SignalText:setRGB(1, 1, 1)
	f6_arg0.SignalText:setAlpha(1)
	f6_arg0.backing:setAlpha(1)
	f6_arg0.fill:setAlpha(1)
	f6_arg0.flashingText:setLeftRight(0, 1, 0, 0)
	f6_arg0.flashingText:setTopBottom(0, 0, 4.5, 19.5)
	f6_arg0.flashingText:setAlpha(0)
	f6_arg0.flashingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	f6_arg0.rechargeMeter:setAlpha(0)
end
CoD.genericVHUDProgressBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.flashingText:completeAnimation()
			f8_arg0.flashingText:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.flashingText)
			f8_arg0.SignalText:completeAnimation()
			f8_arg0.SignalText:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.SignalText)
			f8_arg0.backing:completeAnimation()
			f8_arg0.backing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.backing)
			f8_arg0.fill:completeAnimation()
			f8_arg0.fill:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.fill)
		end,
	},
	FlashText = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(290)
						f12_arg0:setAlpha(0.3)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(399)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.flashingText:beginAnimation(300)
				f9_arg0.flashingText:setAlpha(1)
				f9_arg0.flashingText:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.flashingText:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.flashingText:completeAnimation()
			f9_arg0.flashingText:setLeftRight(0, 1, 0, 0)
			f9_arg0.flashingText:setTopBottom(0, 0, 22, 37)
			f9_arg0.flashingText:setAlpha(0.3)
			f9_arg0.flashingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
			f9_local0(f9_arg0.flashingText)
			f9_arg0.SignalText:completeAnimation()
			f9_arg0.SignalText:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.SignalText)
			f9_arg0.backing:completeAnimation()
			f9_arg0.backing:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.backing)
			f9_arg0.fill:completeAnimation()
			f9_arg0.fill:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.fill)
			f9_arg0.nextClip = "DefaultClip"
		end,
	},
	Recharging = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(290)
						f16_arg0:setAlpha(0.3)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(399)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f13_arg0.flashingText:beginAnimation(300)
				f13_arg0.flashingText:setAlpha(1)
				f13_arg0.flashingText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.flashingText:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.flashingText:completeAnimation()
			f13_arg0.flashingText:setLeftRight(0, 1, 0, 0)
			f13_arg0.flashingText:setTopBottom(0, 0, 4.5, 19.5)
			f13_arg0.flashingText:setAlpha(0.3)
			f13_arg0.flashingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f13_local0(f13_arg0.flashingText)
			f13_arg0.SignalText:completeAnimation()
			f13_arg0.SignalText:setRGB(0.56, 0.56, 0.56)
			f13_arg0.clipFinished(f13_arg0.SignalText)
			f13_arg0.fill:completeAnimation()
			f13_arg0.fill:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.fill)
			f13_arg0.rechargeMeter:completeAnimation()
			f13_arg0.rechargeMeter:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.rechargeMeter)
			f13_arg0.nextClip = "DefaultClip"
		end,
	},
}
