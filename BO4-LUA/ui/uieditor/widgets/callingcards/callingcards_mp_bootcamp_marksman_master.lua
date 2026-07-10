CoD[0x16E262B518BD2C4] = InheritFrom(LUI.UIElement)
CoD[0x16E262B518BD2C4].__defaultWidth = 960
CoD[0x16E262B518BD2C4].__defaultHeight = 240
CoD[0x16E262B518BD2C4].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x16E262B518BD2C4])
	self.id = "CallingCards_MP_Bootcamp_Marksman_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0xC5FC36C791D72CE))
	bg:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	bg:setShaderVector(0, 1, 1, 0, 0)
	bg:setShaderVector(1, 0, 0.09, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local bandanna = LUI.UIImage.new(0, 0, 444, 708, 0, 0, -6, 82)
	bandanna:setImage(RegisterImage(0xFE7E57765D88B43))
	bandanna:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	bandanna:setShaderVector(0, 0, 3, 0, 0)
	bandanna:setShaderVector(1, 3, 0, 0, 0)
	self:addElement(bandanna)
	self.bandanna = bandanna
	local Chi = LUI.UIImage.new(0, 0, 496, 960, 0, 0, 0, 240)
	Chi:setAlpha(0.5)
	Chi:setImage(RegisterImage(0xB2062AC12676D94))
	Chi:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	Chi:setShaderVector(0, 0, 5, 0, 0)
	Chi:setShaderVector(1, 10, 0, 0, 0)
	self:addElement(Chi)
	self.Chi = Chi
	local dude = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	dude:setScale(1.03, 1.03)
	dude:setImage(RegisterImage(0x714FA4AAB8E8CF6))
	self:addElement(dude)
	self.dude = dude
	local hands = LUI.UIImage.new(0, 0, 619, 899, 0, 0, 38, 278)
	hands:setImage(RegisterImage(0x162E56257B9C118))
	self:addElement(hands)
	self.hands = hands
	local vienGlow = LUI.UIImage.new(0, 0, 544.5, 968.5, 0, 0, 120, 248)
	vienGlow:setScale(1.03, 1.03)
	vienGlow:setImage(RegisterImage(0xB6F29CCE90B1935))
	vienGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(vienGlow)
	self.vienGlow = vienGlow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x16E262B518BD2C4].__resetProperties = function(f2_arg0)
	f2_arg0.hands:completeAnimation()
	f2_arg0.dude:completeAnimation()
	f2_arg0.Chi:completeAnimation()
	f2_arg0.vienGlow:completeAnimation()
	f2_arg0.hands:setTopBottom(0, 0, 38, 278)
	f2_arg0.dude:setTopBottom(0, 0, 0, 240)
	f2_arg0.Chi:setLeftRight(0, 0, 496, 960)
	f2_arg0.Chi:setTopBottom(0, 0, 0, 240)
	f2_arg0.vienGlow:setAlpha(1)
end
CoD[0x16E262B518BD2C4].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1000)
					f5_arg0:setTopBottom(0, 0, 0, 240)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.Chi:beginAnimation(1000)
				f3_arg0.Chi:setTopBottom(0, 0, -4, 236)
				f3_arg0.Chi:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Chi:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Chi:completeAnimation()
			f3_arg0.Chi:setLeftRight(0, 0, 505, 969)
			f3_arg0.Chi:setTopBottom(0, 0, 0, 240)
			f3_local0(f3_arg0.Chi)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1000)
					f7_arg0:setTopBottom(0, 0, 0, 240)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.dude:beginAnimation(1000)
				f3_arg0.dude:setTopBottom(0, 0, -4, 236)
				f3_arg0.dude:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dude:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.dude:completeAnimation()
			f3_arg0.dude:setTopBottom(0, 0, 0, 240)
			f3_local1(f3_arg0.dude)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(500)
							f11_arg0:setTopBottom(0, 0, 38, 278)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(500)
						f10_arg0:setTopBottom(0, 0, 50, 290)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(510)
					f9_arg0:setTopBottom(0, 0, 38, 278)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.hands:beginAnimation(490)
				f3_arg0.hands:setTopBottom(0, 0, 50, 290)
				f3_arg0.hands:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.hands:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.hands:completeAnimation()
			f3_arg0.hands:setTopBottom(0, 0, 38, 278)
			f3_local2(f3_arg0.hands)
			local f3_local3 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(500)
					f13_arg0:setAlpha(0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f12_arg0:beginAnimation(510)
				f12_arg0:setAlpha(1)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.vienGlow:beginAnimation(490)
			f3_arg0.vienGlow:setAlpha(0)
			f3_arg0.vienGlow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.vienGlow:registerEventHandler("transition_complete_keyframe", f3_local3)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
