CoD.PC_Korea_Event_Daily_Tier = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_Daily_Tier.__defaultWidth = 40
CoD.PC_Korea_Event_Daily_Tier.__defaultHeight = 40
CoD.PC_Korea_Event_Daily_Tier.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Event_Daily_Tier)
	self.id = "PC_Korea_Event_Daily_Tier"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TokenEmpty = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -15, 15)
	TokenEmpty:setAlpha(0.7)
	TokenEmpty:setImage(RegisterImage(@"uie_pc_igrevent_progression_tier"))
	self:addElement(TokenEmpty)
	self.TokenEmpty = TokenEmpty
	local TokenFull = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -15, 15)
	TokenFull:setAlpha(0)
	TokenFull:setImage(RegisterImage(@"ui_icon_blackmarket_tier_token_small"))
	TokenFull:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_glint"))
	TokenFull:setShaderVector(0, 0, 0, 0, 0)
	TokenFull:setShaderVector(1, -46.8, 0, 0, 0)
	self:addElement(TokenFull)
	self.TokenFull = TokenFull
	local TokenRewardSound = LUI.UIElement.new(0, 0, 5, 37, 0, 0, 44.5, 76.5)
	self:addElement(TokenRewardSound)
	self.TokenRewardSound = TokenRewardSound
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Korea_Event_Daily_Tier.__resetProperties = function(f2_arg0)
	f2_arg0.TokenFull:completeAnimation()
	f2_arg0.TokenRewardSound:completeAnimation()
	f2_arg0.TokenFull:setAlpha(0)
	f2_arg0.TokenFull:setScale(1, 1)
	f2_arg0.TokenFull:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_glint"))
	f2_arg0.TokenFull:setShaderVector(0, 0, 0, 0, 0)
	f2_arg0.TokenFull:setShaderVector(1, -46.8, 0, 0, 0)
	f2_arg0.TokenRewardSound:setPlaySoundDirect(false)
end
CoD.PC_Korea_Event_Daily_Tier.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.TokenFull:completeAnimation()
			f3_arg0.TokenFull:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.TokenFull)
		end,
	},
	TokenReward = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							f8_arg0:beginAnimation(770)
							f8_arg0:setShaderVector(0, 1.2, 0, 0, 0)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
						end
						f7_arg0:beginAnimation(669)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(39)
					f6_arg0:setScale(1, 1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f5_arg0:beginAnimation(210)
				f5_arg0:setAlpha(1)
				f5_arg0:setScale(0.9, 0.9)
				f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.TokenFull:beginAnimation(1000)
			f4_arg0.TokenFull:setAlpha(0)
			f4_arg0.TokenFull:setScale(2, 2)
			f4_arg0.TokenFull:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_glint"))
			f4_arg0.TokenFull:setShaderVector(0, 0, 0, 0, 0)
			f4_arg0.TokenFull:setShaderVector(1, -46.8, 0, 0, 0)
			f4_arg0.TokenFull:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.TokenFull:registerEventHandler("transition_complete_keyframe", f4_local0)
			local f4_local1 = function(f9_arg0)
				f4_arg0.TokenRewardSound:beginAnimation(1000)
				f4_arg0.TokenRewardSound:setPlaySoundDirect(true)
				f4_arg0.TokenRewardSound:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.TokenRewardSound:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playSound("uin_igr_tokenreward", f4_arg1)
					f4_arg0.clipFinished(element, event)
				end)
			end
			f4_arg0.TokenRewardSound:completeAnimation()
			f4_arg0.TokenRewardSound:setPlaySoundDirect(false)
			f4_local1(f4_arg0.TokenRewardSound)
		end,
	},
	TokenReceived = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(960)
					f13_arg0:setShaderVector(0, 1.2, 0, 0, 0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.TokenFull:beginAnimation(3000)
				f11_arg0.TokenFull:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.TokenFull:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.TokenFull:completeAnimation()
			f11_arg0.TokenFull:setAlpha(1)
			f11_arg0.TokenFull:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_glint"))
			f11_arg0.TokenFull:setShaderVector(0, 0, 0, 0, 0)
			f11_arg0.TokenFull:setShaderVector(1, -46.8, 0, 0, 0)
			f11_local0(f11_arg0.TokenFull)
			f11_arg0.nextClip = "DefaultClip"
		end,
	},
}
