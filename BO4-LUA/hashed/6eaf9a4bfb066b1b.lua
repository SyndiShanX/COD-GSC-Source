CoD.vhud_gunship_recticle_40mm = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_recticle_40mm.__defaultWidth = 438
CoD.vhud_gunship_recticle_40mm.__defaultHeight = 436
CoD.vhud_gunship_recticle_40mm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_recticle_40mm)
	self.id = "vhud_gunship_recticle_40mm"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local reticle40InnerBox = LUI.UIImage.new(0, 0, 172, 266, 0, 0, 170, 264)
	reticle40InnerBox:setImage(RegisterImage(0xE40AD78B35D221C))
	reticle40InnerBox:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	reticle40InnerBox:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(reticle40InnerBox)
	self.reticle40InnerBox = reticle40InnerBox
	local reticle40InnerBox2 = LUI.UIImage.new(0, 0, 172, 266, 0, 0, 170, 264)
	reticle40InnerBox2:setRGB(0, 0, 0)
	reticle40InnerBox2:setAlpha(0.9)
	reticle40InnerBox2:setZRot(45)
	reticle40InnerBox2:setScale(0.4, 0.4)
	reticle40InnerBox2:setImage(RegisterImage(0xE40AD78B35D221C))
	reticle40InnerBox2:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	reticle40InnerBox2:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(reticle40InnerBox2)
	self.reticle40InnerBox2 = reticle40InnerBox2
	local reticle40InnerDots = LUI.UIImage.new(0, 0, 191, 247, 0, 0, 189, 245)
	reticle40InnerDots:setImage(RegisterImage(0x4F843497C67FAAF))
	reticle40InnerDots:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	reticle40InnerDots:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(reticle40InnerDots)
	self.reticle40InnerDots = reticle40InnerDots
	local reticle40InnerLineT = LUI.UIImage.new(0, 0, 137.5, 301.5, 0, 0, 81.5, 107.5)
	reticle40InnerLineT:setZRot(90)
	reticle40InnerLineT:setImage(RegisterImage(0x23F9307240E28C1))
	self:addElement(reticle40InnerLineT)
	self.reticle40InnerLineT = reticle40InnerLineT
	local reticle40InnerLineR = LUI.UIImage.new(0, 0, 259.5, 423.5, 0, 0, 204, 230)
	reticle40InnerLineR:setImage(RegisterImage(0x23F9307240E28C1))
	self:addElement(reticle40InnerLineR)
	self.reticle40InnerLineR = reticle40InnerLineR
	local reticle40InnerLineL = LUI.UIImage.new(0, 0, 15, 179, 0, 0, 204, 230)
	reticle40InnerLineL:setZRot(180)
	reticle40InnerLineL:setImage(RegisterImage(0x23F9307240E28C1))
	self:addElement(reticle40InnerLineL)
	self.reticle40InnerLineL = reticle40InnerLineL
	local reticle40InnerLineB = LUI.UIImage.new(0, 0, 137, 301, 0, 0, 326.5, 352.5)
	reticle40InnerLineB:setZRot(270)
	reticle40InnerLineB:setImage(RegisterImage(0x23F9307240E28C1))
	self:addElement(reticle40InnerLineB)
	self.reticle40InnerLineB = reticle40InnerLineB
	local reticle40outerBR = LUI.UIImage.new(0, 0, 409.5, 437.5, 0, 0, 408, 436)
	reticle40outerBR:setImage(RegisterImage(0x9D07F50408DB4FD))
	self:addElement(reticle40outerBR)
	self.reticle40outerBR = reticle40outerBR
	local reticle40outerBR2 = LUI.UIImage.new(0, 0, 3, 31, 0, 0, 0, 28)
	reticle40outerBR2:setZRot(180)
	reticle40outerBR2:setImage(RegisterImage(0x9D07F50408DB4FD))
	self:addElement(reticle40outerBR2)
	self.reticle40outerBR2 = reticle40outerBR2
	local reticle40outerBL = LUI.UIImage.new(0, 0, 0, 28, 0, 0, 408, 436)
	reticle40outerBL:setZRot(270)
	reticle40outerBL:setImage(RegisterImage(0x9D07F50408DB4FD))
	self:addElement(reticle40outerBL)
	self.reticle40outerBL = reticle40outerBL
	local reticle40outerTR = LUI.UIImage.new(0, 0, 409.5, 437.5, 0, 0, 0, 28)
	reticle40outerTR:setZRot(90)
	reticle40outerTR:setImage(RegisterImage(0x9D07F50408DB4FD))
	self:addElement(reticle40outerTR)
	self.reticle40outerTR = reticle40outerTR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_gunship_recticle_40mm.__resetProperties = function(f2_arg0)
	f2_arg0.reticle40InnerDots:completeAnimation()
	f2_arg0.reticle40InnerBox2:completeAnimation()
	f2_arg0.reticle40InnerBox:completeAnimation()
	f2_arg0.reticle40InnerDots:setAlpha(1)
	f2_arg0.reticle40InnerDots:setScale(1, 1)
	f2_arg0.reticle40InnerBox2:setAlpha(0.9)
	f2_arg0.reticle40InnerBox:setAlpha(1)
	f2_arg0.reticle40InnerBox:setScale(1, 1)
end
CoD.vhud_gunship_recticle_40mm.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(50)
					f5_arg0:setAlpha(1)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.reticle40InnerBox:beginAnimation(100)
				f3_arg0.reticle40InnerBox:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.reticle40InnerBox:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.reticle40InnerBox:completeAnimation()
			f3_arg0.reticle40InnerBox:setAlpha(0)
			f3_arg0.reticle40InnerBox:setScale(1.5, 1.5)
			f3_local0(f3_arg0.reticle40InnerBox)
			local f3_local1 = function(f6_arg0)
				f3_arg0.reticle40InnerBox2:beginAnimation(100)
				f3_arg0.reticle40InnerBox2:setAlpha(0.9)
				f3_arg0.reticle40InnerBox2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.reticle40InnerBox2:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.reticle40InnerBox2:completeAnimation()
			f3_arg0.reticle40InnerBox2:setAlpha(0)
			f3_local1(f3_arg0.reticle40InnerBox2)
			local f3_local2 = function(f7_arg0)
				f3_arg0.reticle40InnerDots:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.reticle40InnerDots:setAlpha(1)
				f3_arg0.reticle40InnerDots:setScale(1, 1)
				f3_arg0.reticle40InnerDots:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.reticle40InnerDots:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.reticle40InnerDots:completeAnimation()
			f3_arg0.reticle40InnerDots:setAlpha(0)
			f3_arg0.reticle40InnerDots:setScale(2, 2)
			f3_local2(f3_arg0.reticle40InnerDots)
		end,
	},
}
