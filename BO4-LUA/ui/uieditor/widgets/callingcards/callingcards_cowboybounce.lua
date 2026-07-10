CoD.CallingCards_CowboyBounce = InheritFrom(LUI.UIElement)
CoD.CallingCards_CowboyBounce.__defaultWidth = 960
CoD.CallingCards_CowboyBounce.__defaultHeight = 240
CoD.CallingCards_CowboyBounce.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_CowboyBounce)
	self.id = "CallingCards_CowboyBounce"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local cowboy = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	cowboy:setImage(RegisterImage(0xFBA9530508945EC))
	self:addElement(cowboy)
	self.cowboy = cowboy
	local lightFX1 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lightFX1:setAlpha(0)
	lightFX1:setImage(RegisterImage(0xCD88B9F07075BDE))
	self:addElement(lightFX1)
	self.lightFX1 = lightFX1
	local lightFX2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lightFX2:setAlpha(0)
	lightFX2:setImage(RegisterImage(0xCD88A9F07075A2B))
	self:addElement(lightFX2)
	self.lightFX2 = lightFX2
	local bullet = LUI.UIImage.new(0, 0, 398, 614, 0, 0, 26, 90)
	bullet:setImage(RegisterImage(0xDC3C3D72C0643D7))
	bullet:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(bullet)
	self.bullet = bullet
	local bullet2 = LUI.UIImage.new(0, 0, 264, 480, 0, 0, 14, 78)
	bullet2:setAlpha(0)
	bullet2:setImage(RegisterImage(0xDC3C3D72C0643D7))
	bullet2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(bullet2)
	self.bullet2 = bullet2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_CowboyBounce.__resetProperties = function(f2_arg0)
	f2_arg0.cowboy:completeAnimation()
	f2_arg0.lightFX1:completeAnimation()
	f2_arg0.bullet:completeAnimation()
	f2_arg0.lightFX2:completeAnimation()
	f2_arg0.bullet2:completeAnimation()
	f2_arg0.cowboy:setAlpha(1)
	f2_arg0.lightFX1:setLeftRight(0, 0, 0, 960)
	f2_arg0.lightFX1:setAlpha(0)
	f2_arg0.bullet:setLeftRight(0, 0, 398, 614)
	f2_arg0.bullet:setTopBottom(0, 0, 26, 90)
	f2_arg0.bullet:setAlpha(1)
	f2_arg0.lightFX2:setLeftRight(0, 0, 0, 960)
	f2_arg0.lightFX2:setAlpha(0)
	f2_arg0.bullet2:setLeftRight(0, 0, 264, 480)
	f2_arg0.bullet2:setTopBottom(0, 0, 14, 78)
	f2_arg0.bullet2:setAlpha(0)
end
CoD.CallingCards_CowboyBounce.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			f3_arg0.cowboy:completeAnimation()
			f3_arg0.cowboy:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.cowboy)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(120)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(60)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.lightFX1:beginAnimation(60)
				f3_arg0.lightFX1:setAlpha(1)
				f3_arg0.lightFX1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lightFX1:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.lightFX1:completeAnimation()
			f3_arg0.lightFX1:setLeftRight(0, 0, 9, 969)
			f3_arg0.lightFX1:setAlpha(0)
			f3_local0(f3_arg0.lightFX1)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							f10_arg0:beginAnimation(19)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f9_arg0:beginAnimation(49)
						f9_arg0:setAlpha(1)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(49)
					f8_arg0:setAlpha(0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f7_arg0:beginAnimation(10)
				f7_arg0:setAlpha(1)
				f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.lightFX2:beginAnimation(130)
			f3_arg0.lightFX2:setLeftRight(0, 0, 10, 970)
			f3_arg0.lightFX2:setAlpha(0)
			f3_arg0.lightFX2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.lightFX2:registerEventHandler("transition_complete_keyframe", f3_local1)
			local f3_local2 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							local f14_local0 = function(f15_arg0)
								local f15_local0 = function(f16_arg0)
									f16_arg0:beginAnimation(139)
									f16_arg0:setLeftRight(0, 0, 55, 271)
									f16_arg0:setTopBottom(0, 0, 162, 226)
									f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f15_arg0:beginAnimation(9)
								f15_arg0:setLeftRight(0, 0, 236, 452)
								f15_arg0:setTopBottom(0, 0, 191, 255)
								f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
							end
							f14_arg0:beginAnimation(10)
							f14_arg0:setLeftRight(0, 0, 229, 445)
							f14_arg0:setTopBottom(0, 0, 165, 229)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
						end
						f13_arg0:beginAnimation(20)
						f13_arg0:setLeftRight(0, 0, 326, 542)
						f13_arg0:setTopBottom(0, 0, 135, 199)
						f13_arg0:setAlpha(0)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(30)
					f12_arg0:setLeftRight(0, 0, 341, 557)
					f12_arg0:setTopBottom(0, 0, 127, 191)
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f11_arg0:beginAnimation(10)
				f11_arg0:setLeftRight(0, 0, 480, 696)
				f11_arg0:setTopBottom(0, 0, 78, 142)
				f11_arg0:setAlpha(0)
				f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.bullet:beginAnimation(20)
			f3_arg0.bullet:setLeftRight(0, 0, 548, 764)
			f3_arg0.bullet:setTopBottom(0, 0, 50, 114)
			f3_arg0.bullet:setAlpha(1)
			f3_arg0.bullet:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.bullet:registerEventHandler("transition_complete_keyframe", f3_local2)
			local f3_local3 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						local f19_local0 = function(f20_arg0)
							f20_arg0:beginAnimation(30)
							f20_arg0:setLeftRight(0, 0, -57, 159)
							f20_arg0:setTopBottom(0, 0, 169, 233)
							f20_arg0:setAlpha(0)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f19_arg0:beginAnimation(29)
						f19_arg0:setLeftRight(0, 0, 137, 353)
						f19_arg0:setTopBottom(0, 0, 116, 180)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(10)
					f18_arg0:setLeftRight(0, 0, 207, 423)
					f18_arg0:setTopBottom(0, 0, 98, 162)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f17_arg0:beginAnimation(10)
				f17_arg0:setAlpha(1)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f3_arg0.bullet2:beginAnimation(160)
			f3_arg0.bullet2:setLeftRight(0, 0, 296, 512)
			f3_arg0.bullet2:setTopBottom(0, 0, 63, 127)
			f3_arg0.bullet2:setAlpha(0)
			f3_arg0.bullet2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.bullet2:registerEventHandler("transition_complete_keyframe", f3_local3)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
