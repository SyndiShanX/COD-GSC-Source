require("x64:3817c701caa07b3")
CoD[0x16E4D2022024D11] = InheritFrom(LUI.UIElement)
CoD[0x16E4D2022024D11].__defaultWidth = 960
CoD[0x16E4D2022024D11].__defaultHeight = 240
CoD[0x16E4D2022024D11].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x16E4D2022024D11])
	self.id = "CallingCards_zm_DarkOps"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0xC7FA1C0EF867E7B))
	self:addElement(bg)
	self.bg = bg
	local candles = LUI.UIImage.new(0, 0, 656, 920, 0, 0, -7, 233)
	candles:setImage(RegisterImage(0xAA0B41381FB84B3))
	candles:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	candles:setShaderVector(0, 0, 3, 0, 0)
	candles:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(candles)
	self.candles = candles
	local ghostSpin = CoD.CallingCards_Asset_ghost_spin.new(f1_arg0, f1_arg1, 0, 0, 165.5, 885.5, 0, 0, -274.5, 445.5)
	ghostSpin:setRGB(1, 0.68, 0)
	ghostSpin:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ghostSpin)
	self.ghostSpin = ghostSpin
	local dust2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, -159, 240)
	dust2:setAlpha(0.3)
	dust2:setImage(RegisterImage(0xEA71666B3E5511F))
	dust2:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	dust2:setShaderVector(0, 1, 1, 0, 0)
	dust2:setShaderVector(1, 0.35, 0, 0, 0)
	self:addElement(dust2)
	self.dust2 = dust2
	local dust = LUI.UIImage.new(0, 0, 337, 992, 0, 0, -321, 240)
	dust:setRGB(1, 0.68, 0)
	dust:setImage(RegisterImage(0xEA71666B3E5511F))
	dust:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(dust)
	self.dust = dust
	local monks = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	monks:setImage(RegisterImage(0x4FBCFCF7A6DFDF5))
	self:addElement(monks)
	self.monks = monks
	local Lightshimmer = LUI.UIImage.new(0, 0, 344, 960, 0, 0, 0, 240)
	Lightshimmer:setAlpha(0.75)
	Lightshimmer:setImage(RegisterImage(0x85D28B3432378D9))
	Lightshimmer:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	Lightshimmer:setShaderVector(0, 0, 3, 0, 0)
	Lightshimmer:setShaderVector(1, 6, 0, 0, 0)
	self:addElement(Lightshimmer)
	self.Lightshimmer = Lightshimmer
	local paranormal = LUI.UIImage.new(0, 0, 430, 702, 0, 0, 26, 266)
	paranormal:setAlpha(0.5)
	paranormal:setImage(RegisterImage(0x2D34C8BFE864557))
	paranormal:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	paranormal:setShaderVector(0, 0, 5, 0, 0)
	paranormal:setShaderVector(1, 5, 0, 0, 0)
	self:addElement(paranormal)
	self.paranormal = paranormal
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(0x7EEE1693E39382A))
	self:addElement(cropper)
	self.cropper = cropper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x16E4D2022024D11].__resetProperties = function(f2_arg0)
	f2_arg0.ghostSpin:completeAnimation()
	f2_arg0.paranormal:completeAnimation()
	f2_arg0.ghostSpin:setAlpha(1)
	f2_arg0.paranormal:setAlpha(0.5)
end
CoD[0x16E4D2022024D11].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.ghostSpin:completeAnimation()
			f3_arg0.ghostSpin:setAlpha(0.7)
			f3_arg0.ghostSpin:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.ghostSpin)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(500)
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(500)
						f6_arg0:setAlpha(0.5)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500)
					f5_arg0:setAlpha(0.75)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f4_arg0:beginAnimation(500)
				f4_arg0:setAlpha(0.5)
				f4_arg0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.paranormal:beginAnimation(1000)
			f3_arg0.paranormal:setAlpha(0)
			f3_arg0.paranormal:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.paranormal:registerEventHandler("transition_complete_keyframe", f3_local0)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0x16E4D2022024D11].__onClose = function(f8_arg0)
	f8_arg0.ghostSpin:close()
end
