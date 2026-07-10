CoD[0x4AFF0067298BAB8] = InheritFrom(LUI.UIElement)
CoD[0x4AFF0067298BAB8].__defaultWidth = 960
CoD[0x4AFF0067298BAB8].__defaultHeight = 240
CoD[0x4AFF0067298BAB8].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x4AFF0067298BAB8])
	self.id = "CallingCards_Game_Victories"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CardIcon:setImage(RegisterImage(0x434A15996B65B48))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0xBA269997E6598E7))
	self:addElement(bg)
	self.bg = bg
	local subLeft = LUI.UIImage.new(0, 0, 7.5, 343.5, 0, 0, 8, 168)
	subLeft:setImage(RegisterImage(0xB26831F23B411F1))
	self:addElement(subLeft)
	self.subLeft = subLeft
	local subRight = LUI.UIImage.new(0, 0, 824, 960, 0, 0, 8, 128)
	subRight:setImage(RegisterImage(0x989B413A9BFC552))
	self:addElement(subRight)
	self.subRight = subRight
	local reflection = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 248)
	reflection:setAlpha(0.12)
	reflection:setImage(RegisterImage(0x52C891EBDF9C0E))
	reflection:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	reflection:setShaderVector(0, 1, 1, 0, 0)
	reflection:setShaderVector(1, 0.01, 0, 0, 0)
	self:addElement(reflection)
	self.reflection = reflection
	local kraken = LUI.UIImage.new(0, 0, 0, 964, 0, 0, 0, 240)
	kraken:setAlpha(0.5)
	kraken:setScale(1.02, 1.02)
	kraken:setImage(RegisterImage(0xC5AFD0403E0C769))
	kraken:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	kraken:setShaderVector(0, 1.27, 0, 0, 0)
	self:addElement(kraken)
	self.kraken = kraken
	local bubbles = LUI.UIImage.new(0, 0, 194.5, 239.5, 0, 0, 0, 240)
	bubbles:setImage(RegisterImage(0x355FCE59C482A5E))
	bubbles:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	bubbles:setShaderVector(0, 1, 1, 0, 0)
	bubbles:setShaderVector(1, 0, 0.05, 0, 0)
	self:addElement(bubbles)
	self.bubbles = bubbles
	local bubbles2 = LUI.UIImage.new(0, 0, 789, 834, 0, 0, -119, 121)
	bubbles2:setImage(RegisterImage(0x355FCE59C482A5E))
	bubbles2:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	bubbles2:setShaderVector(0, 1, 1, 0, 0)
	bubbles2:setShaderVector(1, 0, 0.05, 0, 0)
	self:addElement(bubbles2)
	self.bubbles2 = bubbles2
	local diverLeft = LUI.UIImage.new(0, 0, 7.5, 399.5, 0, 0, 74, 242)
	diverLeft:setAlpha(0.5)
	diverLeft:setImage(RegisterImage(0x5553161710958DF))
	diverLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	diverLeft:setShaderVector(0, 1.23, 0, 0, 0)
	self:addElement(diverLeft)
	self.diverLeft = diverLeft
	local diverRight = LUI.UIImage.new(0, 0, 741.5, 957.5, 0, 0, 68, 228)
	diverRight:setAlpha(0.5)
	diverRight:setImage(RegisterImage(0x35FABA1C9ED9D10))
	diverRight:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	diverRight:setShaderVector(0, 1.3, 0, 0, 0)
	self:addElement(diverRight)
	self.diverRight = diverRight
	local bubbles3 = LUI.UIImage.new(0, 0, 386.5, 490.5, 0, 0, -119, 436)
	bubbles3:setImage(RegisterImage(0x355FCE59C482A5E))
	bubbles3:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	bubbles3:setShaderVector(0, 1, 1, 0, 0)
	bubbles3:setShaderVector(1, 0, 0.05, 0, 0)
	self:addElement(bubbles3)
	self.bubbles3 = bubbles3
	local bubbles4 = LUI.UIImage.new(0, 0, 26.5, 130.5, 0, 0, -220, 335)
	bubbles4:setImage(RegisterImage(0x355FCE59C482A5E))
	bubbles4:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	bubbles4:setShaderVector(0, 1, 1, 0, 0)
	bubbles4:setShaderVector(1, 0, 0.05, 0, 0)
	self:addElement(bubbles4)
	self.bubbles4 = bubbles4
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x4AFF0067298BAB8].__resetProperties = function(f2_arg0)
	f2_arg0.kraken:completeAnimation()
	f2_arg0.subRight:completeAnimation()
	f2_arg0.diverLeft:completeAnimation()
	f2_arg0.diverRight:completeAnimation()
	f2_arg0.reflection:completeAnimation()
	f2_arg0.kraken:setTopBottom(0, 0, 0, 240)
	f2_arg0.subRight:setTopBottom(0, 0, 8, 128)
	f2_arg0.diverLeft:setTopBottom(0, 0, 74, 242)
	f2_arg0.diverRight:setTopBottom(0, 0, 68, 228)
	f2_arg0.reflection:setTopBottom(0, 0, 0, 248)
	f2_arg0.reflection:setAlpha(0.12)
end
CoD[0x4AFF0067298BAB8].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1010)
					f5_arg0:setTopBottom(0, 0, 8, 128)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.subRight:beginAnimation(990)
				f3_arg0.subRight:setTopBottom(0, 0, 12, 132)
				f3_arg0.subRight:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.subRight:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.subRight:completeAnimation()
			f3_arg0.subRight:setTopBottom(0, 0, 8, 128)
			f3_local0(f3_arg0.subRight)
			f3_arg0.reflection:completeAnimation()
			f3_arg0.reflection:setTopBottom(0, 0, 0, 248)
			f3_arg0.reflection:setAlpha(0.15)
			f3_arg0.clipFinished(f3_arg0.reflection)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1010)
					f7_arg0:setTopBottom(0, 0, 3, 243)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.kraken:beginAnimation(990)
				f3_arg0.kraken:setTopBottom(0, 0, -3, 237)
				f3_arg0.kraken:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.kraken:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.kraken:completeAnimation()
			f3_arg0.kraken:setTopBottom(0, 0, 3, 243)
			f3_local1(f3_arg0.kraken)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(1010)
					f9_arg0:setTopBottom(0, 0, 74, 242)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.diverLeft:beginAnimation(990)
				f3_arg0.diverLeft:setTopBottom(0, 0, 77, 245)
				f3_arg0.diverLeft:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.diverLeft:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.diverLeft:completeAnimation()
			f3_arg0.diverLeft:setTopBottom(0, 0, 74, 242)
			f3_local2(f3_arg0.diverLeft)
			local f3_local3 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(1010)
					f11_arg0:setTopBottom(0, 0, 68, 228)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.diverRight:beginAnimation(990)
				f3_arg0.diverRight:setTopBottom(0, 0, 57.5, 217.5)
				f3_arg0.diverRight:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.diverRight:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.diverRight:completeAnimation()
			f3_arg0.diverRight:setTopBottom(0, 0, 68, 228)
			f3_local3(f3_arg0.diverRight)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
