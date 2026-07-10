CoD[@"hash_FE0FBDC105843CB"] = InheritFrom(LUI.UIElement)
CoD[@"hash_FE0FBDC105843CB"].__defaultWidth = 960
CoD[@"hash_FE0FBDC105843CB"].__defaultHeight = 240
CoD[@"hash_FE0FBDC105843CB"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_FE0FBDC105843CB"])
	self.id = "CallingCards_Tour_Of_Duty_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CardIcon:setImage(RegisterImage(@"uie_t7_icon_callingcard_temp2_lrg"))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local sandyBg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	sandyBg:setImage(RegisterImage(@"uie_sandy_bg"))
	self:addElement(sandyBg)
	self.sandyBg = sandyBg
	local warrior = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	warrior:setImage(RegisterImage(@"uie_warrior"))
	self:addElement(warrior)
	self.warrior = warrior
	local dust = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	dust:setImage(RegisterImage(@"uie_dust_bloom"))
	dust:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	dust:setShaderVector(0, 1, 1, 0, 0)
	dust:setShaderVector(1, 0.75, 0, 0, 0)
	self:addElement(dust)
	self.dust = dust
	local dust2 = LUI.UIImage.new(0, 0, -966, 742, 0, 0, -287, 140)
	dust2:setScale(1.5, 1.5)
	dust2:setImage(RegisterImage(@"uie_dust_bloom"))
	dust2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	dust2:setShaderVector(0, 1, 1, 0, 0)
	dust2:setShaderVector(1, 0.75, 0, 0, 0)
	self:addElement(dust2)
	self.dust2 = dust2
	local bloodSpray2 = LUI.UIImage.new(0, 0, 188.5, 700.5, 0, 0, 70, 268)
	bloodSpray2:setRGB(0.62, 0.02, 0.02)
	bloodSpray2:setAlpha(0.98)
	bloodSpray2:setImage(RegisterImage(@"uie_blood_spray2"))
	bloodSpray2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	bloodSpray2:setShaderVector(0, 0, 5, 0, 0)
	bloodSpray2:setShaderVector(1, 10, 0, 0, 0)
	self:addElement(bloodSpray2)
	self.bloodSpray2 = bloodSpray2
	local torso = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	torso:setImage(RegisterImage(@"uie_torso"))
	self:addElement(torso)
	self.torso = torso
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(@"uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	local Image = LUI.UIImage.new(0, 0, 770, 850, 0, 0, -2, 94)
	Image:setAlpha(0.6)
	Image:setImage(RegisterImage(@"uie_sword_sheen"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	Image:setShaderVector(0, 0.94, 1.07, 0, 0)
	Image:setShaderVector(1, 0.04, 0.04, 0, 0)
	Image:setShaderVector(2, 0, 1, 0, 0)
	Image:setShaderVector(3, 0, 0, 0, 0)
	Image:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_FE0FBDC105843CB"].__resetProperties = function(f2_arg0)
	f2_arg0.warrior:completeAnimation()
	f2_arg0.Image:completeAnimation()
	f2_arg0.dust2:completeAnimation()
	f2_arg0.bloodSpray2:completeAnimation()
	f2_arg0.warrior:setTopBottom(0, 0, 0, 240)
	f2_arg0.warrior:setScale(1, 1)
	f2_arg0.Image:setLeftRight(0, 0, 770, 850)
	f2_arg0.Image:setTopBottom(0, 0, -2, 94)
	f2_arg0.Image:setAlpha(0.6)
	f2_arg0.Image:setShaderVector(0, 0.94, 1.07, 0, 0)
	f2_arg0.Image:setShaderVector(1, 0.04, 0.04, 0, 0)
	f2_arg0.Image:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.Image:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.Image:setShaderVector(4, 0, 0, 0, 0)
	f2_arg0.dust2:setLeftRight(0, 0, -966, 742)
	f2_arg0.dust2:setTopBottom(0, 0, -287, 140)
	f2_arg0.dust2:setScale(1.5, 1.5)
	f2_arg0.bloodSpray2:setAlpha(0.98)
end
CoD[@"hash_FE0FBDC105843CB"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										local f10_local0 = function(f11_arg0)
											f11_arg0:beginAnimation(500)
											f11_arg0:setTopBottom(0, 0, 0, 240)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f10_arg0:beginAnimation(500)
										f10_arg0:setTopBottom(0, 0, -5, 235)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(449)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(500)
								f8_arg0:setTopBottom(0, 0, 0, 240)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(500)
							f7_arg0:setTopBottom(0, 0, -5, 235)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(409)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500)
					f5_arg0:setTopBottom(0, 0, 0, 240)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.warrior:beginAnimation(500)
				f3_arg0.warrior:setTopBottom(0, 0, -5, 235)
				f3_arg0.warrior:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.warrior:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.warrior:completeAnimation()
			f3_arg0.warrior:setTopBottom(0, 0, 0, 240)
			f3_arg0.warrior:setScale(1.05, 1.05)
			f3_local0(f3_arg0.warrior)
			f3_arg0.dust2:completeAnimation()
			f3_arg0.dust2:setLeftRight(0, 0, -966, 742)
			f3_arg0.dust2:setTopBottom(0, 0, -287, 140)
			f3_arg0.dust2:setScale(1.5, 1.5)
			f3_arg0.clipFinished(f3_arg0.dust2)
			f3_arg0.bloodSpray2:completeAnimation()
			f3_arg0.bloodSpray2:setAlpha(0.95)
			f3_arg0.clipFinished(f3_arg0.bloodSpray2)
			local f3_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									local f17_local0 = function(f18_arg0)
										local f18_local0 = function(f19_arg0)
											f19_arg0:beginAnimation(869)
											f19_arg0:setShaderVector(0, -0.06, 0.03, 0, 0)
											f19_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f18_arg0:beginAnimation(9)
										f18_arg0:setShaderVector(0, 0.95, 1.07, 0, 0)
										f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
									end
									f17_arg0:beginAnimation(39)
									f17_arg0:setAlpha(1)
									f17_arg0:setShaderVector(0, 0.94, 1.06, 0, 0)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
								end
								f16_arg0:beginAnimation(580)
								f16_arg0:setShaderVector(0, 0.92, 1.04, 0, 0)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(1269)
							f15_arg0:setShaderVector(0, 0.62, 0.72, 0, 0)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(90)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(9)
					f13_arg0:setShaderVector(0, -0.06, 0.03, 0, 0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.Image:beginAnimation(990)
				f3_arg0.Image:setAlpha(0)
				f3_arg0.Image:setShaderVector(0, -0.05, 0.04, 0, 0)
				f3_arg0.Image:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.Image:completeAnimation()
			f3_arg0.Image:setLeftRight(0, 0, 790, 870)
			f3_arg0.Image:setTopBottom(0, 0, -6, 90)
			f3_arg0.Image:setAlpha(1)
			f3_arg0.Image:setShaderVector(0, 0.95, 1.07, 0, 0)
			f3_arg0.Image:setShaderVector(1, 0.04, 0.04, 0, 0)
			f3_arg0.Image:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.Image:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.Image:setShaderVector(4, 0, 0, 0, 0)
			f3_local1(f3_arg0.Image)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
