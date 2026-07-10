CoD[@"hash_6C38A19E12618D51"] = InheritFrom(LUI.UIElement)
CoD[@"hash_6C38A19E12618D51"].__defaultWidth = 960
CoD[@"hash_6C38A19E12618D51"].__defaultHeight = 240
CoD[@"hash_6C38A19E12618D51"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_6C38A19E12618D51"])
	self.id = "CallingCards_Operations_Precision_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"uie_ui_icon_callingcards_operations_precision_master_bg"))
	self:addElement(bg)
	self.bg = bg
	local skullsAnimated = LUI.UIImage.new(0, 0, -32, 992, 0, 0, 0, 240)
	skullsAnimated:setRGB(0.95, 0.76, 0.48)
	skullsAnimated:setImage(RegisterImage(@"uie_ui_icon_callingcards_operations_precision_master_animated_skulls"))
	skullsAnimated:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	skullsAnimated:setShaderVector(0, 0, 3, 0, 0)
	skullsAnimated:setShaderVector(1, 6, 0, 0, 0)
	self:addElement(skullsAnimated)
	self.skullsAnimated = skullsAnimated
	local girl = LUI.UIImage.new(0, 0, 527.5, 783.5, 0, 0, 0, 240)
	girl:setImage(RegisterImage(@"uie_ui_icon_callingcards_operations_precision_master_witch_animated"))
	girl:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	girl:setShaderVector(0, 0, 3, 0, 0)
	girl:setShaderVector(1, 6, 0, 0, 0)
	self:addElement(girl)
	self.girl = girl
	local hair = LUI.UIImage.new(0, 0, 613, 661, 0, 0, 25.5, 153.5)
	hair:setImage(RegisterImage(@"uie_ui_icon_callingcards_operations_precision_master_hair"))
	self:addElement(hair)
	self.hair = hair
	local swords = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	swords:setImage(RegisterImage(@"uie_ui_icon_callingcards_operations_precision_master_swords"))
	self:addElement(swords)
	self.swords = swords
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(@"uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_6C38A19E12618D51"].__resetProperties = function(f2_arg0)
	f2_arg0.hair:completeAnimation()
	f2_arg0.hair:setLeftRight(0, 0, 613, 661)
	f2_arg0.hair:setTopBottom(0, 0, 25.5, 153.5)
	f2_arg0.hair:setZRot(0)
	f2_arg0.hair:setScale(1, 1)
end
CoD[@"hash_6C38A19E12618D51"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									f9_arg0:beginAnimation(500)
									f9_arg0:setLeftRight(0, 0, 613, 661)
									f9_arg0:setZRot(0)
									f9_arg0:setScale(1, 1)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f8_arg0:beginAnimation(500)
								f8_arg0:setLeftRight(0, 0, 617, 665)
								f8_arg0:setZRot(3)
								f8_arg0:setScale(1.06, 1)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(500)
							f7_arg0:setLeftRight(0, 0, 613, 661)
							f7_arg0:setZRot(0)
							f7_arg0:setScale(1, 1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(500)
						f6_arg0:setLeftRight(0, 0, 617, 665)
						f6_arg0:setZRot(3)
						f6_arg0:setScale(1.06, 1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500)
					f5_arg0:setLeftRight(0, 0, 613, 661)
					f5_arg0:setZRot(0)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.hair:beginAnimation(500)
				f3_arg0.hair:setLeftRight(0, 0, 617, 665)
				f3_arg0.hair:setZRot(3)
				f3_arg0.hair:setScale(1.06, 1)
				f3_arg0.hair:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.hair:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.hair:completeAnimation()
			f3_arg0.hair:setLeftRight(0, 0, 613, 661)
			f3_arg0.hair:setTopBottom(0, 0, 23.5, 151.5)
			f3_arg0.hair:setZRot(0)
			f3_arg0.hair:setScale(1, 1)
			f3_local0(f3_arg0.hair)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
