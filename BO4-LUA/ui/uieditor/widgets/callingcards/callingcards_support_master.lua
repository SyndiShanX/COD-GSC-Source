CoD.callingcards_support_master = InheritFrom(LUI.UIElement)
CoD.callingcards_support_master.__defaultWidth = 960
CoD.callingcards_support_master.__defaultHeight = 240
CoD.callingcards_support_master.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_support_master)
	self.id = "CallingCards_Support_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	CardIcon:setImage(RegisterImage("uie_t7_icon_callingcard_temp2_lrg"))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage("uie_dino_background"))
	self:addElement(bg)
	self.bg = bg
	local ufo2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	ufo2:setImage(RegisterImage("uie_ufo"))
	self:addElement(ufo2)
	self.ufo2 = ufo2
	local LightSpin = LUI.UIImage.new(0, 0, 153, 979, 0, 0, -423, 403)
	LightSpin:setImage(RegisterImage("uie_light_burst"))
	LightSpin:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(LightSpin)
	self.LightSpin = LightSpin
	local BgHoled = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BgHoled:setImage(RegisterImage("uie_dino_background_holed"))
	self:addElement(BgHoled)
	self.BgHoled = BgHoled
	local ufo = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	ufo:setImage(RegisterImage("uie_ufo"))
	self:addElement(ufo)
	self.ufo = ufo
	local rockFloat = LUI.UIImage.new(0, 0, 178, 887, 0, 0, -105.5, 426.5)
	rockFloat:setAlpha(0.5)
	rockFloat:setImage(RegisterImage("uie_rock_float"))
	rockFloat:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	rockFloat:setShaderVector(0, 1, 1, 0, 0)
	rockFloat:setShaderVector(1, 0, 0.05, 0, 0)
	self:addElement(rockFloat)
	self.rockFloat = rockFloat
	local rockFloat2 = LUI.UIImage.new(0, 0, 106.5, 755.5, 0, 0, -3.5, 483.5)
	rockFloat2:setAlpha(0.7)
	rockFloat2:setImage(RegisterImage("uie_rock_float"))
	rockFloat2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	rockFloat2:setShaderVector(0, 1, 1, 0, 0)
	rockFloat2:setShaderVector(1, 0, 0.05, 0, 0)
	self:addElement(rockFloat2)
	self.rockFloat2 = rockFloat2
	local dinos = LUI.UIImage.new(0, 0, 69, 1029, 0, 0, 0, 240)
	dinos:setImage(RegisterImage("uie_dino"))
	dinos:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	dinos:setShaderVector(0, 0, 3, 0, 0)
	dinos:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(dinos)
	self.dinos = dinos
	local lightSource = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lightSource:setAlpha(0.2)
	lightSource:setImage(RegisterImage("uie_light_blur"))
	lightSource:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(lightSource)
	self.lightSource = lightSource
	local dinoStill = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	dinoStill:setImage(RegisterImage("uie_dino_still"))
	self:addElement(dinoStill)
	self.dinoStill = dinoStill
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage("uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_support_master.__resetProperties = function(f2_arg0)
	f2_arg0.LightSpin:completeAnimation()
	f2_arg0.dinos:completeAnimation()
	f2_arg0.dinoStill:completeAnimation()
	f2_arg0.LightSpin:setLeftRight(0, 0, 153, 979)
	f2_arg0.LightSpin:setTopBottom(0, 0, -423, 403)
	f2_arg0.LightSpin:setZRot(0)
	f2_arg0.dinos:setLeftRight(0, 0, 69, 1029)
	f2_arg0.dinos:setAlpha(1)
	f2_arg0.dinoStill:setAlpha(1)
end
CoD.callingcards_support_master.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				f3_arg0.LightSpin:beginAnimation(3810)
				f3_arg0.LightSpin:setZRot(125)
				f3_arg0.LightSpin:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.LightSpin:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.LightSpin:completeAnimation()
			f3_arg0.LightSpin:setLeftRight(0, 0, 134, 960)
			f3_arg0.LightSpin:setTopBottom(0, 0, -413, 413)
			f3_arg0.LightSpin:setZRot(90)
			f3_local0(f3_arg0.LightSpin)
			local f3_local1 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							local f8_local0 = function(f9_arg0)
								local f9_local0 = function(f10_arg0)
									f10_arg0:beginAnimation(500)
									f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f9_arg0:beginAnimation(319)
								f9_arg0:setAlpha(1)
								f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
							end
							f8_arg0:beginAnimation(500)
							f8_arg0:setAlpha(0)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
						end
						f7_arg0:beginAnimation(1579)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(500)
					f6_arg0:setAlpha(0.8)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f3_arg0.dinos:beginAnimation(410)
				f3_arg0.dinos:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dinos:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f3_arg0.dinos:completeAnimation()
			f3_arg0.dinos:setLeftRight(0, 0, 67, 1027)
			f3_arg0.dinos:setAlpha(1)
			f3_local1(f3_arg0.dinos)
			local f3_local2 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							f14_arg0:beginAnimation(240)
							f14_arg0:setAlpha(0.5)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f13_arg0:beginAnimation(2560)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(90)
					f12_arg0:setAlpha(0.8)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f3_arg0.dinoStill:beginAnimation(420)
				f3_arg0.dinoStill:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dinoStill:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.dinoStill:completeAnimation()
			f3_arg0.dinoStill:setAlpha(0.5)
			f3_local2(f3_arg0.dinoStill)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
