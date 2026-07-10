require("x64:ea9b3d743198d18")
CoD[0x8482E5A4D7D79F3] = InheritFrom(LUI.UIElement)
CoD[0x8482E5A4D7D79F3].__defaultWidth = 960
CoD[0x8482E5A4D7D79F3].__defaultHeight = 240
CoD[0x8482E5A4D7D79F3].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x8482E5A4D7D79F3])
	self.id = "CallingCards_Dark_Ops_Master"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	Background:setImage(RegisterImage(0xF22A188DCC284BD))
	self:addElement(Background)
	self.Background = Background
	local dragon01 = CoD.CallingCards_Asset_dragon.new(f1_arg0, f1_arg1, 0, 0, 171, 395, 0, 0, -54, 154)
	dragon01:setScale(0.8, 0.8)
	self:addElement(dragon01)
	self.dragon01 = dragon01
	local pillar = LUI.UIImage.new(0, 0, 25, 312, 0, 0, -34, 243)
	pillar:setImage(RegisterImage(0x6DD750FA7162F43))
	self:addElement(pillar)
	self.pillar = pillar
	local soldier = LUI.UIImage.new(0, 0, 502, 915, 0, 0, 0, 240)
	soldier:setImage(RegisterImage(0x3A1A67DA8F5A967))
	self:addElement(soldier)
	self.soldier = soldier
	local soldierGun = LUI.UIImage.new(0, 0, 545, 960, 0, 0, 0, 240)
	soldierGun:setImage(RegisterImage(0x39FFDB6B3794DC2))
	self:addElement(soldierGun)
	self.soldierGun = soldierGun
	local soldierGlow = LUI.UIImage.new(0, 0, 502, 916, 0, 0, 0, 240)
	soldierGlow:setImage(RegisterImage(0x11E4373241FF189))
	soldierGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(soldierGlow)
	self.soldierGlow = soldierGlow
	local dragon02 = LUI.UIImage.new(0, 0, 395, 456, 0, 0, 125.5, 173.5)
	dragon02:setImage(RegisterImage(0x76C75C966E92FA7))
	self:addElement(dragon02)
	self.dragon02 = dragon02
	local firespot = LUI.UIImage.new(0, 0, 68.5, 186.5, 0, 0, 122.5, 240.5)
	firespot:setImage(RegisterImage(0xDD88A92D094B9B0))
	firespot:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	firespot:setShaderVector(0, 0, 3, 0, 0)
	firespot:setShaderVector(1, 6, 0, 0, 0)
	self:addElement(firespot)
	self.firespot = firespot
	local firespot2 = LUI.UIImage.new(0, 0, 473, 576, 0, 0, -66, 37)
	firespot2:setImage(RegisterImage(0xDD88A92D094B9B0))
	firespot2:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	firespot2:setShaderVector(0, 0, 3, 0, 0)
	firespot2:setShaderVector(1, 6, 0, 0, 0)
	self:addElement(firespot2)
	self.firespot2 = firespot2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x8482E5A4D7D79F3].__resetProperties = function(f2_arg0)
	f2_arg0.dragon01:completeAnimation()
	f2_arg0.soldierGlow:completeAnimation()
	f2_arg0.dragon02:completeAnimation()
	f2_arg0.soldierGun:completeAnimation()
	f2_arg0.soldierGlow:setTopBottom(0, 0, 0, 240)
	f2_arg0.soldierGlow:setAlpha(1)
	f2_arg0.dragon02:setTopBottom(0, 0, 125.5, 173.5)
	f2_arg0.soldierGun:setTopBottom(0, 0, 0, 240)
end
CoD[0x8482E5A4D7D79F3].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			f3_arg0.dragon01:completeAnimation()
			f3_arg0.dragon01:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.dragon01)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									f9_arg0:beginAnimation(500)
									f9_arg0:setTopBottom(0, 0, 56, 239)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f8_arg0:beginAnimation(500)
								f8_arg0:setTopBottom(0, 0, 62, 245)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(500)
							f7_arg0:setTopBottom(0, 0, 56, 239)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(500)
						f6_arg0:setTopBottom(0, 0, 62, 245)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500)
					f5_arg0:setTopBottom(0, 0, 56, 239)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.soldierGun:beginAnimation(500)
				f3_arg0.soldierGun:setTopBottom(0, 0, 62, 245)
				f3_arg0.soldierGun:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.soldierGun:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.soldierGun:completeAnimation()
			f3_arg0.soldierGun:setTopBottom(0, 0, 56, 239)
			f3_local0(f3_arg0.soldierGun)
			local f3_local1 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						local f12_local0 = function(f13_arg0)
							f13_arg0:beginAnimation(29)
							f13_arg0:setAlpha(0)
							f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f12_arg0:beginAnimation(960)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
					end
					f11_arg0:beginAnimation(39)
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f3_arg0.soldierGlow:beginAnimation(1000)
				f3_arg0.soldierGlow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.soldierGlow:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.soldierGlow:completeAnimation()
			f3_arg0.soldierGlow:setTopBottom(0, 0, 0, 240)
			f3_arg0.soldierGlow:setAlpha(0)
			f3_local1(f3_arg0.soldierGlow)
			local f3_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							local f17_local0 = function(f18_arg0)
								local f18_local0 = function(f19_arg0)
									f19_arg0:beginAnimation(500)
									f19_arg0:setTopBottom(0, 0, 78.5, 126.5)
									f19_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f18_arg0:beginAnimation(500)
								f18_arg0:setTopBottom(0, 0, 73.5, 121.5)
								f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
							end
							f17_arg0:beginAnimation(500)
							f17_arg0:setTopBottom(0, 0, 78.5, 126.5)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
						end
						f16_arg0:beginAnimation(500)
						f16_arg0:setTopBottom(0, 0, 73.5, 121.5)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(500)
					f15_arg0:setTopBottom(0, 0, 78.5, 126.5)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f3_arg0.dragon02:beginAnimation(500)
				f3_arg0.dragon02:setTopBottom(0, 0, 73.5, 121.5)
				f3_arg0.dragon02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragon02:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f3_arg0.dragon02:completeAnimation()
			f3_arg0.dragon02:setTopBottom(0, 0, 78.5, 126.5)
			f3_local2(f3_arg0.dragon02)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0x8482E5A4D7D79F3].__onClose = function(f20_arg0)
	f20_arg0.dragon01:close()
end
