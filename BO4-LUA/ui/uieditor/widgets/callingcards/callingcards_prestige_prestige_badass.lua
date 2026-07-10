CoD[@"hash_660D368575962A3"] = InheritFrom(LUI.UIElement)
CoD[@"hash_660D368575962A3"].__defaultWidth = 960
CoD[@"hash_660D368575962A3"].__defaultHeight = 240
CoD[@"hash_660D368575962A3"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_660D368575962A3"])
	self.id = "CallingCards_Prestige_Prestige_Badass"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_prestige_prestige_badass_background"))
	bg:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	bg:setShaderVector(0, 1, 1, 0, 0)
	bg:setShaderVector(1, 0, 0.04, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local wings = LUI.UIImage.new(0, 0, 402, 962, 0, 0, 0, 240)
	wings:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_prestige_prestige_badass_wings"))
	self:addElement(wings)
	self.wings = wings
	local body = LUI.UIImage.new(0, 0, 550, 846, 0, 0, 58, 242)
	body:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_prestige_prestige_badass_body"))
	self:addElement(body)
	self.body = body
	local skull = LUI.UIImage.new(0, 0, 393, 489, 0, 0, 144, 240)
	skull:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_prestige_prestige_badass_skull"))
	self:addElement(skull)
	self.skull = skull
	local headOpen = LUI.UIImage.new(0, 0, 538, 714, 0, 0, 0, 160)
	headOpen:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_prestige_prestige_badass_mouth_open"))
	self:addElement(headOpen)
	self.headOpen = headOpen
	local bodyGlow = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bodyGlow:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_prestige_prestige_badass_body_glow"))
	self:addElement(bodyGlow)
	self.bodyGlow = bodyGlow
	local headClosed = LUI.UIImage.new(0, 0, 538, 714, 0, 0, -4, 132)
	headClosed:setScale(1.05, 1.05)
	headClosed:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_prestige_prestige_badass_mouth_closed"))
	self:addElement(headClosed)
	self.headClosed = headClosed
	local mouthBlast = LUI.UIImage.new(0, 0, 0, 648, 0, 0, 16.5, 256.5)
	mouthBlast:setImage(RegisterImage(@"uie_ui_icon_callingcards_mp_prestige_prestige_badass_blast_glow"))
	mouthBlast:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	mouthBlast:setShaderVector(0, 0, 3, 0, 0)
	mouthBlast:setShaderVector(1, 18, 0, 0, 0)
	self:addElement(mouthBlast)
	self.mouthBlast = mouthBlast
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
CoD[@"hash_660D368575962A3"].__resetProperties = function(f2_arg0)
	f2_arg0.wings:completeAnimation()
	f2_arg0.skull:completeAnimation()
	f2_arg0.headClosed:completeAnimation()
	f2_arg0.cropper:completeAnimation()
	f2_arg0.mouthBlast:completeAnimation()
	f2_arg0.bodyGlow:completeAnimation()
	f2_arg0.headOpen:completeAnimation()
	f2_arg0.wings:setAlpha(1)
	f2_arg0.wings:setScale(1, 1)
	f2_arg0.skull:setTopBottom(0, 0, 144, 240)
	f2_arg0.headClosed:setAlpha(1)
	f2_arg0.cropper:setAlpha(0)
	f2_arg0.mouthBlast:setAlpha(1)
	f2_arg0.bodyGlow:setAlpha(1)
	f2_arg0.headOpen:setAlpha(1)
end
CoD[@"hash_660D368575962A3"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(7)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1940)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.wings:beginAnimation(1060)
				f3_arg0.wings:setScale(1.04, 1)
				f3_arg0.wings:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.wings:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.wings:completeAnimation()
			f3_arg0.wings:setAlpha(1)
			f3_arg0.wings:setScale(1, 1)
			f3_local0(f3_arg0.wings)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1500)
					f7_arg0:setTopBottom(0, 0, 144, 240)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.skull:beginAnimation(1500)
				f3_arg0.skull:setTopBottom(0, 0, 148, 244)
				f3_arg0.skull:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.skull:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.skull:completeAnimation()
			f3_arg0.skull:setTopBottom(0, 0, 144, 240)
			f3_local1(f3_arg0.skull)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(9)
						f10_arg0:setAlpha(0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f9_arg0:beginAnimation(1390)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f8_arg0:beginAnimation(9)
				f8_arg0:setAlpha(1)
				f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.headOpen:beginAnimation(1590)
			f3_arg0.headOpen:setAlpha(0)
			f3_arg0.headOpen:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.headOpen:registerEventHandler("transition_complete_keyframe", f3_local2)
			local f3_local3 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						f13_arg0:beginAnimation(9)
						f13_arg0:setAlpha(0)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f12_arg0:beginAnimation(1390)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f11_arg0:beginAnimation(9)
				f11_arg0:setAlpha(1)
				f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.bodyGlow:beginAnimation(1590)
			f3_arg0.bodyGlow:setAlpha(0)
			f3_arg0.bodyGlow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.bodyGlow:registerEventHandler("transition_complete_keyframe", f3_local3)
			local f3_local4 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							f17_arg0:beginAnimation(9)
							f17_arg0:setAlpha(1)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f16_arg0:beginAnimation(1390)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(9)
					f15_arg0:setAlpha(0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f3_arg0.headClosed:beginAnimation(1590)
				f3_arg0.headClosed:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.headClosed:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f3_arg0.headClosed:completeAnimation()
			f3_arg0.headClosed:setAlpha(1)
			f3_local4(f3_arg0.headClosed)
			local f3_local5 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						f20_arg0:beginAnimation(9)
						f20_arg0:setAlpha(0)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f19_arg0:beginAnimation(1390)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f18_arg0:beginAnimation(9)
				f18_arg0:setAlpha(1)
				f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f3_arg0.mouthBlast:beginAnimation(1590)
			f3_arg0.mouthBlast:setAlpha(0)
			f3_arg0.mouthBlast:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.mouthBlast:registerEventHandler("transition_complete_keyframe", f3_local5)
			f3_arg0.cropper:beginAnimation(1130)
			f3_arg0.cropper:setAlpha(0)
			f3_arg0.cropper:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.cropper:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
