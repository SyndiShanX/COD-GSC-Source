CoD.CallingCards_Asset_dragon = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_dragon.__defaultWidth = 512
CoD.CallingCards_Asset_dragon.__defaultHeight = 512
CoD.CallingCards_Asset_dragon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_dragon)
	self.id = "CallingCards_Asset_dragon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fireGlow = LUI.UIImage.new(0, 0, -6, 122, 0, 0, 256, 349)
	fireGlow:setRGB(1, 0.44, 0)
	fireGlow:setImage(RegisterImage(@"uie_fire_glow"))
	fireGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	fireGlow:setShaderVector(0, 1.69, 0, 0, 0)
	self:addElement(fireGlow)
	self.fireGlow = fireGlow
	local dragonFlame = LUI.UIImage.new(0, 0, 10, 138, 0, 0, 208, 336)
	dragonFlame:setRGB(0.97, 0.8, 0.53)
	dragonFlame:setImage(RegisterImage(@"uie_dragon_flame"))
	dragonFlame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	dragonFlame:setShaderVector(0, 0, 3, 0, 0)
	dragonFlame:setShaderVector(1, 12, 0, 0, 0)
	self:addElement(dragonFlame)
	self.dragonFlame = dragonFlame
	local dragon01 = LUI.UIImage.new(0, 0, 114, 338, 0, 0, 12, 220)
	dragon01:setImage(RegisterImage(@"uie_dragon_01"))
	self:addElement(dragon01)
	self.dragon01 = dragon01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_dragon.__resetProperties = function(f2_arg0)
	f2_arg0.dragon01:completeAnimation()
	f2_arg0.dragonFlame:completeAnimation()
	f2_arg0.fireGlow:completeAnimation()
	f2_arg0.dragon01:setTopBottom(0, 0, 12, 220)
	f2_arg0.dragonFlame:setScale(1, 1)
	f2_arg0.fireGlow:setScale(1, 1)
end
CoD.CallingCards_Asset_dragon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(780)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(9)
						f6_arg0:setScale(0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(1200)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f4_arg0:beginAnimation(19)
				f4_arg0:setScale(1, 1)
				f4_arg0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.fireGlow:beginAnimation(990)
			f3_arg0.fireGlow:setScale(0, 0)
			f3_arg0.fireGlow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.fireGlow:registerEventHandler("transition_complete_keyframe", f3_local0)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(780)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(9)
						f10_arg0:setScale(0, 0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(1200)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f8_arg0:beginAnimation(19)
				f8_arg0:setScale(1, 1)
				f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.dragonFlame:beginAnimation(990)
			f3_arg0.dragonFlame:setScale(0, 0)
			f3_arg0.dragonFlame:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.dragonFlame:registerEventHandler("transition_complete_keyframe", f3_local1)
			local f3_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									f17_arg0:beginAnimation(500)
									f17_arg0:setTopBottom(0, 0, 0, 208)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f16_arg0:beginAnimation(500)
								f16_arg0:setTopBottom(0, 0, 5, 213)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(500)
							f15_arg0:setTopBottom(0, 0, 0, 208)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(500)
						f14_arg0:setTopBottom(0, 0, 5, 213)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(500)
					f13_arg0:setTopBottom(0, 0, 0, 208)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.dragon01:beginAnimation(500)
				f3_arg0.dragon01:setTopBottom(0, 0, 5, 213)
				f3_arg0.dragon01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragon01:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.dragon01:completeAnimation()
			f3_arg0.dragon01:setTopBottom(0, 0, 0, 208)
			f3_local2(f3_arg0.dragon01)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
