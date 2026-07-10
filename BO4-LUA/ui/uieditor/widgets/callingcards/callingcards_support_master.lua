CoD[0x3E15977AA24AE9] = InheritFrom(LUI.UIElement)
CoD[0x3E15977AA24AE9].__defaultWidth = 960
CoD[0x3E15977AA24AE9].__defaultHeight = 240
CoD[0x3E15977AA24AE9].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x3E15977AA24AE9])
	self.id = "CallingCards_Support_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	CardIcon:setImage(RegisterImage(0x434A15996B65B48))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0xFF7B22152862DEC))
	self:addElement(bg)
	self.bg = bg
	local ufo2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	ufo2:setImage(RegisterImage(0xFEEABCC6DCAF925))
	self:addElement(ufo2)
	self.ufo2 = ufo2
	local LightSpin = LUI.UIImage.new(0, 0, 153, 979, 0, 0, -423, 403)
	LightSpin:setImage(RegisterImage(0xCDE878DE89C8808))
	LightSpin:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(LightSpin)
	self.LightSpin = LightSpin
	local BgHoled = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BgHoled:setImage(RegisterImage(0x2D62BFD4083DA69))
	self:addElement(BgHoled)
	self.BgHoled = BgHoled
	local ufo = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	ufo:setImage(RegisterImage(0xFEEABCC6DCAF925))
	self:addElement(ufo)
	self.ufo = ufo
	local rockFloat = LUI.UIImage.new(0, 0, 178, 887, 0, 0, -105.5, 426.5)
	rockFloat:setAlpha(0.5)
	rockFloat:setImage(RegisterImage(0xDEF88942FAD1C47))
	rockFloat:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	rockFloat:setShaderVector(0, 1, 1, 0, 0)
	rockFloat:setShaderVector(1, 0, 0.05, 0, 0)
	self:addElement(rockFloat)
	self.rockFloat = rockFloat
	local rockFloat2 = LUI.UIImage.new(0, 0, 106.5, 755.5, 0, 0, -3.5, 483.5)
	rockFloat2:setAlpha(0.7)
	rockFloat2:setImage(RegisterImage(0xDEF88942FAD1C47))
	rockFloat2:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	rockFloat2:setShaderVector(0, 1, 1, 0, 0)
	rockFloat2:setShaderVector(1, 0, 0.05, 0, 0)
	self:addElement(rockFloat2)
	self.rockFloat2 = rockFloat2
	local dinos = LUI.UIImage.new(0, 0, 69, 1029, 0, 0, 0, 240)
	dinos:setImage(RegisterImage(0xC1101EC87C9C617))
	dinos:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	dinos:setShaderVector(0, 0, 3, 0, 0)
	dinos:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(dinos)
	self.dinos = dinos
	local lightSource = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lightSource:setAlpha(0.2)
	lightSource:setImage(RegisterImage(0xAF3A3B27E2F12D3))
	lightSource:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(lightSource)
	self.lightSource = lightSource
	local dinoStill = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	dinoStill:setImage(RegisterImage(0xC3ECF8A8BCBB9B2))
	self:addElement(dinoStill)
	self.dinoStill = dinoStill
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(0x7EEE1693E39382A))
	self:addElement(cropper)
	self.cropper = cropper
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x3E15977AA24AE9].__resetProperties = function(f2_arg0)
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
CoD[0x3E15977AA24AE9].__clipsPerState = {
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
