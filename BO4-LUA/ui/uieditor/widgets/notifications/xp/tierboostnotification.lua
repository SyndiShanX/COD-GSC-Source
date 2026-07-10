require("x64:683120446682173")
CoD.TierBoostNotification = InheritFrom(LUI.UIElement)
CoD.TierBoostNotification.__defaultWidth = 72
CoD.TierBoostNotification.__defaultHeight = 72
CoD.TierBoostNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TierBoostNotification)
	self.id = "TierBoostNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TierBoost = CoD.Notification2xpBlackMarketReward.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(TierBoost)
	self.TierBoost = TierBoost
	local Glow2 = LUI.UIImage.new(0, 0, 1, 71, 0, 0, -25.5, 102.5)
	Glow2:setRGB(0.8, 0.58, 0.12)
	Glow2:setAlpha(0.15)
	Glow2:setScale(2, 2)
	Glow2:setImage(RegisterImage(@"uie_ui_hud_notifications_glow"))
	Glow2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Glow2:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Glow2)
	self.Glow2 = Glow2
	local Glow = LUI.UIImage.new(0, 0, 1, 71, 0, 0, -25.5, 102.5)
	Glow:setRGB(0.8, 0.58, 0.12)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_ui_hud_notifications_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Glow:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Glow)
	self.Glow = Glow
	local SoundTierBoostAAR = LUI.UIElement.new(0, 0, 244.5, 276.5, 0, 0, 15, 47)
	SoundTierBoostAAR:setPlaySoundDirect(true)
	self:addElement(SoundTierBoostAAR)
	self.SoundTierBoostAAR = SoundTierBoostAAR
	self:mergeStateConditions({
		{
			stateName = "TierBoost",
			condition = function(menu, element, event)
				return IsTierBoostActive(f1_arg1)
			end,
		},
		{
			stateName = "TierBoostAAR",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TierBoostNotification.__resetProperties = function(f4_arg0)
	f4_arg0.TierBoost:completeAnimation()
	f4_arg0.Glow2:completeAnimation()
	f4_arg0.Glow:completeAnimation()
	f4_arg0.SoundTierBoostAAR:completeAnimation()
	f4_arg0.TierBoost:setAlpha(1)
	f4_arg0.TierBoost:setScale(1, 1)
	f4_arg0.Glow2:setAlpha(0.15)
	f4_arg0.Glow:setAlpha(0)
	f4_arg0.Glow:setScale(1, 1)
	f4_arg0.Glow:setShaderVector(0, 1.5, 0, 0, 0)
end
CoD.TierBoostNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.TierBoost:completeAnimation()
			f5_arg0.TierBoost:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TierBoost)
			f5_arg0.Glow2:completeAnimation()
			f5_arg0.Glow2:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Glow2)
		end,
	},
	TierBoost = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.TierBoost:completeAnimation()
			f6_arg0.TierBoost:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.TierBoost)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							f10_arg0:beginAnimation(2010)
							f10_arg0:setScale(2, 2)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
						end
						f9_arg0:beginAnimation(250)
						f9_arg0:setScale(4, 4)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(2240)
					f8_arg0:setAlpha(0)
					f8_arg0:setScale(3.83, 3.83)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f6_arg0.Glow:beginAnimation(510)
				f6_arg0.Glow:setAlpha(0.6)
				f6_arg0.Glow:setScale(2.34, 2.34)
				f6_arg0.Glow:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Glow:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.Glow:completeAnimation()
			f6_arg0.Glow:setAlpha(0)
			f6_arg0.Glow:setScale(2, 2)
			f6_local0(f6_arg0.Glow)
			f6_arg0.nextClip = "DefaultClip"
		end,
	},
	TierBoostAAR = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(110, Enum[@"luitween"][@"luitween_ease_out"])
					f13_arg0:setScale(1, 1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.TierBoost:beginAnimation(220, Enum[@"luitween"][@"luitween_ease_out"])
				f11_arg0.TierBoost:setAlpha(1)
				f11_arg0.TierBoost:setScale(0.2, 0.2)
				f11_arg0.TierBoost:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.TierBoost:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.TierBoost:completeAnimation()
			f11_arg0.TierBoost:setAlpha(0)
			f11_arg0.TierBoost:setScale(7, 7)
			f11_local0(f11_arg0.TierBoost)
			f11_arg0.Glow2:completeAnimation()
			f11_arg0.Glow2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Glow2)
			local f11_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_out"])
						f16_arg0:setAlpha(0)
						f16_arg0:setScale(7, 7)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_out"])
					f15_arg0:setAlpha(1)
					f15_arg0:setScale(2.71, 2.71)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f11_arg0.Glow:beginAnimation(280)
				f11_arg0.Glow:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Glow:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f11_arg0.Glow:completeAnimation()
			f11_arg0.Glow:setAlpha(0)
			f11_arg0.Glow:setScale(1, 1)
			f11_arg0.Glow:setShaderVector(0, 2, 0, 0, 0)
			f11_local1(f11_arg0.Glow)
			f11_arg0.SoundTierBoostAAR:beginAnimation(200)
			f11_arg0.SoundTierBoostAAR:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.SoundTierBoostAAR:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_mtx_item_purchased_stamp", f11_arg1)
				f11_arg0.clipFinished(element, event)
			end)
		end,
	},
}
CoD.TierBoostNotification.__onClose = function(f18_arg0)
	f18_arg0.TierBoost:close()
end
